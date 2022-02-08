<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------
// | 会话设置
// +----------------------------------------------------------------------

return [
    'id'             => '',
    // SESSION_ID的提交变量,解决flash上传跨域
    'var_session_id' => '',
    // 驱动方式 支持redis memcache memcached
    'type'           => 'redis',
    // SESSION 前缀
    'prefix'         => 'system_session',
    // 是否自动开启 SESSION
    'auto_start'     => true,
    // redis主机
    'host'           => 'redis库主机',
    // redis端口
    'port'           => 6379,
    // 密码
    'password'       => 'redis库密码',
    // 查询库
    'select'         => 0,
    // 是否长连接
    'persistent'     => false,
    // 有效期(秒)
    'expire'         => 14400,
    // 是否socket方式连接
    'is_unix'        => false,
    'unix_path'      => '/tmp/redis.sock',
];
