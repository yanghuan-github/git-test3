<?php
return [
    ///////////////////////////////     Index/index     ///////////////////////////////////////////
    'index'     =>  [
        'title'                 =>  'system - 后台',
        'side_extension'        =>  '侧边伸缩',
        'refresh'               =>  '刷新',
        'search'                =>  '搜索',
        'change_password'       =>  '修改密码',
        'logout'                =>  '退出',
        'close_current_tab'     =>  '关闭当前标签页',
        'close_other_tabs'      =>  '关闭其它标签页',
        'close_all_tabs'        =>  '关闭全部标签页',
    ],

    ///////////////////////////////     Index/user     ///////////////////////////////////////////
    
    ///////用户
    'userError'     =>  [
        'error_format'          =>  '密码必须6到12位，且不能出现空格',

        'error_4'               =>  '登录密码字段与确认登录密码字段不符',
        'error_5'               =>  '白名单账号无法修改/删除',
        'error_6'               =>  '不可添加顶级菜单',
        'error_7'               =>  '角色组名已存在',
        'error_8'               =>  '白名单角色组无法修改/删除',
    ],
    'userList'      =>  [
        'title'                 =>  '用户列表',
        'addTitle'              =>  '用户新增页面',
        'editTitle'             =>  '用户编辑页面',
    ],
    ///////角色
    'roleList'      =>  [
        'title'                 =>  '角色列表',
        'addTitle'              =>  '角色新增页面',
        'editTitle'             =>  '角色编辑页面',
        'perTitle'              =>  '角色权限编辑页面',
    ],
    
    ///////////////////////////////     Index/Config     ///////////////////////////////////////////
    
    ///////菜单
    'configError'     =>  [
        'error_4'               =>  '白名单菜单无法修改/删除',
    ],
    'menuList'      =>  [
        'title'                 =>  '菜单列表',
        'addTitle'              =>  '菜单新增页面',
        'editTitle'             =>  '菜单编辑页面',
    ],
    ///////kv配置
    'paramList'      =>  [
        'title'                 =>  'KV参数配置列表',
        'addTitle'              =>  'KV参数配置新增页面',
        'editTitle'             =>  'KV参数配置编辑页面',
    ],
    ///////项目
    'pjList'        =>  [
        'title'                 =>  '项目配置列表',
        'addTitle'              =>  '项目配置新增页面',
        'editTitle'             =>  '项目配置编辑页面',
    ],
];