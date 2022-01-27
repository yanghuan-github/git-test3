<?php

namespace app\common\constant;

/**
 * 用户公共常量
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
class User extends Base
{
    const USER_PASSWORD_ERROR       =   4;  //  密码与确认密码字段不符
    const USER_CANNOT_BE_MODIFIED   =   5;  //  白名单用户无法操作/删除
    const USER_OLD_PASSWORD_ERROR   =   9;  //  旧密码与用户传入密码不符


    const ROLE_NOT_ADD_TOP_MENU     =   6;  //  不可添加顶级菜单
    const ROLE_NAME_EXISTS          =   7;  //  角色组名已存在
    CONST ROLE_CANNOT_BE_MODIFIED   =   8;  //  白名单角色组不可删除
}