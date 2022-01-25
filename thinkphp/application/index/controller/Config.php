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
        $id = input('id',0,'int');

        $paramInfo = [
            'name'      =>  '',
            'value'     =>  '',
            'msg'       =>  '',
            'status'    =>  '',
        ];
        if ($id) {
            $paramInfo = model('Config','logic')->getParamInfo('name,value,msg,status',$id);
        }
        $this->assign([
            'id'    =>  $id,
        ]);
        $this->form([
            ['input','name','name','属性名','KV参数名(唯一)',$paramInfo['name']],
            ['textarea','value','value','键值',$paramInfo['value']],
            ['textarea','msg','msg','参数含义(参数意义)',$paramInfo['msg']],
            ['statusView',$paramInfo['status']],
        ]);
        return view('paramEdit');
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
        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $id         = input('id','','int');
        $name       = input('name','','string');
        $value      = input('value','','string');
        $msg        = input('msg','','string');
        $status     = input('status',2,'int');

        // 编辑
        return model('Config','logic')->paramEditSave($id,$name,$value,$msg,$status);
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
        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $name       = input('name','','string');
        $value      = input('value','','string');
        $msg        = input('msg','','string');
        $status     = input('status',2,'int');

        // 编辑
        return model('Config','logic')->paramAddSave($name,$value,$msg,$status);
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
        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $id     = input('id','','int');
        return model('Config','logic')->paramDele($id);
    }
}