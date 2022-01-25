<?php
namespace app\index\controller;

use app\common\constant\Config as ConfigConstant;
class Config extends BaseController
{
    
    /**
     * KV参数配置列表页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function paramList()
    {
        $this->search([
            ['statusView',[0=>'全部'],true],
            ['input','name','name','属性名','支持模糊查询'],
        ]);
        return view('paramList');
    }

    /**
     * KV参数配置列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function paramListData()
    {
        $name       = input('name','','string');
        $status     = input('status',0,'int');
        $pageLimit  = pageToLimit();
        return json(model('Config','logic')->paramListData($name,$status,$pageLimit));
    }

    /**
     * KV参数新增，编辑页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function paramEdit()
    {

    }

    /**
     * KV参数编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function paramEditSave()
    {

    }

    /**
     * KV参数新增保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function paramAddSave()
    {

    }

    /**
     * KV参数删除
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function paramDele()
    {

    }
}