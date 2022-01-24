<?php

namespace app\index\logic;

use app\common\constant\Log;
use app\common\constant\Role as RoleConstant;
class Role extends BaseLogic
{

    /**
     * 获取当前用户角色组id
     *
     * @param int $adminId
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getBindRoleId($adminId)
    {
        $where = [];
        if ($adminId) {
            $where['admin_id'] = $adminId;
        }
        return model('BindAdminRole')->getValue($where,'role_id');
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
        return model('AdminRole')->getColumn([],'role_id,role_name');
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
        $model   = $model->field($field)->where($where);
        if ($pageLimit) {
            $model = $model->limit($pageLimit);
        }
        $data = $model->select();
        $count  = $model->count();
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
            return RoleConstant::LACK_PARAMS;
        }
        if (in_array($roleId,KV('whiteListRole'))) {
            return RoleConstant::ROLE_CANNOT_BE_DELETE;
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
            return RoleConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return RoleConstant::ERROR;
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
            return RoleConstant::LACK_PARAMS;
        }
        if ($rolePid == 0) {
            return RoleConstant::ROLE_NOT_ADD_TOP_MENU;
        }
        if ($this->getRoleInfo('role_id',null,$roleName)) {
            return RoleConstant::ROLE_NAME_EXISTS;
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
            return RoleConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return RoleConstant::ERROR;
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
        if (in_array($roleId,KV('whiteListRole'))) {
            return RoleConstant::ROLE_CANNOT_BE_DELETE;
        }
        model('AdminRole')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getRoleInfo('*',$roleId),
            ];
            model('AdminRole')->where('role_id',$roleId)->delete();
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminRole')->commit();
            return RoleConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminRole')->rollback();
            return RoleConstant::ERROR;
        }
    }
}