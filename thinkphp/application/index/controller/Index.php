<?php
namespace app\index\controller;

use app\common\constant\Base as BaseConstant;
class Index extends BaseController
{
    /**
     * 首页
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-18
     */
    public function index()
    {
        return view('index');
    }


    /**
     * 控制台
     *
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-18
     */
    public function console()
    {
        $menuList = model('common/Menu','logic')->shortcutNode();
        $this->assign([
            'menuList'  =>  $menuList,
        ]);
        return view('console');
    }

    
    public function test2()
    {
        echo '这是测试2页面';
    }

    /**
     * 退出
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-17
     */
    public function loginOut()
    {
        // 清除用户菜单缓存
        $jwtCheckKey = '__check_token_'.md5($this->userName);
        $dataKey = "__auth_data_" .md5(json_encode($this->userInfo));
        $this->cache('redis')->rm($jwtCheckKey);
        $this->cache('file')->rm($dataKey);
        session(null);
        $this->success('退出成功','login/Login/login');
    }

    /**
     * 主页
     *
     * @return view
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-18
     */
    public function home1()
    {
        return view('home1');
    }
    public function home2()
    {
        return view('home2');
    }


    /**
     * 重置密码
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-19
     */
    public function resetPassword()
    {
        $adminId = input('adminId',0,'int');
        if (!empty($adminId)) {
            $salt = md5(uniqid(microtime(true),true));
            $password = md5('admin123');
            $password = md5(sha1(md5($password.$salt)));
            $updateData = [
                'salt'          =>  $salt,
                'login_pwd'     =>  $password,
                'update_time'   =>  time(),
            ];
            try {
                model('AdminUser')->startTrans();
                model('AdminUser')->where('admin_id',$adminId)->update($updateData);
                model('AdminUser')->commit();
            } catch (\Exception $e) {
                model('AdminUser')->rollback();
                $data = [
                    'msg'   =>  $e->getMessage(),
                    'data'  =>  input('post.'),
                ];
                logs(__FUNCTION__,json_encode($data,JSON_UNESCAPED_UNICODE));
                return BaseConstant::ERROR;
            }
            return BaseConstant::SUCCESS;
        }
        return BaseConstant::ERROR;
    }


}
