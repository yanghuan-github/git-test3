<?php

namespace app\common\traits\view;

/**
 * 按钮模板
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-18
 */
use app\common\traits\KvFun;
trait Btu
{
    use KvFun;

    protected $btuClass = [
        'btu',      // 提交
        'reset',    // 重置
        'cancel',   // 返回上级
    ];

    public function btu(array $btu = [])
    {
        foreach ($btu as $key => $val) {
            if (!in_array($val,$this->btuClass)) {
                unset($btu[$key]);
            }
        }
        $this->assign('btu',$btu);
    }
}