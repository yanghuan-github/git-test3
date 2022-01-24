<?php

namespace app\common\constant;

/**
 * 菜单公共常量
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
class Menu extends Base
{

    const USER_AUTH_ERROR           =   2; //  当前用户没权限添加顶级菜单
    const MENU_LACK_PARAMS          =   3; //  缺少必要参数
    const MENU_CANNOT_BE_MODIFIED   =   4; //  黑名单菜单无法修改
}