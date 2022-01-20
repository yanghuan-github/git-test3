<?php

namespace app\common\traits;

/**
 * 缓存类
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-18
 */

use think\facade\Cache as tpCache;
trait Cache
{
    /**
     * @var object
     */
    protected $cache;

    protected function cache($type = 'default')
    {
        $this->cache = tpCache::store($type);
        return $this->cache;
    }
}