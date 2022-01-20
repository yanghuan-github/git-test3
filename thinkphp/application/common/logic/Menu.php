<?php

namespace app\common\logic;
/**
 * 菜单配置逻辑
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-17
 */
class Menu
{
    public function adminNodeAccess($roleId)
    {
        // 系统项目时 直接model 不需要通过system的接口在获取数据
        if (C('pj_id') == 0) {
            $nodeIdList = model('AdminRoleAccess')->getColumn(['role_id'=>$roleId],'node_id');
            $where = [
                ['node_id','in',$nodeIdList],
                ['pj_id','=',C('pj_id')],
                ['status','=',1]
            ];
            $field = 'node_id,node_title,show_type,node_pid,node_type,data,level,remark';
            $data = model('AdminNode')->getList($field,$where,'node_pid,sort,node_id');
            return $data;
        } else {
            // system接口写好在补充
        }
    }
}