<?php

namespace app\common\logic;
/**
 * 菜单配置逻辑
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-17
 */
use app\common\traits\Cache;

class Menu
{
    use Cache;
    public function adminNodeAccess($roleId)
    {
        $pjId = C('pj_id');
        $cacheName = '__admin_node_access_pj_id_'.$pjId;
        $data = $this->cache('file')->get($cacheName);
        if (!$data) {
            // 系统项目时 直接model 不需要通过system的接口在获取数据
            if ($pjId == 0) {
                $nodeIdList = model('AdminRoleAccess')->getColumn(['role_id'=>$roleId],'node_id');
                $where = [
                    ['node_id','in',$nodeIdList],
                    ['pj_id','=',$pjId],
                    ['status','=',1]
                ];
                $field = 'node_id,node_title,show_type,node_pid,node_type,data,level,remark';
                $data = model('AdminNode')->getList($field,$where,'node_pid,sort,node_id');
                if ($data) {
                    $this->cache('file')->set($cacheName,$data);
                }
            } else {
                // system接口写好在补充
            }
        }
        return $data;
    }

    /**
     * 获取项目快捷显示菜单
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-27
     */
    public function shortcutNode()
    {
        $pjId = C('pj_id');
        $cacheName = '__shortcut_node_pj_id_'.$pjId;
        $data = $this->cache('file')->get($cacheName);
        if (!$data) {
            // 系统项目时 直接model 不需要通过system的接口在获取数据
            if ($pjId == 0) {
                // 获取存在快捷跳转的菜单
                $menu = model('AdminNode')->getList('node_title,data,remark',['is_shortcut'=>1]);
                // 分段处理 每页显示8个
                $data = array_chunk($menu,8);
                if ($data) {
                    $this->cache('file')->set($cacheName,$data);
                }
            } else {

            }
        }
        return $data;
    }
}