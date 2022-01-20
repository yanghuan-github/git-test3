<?php

namespace app\common\logic;
/**
 * 公共配置逻辑
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-17
 */

// 引入工具类
use app\common\traits\Cache;


class Config
{
    // 常用工具类
    use Cache;

    /**
     * 获取配置参数数据
     * @param array $where
     * @param boolean $refresh
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-17
     */
    public function getParams($where = [],$refresh = false)
    {
        $cacheName = '__config_params';
        $data = $this->cache('file')->get($cacheName);
        if (empty($data) || $refresh) {
            $data = [];
            $raw = model('ConfigParams')->getList('name,value',$where,'id desc');
            foreach ($raw as $val) {
                $data[$val['name']] = $val['value'];
            }
            if ($data) {
                $data = json_encode($data);
                $this->cache('file')->set($cacheName,$data);
            }
        }
        return $data;
    }
}