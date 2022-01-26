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
        if (!$this->isRoot) {
            return UserConstant::USER_AUTH_ERROR;
        }
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
        if (!$this->isRoot) {
            return UserConstant::USER_AUTH_ERROR;
        }
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
        if (!$this->isRoot) {
            return UserConstant::USER_AUTH_ERROR;
        }
        $adminId     = input('adminId','','int');
        return model('User','logic')->userDele($adminId);
    }
}