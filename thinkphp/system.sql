/*
 Navicat Premium Data Transfer

 Source Server         : 外测
 Source Server Type    : MySQL
 Source Server Version : 50562
 Source Host           : 120.24.63.166:3306
 Source Schema         : system

 Target Server Type    : MySQL
 Target Server Version : 50562
 File Encoding         : 65001

 Date: 24/01/2022 14:46:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin_node
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_node`;
CREATE TABLE `t_admin_node`  (
  `node_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pj_id` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '项目ID',
  `node_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '节点标题',
  `show_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 3 COMMENT '显示类型 1导航菜单 2列表菜单 3不显示',
  `node_pid` smallint(6) UNSIGNED NOT NULL COMMENT '父节点ID',
  `node_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点类型 1查看 2新增 3修改 4删除 5导出 6导入 7审核',
  `data` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '权限Url方法',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '节点状态 1启用 2关闭',
  `sort` smallint(6) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  `level` tinyint(1) UNSIGNED NOT NULL COMMENT '节点层级',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'layui图标样式',
  PRIMARY KEY (`node_id`) USING BTREE,
  INDEX `nodeType`(`show_type`) USING BTREE,
  INDEX `dataType`(`node_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台系统节点表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_node
-- ----------------------------
INSERT INTO `t_admin_node` VALUES (1, 0, '主页（默认存在）', 1, 0, 1, '/index/Index/index.html', 1, 1, 1, '');
INSERT INTO `t_admin_node` VALUES (2, 0, '测试', 2, 1, 1, '', 1, 2, 2, '');
INSERT INTO `t_admin_node` VALUES (3, 0, '测试二级', 3, 2, 1, '/index/Index/test2.html', 1, 3, 3, '');
INSERT INTO `t_admin_node` VALUES (4, 0, '控制台', 3, 1, 1, '/index/Index/console.html', 1, 4, 2, '');
INSERT INTO `t_admin_node` VALUES (6, 0, '主页1', 2, 1, 1, '/index/Index/home1.html', 1, 5, 2, '');
INSERT INTO `t_admin_node` VALUES (7, 0, '主页2', 2, 1, 1, '/index/Index/home2.html', 1, 6, 2, '');
INSERT INTO `t_admin_node` VALUES (8, 0, '用户', 2, 1, 1, '', 1, 7, 2, '');
INSERT INTO `t_admin_node` VALUES (9, 0, '用户数据', 3, 15, 1, '/index/User/userListData.html', 1, 8, 4, '');
INSERT INTO `t_admin_node` VALUES (10, 0, '用户新增/编辑页面', 3, 15, 1, '/index/User/userEdit.html', 1, 9, 4, '');
INSERT INTO `t_admin_node` VALUES (11, 0, '用户新增保存', 3, 15, 1, '/index/User/userAddSave.html', 1, 10, 4, '');
INSERT INTO `t_admin_node` VALUES (12, 0, '用户编辑保存', 3, 15, 1, '/index/User/userEditSave.html', 1, 11, 4, '');
INSERT INTO `t_admin_node` VALUES (13, 0, '通用', 2, 1, 1, '', 1, 12, 2, '');
INSERT INTO `t_admin_node` VALUES (14, 0, '菜单列表', 2, 13, 1, '/index/Menu/menuList.html', 1, 13, 3, '');
INSERT INTO `t_admin_node` VALUES (15, 0, '用户列表', 2, 8, 1, '/index/User/userList.html', 1, 14, 3, '');
INSERT INTO `t_admin_node` VALUES (16, 0, '菜单数据', 3, 14, 1, '/index/Menu/menuListData.html', 1, 15, 4, '');
INSERT INTO `t_admin_node` VALUES (17, 0, '菜单新增页面', 3, 14, 1, '/index/Menu/menuAdd.html', 1, 16, 4, '');
INSERT INTO `t_admin_node` VALUES (18, 0, '菜单新增保存', 3, 14, 1, '/index/Menu/menuAddSave.html', 1, 17, 4, '');
INSERT INTO `t_admin_node` VALUES (19, 0, '菜单编辑保存', 3, 14, 1, '/index/Menu/menuEditSave.html', 1, 18, 4, '');
INSERT INTO `t_admin_node` VALUES (20, 0, '菜单编辑页面', 3, 14, 1, '/index/Menu/menuEdit.html', 1, 19, 4, '');
INSERT INTO `t_admin_node` VALUES (27, 0, '角色列表', 2, 8, 1, '/index/Role/roleList.html', 1, 0, 3, '');
INSERT INTO `t_admin_node` VALUES (28, 0, '角色数据', 3, 27, 1, '/index/Role/roleListData.html', 1, 0, 4, '');
INSERT INTO `t_admin_node` VALUES (30, 0, '菜单删除', 3, 14, 4, '/index/Menu/menuDele.html', 1, 0, 4, '');

-- ----------------------------
-- Table structure for t_admin_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_operation_log`;
CREATE TABLE `t_admin_operation_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '方法名',
  `admin_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_name`(`admin_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户操作记录表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_operation_log
-- ----------------------------
INSERT INTO `t_admin_operation_log` VALUES (1, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":1},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":1,\"update_time\":1642592155}}', 1642592156);
INSERT INTO `t_admin_operation_log` VALUES (2, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":1},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"update_time\":1642592184}}', 1642592184);
INSERT INTO `t_admin_operation_log` VALUES (3, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd52\",\"login_name\":\"test2\",\"login_pwd\":\"0192023a7bbd73250516f069df18b500\",\"status\":1,\"create_time\":1642592256,\"update_time\":1642592256,\"laston_ip\":\"127.0.0.1\",\"salt\":\"0ee5466f7e480f81c1d2b56a6e555c13\"}}', 1642592256);
INSERT INTO `t_admin_operation_log` VALUES (4, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd52\",\"status\":1},\"data\":{\"real_name\":\"\\u6d4b\\u8bd52\",\"status\":3,\"update_time\":1642642152}}', 1642642152);
INSERT INTO `t_admin_operation_log` VALUES (5, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd52\",\"status\":3},\"data\":{\"real_name\":\"\\u6d4b\\u8bd52\",\"status\":3,\"update_time\":1642642154}}', 1642642154);
INSERT INTO `t_admin_operation_log` VALUES (6, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"login_name\":\"test3\",\"login_pwd\":\"8ad8757baa8564dc136c1e07507f4a98\",\"status\":1,\"create_time\":1642642534,\"update_time\":1642642534,\"salt\":\"6bb8070a3bdfca18d9b62e40545038e5\"}}', 1642642534);
INSERT INTO `t_admin_operation_log` VALUES (7, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":1},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":3,\"update_time\":1642642544}}', 1642642544);
INSERT INTO `t_admin_operation_log` VALUES (8, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":3},\"data\":{\"real_name\":\"\\u6d4b\\u8bd53\",\"status\":3,\"update_time\":1642642556}}', 1642642556);
INSERT INTO `t_admin_operation_log` VALUES (9, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd53\",\"status\":3},\"data\":{\"real_name\":\"\\u6d4b\\u8bd53\",\"status\":3,\"update_time\":1642643974}}', 1642643974);
INSERT INTO `t_admin_operation_log` VALUES (10, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd53\",\"status\":3},\"data\":{\"status\":3,\"update_time\":1642643985}}', 1642643985);
INSERT INTO `t_admin_operation_log` VALUES (11, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"nodePid\":\"8\",\"modular\":\"index\",\"controller\":\"Role\",\"actionName\":[{\"node_title\":\"\\u89d2\\u8272\\u5217\\u8868\",\"show_type\":\"2\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"8\",\"data\":\"index\\/Role\\/roleList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"role\":{\"1\":\"on\",\"2\":\"on\"}}}', 1642991321);
INSERT INTO `t_admin_operation_log` VALUES (12, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"nodePid\":\"0\",\"modular\":\"index\",\"controller\":\"Role\",\"actionName\":[{\"node_title\":\"\\u89d2\\u8272\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/index\\/Role\\/roleListData.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"role\":{\"1\":\"on\"}}}', 1642991519);
INSERT INTO `t_admin_operation_log` VALUES (13, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":13,\"pj_id\":0,\"node_title\":\"\\u901a\\u7528\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":12,\"level\":2,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u901a\\u7528\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":12}}', 1643004974);
INSERT INTO `t_admin_operation_log` VALUES (14, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":13,\"pj_id\":0,\"node_title\":\"\\u901a\\u7528\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":12,\"level\":2,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u901a\\u7528\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":12}}', 1643005019);
INSERT INTO `t_admin_operation_log` VALUES (15, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"test\",\"show_type\":\"1\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/test\\/test\\/test.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"roleAccess\":[]}}', 1643005513);
INSERT INTO `t_admin_operation_log` VALUES (16, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u83dc\\u5355\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"14\",\"data\":\"\\/index\\/Menu\\/menuDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"30\"}]}}', 1643005647);
INSERT INTO `t_admin_operation_log` VALUES (17, 'app\\index\\logic\\Menu::menuDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"node_id\":29,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"}}', 1643006082);
INSERT INTO `t_admin_operation_log` VALUES (18, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"test\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/test\\/test\\/test.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"roleAccess\":[]}}', 1643006111);
INSERT INTO `t_admin_operation_log` VALUES (19, 'app\\index\\logic\\Menu::menuDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"node_id\":31,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":3,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"}}', 1643006117);
INSERT INTO `t_admin_operation_log` VALUES (20, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"tes\",\"show_type\":\"1\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/test\\/test\\/test.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"roleAccess\":[]}}', 1643006169);
INSERT INTO `t_admin_operation_log` VALUES (29, 'app\\index\\logic\\Menu::menuDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"node_id\":32,\"pj_id\":0,\"node_title\":\"tes\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"}}', 1643006296);

-- ----------------------------
-- Table structure for t_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role`;
CREATE TABLE `t_admin_role`  (
  `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_pid` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色父级ID',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `rolePid`(`role_pid`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限组' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_role
-- ----------------------------
INSERT INTO `t_admin_role` VALUES (1, '超级管理员', 0, 1, 0, 0);
INSERT INTO `t_admin_role` VALUES (2, '测试', 1, 1, 0, 0);

-- ----------------------------
-- Table structure for t_admin_role_access
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role_access`;
CREATE TABLE `t_admin_role_access`  (
  `role_id` smallint(6) UNSIGNED NOT NULL COMMENT '角色ID',
  `node_id` smallint(6) UNSIGNED NOT NULL COMMENT '节点ID',
  PRIMARY KEY (`role_id`, `node_id`) USING BTREE,
  INDEX `groupId`(`role_id`) USING BTREE,
  INDEX `nodeId`(`node_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_role_access
-- ----------------------------
INSERT INTO `t_admin_role_access` VALUES (1, 1);
INSERT INTO `t_admin_role_access` VALUES (1, 2);
INSERT INTO `t_admin_role_access` VALUES (1, 3);
INSERT INTO `t_admin_role_access` VALUES (1, 4);
INSERT INTO `t_admin_role_access` VALUES (1, 5);
INSERT INTO `t_admin_role_access` VALUES (1, 6);
INSERT INTO `t_admin_role_access` VALUES (1, 7);
INSERT INTO `t_admin_role_access` VALUES (1, 8);
INSERT INTO `t_admin_role_access` VALUES (1, 9);
INSERT INTO `t_admin_role_access` VALUES (1, 10);
INSERT INTO `t_admin_role_access` VALUES (1, 11);
INSERT INTO `t_admin_role_access` VALUES (1, 12);
INSERT INTO `t_admin_role_access` VALUES (1, 13);
INSERT INTO `t_admin_role_access` VALUES (1, 14);
INSERT INTO `t_admin_role_access` VALUES (1, 15);
INSERT INTO `t_admin_role_access` VALUES (1, 16);
INSERT INTO `t_admin_role_access` VALUES (1, 17);
INSERT INTO `t_admin_role_access` VALUES (1, 18);
INSERT INTO `t_admin_role_access` VALUES (1, 19);
INSERT INTO `t_admin_role_access` VALUES (1, 20);
INSERT INTO `t_admin_role_access` VALUES (1, 27);
INSERT INTO `t_admin_role_access` VALUES (1, 28);
INSERT INTO `t_admin_role_access` VALUES (1, 29);
INSERT INTO `t_admin_role_access` VALUES (1, 30);

-- ----------------------------
-- Table structure for t_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_user`;
CREATE TABLE `t_admin_user`  (
  `admin_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `login_pwd` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '帐号状态 1启用 2停用 3软删除',
  `salt` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机密码加密串',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `laston_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `laston_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `login_name`(`login_name`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_user
-- ----------------------------
INSERT INTO `t_admin_user` VALUES (1, 'yanghuan', '3b280b4d380facd4f0f5b6c717d79005', '杨欢', 1, '0cabc555ad4221b844e04b9f88681896', 1642575022, 1642586097, '127.0.0.1', 1643005654);
INSERT INTO `t_admin_user` VALUES (2, 'test', '0192023a7bbd73250516f069df18b500', '测试', 2, '9deed250a088da2a040c2bab4a1fcbb9', 1642586545, 1642592184, '127.0.0.1', 0);
INSERT INTO `t_admin_user` VALUES (10, 'test2', '0192023a7bbd73250516f069df18b500', '测试2', 3, '0ee5466f7e480f81c1d2b56a6e555c13', 1642592256, 1642642154, '127.0.0.1', 0);
INSERT INTO `t_admin_user` VALUES (11, 'test3', '8ad8757baa8564dc136c1e07507f4a98', '测试3', 3, '6bb8070a3bdfca18d9b62e40545038e5', 1642642534, 1642643985, '', 0);

-- ----------------------------
-- Table structure for t_bind_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_bind_admin_role`;
CREATE TABLE `t_bind_admin_role`  (
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `role_id` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  PRIMARY KEY (`admin_id`, `role_id`) USING BTREE,
  INDEX `adminId`(`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色与用户关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bind_admin_role
-- ----------------------------
INSERT INTO `t_bind_admin_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for t_config_params
-- ----------------------------
DROP TABLE IF EXISTS `t_config_params`;
CREATE TABLE `t_config_params`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '属性名',
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '键值',
  `msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数含义',
  `last_up_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后更新时间',
  `date_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置参数表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_params
-- ----------------------------
INSERT INTO `t_config_params` VALUES (1, 'authSign', '{\"0\":\"IwteRGXK33oiCnnR\"}', 'auto秘钥', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (2, 'jwtSign', '{\"0\":\"BQETsZPCUKVI6F00\"}', 'jwt秘钥', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (3, 'status', '{\"1\":\"启用\",\"2\":\"停用\"}', '通用状态', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (4, 'environType', '{\"1\":\"内网\",\"2\":\"外测\",\"3\":\"正式\"}', '环境类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (5, 'showType', '{\"1\":\"导航栏\",\"2\":\"列表菜单\",\"3\":\"不显示\"}', '菜单显示类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (6, 'nodeType', '{\"1\":\"查看\",\"2\":\"新增\",\"3\":\"修改\",\"4\":\"删除\",\"5\":\"导出\",\"6\":\"导入\",\"7\":\"审核\"}', '节点类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (7, 'blackListMenu', '{\"0\":\"1\"}', '黑名单菜单(不可修改)', 0, 0, 1);

-- ----------------------------
-- Table structure for t_config_pj
-- ----------------------------
DROP TABLE IF EXISTS `t_config_pj`;
CREATE TABLE `t_config_pj`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pj_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'pjId',
  `environ_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '环境ID 标识 1内测 2外测 3正式环境',
  `pj_title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目名称',
  `is_view` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有管理界面',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pj_id`(`pj_id`) USING BTREE,
  INDEX `environ_id`(`environ_id`) USING BTREE,
  INDEX `is_view`(`is_view`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_pj
-- ----------------------------
INSERT INTO `t_config_pj` VALUES (1, 0, 1, 'system', 1);
INSERT INTO `t_config_pj` VALUES (2, 0, 2, 'system', 1);
INSERT INTO `t_config_pj` VALUES (3, 0, 3, 'system', 1);
INSERT INTO `t_config_pj` VALUES (4, 1, 1, 'issue', 1);

SET FOREIGN_KEY_CHECKS = 1;
