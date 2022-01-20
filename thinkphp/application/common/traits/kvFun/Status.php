<?php

namespace app\common\traits\kvFun;

trait Status
{
    // 默认值
    protected $value = 0;

    /**
     * 状态类型 
     * 1 => 启用 2 =>  停用
     * 该方法传入参数顺序无关 不支持特殊事件
     * 可传入int类型值 作为默认值
     * 可传入bool值 true 用于标识是否需要转json
     * 可通过直接传入数组 规定键值对的形式扩展
     * 也可通过直接传入参数，使数组自动生成键
     * @param array $array
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    protected function status($array = [])
    {
        $status = KV('status');
        $needJosn = false;
        foreach ($array as $val) {
            if (is_array($val)) {
                // 不使用 array_merge() 是因为会重置键名
                $status += $val;
            } elseif (is_bool($val) && $val === true) {
                $needJosn = true;
            }elseif (is_int($val)) {
                if ($val) {
                    $this->value = $val;
                }
            } else {
                $status[] = $val;
            }
        }
        ksort($status);
        $this->assign('status',$status);
        $this->assign('value',$this->value);
        if ($needJosn) {
            $this->assign('statusJson',json_encode($status));
        }
    }
}