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
    'console'   =>  [
        'version'               =>  '1.0',
        'title'                 =>  '控制台',
        'a_shortcut'            =>  '快捷方式',
    ],

    ///////////////////////////////     Index/user     ///////////////////////////////////////////
    
    ///////用户
    'user_error'     =>  [
        'error_format'          =>  '密码必须6到12位，且不能出现空格',

        'error_4'               =>  '登录密码字段与确认登录密码字段不符',
        'error_5'               =>  '白名单账号无法修改/删除',
        'error_6'               =>  '不可添加顶级菜单',
        'error_7'               =>  '角色组名已存在',
        'error_8'               =>  '白名单角色组无法修改/删除',
        'error_9'               =>  '旧密码错误,请检查',
    ],
    'user_list'      =>  [
        'title'                 =>  '用户列表',
        'add_title'             =>  '用户新增页面',
        'edit_title'            =>  '用户编辑页面',
        'change_pwd'            =>  '用户修改密码',
    ],
    ///////角色
    'role_list'      =>  [
        'title'                 =>  '角色列表',
        'add_title'             =>  '角色新增页面',
        'edit_title'            =>  '角色编辑页面',
        'perTitle'              =>  '角色权限编辑页面',
    ],
    
    ///////////////////////////////     Index/Config     ///////////////////////////////////////////
    
    ///////菜单
    'config_error'     =>  [
        'error_4'               =>  '白名单菜单无法修改/删除',
    ],
    'menu_list'      =>  [
        'title'                 =>  '菜单列表',
        'add_title'             =>  '菜单新增页面',
        'edit_title'            =>  '菜单编辑页面',
    ],
    ///////kv配置
    'param_list'      =>  [
        'title'                 =>  'KV参数配置列表',
        'add_title'             =>  'KV参数配置新增页面',
        'edit_title'            =>  'KV参数配置编辑页面',
    ],
    ///////项目
    'pj_list'        =>  [
        'title'                 =>  '项目配置列表',
        'add_title'             =>  '项目配置新增页面',
        'edit_title'            =>  '项目配置编辑页面',
    ],
    ///////db库
    'db_list'        =>  [
        'title'                 =>  'db库列表',
        'add_title'             =>  'db库新增页面',
        'edit_title'            =>  'db库编辑页面',
    ],
];