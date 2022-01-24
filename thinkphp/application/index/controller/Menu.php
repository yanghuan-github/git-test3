<?php
namespace app\index\controller;

use app\common\constant\Menu as MenuConstant;
class Menu extends BaseController
{
    /**
     * 菜单列表
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuList()
    {
        $this->search([
            ['pjView'],
            ['statusView',[0=>'全部']]
        ]);

        // 静态表格
        $pjId       = input('pjId',0,'int');
        $status     = input('status',0,'int');
        $page       = 1;
        $limit      = -1; // -1表示取出全部条数
        $menuListData = $this->menuListData($pjId,$status,$page,$limit);

        $this->assign([
            'menuListData'  =>  $menuListData,
            'showType'      =>  KV('showType'),
            'nodeType'      =>  KV('nodeType'),
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
    private function menuListData($pjId,$status,$page,$limit)
    {
        $pageLimit  = pageToLimit($page,$limit);
        return model('Menu','logic')->menuListData($pjId,$status,$pageLimit);
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
        $nodeIdName = model('Menu','logic')->getNodeIdName();

        // 获取角色组
        $roleIdName = model('Role','logic')->getRoleIdName();
        $this->form([
            ['input','controller','controller','控制器名']
        ]);

        $this->assign([
            'nodePidvalue'  =>  $nodePid,
            'nodeIdName'    =>  $nodeIdName,
            'roleIdName'    =>  $roleIdName,
            'showType'      =>  KV('showType'),
            'nodeType'      =>  KV('nodeType'),
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
            return MenuConstant::USER_AUTH_ERROR;
        }
        $modular        =   $data['modular']; 
        $controller     =   $data['controller']; 
        $actionName     =   $data['actionName']; 
        $role           =   $data['role'] ?? []; 
        
        return json(model('Menu','logic')->menuAddSave($nodePid,$modular,$controller,$actionName,$role));
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
        $nodeIdName = model('Menu','logic')->getNodeIdName();

        $menuInfo = [
            'node_title'    =>  '',
            'show_type'     =>  '',
            'node_pid'      =>  '',
            'node_type'     =>  '',
            'data'          =>  '',
            'status'        =>  '',
            'sort'          =>  '',
            'remark'        =>  '',
        ];
        if ($nodeId) {
            $menuInfo = model('Menu','logic')->getMenuInfo('node_title,show_type,node_pid,node_type,data,status,sort,remark',$nodeId);
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

        if (!$this->isRoot) {
            return MenuConstant::USER_AUTH_ERROR;
        }
        // 编辑
        return json(model('Menu','logic')->menuEditSave($nodeId,$nodeTitle,$nodePid,$showType,$nodeType,$status,$modular,$controller,$action,$sort,$remark));
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
        if (!$this->isRoot) {
            return MenuConstant::USER_AUTH_ERROR;
        }

        return json(model('Menu','logic')->menuDele($nodeId));
    }
}