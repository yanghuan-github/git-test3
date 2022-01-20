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

    public function menuAddSave()
    {
        $data = input('post.');
        $nodePid        =   $data['nodePid']; 
        $modular        =   $data['modular']; 
        $controller     =   $data['controller']; 
        $actionName     =   $data['actionName']; 
        $role           =   $data['role']; 
        if ($nodePid == 0 && !$this->isRoot) {
            return MenuConstant::USER_AUTH_ERROR;
        }
        if (!$modular || !$controller) {
            return MenuConstant::MENU_LACK_PARAMS;
        }
        return json(model('Menu','logic')->menuAddSave($nodePid,$modular,$controller,$actionName,$role));
    }

    public function menuEditSave()
    {

    }
}