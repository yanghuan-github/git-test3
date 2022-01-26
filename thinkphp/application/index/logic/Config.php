<?php

namespace app\index\logic;

use app\common\constant\Log;
use app\common\constant\Config as ConfigConstant;
class Config extends BaseLogic
{

    /**
     * 获取当前kv参数信息
     * @param string $field
     * @param string $roleId
     * @param string $order
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-14
     */
    public function getParamInfo($field = '*',$id = '',$name = '',$order = '')
    {
        $where = [];
        if ($id) {
            $where['id'] = $id;
        }
        if ($name) {
            $where['name'] = $name;
        }
        return model('ConfigParams')->getDetail($field,$where,$order);
    }

    /**
     * 获取KV参数列表数据
     * @param string $name
     * @param int $status
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function paramListData($name,$status,$pageLimit)
    {
        $where = [];
        if ($name) {
            $where[] = ['name','like','%'.$name.'%'];
        }
        if ($status) {
            $where['status'] = $status;
        }
        $field  = '*';
        $model = model('ConfigParams');
        if ($pageLimit) {
            $data = $model->getList($field,$where,null,$pageLimit);
        } else {
            $data = $model->getList($field,$where);
        }
        $count  = $model->field('id')->where($where)->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }

    /**
     * KV参数添加保存
     * @param string $name
     * @param string $value
     * @param int $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function paramAddSave($name,$value,$msg,$status)
    {
        if (!$name || !$value) {
            return ConfigConstant::LACK_PARAMS;
        }
        $add = [];
        if ($name) {
            $add['name'] = $name;
        }
        if ($value) {
            $add['value'] = $value;
        }
        if ($msg) {
            $add['msg'] = $msg;
        }
        if ($status) {
            $add['status'] = $status;
        }
        $time = time();
        $add['create_time']     = $time;
        $add['update_time']     = $time;
        model('ConfigParams')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_ADD,
                'oldData'   =>  [],
                'data'      =>  $add,
            ];
            model('ConfigParams')->insert($add);
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigParams')->commit();

            // 刷新缓存
            KV('__config_params',true);
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigParams')->rollback();
            return ConfigConstant::ERROR;
        }
    }

    /**
     * KV参数编辑保存
     * @param int $id
     * @param string $name
     * @param string $value
     * @param string $msg
     * @param int $status
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function paramEditSave($id,$name,$value,$msg,$status)
    {
        if (!$name || !$value) {
            return ConfigConstant::LACK_PARAMS;
        }
        $update = [];
        if ($name) {
            $update['name'] = $name;
        }
        if ($value) {
            $update['value'] = $value;
        }
        if ($msg) {
            $update['msg'] = $msg;
        }
        if ($status) {
            $update['status'] = $status;
        }
        $update['update_time'] = time();
        model('ConfigParams')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getParamInfo('*',$id),
                'data'      =>  $update,
            ];
            model('ConfigParams')->where('id',$id)->update($update);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigParams')->commit();

            // 刷新缓存
            KV('__config_params',true);
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigParams')->rollback();
            return ConfigConstant::ERROR;
        }
    }

    /**
     * kv参数删除
     * @param int $id
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function paramDele($id)
    {
        if (!$id) {
            return ConfigConstant::LACK_PARAMS;
        }
        model('ConfigParams')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getParamInfo('*',$id),
            ];
            model('ConfigParams')->where('id',$id)->delete();
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigParams')->commit();
              
            // 刷新缓存
            KV('__config_params',true);
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigParams')->rollback();
            return ConfigConstant::ERROR;
        }
    }

    /**
     * 获取当前项目信息
     * @param string $field
     * @param string $id
     * @param string $pjId
     * @param string $pjLogo
     * @param string $pjName
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function getPjInfo($field = '*',$id = '',$pjId = '',$pjLogo = '',$pjName = '',$order = '')
    {
        $where = [];
        if ($id) {
            $where['id'] = $id;
        }
        if ($pjId) {
            $where['pj_id'] = $pjId;
        }
        if ($pjLogo) {
            $where['pj_logo'] = $pjLogo;
        }
        if ($pjName) {
            $where['pj_name'] = $pjName;
        }
        return model('ConfigPj')->getDetail($field,$where,$order);
    }

    /**
     * 项目列表数据
     * @param int $pjId
     * @param int $environId
     * @param int $isView
     * @param string $pjLogo
     * @param string $pjName
     * @param string $pageLimit
     * @return array
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjListData($pjId,$environId,$isView,$pjLogo,$pjName,$pageLimit)
    {
        $where = [];
        if ($pjId) {
            $where['pj_id'] = $pjId;
        }
        if ($environId) {
            $where['environ_id'] = $environId;
        }
        if ($isView) {
            $where['is_view'] = $isView;
        }
        if ($pjName) {
            $where[] = ['pj_name','like','%'.$pjName.'%'];
        }
        if ($pjLogo) {
            $where[] = ['pj_logo','like','%'.$pjLogo.'%'];
        }
        $field  = '*';
        $model = model('ConfigPj');
        if ($pageLimit) {
            $data = $model->getList($field,$where,null,$pageLimit);
        } else {
            $data = $model->getList($field,$where);
        }
        $count  = $model->field('id')->where($where)->count();
        return  ['code' => 0, 'msg' => '','count' => $count,'data' => $data];
    }

    /**
     * 项目添加保存
     * @param int $pjId
     * @param int $environId
     * @param string $pjLogo
     * @param string $pjName
     * @param int $isView
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjAddSave($pjId,$environId,$pjLogo,$pjName,$isView)
    {
        if (!$pjId || !$pjLogo || !$pjName) {
            return ConfigConstant::LACK_PARAMS;
        }
        $add = [];
        if ($pjId) {
            $add['pj_id'] = $pjId;
        }
        if ($environId) {
            $add['environ_id'] = $environId;
        }
        if ($pjLogo) {
            $add['pj_logo'] = $pjLogo;
        }
        if ($pjName) {
            $add['pj_name'] = $pjName;
        }
        if ($isView) {
            $add['is_view'] = $isView;
        }
        model('ConfigPj')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_ADD,
                'oldData'   =>  [],
                'data'      =>  $add,
            ];
            model('ConfigPj')->insert($add);
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigPj')->commit();

            // 刷新缓存
            vagueDeleteCache('__common_pjIdName_');
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigPj')->rollback();
            return ConfigConstant::ERROR;
        }
    }

    /**
     * 项目编辑保存
     * @param int $id
     * @param int $pjId
     * @param int $environId
     * @param string $pjLogo
     * @param string $pjName
     * @param int $isView
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjEditSave($id,$pjId,$environId,$pjLogo,$pjName,$isView)
    {
        if (!$id || !$pjId || !$environId || !$pjLogo || !$pjName) {
            return ConfigConstant::LACK_PARAMS;
        }
        $update = [];
        if ($pjId) {
            $add['pj_id'] = $pjId;
        }
        if ($environId) {
            $add['environ_id'] = $environId;
        }
        if ($pjLogo) {
            $add['pj_logo'] = $pjLogo;
        }
        if ($pjName) {
            $add['pj_name'] = $pjName;
        }
        if ($isView) {
            $add['is_view'] = $isView;
        }
        model('ConfigPj')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_UPDATE,
                'oldData'   =>  $this->getPjInfo('*',$id),
                'data'      =>  $update,
            ];
            model('ConfigPj')->where('id',$id)->update($update);
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigPj')->commit();

            // 刷新缓存
            vagueDeleteCache('__common_pjIdName_');
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigPj')->rollback();
            return ConfigConstant::ERROR;
        }
    }

    /**
     * 项目删除
     * @param int $id
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-25
     */
    public function pjDele($id)
    {
        if (!$id) {
            return ConfigConstant::LACK_PARAMS;
        }
        model('ConfigPj')->startTrans();
        try {
            // 拼装记录数据
            $data = [
                'type'      =>  Log::LOG_DELETE,
                'oldData'   =>  $this->getPjInfo('*',$id),
            ];
            model('ConfigPj')->where('id',$id)->delete();
            // 写入操作记录
            $this->operationLog(__METHOD__,session('loginName'),json_encode($data));
            model('ConfigPj')->commit();
              
            // 刷新缓存
            vagueDeleteCache('__common_pjIdName_');
            return ConfigConstant::SUCCESS;
        } catch(\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data));
            // 后续都是需要写入日志 和 操作记录的
            model('ConfigPj')->rollback();
            return ConfigConstant::ERROR;
        }
    }
}