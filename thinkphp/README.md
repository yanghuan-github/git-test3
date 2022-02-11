# 基于Thinkphp5.1 - LayuiAdmin 开发的多语言后台管理系统

## 本地部署流程

1. 将代码中的system.sql在本地库中执行，生成对应的基础表及数据。
2. 下拉代码至本地中，配置本地环境。
3. 修改config文件夹中的 cache.php,database.php,session.php文件改为自己的即可，配置完成后可打开后台登录页面。
4. 在项目中打开命令行，运行composer install，安装对应的扩展包依赖。
5. 修改thinkphp/library/think/cache/driver/File.php中 81行。

   `$name = hash($this->options['hash_type'], $name);`

   修改为下方代码即可：
   `if (!empty($this->options['hash_type'])) { $name = hash($this->options['hash_type'], $name); }`
6. 超级管理员账号密码：yanghuan,yanghuan 开发人员账号密码：testadmin，admin123，验证码随便填，验证码校验被注释屏蔽。
