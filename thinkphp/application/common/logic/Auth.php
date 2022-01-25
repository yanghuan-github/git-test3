<?php

namespace app\common\logic;


use Firebase\JWT\JWT;
/**
 * 权限公共
 *
 * @author yanghuan
 * @author 1305964327@qq.com
 * @date 2022-01-17
 */
// 引入工具类
use app\common\traits\Cache;

class Auth
{
    // 常用工具类
    use Cache;

    /**
     * 创建jwt令牌
     *
     * @param array $userInfo
     * @param array $roleInfo
     * @return string
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-17
     */
    public function createToken(array $userInfo,array $roleInfo)
    {
        $time = time();
        $sign = $this->createSign($userInfo['admin_id']);
        $status = false;
        if ($userInfo['status'] == 1 && $roleInfo['status'] == 1) {
            $status = true;
        }
        $tokenInfo = [
            'iat'   => $time,    //签发时间
            'voe'   => $time + 86400, //换取有效时间
            'exp'   => $time + 86400,   //有效时间
            'sign'  => $sign,//签名
            'data'  => [
                'user_info' =>  $userInfo,
                'role_info' =>  $roleInfo,
                'status'    =>  $status // 是否被禁用
            ]
        ];
        $jwtSign = KV('jwtSign');
        $authToken = JWT::encode($tokenInfo,$jwtSign[C('pj_id')]);
        return $authToken;
    }

    /**
     * 生成登录token sign
     * @param int $userId       用户id
     * @param string $userName  用户名
     * @return string
     */
    private function createSign($userId)
    {
        $sign = KV('authSign');
        return base64_encode(md5($sign[C('pj_id')].$userId));
    }

    public function checkToken($authToken,$userName)
    {
        try {
            $jwtCheckKey = '__check_token_'.md5($userName);
            $raw = $this->cache('redis')->get($jwtCheckKey);
            if (!$raw) {
                $jwtSign = KV('jwtSign');
                $raw = JWT::decode($authToken,$jwtSign[C('pj_id')],['HS256']);
            }
        } catch (\Exception $e) {
            // 后续补充日志记录
            $data = [
                'msg'   =>  $e->getMessage(),
                'data'  =>  [
                    'authToken'     =>  $authToken,
                    'userName'      =>  $userName,
                ],
            ];
            logs(__FUNCTION__,json_encode($data));
            return [];
        }
        // 计算出有效期剩余时间 存入缓存 避免重复验证
        $surplusTime = $raw->exp - time();
        $this->cache('redis')->set($jwtCheckKey,$raw,$surplusTime);
        // 验证sign是否正确
        if ($raw) {
            $dataKey = "__auth_data_" .md5(json_encode((array)$raw->data->user_info));
            $data = $this->cache('file')->get($dataKey);
            if (!$data) {
                $data = $this->checkSign($raw);
                $this->cache('file')->set($dataKey,$data,$surplusTime);
            }
            if ($data) {
                return $data;
            }
        }
        return [];
    }

    /**
     * 验证签名
     * @param object $raw   jwt对象数据
     * @return bool
     */
    private function checkSign(object $raw)
    {
        $sign = $this->createSign($raw->data->user_info->admin_id);
        if ($sign == $raw->sign) {
            // 检验令牌是否过期
            $time = time();
            if ($time < $raw->exp) {
                // 是否禁用
                if ($raw->data->status == 1) {
                    // 生成缓存 有效期内的缓存 避免下次还需进行验证
                    $userInfo = $this->toArray($raw->data->user_info);
                    $roleInfo = $this->toArray($raw->data->role_info);
                    $userMenu = model('common/Menu','logic')->adminNodeAccess($roleInfo['role_id']);
                    return [
                        'user_info' =>  $userInfo,
                        'role_info' =>  $roleInfo,
                        'user_menu' =>  $userMenu
                    ];
                }
            }
        }
        return false;
    }

    /**
     * 对象转为数组
     * @param object $data
     * @return void
     * @author yanghuan
     * @author 1305964327@qq.com
     * @date 2022-01-18
     */
    private function toArray($data)
    {
        $tmp = [];
        if (is_array($data)) {
            foreach ($data as $val) {
                $tmp[] = (array)$val;
            }
        } else {
            $tmp = (array)$data;
        }
        return $tmp;
    }
}