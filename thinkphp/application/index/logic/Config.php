<?php

namespace app\index\logic;

class Config extends BaseLogic
{
    public function paramListData($name,$status,$pageLimit)
    {
        $where = [];
        if ($name) {
            $where[] = ['name','like','%'.$name.'%'];
        }
        if ($status) {
            $where['status'] = $status;
        }
        $field  = '*';
        $model = model('ConfigParams');
        $model   = $model->field($field)->where($where);
        if ($pageLimit) {
            $model = $model->limit($pageLimit);
        }
        $data = $model->select();
        $count  = $model->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }
}