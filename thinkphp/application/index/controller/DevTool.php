<?php
namespace app\index\controller;

class DevTool extends BaseController
{

    /**
     * 用户操作日志列表
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-10
     */
    public function userOperationList()
    {
        $this->search([
            ['input','adminName','adminName','操作人','操作人(支持模糊查询)'],
            ['timeRegionView'],
        ]);
        return view('userOperationList');
    }

    /**
     * 用户操作日志列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-10
     */
    public function userOperationListData()
    {
        $adminName  = input('adminName','','string');
        $start      = input('start','','string');
        $end        = input('end','','string');
        $pageLimit  = pageToLimit();
        return json(model('DevTool','logic')->userOperationListData($adminName,$start,$end,$pageLimit));
    }

    /**
     * 查看用户操作日志数据详情
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-10
     */
    public function checkUserOperation()
    {
        $id = input('id',0,'int');
        $data = model('DevTool','logic')->checkUserOperation($id);
        $this->assign('data',$data);
        return view('checkUserOperation');
    }
}