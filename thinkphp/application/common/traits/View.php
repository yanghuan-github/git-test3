<?php

namespace app\common\traits;

/**
 * 通用视图模板
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-18
 */
use app\common\traits\view\Form;
use app\common\traits\view\Search;
use app\common\traits\view\Btu;
trait View
{
    use Form,Search,Btu;
}