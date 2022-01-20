<?php
return [
    ///////////////////////////////     login/index     ///////////////////////////////////////////
    'login' =>  [
        'title' =>  'system登录',
        'hint'  =>  '仅供测试自嗨',
        'input' =>  [
            'user_name'         =>  '用户名',
            'password'          =>  '密码',
            'vercode'           =>  '验证码',
        ],
        'btu'   =>  [
            'login_btu'         =>  '登 入'
        ],
        'error_list' =>          [
            'error_not_empty'   =>  '必填项不为空',
            'error_format'      =>  '密码必须6到12位，且不能出现空格',
            'error_2'           =>  '验证码错误,请检查',
            'error_3'           =>  '用户不存在或已停用,请检查',
            'error_4'           =>  '密码或用户名错误,请检查',
            'error_5'           =>  '帐户未绑定角色',
            'error_6'           =>  '当前账户角色组已停用',
        ],
    ],
];
