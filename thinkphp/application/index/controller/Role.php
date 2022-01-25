<?php
namespace app\index\controller;

use app\common\constant\Role as RoleConstant;
class Role extends BaseController
{
    /**
     * 角色列表页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function roleList()
    {
        $this->search([
            ['statusView',[0=>'全部'],true],
            ['input','roleName','roleName','角色组名称','支持模糊查询'],
        ]);
        return view('roleList');
    }

    /**
     * 角色列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleListData()
    {
        $roleName   = input('roleName','','string');
        $status     = input('status',0,'int');
        $pageLimit  = pageToLimit();
        return json(model('Role','logic')->roleListData($roleName,$status,$pageLimit));
    }

    /**
     * 角色新增、编辑页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function roleEdit()
    {
        $roleId = input('roleId',0,'int');
        $roleInfo = [
            'role_name'    =>  '',
            'role_pid'     =>  '',
            'status'        =>  '',
        ];
        if ($roleId) {
            $roleInfo = model('Role','logic')->getRoleInfo('role_name,role_pid,status',$roleId);
        }
        $this->assign([
            'roleId'    =>  $roleId,
        ]);
        // 获取角色组id->name值
        $roleIdName = model('Role','logic')->getRoleIdName();

        $this->form([
            ['input','roleName','roleName','角色组名称','权限组名称',$roleInfo['role_name']],
            ['select','rolePid','rolePid','上级角色组',[0=>'顶级菜单']+$roleIdName,$roleInfo['role_pid']],
            ['statusView',$roleInfo['status']],
        ]);

        return view('roleEdit');
    }

    /**
     * 角色编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleEditSave()
    {
        if (!$this->isRoot) {
            return RoleConstant::USER_AUTH_ERROR;
        }
        $roleId     = input('roleId','','int');
        $roleName   = input('roleName','','string');
        $rolePid    = input('rolePid','','int');
        $status     = input('status',2,'int');

        // 编辑
        return model('Role','logic')->roleEditSave($roleId,$roleName,$rolePid,$status);
    }

    /**
     * 角色添加保存
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleAddSave()
    {
        if (!$this->isRoot) {
            return RoleConstant::USER_AUTH_ERROR;
        }
        $roleName   = input('roleName','','string');
        $rolePid    = input('rolePid',0,'int');
        $status     = input('status',2,'int');

        // 编辑
        return model('Role','logic')->roleAddSave($roleName,$rolePid,$status);
    }

    /**
     * 
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function roleDele()
    {
        if (!$this->isRoot) {
            return RoleConstant::USER_AUTH_ERROR;
        }
        $roleId     = input('roleId','','int');
        return model('Role','logic')->roleDele($roleId);
    }
}