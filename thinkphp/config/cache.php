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
// | 缓存设置
// +----------------------------------------------------------------------

return [
    // 使用复合缓存类型
    'type' => 'complex',
    // 默认使用的缓存
    'default'   =>  [
        // 驱动方式
        'type' => 'file',
        // 设置不同的缓存保存目录
        'prefix' => 'system',
        'path'   => '/data/git-test3/system/',
        // 缓存有效期 0表示永久缓存
        'expire' => 0,
        //存储压缩
        'data_compress' => true,
        //是否切割目录
        'cache_subdir' => false,
        //加密文件名方式
        'hash_type' => '',
    ],
    // 文件缓存
    'file'   =>  [
        // 驱动方式
        'type' => 'file',
        // 设置不同的缓存保存目录
        'prefix' => 'system',
        'path'   => '/data/git-test3/system/',
        // 缓存有效期 0表示永久缓存
        'expire' => 0,
        //存储压缩
        'data_compress' => true,
        //是否切割目录
        'cache_subdir' => false,
        //加密文件名方式
        'hash_type' => '',
    ],
    // redis缓存
    'redis'   =>  [
        // 驱动方式
        'type' => 'redis',
        // 链接地址
        'host' => '改为自己的地址',
        // 端口号
        'port' => 6379,
        // 密码
        'password' => '改为自己地址的密码',
        // 缓存有效期 0表示永久缓存
        'expire' => 0,
        // 缓存前缀
        'prefix' => 'system_',
        // 查询库
        'select' => 0,
        // 是否为长连接
        'persistent' => false,
        //存储压缩
        'data_compress' => true,
        // 是否socket方式连接
        'is_unix'   => false,
        'unix_path' => '/tmp/redis.sock',
    ],
];
