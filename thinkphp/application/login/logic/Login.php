<?php

namespace app\Login\logic;

// 引入登录常量类
use app\common\constant\Login as LoginConstant;

// 引入公共权限类
use app\common\logic\Auth;

class Login
{

    public function login($userName,$password)
    {
        // 取出用户信息
        $userInfo = model('index/User','logic')->getAdminInfo('u.admin_id,u.login_name,u.login_pwd,u.status u_status,u.salt,r.role_id,r.role_name,r.status r_status',false,$userName);
        if ($userInfo && $userInfo['u_status'] == 1) {
            // 加密用户密码
            if ($this->password($userInfo,$password,$userInfo['salt'])) {
                if ($userInfo['role_id']) {
                    if ($userInfo['r_status'] == 1) {
                        unset($userInfo['login_pwd'],$userInfo['salt']);
                        // 更新登录时间
                        model('AdminUser')->where('login_name',$userName)->update([
                            'laston_time'   =>  time(),
                            'laston_ip'     =>  request()->ip(),
                        ]);
                        // 创建权限token
                        $authToken = (new Auth())->createToken($userInfo);
                        session('authToken',$authToken);
                        session('loginName',$userName);
                        return LoginConstant::LOGIN_SUCCESS;
                    }
                    return LoginConstant::LOGIN_ROLE_NOT_EXIST;
                }
                return LoginConstant::LOGIN_NOT_BIND_ROLE;
            }
            return LoginConstant::LOGIN_PASSWORD_ERROR;
        }
        return LoginConstant::LOGIN_ACCOUNT_NOT_EXIST;
    }

    /**
     * 检查用户密码
     * @param array $userInfo 用户基础信息
     * @param string $password 密码串
     * @param string $salt 加密盐
     * @return bool
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    private function password($userInfo,$password,$salt)
    {
        $password = md5(sha1(md5($password.$salt)));
        if ($password ===  $userInfo['login_pwd']) {
            return true;
        }
        return false;
    }

}