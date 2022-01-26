<?php

namespace app\common\traits\view;

/**
 * 表单模板
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-18
 */
use app\common\traits\KvFun;
trait Form
{
    use KvFun;

    // 当前模板类型
    protected $type;
    // 特殊方法类型
    protected $specifyFormFun = [
        'statusView','passwordView','urlView','roleView'
    ];
    // 表单数据
    protected $form = [];


    /**
     * 表单公共模板
     * @param array $form 参数的数组先后顺序决定页面显示先后顺序
     * @param array $form['input'] input参数类型事例 ['input','id值','name值','title(标题)值','placeholder值','value值','特殊属性或者事件']
     * @param array $form['select'] select参数类型事例 ['select','id值','name值','title(标题)值','下拉框数组数据','默认值','特殊属性或者事件']
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function form(array $form = [])
    {
        foreach ($form as $val) {
            $this->type = $val['0'];

            if (in_array($this->type,$this->specifyFormFun)) {
                // 删除类型值，将剩余参数传入方法中，用于扩展
                unset($val[0]);
                call_user_func([$this,$this->type],$val);
                $this->form[] = ['form_'.$this->type];
            } else {
                $this->form[] = $val;
            }
        }

        $this->assign('form',$this->form);
    }

    /**
     * 密码页面特殊处理
     * @param array $array
     * $param bool 
     * type     => true     编辑
     * type     => false    新增
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    protected function passwordView($array)
    {
        if ($array[1] && $array[2]) {
            $this->assign([
                'type'      =>  true,
                'adminId'   =>  $array[1],
            ]);
        } else {
            $this->assign('type',false);
        }
    }
}