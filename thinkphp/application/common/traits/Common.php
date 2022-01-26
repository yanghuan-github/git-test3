<?php

namespace app\common\traits;

/**
 * 公共方法
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-19
 */
use app\common\traits\Cache;

trait Common
{
    use Cache;

    /**
     * 记录操作日志
     * @param stirng $funName
     * @param string $adminName
     * @param json $data
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    protected function operationLog($funName,$adminName,$data)
    {
        $data = [
            'method'        =>  $funName,
            'admin_name'    =>  $adminName,
            'data'          =>  $data,
            'create_time'   =>  time(),
        ];
        try {
            model('AdminOperationLog')->insert($data);
        } catch (\Exception $e) {
            // 记录日志
            $log = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  [
                    'funName'       =>  $funName,
                    'adminName'     =>  $adminName,
                    'data'          =>  $data,
                ],
            ];
            logs(__FUNCTION__,json_encode($log));
        }
    }

    /**
     * 获取项目数据 
     * 拼装为 id => name 格式
     * @param int $environId
     * @param boolean $refresh
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    protected function pjIdName($environId,$refresh = false)
    {
        $cache = '__common_pjIdName_'.$environId;
        $data = $this->cache('file')->get($cache);
        if (empty($data) || $refresh) {
            $data = [];
            $where = [
                'environ_id' =>  $environId
            ];
            $field = 'pj_id,pj_logo';
            $data = model('ConfigPj')->getColumn($where,$field);
            if ($data) {
                $this->cache('file')->set($cache,$data);
            }
        }
        return $data;
    }

    /**
     * 获取角色数据
     * 拼装为 id => name 格式
     * @param boolean $refresh
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    protected function roleIdName($refresh = false)
    {
        $cache = '__common_roleIdName';
        $data = $this->cache('file')->get($cache);
        if (empty($data) || $refresh) {
            $data = [];
            // 只不显示软删除的角色组即可
            $where = [
                ['status','in',[1,2]]
            ];
            $field = 'role_id,role_name';
            $data = model('AdminRole')->getColumn($where,$field);
            if ($data) {
                $this->cache('file')->set($cache,$data);
            }
        }
        return $data;
    }
}