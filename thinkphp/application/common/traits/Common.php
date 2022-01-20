<?php

namespace app\common\traits;

/**
 * 公共方法
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-19
 */
trait Common
{
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
}