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
        $this->funCheckAuth();
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
        $this->funCheckAuth();
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
        $this->funCheckAuth();
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
        $this->funCheckAuth();
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
        $this->funCheckAuth();
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

        $this->funCheckAuth();
        $id     = input('id',0,'int');
        return model('Config','logic')->pjDele($id);
    }

    /**
     * 菜单列表
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuList()
    {
        $pjId       = input('pjId',0,'int');
        $showId     = input('showType',0,'int');
        $nodeId     = input('nodeType',0,'int');
        $status     = input('status',0,'int');
        $isShortcut = input('shortcutType',0,'int');
        $page       = 1;
        $limit      = -1; // -1表示取出全部条数
        $showType       = [0=>'全部'] + KV('showType');
        $nodeType       = [0=>'全部'] + KV('nodeType');
        $shortcutType   = [0=>'全部'] + KV('shortcutType');
        $this->search([
            ['pjView',$pjId],
            ['select','showType','showType','显示类型',$showType,$showId],
            ['select','nodeType','nodeType','节点类型',$nodeType,$nodeId],
            ['statusView',[0=>'全部'],$status],
            ['select','shortcutType','shortcutType','快捷显示',$shortcutType,$isShortcut]
        ]);

        // 静态表格
        $menuListData = $this->menuListData($pjId,$showId,$nodeId,$status,$isShortcut,$page,$limit);

        $this->assign([
            'menuListData'  =>  $menuListData,
            'showType'      =>  $showType,
            'nodeType'      =>  $nodeType,
            'shortcutType'  =>  $shortcutType,
        ]);
        return view('menuList');
    }

    /**
     * 菜单列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    private function menuListData($pjId,$showType,$nodeType,$status,$isShortcut,$page,$limit)
    {
        $pageLimit  = pageToLimit($page,$limit);
        return model('Config','logic')->menuListData($pjId,$showType,$nodeType,$status,$isShortcut,$pageLimit);
    }

    /**
     * 菜单新增页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuAdd()
    {
        $nodePid = input('nodePid',0,'int');

        // 获取菜单KV值
        $nodeIdName = model('Config','logic')->getNodeIdName();

        // 获取角色组
        $roleIdName = model('User','logic')->getRoleIdName();
        $this->form([
            ['input','controller','controller','控制器名']
        ]);

        $this->assign([
            'nodePidvalue'  =>  $nodePid,
            'nodeIdName'    =>  $nodeIdName,
            'roleIdName'    =>  $roleIdName,
            'showType'      =>  KV('showType'),
            'nodeType'      =>  KV('nodeType'),
            'shortcutType'  =>  KV('shortcutType')
        ]);
        return view('menuAdd');
    }

    /**
     * 菜单新增保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuAddSave()
    {
        $data = input('post.');
        $nodePid        =   $data['nodePid']; 
        if ($nodePid == 0 && !$this->isRoot) {
            return ConfigConstant::USER_AUTH_ERROR;
        }
        $modular        =   $data['modular']; 
        $controller     =   $data['controller']; 
        $actionName     =   $data['actionName']; 
        $role           =   $data['role'] ?? []; 

        return model('Config','logic')->menuAddSave($nodePid,$modular,$controller,$actionName,$role);
    }

    /**
     * 菜单编辑页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuEdit()
    {
        $nodeId = input('nodeId',0,'int');

        // 获取菜单KV值
        $nodeIdName = model('Config','logic')->getNodeIdName();

        $menuInfo = [
            'node_title'    =>  '',
            'show_type'     =>  '',
            'node_pid'      =>  '',
            'node_type'     =>  '',
            'data'          =>  '',
            'status'        =>  '',
            'sort'          =>  '',
            'remark'        =>  '',
            'is_shortcut'   =>  '',
        ];
        if ($nodeId) {
            $menuInfo = model('Config','logic')->getMenuInfo('node_title,show_type,node_pid,node_type,data,status,sort,remark,is_shortcut',$nodeId);
            if ($menuInfo['data']) {
                $urlArray = explode('/',$menuInfo['data']);
                $menuInfo['modular'] = $urlArray[1];
                $menuInfo['controller'] = $urlArray[2];
                $actionName = explode('.',$urlArray[3]);
                $menuInfo['action'] = $actionName[0];
            } else {
                $menuInfo['modular'] = '';
                $menuInfo['controller'] = '';
                $menuInfo['action'] = '';
            }
            unset($menuInfo['data']);
        }
        $this->form([
            ['input','nodeTitle','nodeTitle','节点标题','节点名',$menuInfo['node_title']],
            ['select','nodePid','nodePid','父级菜单',[0=>'顶级菜单']+$nodeIdName,$menuInfo['node_pid']],
            ['select','showType','showType','显示类型',KV('showType'),$menuInfo['show_type']],
            ['select','nodeType','nodeType','节点类型',KV('nodeType'),$menuInfo['node_type']],
            ['select','status','status','节点状态',KV('status'),$menuInfo['status']],
            ['select','isShortcut','isShortcut','快捷显示',KV('shortcutType'),$menuInfo['is_shortcut']],
            ['urlView',$menuInfo['modular'],$menuInfo['controller'],$menuInfo['action']],
            ['input','sort','sort','排序','显示顺序',$menuInfo['sort']],
            ['input','remark','remark','layui样式名','菜单图标',$menuInfo['remark']],
        ]);

        $this->assign([
            'nodeId'    =>  $nodeId,
        ]);
        return view('menuEdit');
    }

    /**
     * 菜单编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuEditSave()
    {
        $nodeId     = input('nodeId',0,'int');
        $nodeTitle  = input('nodeTitle','','string');
        $nodePid    = input('nodePid',0,'int');
        $showType   = input('showType',0,'int');
        $nodeType   = input('nodeType',0,'int');
        $status     = input('status',0,'int');
        $modular    = input('modular','','string');
        $controller = input('controller','','string');
        $action     = input('action','','string');
        $sort       = input('sort',0,'int');
        $remark     = input('remark','','string');
        $isShortcut = input('isShortcut',0,'int');

        $this->funCheckAuth();
        // 编辑
        return model('Config','logic')->menuEditSave($nodeId,$nodeTitle,$nodePid,$showType,$nodeType,$status,$modular,$controller,$action,$sort,$remark,$isShortcut);
    }

    /**
     * 删除菜单
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuDele()
    {
        $nodeId     = input('nodeId',0,'int');
        $this->funCheckAuth();

        return model('Config','logic')->menuDele($nodeId);
    }

    /**
     * db库列表
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbList()
    {
        $type = KV('dbLibraryType');
        $this->search([
            ['select','type','type','db库类型',[0=>'全部'] + $type],
            ['input','dbName','dbName','数据库名','数据库名(支持模糊查询)']
        ]);
        $this->assign([
            'typeJson'  =>  json_encode($type),
        ]);
        return view('dbList');
    }

    /**
     * db库列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbListData()
    {
        $type       = input('type',0,'int');
        $dbName     = input('dbName','','string');
        $pageLimit  = pageToLimit();
        return json(model('Config','logic')->dbListData($type,$dbName,$pageLimit));
    }

    /**
     * db库新增，编辑页面
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbEdit()
    {
        $dbId = input('dbId',0,'int');
        $dbIdView = ['input','dbId','dbId','数据库ID','数据库ID'];
        $dbStatus = 1;  //  默认为添加
        
        $dbInfo = [
            'db_name'   =>  '',
            'type'      =>  '',
            'msg'       =>  '',
        ];

        if ($dbId) {
            $dbInfo = model('Config','logic')->getDbInfo('db_name,type,msg',$dbId);
            array_push($dbIdView,$dbId);
            $dbStatus = 2;
        }
        $this->assign([
            'dbId'      =>  $dbId,
            'dbStatus'  =>  $dbStatus,
        ]);
        $this->form([
            ['select','type','type','db库类型', KV('dbLibraryType')],
            $dbIdView,
            ['input','dbName','dbName','数据库名称','数据库名称',$dbInfo['db_name']],
            ['textarea','msg','msg','说明',$dbInfo['msg']],
        ]);
        return view('dbEdit');
    }

    /**
     * db库新增保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbAddSave()
    {
        $this->funCheckAuth();
        $dbId       = input('dbId',0,'int');
        $type       = input('type',0,'int');
        $dbName     = input('dbName','','string');
        $msg        = input('msg','','string');

        // 新增
        return model('Config','logic')->dbAddSave($dbId,$type,$dbName,$msg);
    }

    /**
     * db库编辑保存
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbEditSave()
    {
        $this->funCheckAuth();
        $dbId       = input('dbId',0,'int');
        $type       = input('type',0,'int');
        $dbName     = input('dbName','','string');
        $msg        = input('msg','','string');

        // 编辑
        return model('Config','logic')->dbEditSave($dbId,$type,$dbName,$msg);
    }

    /**
     * db库删除
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function dbDele()
    {
        $this->funCheckAuth();
        $dbId     = input('dbId',0,'int');
        return model('Config','logic')->dbDele($dbId);
    }

    /**
     * 项目数据库列表
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-08
     */
    public function pjDatabaseList()
    {
        echo 2131;
    }

    /**
     * 项目数据库列表数据
     * @return json
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-02-08
     */
    public function pjDatabaseListData()
    {

    }
}