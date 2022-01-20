<?php

namespace app\index\logic;


use app\common\constant\Log;
use app\common\constant\Base;

class User extends BaseLogic
{
    /**
     * 获取用户信息详情 - 单条
     * @param string $field
     * @param string $adminId
     * @param string $loginName
     * @param string $realName
     * @param string $order
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getAdminInfo($field = '*',$adminId = '',$loginName = '',$realName = '',$order = '')
    {
        $where = [];
        if ($adminId) {
            $where['admin_id'] = $adminId;
        }
        if ($loginName) {
            $where['login_name'] = $loginName;
        }
        if ($realName) {
            $where['real_name'] = $realName;
        }
        return model('AdminUser')->getDetail($field,$where,$order);
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
    public function userListData($realName,$status,$pageLimit)
    {
        $where = [];
        if ($realName) {
            $where['real_name'] = $realName;
        }
        if ($status) {
            $where['status'] = $status;
        }
        $field  = 'admin_id,login_name,real_name,status,create_time,update_time,laston_ip,laston_time';
        $model = model('AdminUser');
        $model   = $model->field($field)->where($where);
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
    public function userEditSave($adminId,$realName,$status)
    {
        $update = [];
        if ($realName) {
            $update['real_name'] = $realName;
        }
        if ($status) {
            $update['status'] = $status;
        }
        $update['update_time'] = time();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getAdminInfo('real_name,status',$adminId),
                'data'      =>  $update,
            ];
            model('AdminUser')->where('admin_id',$adminId)->update($update);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            return Base::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  [
                    'adminId'       =>  $adminId,
                    'realName'      =>  $realName,
                    'status'        =>  $status,
                ],
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            return Base::ERROR;
        }
    }

    /**
     * 新增用户信息
     * @param string $realName
     * @param string $loginName
     * @param string $password
     * @param stirng $confirmPwd
     * @param int $status
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function userAddSave($realName,$loginName,$password,$confirmPwd,$status)
    {
        if ($password != $confirmPwd) {
            return 0;
        }
        $add = [];
        if ($realName) {
            $add['real_name'] = $realName;
        }
        if ($loginName) {
            $add['login_name'] = $loginName;
        }
        if ($password) {
            $add['login_pwd'] = $password;
        }
        if ($status) {
            $add['status'] = $status;
        }
        $time = time();
        $add['create_time']     = $time;
        $add['update_time']     = $time;
        $add['salt']            = md5(uniqid(microtime(true),true));
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_ADD,
                'oldData'   =>  [],
                'data'      =>  $add,
            ];
            model('AdminUser')->insert($add);
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            return 1;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  [
                    'realName'      =>  $realName,
                    'loginName'     =>  $loginName,
                    'password'      =>  $password,
                    'confirmPwd'    =>  $confirmPwd,
                    'status'        =>  $status,
                ],
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            return Base::ERROR;
        }
    }
}