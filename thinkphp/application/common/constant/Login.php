<?php

namespace app\common\constant;

/**
 * 登录公共常量
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
class Login extends Base
{
    const LOGIN_LACK_PARAMS         =   -1;     //  缺少必要参数
    const LOGIN_WRONG_IP            =   -1;     //  ip错误,不在白名单
    const LOGIN_WRONG_ACCOUNT       =   -1;     //  账号错误,不在白名单
    const LOGIN_SUCCESS             =   1;      //  登录成功
    const LOGIN_VERCODE_ERROR       =   2;      //  登录验证码错误
    const LOGIN_ACCOUNT_NOT_EXIST   =   3;      //  登录账号不存在
    const LOGIN_PASSWORD_ERROR      =   4;      //  用户名与密码不符
    const LOGIN_NOT_BIND_ROLE       =   5;      //  当前账户未绑定权限组
    const LOGIN_ROLE_NOT_EXIST      =   6;      //  当前登录账户角色组不存在
}