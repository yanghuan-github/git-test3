<?php

namespace app\index\logic;

use app\common\constant\Log;
use app\common\constant\Menu as MenuConstant;

class Menu extends BaseLogic
{

    /**
     * 获取菜单信息详情 - 单条
     * @param string $field
     * @param string $nodeId
     * @param string $nodeTitle
     * @param string $order
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function getMenuInfo($field = '*',$nodeId = '',$nodeTitle = '',$order = '')
    {
        $where = [];
        if ($nodeId) {
            $where['node_id'] = $nodeId;
        }
        if ($nodeTitle) {
            $where['node_title'] = $nodeTitle;
        }
        return model('AdminNode')->getDetail($field,$where,$order);
    }


    /**
     * 获取菜单列表
     * @param int $pjId
     * @param int $status
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuListData($pjId,$status,$pageLimit)
    {
        $where = [];
        if ($pjId) {
            $where['pj_id'] = $pjId;
        }
        if ($status) {
            $where['status'] = $status;
        }
        $field  = '*';
        if ($pageLimit) {
            $data = model('AdminNode')->getList($field,$where,null,$pageLimit);
        } else {
            $data = model('AdminNode')->getList($field,$where);
        }
        foreach ($data as $key => $val) {
            $data[$key]['subNumber'] = $this->getSubNumber($val['node_id']);
        }
        $data = list_to_tree($data,'node_id','node_pid');
        return tree_to_list($data);
    }

    /**
     * 获取子节点个数
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    private function getSubNumber($nodeId)
    {
        return model('AdminNode')->where('node_pid',$nodeId)->count();
    }

    /**
     * 获取菜单id,name值
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function getNodeIdName()
    {
        $data = model('AdminNode')->getColumn([],'node_id,node_pid,level,node_title');
        $data = list_to_tree($data,'node_id','node_pid');
        $data = tree_to_list($data);
        $temp = [];
        foreach ($data as $val) {
            $temp[$val['node_id']] = str_repeat('|-----',$val['level'] - 1).$val['node_title'];
        }
        unset($data);
        return $temp;
    }

    /**
     * 获取树形菜单列表
     * @param int $roleId
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function getNodeTree()
    {
        $data = model('AdminNode')->getColumn([],'node_id id,node_pid,node_title title');
        foreach ($data as $key => $val) {
            $data[$key]['spread'] = true;
        }
        return list_to_tree($data,'id','node_pid','children');
    }

    /**
     * 添加菜单
     * @param int $nodePid
     * @param string $modular
     * @param string $controller
     * @param array $actionName
     * @param array $role
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuAddSave($nodePid,$modular,$controller,$actionName,$role)
    {
        if (!$modular || !$controller) {
            return MenuConstant::LACK_PARAMS;
        }
        $pjId = C('pj_id');
        $level = $this->getMenuLevel($nodePid);
        foreach ($actionName as $key => $val) {
            $actionName[$key]['node_pid']   = $nodePid;
            $actionName[$key]['data']       = '/'.$modular.'/'.$controller.'/'.$val['action'].'.html';
            $actionName[$key]['pj_id']      = $pjId;
            $actionName[$key]['status']     = 1;
            $actionName[$key]['level']      = $level + 1;
            if (!$actionName[$key]['node_title']) {
                unset($actionName[$key]);
            }
            unset($actionName[$key]['action']);
        }
        if ($actionName) {
            $nodeId = $roleAccess = [];
            model('AdminNode')->startTrans();
            model('AdminRoleAccess')->startTrans();
            try {
                foreach ($actionName as $v) {
                    $nodeId[] = model('AdminNode')->insertGetId($v);
                }
                foreach ($nodeId as $va) {
                    foreach ($role as $k => $v) {
                        $roleAccess[] = [
                            'role_id'   =>  $k,
                            'node_id'   =>  $va,
                        ];
                    }
                }
                model('AdminRoleAccess')->insertAll($roleAccess);
                // 拼装记录数据
                $data = [
                    'type'      =>  Log::LOG_ADD,
                    'oldData'   =>  [],
                    'data'      =>  [
                        'actionName'    =>  $actionName,
                        'roleAccess'    =>  $roleAccess,
                    ],
                ];
                // 写入操作记录
                $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
                model('AdminNode')->commit();
                model('AdminRoleAccess')->commit();

                // 清除缓存
                vagueDeleteCache('__auth_data_');
                return MenuConstant::SUCCESS;
            } catch (\Exception $e) {
                $data = [
                    'msg'   =>  $e->getMessage(),
                    'data'  =>  input('post.'),
                ];
                logs(__FUNCTION__,json_encode($data));
                // 后续都是需要写入日志 和 操作记录的
                model('AdminNode')->rollback();
                model('AdminRoleAccess')->rollback();
                return MenuConstant::ERROR;
            }
        }
        return MenuConstant::LACK_PARAMS;
    }

    /**
     * 获取菜单等级
     * @param int $nodeId
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    private function getMenuLevel($nodeId)
    {
        return model('AdminNode')->getValue(['node_id'=>$nodeId],'level');
    }

    /**
     * 菜单编辑保存
     * @param int $nodeId
     * @param string $nodeTitle
     * @param int $nodePid
     * @param int $showType
     * @param int $nodeType
     * @param int $status
     * @param string $modular
     * @param string $controller
     * @param string $action
     * @param int $sort
     * @param int $remark
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuEditSave($nodeId,$nodeTitle,$nodePid,$showType,$nodeType,$status,$modular,$controller,$action,$sort,$remark)
    {
        if (!$nodeId || !$nodeTitle) {
            return MenuConstant::LACK_PARAMS;
        }
        if (in_array($nodeId,KV('whiteListMenu'))) {
            return MenuConstant::MENU_CANNOT_BE_MODIFIED;
        }
        $update = [];
        if ($nodeTitle) {
            $update['node_title'] = $nodeTitle;
        }
        if ($nodePid) {
            $update['node_pid'] = $nodePid;
        }
        if ($showType) {
            $update['show_type'] = $showType;
        }
        if ($nodeType) {
            $update['node_type'] = $nodeType;
        }
        if ($status) {
            $update['status'] = $status;
        }
        if ($modular || $controller || $action) {
            if ($modular && $controller && $action) {
                $update['data'] = '/'.$modular.'/'.$controller.'/'.$action.'.html';
            } else {
                return MenuConstant::LACK_PARAMS;
            }
        }
        if ($sort) {
            $update['sort'] = $sort;
        }
        if ($remark) {
            $update['remark'] = $remark;
        }
        model('AdminNode')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getMenuInfo('*',$nodeId),
                'data'      =>  $update,
            ];
            model('AdminNode')->where('node_id',$nodeId)->update($update);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminUser')->commit();

            // 清除缓存
            vagueDeleteCache('__auth_data_');
            return MenuConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminUser')->rollback();
            return MenuConstant::ERROR;
        }
    }

    /**
     * 删除菜单
     * @param int $nodeId
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-24
     */
    public function menuDele($nodeId)
    {
        if (in_array($nodeId,KV('whiteListMenu'))) {
            return MenuConstant::MENU_CANNOT_BE_MODIFIED;
        }
        model('AdminNode')->startTrans();
        model('AdminRoleAccess')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getMenuInfo('*',$nodeId),
            ];
            model('AdminNode')->where('node_id',$nodeId)->delete();
            model('AdminRoleAccess')->where('node_id',$nodeId)->delete();
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('AdminUser')->commit();
            model('AdminRoleAccess')->commit();
            
            // 清除缓存
            vagueDeleteCache('__auth_data_');
            return MenuConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('AdminUser')->rollback();
            model('AdminRoleAccess')->rollback();
            return MenuConstant::ERROR;
        }
    }
    
    /**
     * 获取角色组菜单
     * @param int $roleId
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function getRoleMenu($roleId)
    {
        $where = [];
        if ($roleId) {
            $where['role_id'] = $roleId;
        }
        $data = model('AdminRoleAccess')->getColumn($where,'node_id');
        foreach ($data as $key => $val) {
            // 存在子节点需要删除掉当前菜单id 否则 layui-tree那边会默认选中当前菜单下的所有菜单节点
            // 只选中最底层的节点id即可
            if ($this->getSubNumber($val) != 0) {
                unset($data[$key]);
            }
        }
        return array_values($data);
    }
}