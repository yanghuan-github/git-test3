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

    /**
     * 项目列表页 pj=>project
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjList()
    {
        $this->search([
            ['pjView',true],
            ['environView',[0=>'全部'],true],
            ['select','isView','isView','管理界面',[
                0   =>  '全部',
                1   =>  '是',
                2   =>  '否'
            ]],
            ['input','pjLogo','pjLogo','项目标志','项目标志(支持模糊查询)'],
            ['input','pjName','pjName','项目名称','项目名称(支持模糊查询)'],
        ]);
        return view('pjList');
    }

    /**
     * 项目列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjListData()
    {
        $pjId       = input('pjId',0,'int');
        $environId  = input('environId',0,'int');
        $isView     = input('isView',0,'int');
        $pjLogo     = input('pjLogo','','string');
        $pjName     = input('pjName','','string');
        $pageLimit  = pageToLimit();
        return json(model('Config','logic')->pjListData($pjId,$environId,$isView,$pjLogo,$pjName,$pageLimit));
    }

    /**
     * 项目新增，编辑页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjEdit()
    {
        $id = input('id',0,'int');
        $pjInfo = [
            'pj_id'         =>  '',
            'environ_id'    =>  '',
            'pj_logo'       =>  '',
            'pj_name'       =>  '',
            'is_view'       =>  '',
        ];
        if ($id) {
            $pjInfo = model('Config','logic')->getPjInfo('pj_id,environ_id,pj_logo,pj_name,is_view',$id);
        }

        $this->assign([
            'id'    =>  $id,
        ]);

        $this->form([
            ['input','pjId','pjId','项目ID','项目ID',$pjInfo['pj_id']],
            ['select','environId','environId','环境',KV('environType'),$pjInfo['environ_id']],
            ['input','pjLogo','pjLogo','项目LOGO','项目LOGO',$pjInfo['pj_logo']],
            ['input','pjName','pjName','项目名','项目名',$pjInfo['pj_logo']],
            ['select','isView','isView','是否管理界面',[
                1   =>  '是',
                2   =>  '否'
            ],$pjInfo['is_view']],
        ]);
        return view('pjEdit');
    }

    /**
     * 项目新增保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjAddSave()
    {
        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $pjId       = input('pjId',0,'int');
        $environId  = input('environId',0,'int');
        $pjLogo     = input('pjLogo','','string');
        $pjName     = input('pjName','','string');
        $isView     = input('isView',2,'int');

        // 新增
        return model('Config','logic')->pjAddSave($pjId,$environId,$pjLogo,$pjName,$isView);
    }

    /**
     * 项目编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjEditSave()
    {
        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $id         = input('id',0,'int');
        $pjId       = input('pjId',0,'int');
        $environId  = input('environId',0,'int');
        $pjLogo     = input('pjLogo','','string');
        $pjName     = input('pjName','','string');
        $isView     = input('isView',2,'int');

        // 编辑
        return model('Config','logic')->pjEditSave($id,$pjId,$environId,$pjLogo,$pjName,$isView);
    }

    /**
     * 项目删除
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjDele()
    {

        if (!$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $id     = input('id','','int');
        return model('Config','logic')->pjDele($id);
    }
}