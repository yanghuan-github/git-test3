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
            ['statusView',[0=>'全部',3=>'软删除'],true],
            ['input','roleName','roleName','角色组名称','支持模糊查询'],
        ]);
        $this->assign('rootId',1);
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
            ['select','rolePid','rolePid','上级角色组',$roleIdName,$roleInfo['role_pid']],
            ['statusView','软删除',$roleInfo['status']],
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
     * 角色权限编辑页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function rolePer()
    {
        $roleId = input('roleId',1,'int');
        // 获取菜单列表
        $menuLogic = model('Menu','logic');
        $menuList = $menuLogic->getNodeTree();
        // 获取角色菜单权限
        $roleMenu = $menuLogic->getRoleMenu($roleId);
        $this->assign([
            'roleId'    =>  $roleId,
            'menuList'  =>  json_encode($menuList),
            'roleMenu'  =>  json_encode($roleMenu),
        ]);
        return view('rolePer');
    }

    /**
     * 角色权限编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    public function rolePerSave()
    {
        if (!$this->isRoot) {
            return RoleConstant::USER_AUTH_ERROR;
        }
        $data = input('post.');
        // 权限编辑保存
        return model('Role','logic')->rolePerSave($data);
    }

    /**
     * 父角色权限继承保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    public function roleExtSave()
    {
        $roleId     = input('roleId',0,'int');
        $rolePid    = input('rolePid',0,'int');

        if (!$this->isRoot) {
            return RoleConstant::USER_AUTH_ERROR;
        }
        // 权限编继承保存
        return model('Role','logic')->roleExtSave($roleId,$rolePid);
    }

    /**
     * 角色软删除
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