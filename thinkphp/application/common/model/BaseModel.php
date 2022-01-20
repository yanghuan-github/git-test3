<?php

namespace app\common\model;

// 引入基础类
use think\Model;

class BaseModel extends Model
{
    /**
     * 获取单条数据
     * @param string $field
     * @param mixed $where
     * @param string $order
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-12
     */
    public function getDetail($field,$where,$order)
    {
        if (empty($where)) {
            return [];
        }
        $t = $this->field($field);
        if ($where) {
            $t = $t->where($where);
        }
        if ($order) {
            $t = $t->order($order);
        }
        $data = $t->find();
        return $data ? $data->toArray() : [];
    }

    /**
     * 获取某列的值
     * @param array $where
     * @param string $value
     * @return miexd
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getValue($where,$value)
    {
        return $this->where($where)->value($value);
    }

    /**
     * 查询多条
     * @param string $field
     * @param array $where
     * @param string $order
     * @param string $limit
     * @return array
     */
    public function getList($field = '*',$where = [],$order = '',$limit = '')
    {
        $t = $this->field($field);
        if ($where) {
            $t = $t->where($where);
        }
        if ($order) {
            $t = $t->order($order);
        }
        if ($limit) {
            $t = $t->limit($limit);
        }
        $data = $t->select();
        return $data ? $data->toArray() : [];
    }

    /**
     * 获取某些字段的值
     * @param array $where
     * @param string $field
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-17
     */
    public function getColumn($where,$field)
    {
        return $this->where($where)->column($field);
    }
}