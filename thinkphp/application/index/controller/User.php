<?php
namespace app\index\controller;

use app\common\constant\User as UserConstant;
class User extends BaseController
{
    /**
     * 用户列表页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userList()
    {
        $this->search([
            ['roleView',[0=>'全部']],
            ['statusView',[0=>'全部',3=>'软删除'],true],
            ['input','realName','realName','真实姓名','支持模糊查询'],
        ]);
        return view('userList');
    }

    /**
     * 用户列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userListData()
    {
        $realName   = input('realName','','string');
        $roleId     = input('roleId',0,'int');
        $status     = input('status',0,'int');
        $pageLimit  = pageToLimit();
        return json(model('User','logic')->userListData($realName,$roleId,$status,$pageLimit));
    }

    /**
     * 用户新增、编辑页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userEdit()
    {
        $id = input('id',0,'int');

        $userInfo = [
            'login_name'    =>  '',
            'login_pwd'     =>  '',
            'real_name'     =>  '',
            'status'        =>  '',
            'role_id'       =>  '',
        ];
        $nameInput = [
            'input','loginName','loginName','登录账号','登录时所用的账号'
        ];
        $roleSelect = [
            'roleView',
        ];
        if ($id) {
            $userInfo = model('User','logic')->getAdminInfo('u.login_name,u.login_pwd,u.real_name,u.status,r.role_id',$id);
            array_push($nameInput,$userInfo['login_name'],'disabled');
            array_push($roleSelect,$userInfo['role_id']);
        }
        $this->assign([
            'id'        =>  $id,
            'userInfo'  =>  $userInfo,
        ]);
        $this->form([
            ['input','realName','realName','真实姓名','真实姓名',$userInfo['real_name']],
            $nameInput,
            ['passwordView',$id,$userInfo['login_pwd']],
            $roleSelect,
            ['statusView','软删除',$userInfo['status']]
        ]);
        return view('userEdit');
    }

    /**
     * 用户编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userEditSave()
    {
        $this->funCheckAuth();
        $adminId    = input('adminId',0,'int');
        $roleId    = input('roleId',0,'int');
        $realName   = input('realName','','string');
        $status     = input('status',2,'int');

        // 编辑
        return model('User','logic')->userEditSave($adminId,$roleId,$realName,$status);
       
    }

    /**
     * 用户新增保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function userAddSave()
    {
        $this->funCheckAuth();
        $realName   = input('realName','','string');
        $loginName  = input('loginName','','string');
        $password   = input('password','','string');
        $confirmPwd = input('confirmPwd','','string');
        $roleId    = input('roleId',0,'int');
        $status     = input('status',2,'int');

        // 新增
        return model('User','logic')->userAddSave($realName,$loginName,$password,$confirmPwd,$roleId,$status);
    }

    public function userDele()
    {
        $this->funCheckAuth();
        $adminId     = input('adminId','','int');
        return model('User','logic')->userDele($adminId);
    }

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
        return json(model('User','logic')->roleListData($roleName,$status,$pageLimit));
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
            $roleInfo = model('User','logic')->getRoleInfo('role_name,role_pid,status',$roleId);
        }
        $this->assign([
            'roleId'    =>  $roleId,
        ]);
        // 获取角色组id->name值
        $roleIdName = model('User','logic')->getRoleIdName();
        
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
        $this->funCheckAuth();
        $roleId     = input('roleId','','int');
        $roleName   = input('roleName','','string');
        $rolePid    = input('rolePid','','int');
        $status     = input('status',2,'int');

        // 编辑
        return model('User','logic')->roleEditSave($roleId,$roleName,$rolePid,$status);
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
        $this->funCheckAuth();
        $roleName   = input('roleName','','string');
        $rolePid    = input('rolePid',0,'int');
        $status     = input('status',2,'int');

        // 编辑
        return model('User','logic')->roleAddSave($roleName,$rolePid,$status);
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
        $menuLogic = model('Config','logic');
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
        $this->funCheckAuth();
        $data = input('post.');
        // 权限编辑保存
        return model('User','logic')->rolePerSave($data);
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

        $this->funCheckAuth();
        // 权限编继承保存
        return model('User','logic')->roleExtSave($roleId,$rolePid);
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
        $this->funCheckAuth();
        $roleId     = input('roleId','','int');
        return model('User','logic')->roleDele($roleId);
    }

    /**
     * 修改密码
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    public function changePwd()
    {
        return view('changePwd');
    }
}