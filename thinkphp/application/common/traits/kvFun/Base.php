<?php

namespace app\common\traits\kvFun;

trait Base
{
    // 默认值
    protected $value = 0;
    protected $needJosn = false;
    /**
     * 状态类型 
     * 1 => 启用 2 =>  停用
     * statusType 状态id,name键值对
     * @param array $array
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    protected function statusView($array = [])
    {
        $status = KV('status');
        $this->viewCommonFun($array,$status,__FUNCTION__);
    }

    /**
     * pjIdName 项目id,name键值对
     * @param array $array
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    protected function pjView($array = [])
    {
        $pjIdName = $this->pjIdName($this->environId);
        $this->viewCommonFun($array,$pjIdName,__FUNCTION__);
    }

    /**
     * envIdName 环境id,name键值对
     * @param array $array
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    protected function environView($array = [])
    {
        $envType = KV('environType');
        $this->viewCommonFun($array,$envType,__FUNCTION__);
    }

    /**
     * 公共处理方法
     * 该方法传入参数顺序无关 不支持特殊事件
     * 可传入int类型值 作为默认值
     * 可传入bool值 true 用于标识是否需要转json
     * 可通过直接传入数组 规定键值对的形式扩展
     * 也可通过直接传入参数，使数组自动生成键
     * @param array $array
     * @param array $tempArray
     * @param string $funName
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    private function viewCommonFun(array $array,$tempArray = [],$funName)
    {
        foreach ($array as $val) {
            if (is_array($val)) {
                // 不使用 array_merge() 是因为会重置键名
                $tempArray += $val;
            } elseif (is_bool($val) && $val === true) {
                $this->needJosn = true;
            }elseif (is_int($val)) {
                if ($val) {
                    $this->value = $val;
                }
            } else {
                $tempArray[] = $val;
            }
        }
        ksort($tempArray);
        $this->assign($funName,$tempArray);
        $this->assign('value',$this->value);
        if ($this->needJosn) {
            $this->assign($funName.'Json',json_encode($tempArray));
        }
    }
}