<?php
namespace app\index\controller;

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
            ['input','realName','realName','真实姓名','支持模糊查询'],
            ['status',[0=>'全部',3=>'软删除'],true]
        ]);
        return view('userList');
    }

    /**
     * 用户列表数据
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function userListData()
    {
        $realName   = input('realName','','string');
        $status     = input('status',0,'int');
        $page       = input('page',1,'int');
        $limit      = input('limit',10,'int');
        $pageLimit = pageToLimit($page,$limit);
        return model('User','logic')->userListData($realName,$status,$pageLimit);
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
        ];
        $nameInput = [
            'input','loginName','loginName','登录账号','登录时所用的账号'
        ];
        if ($id) {
            $userInfo = model('User','logic')->getAdminInfo('login_name,login_pwd,real_name,status',$id);
            array_push($nameInput,$userInfo['login_name'],'disabled');
        }
        $this->assign([
            'id'        =>  $id,
            'userInfo'  =>  $userInfo,
        ]);
        $this->form([
            ['input','realName','realName','真实姓名','真实姓名',$userInfo['real_name']],
            $nameInput,
            ['password',$id,$userInfo['login_pwd']],
            ['status','软删除',$userInfo['status']]
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
        $adminId    = input('adminId','','int');
        $realName   = input('realName','','string');
        $status     = input('status',2,'int');

        // 编辑
        return model('User','logic')->userEditSave($adminId,$realName,$status);
       
    }

    /**
     * 用户新增保存
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function userAddSave()
    {
        $realName   = input('realName','','string');
        $loginName  = input('loginName','','string');
        $password   = input('password','','string');
        $confirmPwd = input('confirmPwd','','string');
        $status     = input('status',2,'int');

        // 新增
        return model('User','logic')->userAddSave($realName,$loginName,$password,$confirmPwd,$status);
    }
}