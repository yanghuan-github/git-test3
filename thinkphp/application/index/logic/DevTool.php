<?php

namespace app\index\logic;

class DevTool extends BaseLogic
{
    /**
     * 用户操作日志列表数据
     * @param string $adminName
     * @param string $start
     * @param string $end
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-10
     */
    public function userOperationListData($adminName,$start,$end,$pageLimit)
    {
        $where = [];
        if ($adminName) {
            $where[] = ['admin_name','like','%'.$adminName.'%'];
        }
        if ($start && $end) {
            $start = strtotime($start);
            $end = strtotime($end);
            $where[] = ['create_time','between',[$start,$end]];
        }
        $field  = 'id,method,admin_name,create_time';
        $model = model('AdminOperationLog');
        $data = $model->getList($field,$where,'create_time desc',$pageLimit);
        $count  = $model->field('id')->where($where)->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }

    /**
     * 获取单条数据
     * @param int $id
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-10
     */
    public function checkUserOperation($id)
    {
        $where = [];
        if ($id) {
            $where['id'] = $id;
        }
        return model('AdminOperationLog')->getValue($where,'data');
    }
}