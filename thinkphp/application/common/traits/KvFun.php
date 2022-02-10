<?php

namespace app\common\traits;

/**
 * key => value 模板特殊方法基类
 */
use app\common\traits\kvFun\Base;
use app\common\traits\Common;
trait KvFun
{
    use Common,Base;

    // 特殊方法类型
    protected $specifyFun = [
        'statusView','passwordView','urlView','roleView','pjView','environView','timeRegionView'
    ];
}