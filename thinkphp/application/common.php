<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

use think\facade\Cache;

/**
 * 初始化系统语言类型
 * @param $lang
 * @return void
 */
function setLnag($lang = 'zh-cn')
{
    // 未初始化语言类型 进行初始化
    if (!cookie('think_var')) {
        if (isset($_GET['language'])) {
            // url中设置了语言变量
            $lang = $_GET['language'];
        } elseif (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            // 获取浏览器语言
            $langArray = explode(',',$_SERVER['HTTP_ACCEPT_LANGUAGE']);
            $lang = strtolower($langArray[0]);
        }
        cookie('think_var',$lang);
    }
}

/**
 * 初始化当前页面模板信息
 * @param $dir
 * @return void
 */
function setMessAge($module)
{
    // 获取语言类型
    $lang = cookie('think_var');
    if (!$lang) {
        setLnag();
    }
    app('think\Lang')->load("../application/$module/lang/$lang.php");
}

/**
 * 打印辅助函数
 */
function pp($data,$isDie = true){
    echo "<pre>";
    print_r($data);
    if($isDie){
        die;
    }
}

/**
 * 打印辅助函数
 */
function pv($data,$isDie = true){
    echo "<pre>";
    var_dump($data);
    if($isDie){
        die;
    }
}


/**
 * 判断数组是否存在空值
 *
 * @param array $array
 * @return bool
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
function notEmpty($array = [])
{
    foreach ($array as $val) {
        if (empty($val)) {
            return false;
        }
    }
    return true;
}

/**
 * 获取配置属性
 * 
 * @param string $valueName 属性名
 * @param string $fileName 配置文件名
 * @return mixed
 * @author 1305964327@qq.com
 * @date 2022-01-12
 */
function C($valueName,$fileName = 'app')
{
    $config = config()[$fileName];
    return $config[$valueName];
}

/**
 * 把返回的数据集转换成Tree
 *
 * @author yangxin
 * @date 2021-08-04 16:04:10
 *
 * @param array $list
 * @param string $pk
 * @param string $pid
 * @param string $child
 * @param integer $root
 * @return void
 */
function list_to_tree(array $list,string $pk='id',string $pid = 'pid',string $child = '_child',int $root = 0): array
{
    // 创建Tree
    $tree = array();
    if(is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] =& $list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId =  $data[$pid];
            if ($root == $parentId) {
                $tree[] =& $list[$key];
            }else{
                if (isset($refer[$parentId])) {
                    $parent =& $refer[$parentId];
                    $parent[$child][] =& $list[$key];
                }
            }
        }
    }
    return $tree;
}

/**
 * 将list_to_tree的树还原成列表
 *
 * @author yangxin
 * @date 2021-08-12 14:49:57
 *
 * @param array  $tree  树结构数组
 * @param string $child 孩子节点的键
 * @param array  $list  过渡用的中间数组
 * @return array        树结构顺序
 */
function tree_to_list(array $tree,string $child = '_child',array &$list = array()): array
{
    if(is_array($tree)) {
        foreach ($tree as $value) {
            $reffer = $value;
            if(isset($reffer[$child])){
                unset($reffer[$child]);
                $list[] = $reffer;
                tree_to_list($value[$child], $child, $list);
            } else {
                $list[] = $reffer;
            }
        }
    }
    return $list;
}

/**
 * 获取KV值
 * @param string $name
 * @param boolean $refresh
 * @return miexd
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-17
 */
function KV($name,$refresh = false)
{
    $cacheName = '__config_params';
    $data = Cache::store('file')->get($cacheName);
    if (empty($data) || $refresh) {
        // 系统项目时 直接model 不需要通过system的接口在获取数据
        if (C('pj_id') == 0) {
            $data = model('common/Config','logic')->getParams([],$refresh);
        } else {
            // system接口写好在补充
        }
    }
    // 转为数组格式
    $data = json_decode($data,true);
    $value = isset($data[$name]) ? $data[$name] : '';
    return  json_decode($value, true) ?? $value;
}

/**
 * 通用分页处理
 * @param integer $page
 * @param integer $pageSize
 * @return void
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-19
 */
function pageToLimit($page = 1,$limit = -1)
{
    $page       = input('page',1,'int');
    $limit      = input('limit',-1,'int');
    if ($limit == -1) {
        // 取全部条数
        return false;
    }
    return ($page-1)*$limit.','.$limit;
}

/**
* 写日志
* @param $fileName : 写入哪个日志
* @param $data : 数据
*/
function logs($fileName = '',$data = ''){
    if (!$fileName || !$data) {
        return;
    }
    $path = RUNTIME_PATH . 'log/' . $fileName;
    if (!is_dir($path)) {
        $mkdir_re = mkdir($path,0777,true);
        if(!$mkdir_re){
            logs($data,$fileName);
        }
    }
    $filePath = $path . "/" . date("Y-m-d",time());
			
    $time = date("Y-m-d H:i:s",time());
    file_put_contents($filePath, $time." DATA : ".$data."\r\n\r\n" , FILE_APPEND);
}