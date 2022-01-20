<?php

namespace app\common\traits\view;

/**
 * 搜索模板
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-18
 */
use app\common\traits\KvFun;
trait Search
{

    use KvFun;

    // 当前模板类型
    protected $type;
    // 特殊方法类型
    protected $specifySearchFun = [
        'statusView','pjView','environView'
    ];
    // 表单数据
    protected $search = [];



    /**
     * 表单公共模板
     *
     * @param array $search 参数的数组先后顺序决定页面显示先后顺序
     * @param array $search['input'] input参数类型事例 ['input','id值','name值','title(标题)值','placeholder值','value值','特殊属性或者事件']
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    protected function search(array $search = [])
    {
        foreach ($search as $val) {
            $this->type = $val['0'];

            if (in_array($this->type,$this->specifySearchFun)) {
                // 删除类型值，将剩余参数传入方法中，用于扩展
                unset($val[0]);
                call_user_func([$this,$this->type],$val);
                $this->search[] = ['search_'.$this->type];
            } else {
                $this->search[] = $val;
            }
        }
        $this->assign('search',$this->search);
    }
}