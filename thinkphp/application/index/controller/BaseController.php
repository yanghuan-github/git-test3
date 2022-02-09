<?php
namespace app\index\controller;

use think\Controller;

// 引入公共权限类
use app\common\logic\Auth;

// 引入工具类
use app\common\traits\View;

// 引入基础常量
use app\common\constant\Base as BaseConstant;

class BaseController extends Controller
{

    // 用户信息
    protected $adminId;     //  用户id
    protected $roleId;      //  角色id
    protected $isRoot;      //  是否超级管理员
    protected $userName;    //  用户名
    protected $userInfo;    //  用户基本信息
    protected $userMenu;    //  用户菜单
    protected $nodeUrl;     //  用户菜单权限url

    // 基本配置
    protected $environId;
    protected $pjId;


    // 常用工具类
    use View;

    // 方法白名单
    protected $urlWhileList = [
        '/index/Index/loginOut.html',
        '/index/Index/resetPassword.html',
        '/index/User/changePwd.html',
        '/index/PublicTool/pubPjIdName.html'
    ];

    public function initialize()
    {
        $authToken      = session('authToken');
        $this->userName = session('loginName');
        if (!$authToken && !$this->userName) {
            $this->redirect('login/Login/login');
        }
        // 获取基本信息 解析token
        $userData = (new Auth())->checkToken($authToken,$this->userName);
        unset($authToken);
        if (!$userData) {
            // 清空session
            session(null);
            $this->redirect('login/Login/login');
        }
        // 设置基本用户信息
        $this->adminId  = $userData['user_info']['admin_id'];
        $this->roleId   = $userData['user_info']['role_id'];
        $this->isRoot   = $this->isAdmin($this->userName,$this->roleId);
        $this->userInfo = $userData['user_info'];
        $this->userMenu = $userData['user_menu'];
        $this->nodeUrl  = array_filter(array_unique(array_column($this->userMenu, 'data')));
        unset($userData);

        // 设置基本配置
        $this->environId = C('environ_id');
        $this->pjId = C('pj_id');

        // 检查访问权限 超级管理员跳过
        $request = request();
        if ($this->adminId != C('admin_id')) {
            $url = '/'.$request->module().'/'.$request->controller().'/'.$request->action(true).'.html';
            if (!in_array($url,$this->nodeUrl)) {
                if (!in_array($url,$this->urlWhileList)) {
                    $data = [
                        'msg'   =>  '无权访问',
                        'data'  =>  [
                            'url'       =>  $url,
                            'nodeUrl'   =>  $this->nodeUrl,
                        ]
                    ];
                    logs(__FUNCTION__,json_encode($data,JSON_UNESCAPED_UNICODE));
                    exit('无权访问!');
                }
            }
        }

        // 菜单数组拼接
        $this->assign('__menu__',list_to_tree($this->userMenu, 'node_id', 'node_pid'));

        // 载入模板语言信息
        setMessAge($request->module());
        // 初始化页面基本信息
        $commonMsg  = lang('common');
        $msg        = is_array(lang($request->action())) ? lang($request->action()) : [];
        $errorName  = strtolower($request->controller()).'_error';
        $error      = is_array(lang($errorName)) ? lang($errorName) : [];
        $msg        = array_merge($commonMsg,$msg,$error);
        $this->assign('msg',json_encode($msg));
    }

    /**
     * 是否超级管理员
     * @param int $adminId
     * @return boolean
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-18
     */
    private function isAdmin($adminName,$roleId)
    {
        $cache = '__is_admin_'.$adminName.'_'.$roleId;
        $return = $this->cache('redis')->get($cache);
        if (!$return) {
            $return = 'no';
            if (in_array($adminName,KV('userWhiteList'))) {
                if (in_array($roleId,KV('whiteListRole'))) {
                    $return = 'yes';
                }
            }
            $this->cache('redis')->set($cache,$return,3600 * 3);
        }
        return $return;
    }
    

    /**
     * 检查方法是否受限
     * @return int
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-26
     */
    protected function funCheckAuth()
    {
        if (!$this->isRoot) {
            return BaseConstant::USER_AUTH_ERROR;
        }
    }
}