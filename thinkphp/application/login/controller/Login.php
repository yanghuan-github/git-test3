<?php

namespace app\login\controller;

// 引入基础类
use think\Controller;
// 引入登录常量类
use app\common\constant\Login as LoginConstant;

class Login extends Controller
{
    
    protected function initialize()
    {
        if (!empty(session('authToken'))) {
            $this->redirect('index/Index/index');
        }
        // 初始化浏览器语言
        setLnag();
        // 载入登录页多语言模板信息
        setMessAge(request()->module());
        // 初始化页面错误信息
        $commonError = lang('common');
        $loginError = lang('login')['error_list'];
        $loginError = array_merge($commonError,$loginError);
        $this->assign('errorListJson',json_encode($loginError));
    }
    /**
     * 登录页
     */
    public function index()
    {
        return view('login');
    }
    public function login()
    {
        return view('login');
    }

    /**
     * 生成验证码
     */
    public function verify()
    {
        return app('think\captcha\Captcha')->entry();
    }

    /**
     * 检验验证码
     * @param $vercode
     * @return bool
     */
    private function checkVercode($vercode)
    {
        return app('think\captcha\Captcha')->check($vercode);
    }

    /**
     * 登录验证
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-17
     */
    public function loginCheck()
    {
        $userName   = input('userName','','string');
        $password   = input('password','','string');
        $vercode    = input('vercode','','string');
        try {
            if (notEmpty([$userName,$password,$vercode])) {
                // 检验是否是ip白名单
                $ip = request()->ip();
                if (in_array($ip,KV('ipWhiteList'))) {
                    // 检查是否白名单用户
                    if (in_array($userName,KV('userWhiteList'))) {
                        // if ($this->checkVercode($vercode)) {
                            return model('Login','logic')->login($userName,$password);
                        // }
                        return LoginConstant::LOGIN_VERCODE_ERROR;
                    }
                    return LoginConstant::LOGIN_WRONG_ACCOUNT;
                }
                return LoginConstant::LOGIN_WRONG_IP;
            }
            return LoginConstant::LOGIN_LACK_PARAMS;
        } catch (\Exception $e) {
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  input('post.'),
            ];
            logs(__FUNCTION__,json_encode($data,JSON_UNESCAPED_UNICODE));
            return LoginConstant::LOGIN_LACK_PARAMS;
        }
    }
}
