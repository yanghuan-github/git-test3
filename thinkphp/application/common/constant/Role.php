<?php

namespace app\common\constant;

/**
 * 角色公共常量
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
class Role extends Base
{
    const ROLE_NOT_ADD_TOP_MENU =   4;  //  不可添加顶级菜单
    const ROLE_NAME_EXISTS      =   5;  //  角色组名已存在
    CONST ROLE_CANNOT_BE_DELETE =   6;  //  白名单角色组不可删除
}