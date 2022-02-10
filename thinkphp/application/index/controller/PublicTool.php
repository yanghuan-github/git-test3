<?php
namespace app\index\controller;

/**
 * js公共业务接口
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-02-09
 */
class PublicTool extends BaseController
{
    public function pubPjIdName()
    {
        $environId = input('environId',0,'int');
        return $this->pjIdName($environId);
    }
}