<?php

namespace app\index\logic;

class Menu extends BaseLogic
{

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
        $model = model('AdminNode');
        $model   = $model->field($field)->where($where);
        if ($pageLimit) {
            $model = $model->limit($pageLimit);
        }
        $data = $model->select()->toArray();
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
     * 添加菜单
     * @param int $nodePid
     * @param string $modular
     * @param string $controller
     * @param array $actionName
     * @param array $role
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-20
     */
    public function menuAddSave($nodePid,$modular,$controller,$actionName,$role)
    {
        $pjId = C('pj_id');
        $level = $this->getMenuLevel($nodePid);
        foreach ($actionName as $key => $val) {
            $actionName[$key]['node_pid']   = $nodePid;
            $actionName[$key]['data']       = $modular.'/'.$controller.'/'.$val['action'].'.html';
            $actionName[$key]['pj_id']      = $pjId;
            $actionName[$key]['status']     = 1;
            $actionName[$key]['level']      = $level + 1;
            if (!$actionName[$key]['node_title']) {
                unset($actionName[$key]);
            }
            unset($actionName[$key]['action']);
        }
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
}