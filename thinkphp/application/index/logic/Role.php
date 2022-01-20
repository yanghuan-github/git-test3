<?php

namespace app\index\logic;

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
}