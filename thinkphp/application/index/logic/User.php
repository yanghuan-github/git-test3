<?php

namespace app\index\logic;


use app\common\constant\Log;
use app\common\constant\User as UserConstant;

class User extends BaseLogic
{
    /**
     * 获取用户信息详情 - 单条
     * @param string $field
     * @param string $adminId
     * @param string $loginName
     * @param string $realName
     * @param string $order
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getAdminInfo($field = '',$adminId = '',$loginName = '',$realName = '',$order = '')
    {
        $where = [];
        if ($adminId) {
            $where['u.admin_id'] = $adminId;
        }
        if ($loginName) {
            $where['u.login_name'] = $loginName;
        }
        if ($realName) {
            $where['u.real_name'] = $realName;
        }
        if (!$field) {
            $field  = 'u.login_name,u.login_pwd,u.real_name,u.status,r.role_id';
        }
        $model = model('AdminUser');
        $data =  $model->field($field)->alias('u')
                         ->leftJoin('BindAdminRole b','u.admin_id = b.admin_id')
                         ->leftJoin('AdminRole r','b.role_id = r.role_id')
                         ->where($where)->find();
        return $data->toArray();
    }

    /**
     * 获取用户数据 - 多条
     * @param string $realName
     * @param int $status
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userListData($realName,$roleId,$status,$pageLimit)
    {
        $where = [];
        if ($realName) {
            $where[] = ['u.real_name','like','%'.$realName.'%'];
        }
        if ($status) {
            $where['u.status'] = $status;
        }
        if ($roleId) {
            $where['r.role_id'] = $roleId;
        }
        $field  = 'u.admin_id,u.login_name,u.real_name,u.status,u.create_time,u.update_time,u.laston_ip,u.laston_time,r.role_id,r.role_name';
        $model = model('AdminUser');
        $model   = $model->field($field)
                         ->alias('u')
                         ->leftJoin('BindAdminRole b','u.admin_id = b.admin_id')
                         ->leftJoin('AdminRole r','b.role_id = r.role_id')
                         ->where($where);
        if ($pageLimit) {
            $model = $model->limit($pageLimit);
        }
        $data = $model->select();
        $count  = $model->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }

    /**
     * 更新用户信息
     * @param int $adminId
     * @param string $realName
     * @param string $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userEditSave($adminId,$roleId,$realName,$status)
    {
        if (!$adminId) {
            return UserConstant::LACK_PARAMS;
        }
        if (in_array($adminId,KV('whiteListUser'))) {
            return UserConstant::USER_CANNOT_BE_MODIFIED;
        }
        $update = [];
        if ($realName) {
            $update['real_name'] = $realName;
        }
        if ($status) {
            $update['status'] = $status;
        }
        $update['update_time'] = time();
        model('AdminUser')->startTrans();
        model('BindAdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getAdminInfo('u.real_name,u.status',$adminId),
                'update'    =>  $update,
            ];
            model('AdminUser')->where('admin_id',$adminId)->update($update);
            if ($roleId) {
                // 插入用户角色组绑定表
                $add = [
                    'admin_id'  =>  $adminId,
                    'role_id'   =>  $roleId,
                ];
                model('BindAdminRole')->insert($add,true);
                $data['add'] = $add;
            }
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminUser')->commit();
            model('BindAdminRole')->commit();
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminUser')->rollback();
            model('BindAdminRole')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 新增用户信息
     * @param string $realName
     * @param string $loginName
     * @param string $password
     * @param stirng $confirmPwd
     * @param int $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function userAddSave($realName,$loginName,$password,$confirmPwd,$roleId,$status)
    {
        if (!$loginName || !$password || !$confirmPwd) {
            return UserConstant::LACK_PARAMS;
        }
        if ($password != $confirmPwd) {
            return UserConstant::USER_PASSWORD_ERROR;
        }
        $add = [];
        if ($realName) {
            $add['real_name'] = $realName;
        }
        if ($loginName) {
            $add['login_name'] = $loginName;
        }
        if ($password) {
            $add['salt'] = md5(uniqid(microtime(true),true));
            $add['login_pwd'] = md5(sha1(md5($password.$add['salt'])));
        }
        if ($status) {
            $add['status'] = $status;
        }
        $time = time();
        $add['create_time']     = $time;
        $add['update_time']     = $time;
        model('AdminUser')->startTrans();
        model('BindAdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_ADD,
                'oldData'   =>  [],
                'data'      =>  $add,
            ];
            $adminId = model('AdminUser')->insertGetId($add);
            if ($roleId) {
                // 插入用户角色组绑定表
                $add = [
                    'admin_id'  =>  $adminId,
                    'role_id'   =>  $roleId,
                ];
                model('BindAdminRole')->insert($add);
                $data['add'] = $add;
            }
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminUser')->commit();
            model('BindAdminRole')->commit();
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminUser')->rollback();
            model('BindAdminRole')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 用户软删除
     * @param int $adminId
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function userDele($adminId)
    {
        if (!$adminId) {
            return UserConstant::LACK_PARAMS;
        }
        if (in_array($adminId,KV('whiteListUser'))) {
            return UserConstant::USER_CANNOT_BE_MODIFIED;
        }
        model('AdminUser')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getAdminInfo('*',$adminId),
            ];
            model('AdminUser')->where('admin_id',$adminId)->update(['status'=>3,'update_time'=>time()]);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminUser')->commit();
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminUser')->rollback();
            return UserConstant::ERROR;
        }
    }


    /**
     * 获取当前角色组信息
     * 
     * @param string $field
     * @param string $roleId
     * @param string $order
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getRoleInfo($field = '*',$roleId = '',$roleName = '',$rolePid = '',$order = '')
    {
        $where = [];
        if ($roleId) {
            $where['role_id'] = $roleId;
        }
        if ($roleName) {
            $where['role_name'] = $roleName;
        }
        if ($rolePid) {
            $where['role_pid'] = $rolePid;
        }
        return model('AdminRole')->getDetail($field,$where,$order);
    }

    /**
     * 获取角色组id,name值
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function getRoleIdName()
    {
        return model('AdminRole')->order('role_id asc')->column('role_id,role_name');
    }

    /**
     * 获取角色数据 - 多条
     * @param string $roleName
     * @param int $status
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function roleListData($roleName,$status,$pageLimit)
    {
        $where = [];
        if ($roleName) {
            $where[] = ['role_name','like','%'.$roleName.'%'];
        }
        if ($status) {
            $where['status'] = $status;
        }
        $field  = '*';
        $model = model('AdminRole');
        if ($pageLimit) {
            $data = $model->getList($field,$where,null,$pageLimit);
        } else {
            $data = $model->getList($field,$where);
        }
        $count  = $model->field('role_id')->where($where)->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }

    /**
     * 角色编辑保存
     * @param int $roleId
     * @param string $roleName
     * @param int $rolePid
     * @param int $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleEditSave($roleId,$roleName,$rolePid,$status)
    {
        if (!$roleId || !$roleName) {
            return UserConstant::LACK_PARAMS;
        }
        if (in_array($roleId,KV('whiteListRole'))) {
            return UserConstant::ROLE_CANNOT_BE_MODIFIED;
        }
        $update = [];
        if ($roleName) {
            $update['role_name'] = $roleName;
        }
        if ($rolePid) {
            $update['role_pid'] = $rolePid;
        }
        if ($status) {
            $update['status'] = $status;
        }
        $update['update_time'] = time();
        model('AdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getRoleInfo('*',$roleId),
                'data'      =>  $update,
            ];
            model('AdminRole')->where('role_id',$roleId)->update($update);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRole')->commit();
            $this->roleIdName(true);
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 角色添加报错
     * @param string $roleName
     * @param int $rolePid
     * @param int $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleAddSave($roleName,$rolePid,$status)
    {
        if (!$roleName) {
            return UserConstant::LACK_PARAMS;
        }
        if ($rolePid == 0) {
            return UserConstant::ROLE_NOT_ADD_TOP_MENU;
        }
        if ($this->getRoleInfo('role_id',null,$roleName)) {
            return UserConstant::ROLE_NAME_EXISTS;
        }
        $add = [];
        if ($roleName) {
            $add['role_name'] = $roleName;
        }
        if ($rolePid) {
            $add['role_pid'] = $rolePid;
        }
        if ($status) {
            $add['status'] = $status;
        }
        $time = time();
        $add['create_time']     = $time;
        $add['update_time']     = $time;
        model('AdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_ADD,
                'oldData'   =>  [],
                'data'      =>  $add,
            ];
            model('AdminRole')->insert($add);
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRole')->commit();
            $this->roleIdName(true);
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 角色删除
     * @param int $roleId
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleDele($roleId)
    {
        if (!$roleId) {
            return UserConstant::LACK_PARAMS;
        }
        if (in_array($roleId,KV('whiteListRole'))) {
            return UserConstant::ROLE_CANNOT_BE_MODIFIED;
        }
        model('AdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getRoleInfo('*',$roleId),
            ];
            model('AdminRole')->where('role_id',$roleId)->update(['status'=>3,'update_time'=>time()]);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRole')->commit();
            $this->roleIdName(true);
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 角色组权限编辑保存
     * @param array $data
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    public function rolePerSave($data)
    {
        $insert = [];
        $roleId = $data['roleId'];
        if (in_array($roleId,KV('whiteListRole'))) {
            return UserConstant::ROLE_CANNOT_BE_MODIFIED;
        }
        if (!isset($data['data'])) {
            $data['data'] = [];
        }
        $data = tree_to_list([$data['data']],'children');
        // 获取菜单节点id
        $nodeIdList = array_column($data,'id');
        unset($data);
        model('AdminRoleAccess')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  model('Config','logic')->getRoleMenu($roleId),
                'data'      =>  $nodeIdList,
            ];
            // 先删除旧的权限
            model('AdminRoleAccess')->where('role_id',$roleId)->delete();
            // 添加新权限
            foreach ($nodeIdList as $val) {
                $insert[] = [
                    'role_id'   =>  $roleId,
                    'node_id'   =>  $val,
                ];
            }
            unset($nodeIdList);
            model('AdminRoleAccess')->removeOption()->insertAll($insert);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRoleAccess')->commit();
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRoleAccess')->rollback();
            return UserConstant::ERROR;
        }
    }

    /**
     * 权限继承保存
     * @param int $roleId
     * @param int $rolePid
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    public function roleExtSave($roleId,$rolePid)
    {
        if (in_array($roleId,KV('whiteListRole'))) {
            return UserConstant::ROLE_CANNOT_BE_MODIFIED;
        }
        // 获取父角色组权限
        $pMenu = model('AdminRoleAccess')->getColumn(['role_id'=>$rolePid],'node_id');
        model('AdminRoleAccess')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  model('AdminRoleAccess')->getColumn(['role_id'=>$roleId],'node_id'),
                'data'      =>  $pMenu,
            ];
            // 先删除旧的权限
            model('AdminRoleAccess')->where('role_id',$roleId)->delete();
            // 添加新权限
            foreach ($pMenu as $val) {
                $insert[] = [
                    'role_id'   =>  $roleId,
                    'node_id'   =>  $val,
                ];
            }
            unset($pMenu);
            model('AdminRoleAccess')->removeOption()->insertAll($insert);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRoleAccess')->commit();
            return UserConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRoleAccess')->rollback();
            return UserConstant::ERROR;
        }
    }
}