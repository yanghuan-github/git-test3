/*
 Navicat Premium Data Transfer

 Source Server         : loca_web
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : system

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 09/02/2022 15:27:50
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
  `is_shortcut` tinyint(2) NOT NULL DEFAULT 2 COMMENT '快捷调整(显示至控制台处方便调整) 1显示 2不显示',
  PRIMARY KEY (`node_id`) USING BTREE,
  UNIQUE INDEX `node_title`(`node_title`) USING BTREE,
  INDEX `node_type`(`show_type`) USING BTREE,
  INDEX `data_type`(`node_type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `is_shortcut`(`is_shortcut`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台系统节点表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_node
-- ----------------------------
INSERT INTO `t_admin_node` VALUES (1, 0, '主页（默认存在）', 1, 0, 1, '/index/Index/index.html', 1, 1, 1, 'layui-icon-home', 2);
INSERT INTO `t_admin_node` VALUES (2, 0, '测试', 2, 1, 1, '', 1, 2, 2, '', 2);
INSERT INTO `t_admin_node` VALUES (3, 0, '测试二级', 3, 2, 1, '/index/Index/test2.html', 1, 3, 3, 'layui-icon-tips', 1);
INSERT INTO `t_admin_node` VALUES (4, 0, '控制台', 3, 1, 1, '/index/Index/console.html', 1, 4, 2, 'layui-icon-home', 1);
INSERT INTO `t_admin_node` VALUES (6, 0, '主页1', 2, 1, 1, '/index/Index/home1.html', 1, 5, 2, 'layui-icon-console', 1);
INSERT INTO `t_admin_node` VALUES (7, 0, '主页2', 2, 1, 1, '/index/Index/home2.html', 1, 6, 2, 'layui-icon-chart', 1);
INSERT INTO `t_admin_node` VALUES (8, 0, '用户', 2, 1, 1, '', 1, 7, 2, '', 2);
INSERT INTO `t_admin_node` VALUES (9, 0, '用户数据', 3, 15, 1, '/index/User/userListData.html', 1, 8, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (10, 0, '用户新增/编辑页面', 3, 15, 1, '/index/User/userEdit.html', 1, 9, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (11, 0, '用户新增保存', 3, 15, 1, '/index/User/userAddSave.html', 1, 10, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (12, 0, '用户编辑保存', 3, 15, 1, '/index/User/userEditSave.html', 1, 11, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (13, 0, '通用', 2, 1, 1, '', 1, 12, 2, '', 2);
INSERT INTO `t_admin_node` VALUES (14, 0, '菜单列表', 2, 13, 1, '/index/Config/menuList.html', 1, 13, 3, 'layui-icon-menu-fill', 1);
INSERT INTO `t_admin_node` VALUES (15, 0, '用户列表', 2, 8, 1, '/index/User/userList.html', 1, 14, 3, 'layui-icon-username', 1);
INSERT INTO `t_admin_node` VALUES (16, 0, '菜单数据', 3, 14, 1, '/index/Config/menuListData.html', 1, 15, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (17, 0, '菜单新增页面', 3, 14, 1, '/index/Config/menuAdd.html', 1, 16, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (18, 0, '菜单新增保存', 3, 14, 1, '/index/Config/menuAddSave.html', 1, 17, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (19, 0, '菜单编辑保存', 3, 14, 1, '/index/Config/menuEditSave.html', 1, 18, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (20, 0, '菜单编辑页面', 3, 14, 1, '/index/Config/menuEdit.html', 1, 19, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (27, 0, '角色列表', 2, 8, 1, '/index/User/roleList.html', 1, 0, 3, 'layui-icon-group', 1);
INSERT INTO `t_admin_node` VALUES (28, 0, '角色数据', 3, 27, 1, '/index/User/roleListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (30, 0, '菜单删除', 3, 14, 4, '/index/Config/menuDele.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (34, 0, '角色列表数据', 3, 27, 1, '/index/User/roleListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (35, 0, '角色新增，编辑页面', 3, 27, 1, '/index/User/roleEdit.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (36, 0, '角色编辑保存', 3, 27, 3, '/index/User/roleEditSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (37, 0, '角色新增保存', 3, 27, 2, '/index/User/roleAddSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (38, 0, '角色删除', 3, 27, 4, '/index/User/roleDele.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (39, 0, 'KV参数配置列表', 2, 13, 1, '/index/Config/paramList.html', 1, 0, 3, 'layui-icon-template', 1);
INSERT INTO `t_admin_node` VALUES (40, 0, 'KV参数配置列表数据', 3, 39, 1, '/index/Config/paramListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (41, 0, 'KV参数新增,编辑页', 3, 39, 1, '/index/Config/paramEdit.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (42, 0, 'KV参数编辑保存', 3, 39, 3, '/index/Config/paramEditSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (43, 0, 'KV参数新增保存', 3, 39, 2, '/index/Config/paramAddSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (44, 0, 'KV参数删除', 3, 39, 4, '/index/Config/paramDele.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (45, 0, '项目列表页', 2, 13, 1, '/index/Config/pjList.html', 1, 0, 3, 'layui-icon-app', 1);
INSERT INTO `t_admin_node` VALUES (46, 0, '项目列表数据', 3, 45, 1, '/index/Config/pjListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (47, 0, '项目新增，编辑页', 3, 45, 1, '/index/Config/pjEdit.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (48, 0, '项目新增保存', 3, 45, 2, '/index/Config/pjAddSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (49, 0, '项目编辑保存', 3, 45, 3, '/index/Config/pjEditSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (50, 0, '项目删除', 3, 45, 4, '/index/Config/pjDele.html', 1, 4, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (51, 0, 'test', 1, 0, 1, '/test/test/test.html', 2, 0, 1, '', 2);
INSERT INTO `t_admin_node` VALUES (52, 0, '用户删除', 3, 15, 4, '/index/User/userDele.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (53, 0, '角色权限编辑页面', 3, 27, 1, '/index/User/rolePer.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (54, 0, '角色权限编辑保存', 3, 27, 3, '/index/User/rolePerSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (56, 0, '继承父角色组权限保存', 3, 27, 3, '/index/User/roleExtSave.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (58, 0, 'test222', 3, 51, 1, '/test222/test/test222.html', 1, 0, 2, '', 2);
INSERT INTO `t_admin_node` VALUES (59, 0, '用户修改密码保存', 3, 15, 3, '/index/User/changePwdSave.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (60, 0, 'DB库管理', 2, 13, 1, '/index/Config/dbList.html', 1, 0, 3, '', 2);
INSERT INTO `t_admin_node` VALUES (61, 0, 'db库列表数据', 3, 60, 1, '/index/Config/dbListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (62, 0, 'db库新增，编辑页面', 3, 60, 1, '/index/Config/dbEdit.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (63, 0, 'db库新增保存', 3, 60, 1, '/index/Config/dbAddSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (64, 0, 'db库编辑保存', 3, 60, 1, '/index/Config/dbEditSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (65, 0, 'db库删除', 3, 60, 1, '/index/Config/dbDele.html', 1, 4, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (66, 0, '项目数据库', 2, 13, 1, '/index/Config/pjDatabaseList.html', 1, 0, 3, 'layui-icon-component', 1);
INSERT INTO `t_admin_node` VALUES (67, 0, '项目数据库列表数据', 3, 66, 1, '/index/Config/pjDatabaseListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (68, 0, '项目数据库新增，编辑页面', 3, 66, 1, '/index/Config/pjDatabaseEdit.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (69, 0, '项目数据库新增保存', 3, 66, 2, '/index/Config/pjDatabaseAddSave.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (70, 0, '项目数据库编辑保存', 3, 66, 3, '/index/Config/pjDatabaseEditSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (71, 0, '项目数据库复用页面', 3, 66, 1, '/index/Config/pjDatabaseCopy.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (72, 0, '项目数据库删除', 3, 66, 4, '/index/Config/pjDatabaseDele.html', 1, 4, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (73, 0, '项目服务器', 2, 13, 1, '/index/Config/pjServerList.html', 1, 0, 3, '', 1);
INSERT INTO `t_admin_node` VALUES (74, 0, '项目服务器列表数据', 3, 73, 1, '/index/Config/pjServerListData.html', 1, 0, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (75, 0, '项目服务器新增，编辑页面', 3, 73, 1, '/index/Config/pjServerEdit.html', 1, 1, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (76, 0, '项目服务器新增保存', 3, 73, 1, '/index/Config/pjServerAddSave.html', 1, 2, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (77, 0, '项目服务器编辑保存', 3, 73, 1, '/index/Config/pjServerEditSave.html', 1, 3, 4, '', 2);
INSERT INTO `t_admin_node` VALUES (78, 0, '项目服务器删除', 3, 73, 1, '/index/Config/pjServerDele.html', 1, 4, 4, '', 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户操作记录表' ROW_FORMAT = Compact;

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
INSERT INTO `t_admin_operation_log` VALUES (30, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"test\",\"show_type\":\"1\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/test\\/test\\/test.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"roleAccess\":[{\"role_id\":2,\"node_id\":\"33\"}]}}', 1643007290);
INSERT INTO `t_admin_operation_log` VALUES (31, 'app\\index\\logic\\Menu::menuDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"node_id\":33,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"}}', 1643007301);
INSERT INTO `t_admin_operation_log` VALUES (32, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"\\u89d2\\u8272\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/roleListData.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"\\u89d2\\u8272\\u65b0\\u589e\\uff0c\\u7f16\\u8f91\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/roleEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"\\u89d2\\u8272\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/userEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"\\u89d2\\u8272\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"2\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/userAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"34\"},{\"role_id\":2,\"node_id\":\"34\"},{\"role_id\":1,\"node_id\":\"35\"},{\"role_id\":2,\"node_id\":\"35\"},{\"role_id\":1,\"node_id\":\"36\"},{\"role_id\":2,\"node_id\":\"36\"},{\"role_id\":1,\"node_id\":\"37\"},{\"role_id\":2,\"node_id\":\"37\"}]}}', 1643008316);
INSERT INTO `t_admin_operation_log` VALUES (33, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":36,\"pj_id\":0,\"node_title\":\"\\u89d2\\u8272\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":3,\"node_pid\":27,\"node_type\":3,\"data\":\"\\/index\\/Role\\/userEditSave.html\",\"status\":1,\"sort\":2,\"level\":4,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u89d2\\u8272\\u7f16\\u8f91\\u4fdd\\u5b58\",\"node_pid\":27,\"show_type\":3,\"node_type\":3,\"status\":1,\"data\":\"\\/index\\/Role\\/roleEditSave.html\",\"sort\":2}}', 1643012029);
INSERT INTO `t_admin_operation_log` VALUES (34, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":37,\"pj_id\":0,\"node_title\":\"\\u89d2\\u8272\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":3,\"node_pid\":27,\"node_type\":2,\"data\":\"\\/index\\/Role\\/userAddSave.html\",\"status\":1,\"sort\":3,\"level\":4,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u89d2\\u8272\\u65b0\\u589e\\u4fdd\\u5b58\",\"node_pid\":27,\"show_type\":3,\"node_type\":2,\"status\":1,\"data\":\"\\/index\\/Role\\/roleAddSave.html\",\"sort\":3}}', 1643012042);
INSERT INTO `t_admin_operation_log` VALUES (35, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":1,\"create_time\":0,\"update_time\":0},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":1,\"update_time\":1643013194}}', 1643013194);
INSERT INTO `t_admin_operation_log` VALUES (36, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":1,\"create_time\":0,\"update_time\":1643013194},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":2,\"update_time\":1643013201}}', 1643013201);
INSERT INTO `t_admin_operation_log` VALUES (37, 'app\\index\\logic\\Role::roleAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u96c6\",\"role_pid\":2,\"status\":1,\"create_time\":1643015269,\"update_time\":1643015269}}', 1643015270);
INSERT INTO `t_admin_operation_log` VALUES (38, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":10,\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u96c6\",\"role_pid\":2,\"status\":1,\"create_time\":1643015269,\"update_time\":1643015269},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u96c6\",\"role_pid\":2,\"status\":2,\"update_time\":1643015281}}', 1643015281);
INSERT INTO `t_admin_operation_log` VALUES (39, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u89d2\\u8272\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"28\",\"data\":\"\\/inde\\/Role\\/roleDele.html\",\"pj_id\":0,\"status\":1,\"level\":5}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"38\"},{\"role_id\":2,\"node_id\":\"38\"},{\"role_id\":10,\"node_id\":\"38\"}]}}', 1643015409);
INSERT INTO `t_admin_operation_log` VALUES (40, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":38,\"pj_id\":0,\"node_title\":\"\\u89d2\\u8272\\u5220\\u9664\",\"show_type\":3,\"node_pid\":28,\"node_type\":4,\"data\":\"\\/inde\\/Role\\/roleDele.html\",\"status\":1,\"sort\":0,\"level\":5,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u89d2\\u8272\\u5220\\u9664\",\"node_pid\":27,\"show_type\":3,\"node_type\":4,\"status\":1,\"data\":\"\\/inde\\/Role\\/roleDele.html\"}}', 1643015442);
INSERT INTO `t_admin_operation_log` VALUES (41, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":38,\"pj_id\":0,\"node_title\":\"\\u89d2\\u8272\\u5220\\u9664\",\"show_type\":3,\"node_pid\":27,\"node_type\":4,\"data\":\"\\/inde\\/Role\\/roleDele.html\",\"status\":1,\"sort\":0,\"level\":4,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u89d2\\u8272\\u5220\\u9664\",\"node_pid\":27,\"show_type\":3,\"node_type\":4,\"status\":1,\"data\":\"\\/index\\/Role\\/roleDele.html\"}}', 1643015555);
INSERT INTO `t_admin_operation_log` VALUES (42, 'app\\index\\logic\\Role::roleAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"role_name\":\"test\",\"role_pid\":10,\"status\":1,\"create_time\":1643016112,\"update_time\":1643016112}}', 1643016112);
INSERT INTO `t_admin_operation_log` VALUES (43, 'app\\index\\logic\\Role::roleDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"role_id\":11,\"role_name\":\"test\",\"role_pid\":10,\"status\":1,\"create_time\":1643016112,\"update_time\":1643016112}}', 1643016133);
INSERT INTO `t_admin_operation_log` VALUES (44, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"KV\\u53c2\\u6570\\u914d\\u7f6e\\u5217\\u8868\\u9875\",\"show_type\":\"1\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"13\",\"data\":\"\\/index\\/Config\\/paramList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"39\"},{\"role_id\":2,\"node_id\":\"39\"},{\"role_id\":10,\"node_id\":\"39\"}]}}', 1643022956);
INSERT INTO `t_admin_operation_log` VALUES (45, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"KV\\u53c2\\u6570\\u914d\\u7f6e\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"39\",\"data\":\"\\/index\\/Config\\/paramListData.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"KV\\u53c2\\u6570\\u65b0\\u589e,\\u7f16\\u8f91\\u9875\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"39\",\"data\":\"\\/index\\/Config\\/paramEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"KV\\u53c2\\u6570\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"39\",\"data\":\"\\/index\\/Config\\/paramEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"KV\\u53c2\\u6570\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"2\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"39\",\"data\":\"\\/index\\/Config\\/paramAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"40\"},{\"role_id\":2,\"node_id\":\"40\"},{\"role_id\":10,\"node_id\":\"40\"},{\"role_id\":1,\"node_id\":\"41\"},{\"role_id\":2,\"node_id\":\"41\"},{\"role_id\":10,\"node_id\":\"41\"},{\"role_id\":1,\"node_id\":\"42\"},{\"role_id\":2,\"node_id\":\"42\"},{\"role_id\":10,\"node_id\":\"42\"},{\"role_id\":1,\"node_id\":\"43\"},{\"role_id\":2,\"node_id\":\"43\"},{\"role_id\":10,\"node_id\":\"43\"}]}}', 1643023017);
INSERT INTO `t_admin_operation_log` VALUES (46, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":39,\"pj_id\":0,\"node_title\":\"KV\\u53c2\\u6570\\u914d\\u7f6e\\u5217\\u8868\\u9875\",\"show_type\":1,\"node_pid\":13,\"node_type\":1,\"data\":\"\\/index\\/Config\\/paramList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"\"},\"data\":{\"node_title\":\"KV\\u53c2\\u6570\\u914d\\u7f6e\\u5217\\u8868\\u9875\",\"node_pid\":13,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/paramList.html\"}}', 1643023090);
INSERT INTO `t_admin_operation_log` VALUES (47, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"KV\\u53c2\\u6570\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"39\",\"data\":\"\\/index\\/Config\\/paramDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"44\"},{\"role_id\":2,\"node_id\":\"44\"},{\"role_id\":10,\"node_id\":\"44\"}]}}', 1643023407);
INSERT INTO `t_admin_operation_log` VALUES (50, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":10,\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u96c6\",\"role_pid\":2,\"status\":2,\"create_time\":1643015269,\"update_time\":1643015281},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":2,\"update_time\":1643024058}}', 1643024058);
INSERT INTO `t_admin_operation_log` VALUES (51, 'app\\index\\logic\\Config::paramAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"name\":\"test\",\"value\":\"test\",\"status\":1,\"create_time\":1643077210,\"update_time\":1643077210}}', 1643077210);
INSERT INTO `t_admin_operation_log` VALUES (52, 'app\\index\\logic\\Config::paramEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"id\":11,\"name\":\"test\",\"value\":\"test\",\"msg\":\"\",\"update_time\":1643077210,\"create_time\":1643077210,\"status\":1},\"data\":{\"name\":\"test\",\"value\":\"test\",\"status\":1,\"update_time\":1643077376}}', 1643077376);
INSERT INTO `t_admin_operation_log` VALUES (53, 'app\\index\\logic\\Config::paramEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"id\":11,\"name\":\"test\",\"value\":\"test\",\"msg\":\"\",\"update_time\":1643077376,\"create_time\":1643077210,\"status\":1},\"data\":{\"name\":\"test\",\"value\":\"test\",\"msg\":\"321321\",\"status\":2,\"update_time\":1643077458}}', 1643077458);
INSERT INTO `t_admin_operation_log` VALUES (54, 'app\\index\\logic\\Config::paramDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"id\":11,\"name\":\"test\",\"value\":\"test\",\"msg\":\"321321\",\"update_time\":1643077458,\"create_time\":1643077210,\"status\":2}}', 1643077632);
INSERT INTO `t_admin_operation_log` VALUES (55, 'app\\index\\logic\\Config::paramAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"name\":\"fdasfa\",\"value\":\"fdasfdas\",\"msg\":\"fdasfda\",\"status\":1,\"create_time\":1643077727,\"update_time\":1643077727}}', 1643077727);
INSERT INTO `t_admin_operation_log` VALUES (56, 'app\\index\\logic\\Config::paramEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"id\":13,\"name\":\"fdasfa\",\"value\":\"fdasfdas\",\"msg\":\"fdasfda\",\"update_time\":1643077727,\"create_time\":1643077727,\"status\":1},\"data\":{\"name\":\"fdasfa\",\"value\":\"fdasfdas\",\"msg\":\"fdasfda\",\"status\":2,\"update_time\":1643077821}}', 1643077821);
INSERT INTO `t_admin_operation_log` VALUES (57, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u9879\\u76ee\\u5217\\u8868\\u9875\",\"show_type\":\"2\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"13\",\"data\":\"\\/index\\/Conifg\\/pjList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"roleAccess\":[{\"role_id\":2,\"node_id\":\"45\"},{\"role_id\":1,\"node_id\":\"45\"}]}}', 1643078330);
INSERT INTO `t_admin_operation_log` VALUES (58, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"\\u9879\\u76ee\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"45\",\"data\":\"\\/index\\/Config\\/pjListData.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"\\u9879\\u76ee\\u65b0\\u589e\\uff0c\\u7f16\\u8f91\\u9875\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"45\",\"data\":\"\\/index\\/Config\\/pjEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"\\u9879\\u76ee\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"2\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"45\",\"data\":\"\\/index\\/Config\\/pjAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"\\u9879\\u76ee\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"45\",\"data\":\"\\/index\\/Config\\/pjEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"5\":{\"node_title\":\"\\u9879\\u76ee\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"sort\":\"4\",\"remark\":\"\",\"node_pid\":\"45\",\"data\":\"\\/index\\/Config\\/pjDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":2,\"node_id\":\"46\"},{\"role_id\":1,\"node_id\":\"46\"},{\"role_id\":2,\"node_id\":\"47\"},{\"role_id\":1,\"node_id\":\"47\"},{\"role_id\":2,\"node_id\":\"48\"},{\"role_id\":1,\"node_id\":\"48\"},{\"role_id\":2,\"node_id\":\"49\"},{\"role_id\":1,\"node_id\":\"49\"},{\"role_id\":2,\"node_id\":\"50\"},{\"role_id\":1,\"node_id\":\"50\"}]}}', 1643078394);
INSERT INTO `t_admin_operation_log` VALUES (59, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":45,\"pj_id\":0,\"node_title\":\"\\u9879\\u76ee\\u5217\\u8868\\u9875\",\"show_type\":2,\"node_pid\":13,\"node_type\":1,\"data\":\"\\/index\\/Conifg\\/pjList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u9879\\u76ee\\u5217\\u8868\\u9875\",\"node_pid\":13,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/pjList.html\"}}', 1643078464);
INSERT INTO `t_admin_operation_log` VALUES (60, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"test\",\"show_type\":\"1\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"0\",\"data\":\"\\/test\\/test\\/test.html\",\"pj_id\":0,\"status\":1,\"level\":1}],\"roleAccess\":[]}}', 1643079074);
INSERT INTO `t_admin_operation_log` VALUES (61, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":1,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643079154);
INSERT INTO `t_admin_operation_log` VALUES (62, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":1,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643079170);
INSERT INTO `t_admin_operation_log` VALUES (63, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":2,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643079924);
INSERT INTO `t_admin_operation_log` VALUES (64, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":13,\"pj_id\":0,\"node_title\":\"\\u901a\\u7528\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":12,\"level\":2,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u901a\\u7528\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":2,\"sort\":12}}', 1643079935);
INSERT INTO `t_admin_operation_log` VALUES (65, 'app\\index\\logic\\Config::pjAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"pj_id\":10,\"environ_id\":1,\"pj_logo\":\"test\",\"pj_name\":\"test\",\"is_view\":1}}', 1643092269);
INSERT INTO `t_admin_operation_log` VALUES (66, 'app\\index\\logic\\Config::pjAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"pj_id\":11,\"environ_id\":1,\"pj_logo\":\"test2\",\"pj_name\":\"test2\",\"is_view\":1}}', 1643092606);
INSERT INTO `t_admin_operation_log` VALUES (67, 'app\\index\\logic\\Config::pjDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"id\":6,\"pj_id\":11,\"environ_id\":1,\"pj_logo\":\"test2\",\"pj_name\":\"test2\",\"is_view\":1}}', 1643092743);
INSERT INTO `t_admin_operation_log` VALUES (68, 'app\\index\\logic\\Config::pjDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"id\":5,\"pj_id\":10,\"environ_id\":1,\"pj_logo\":\"test\",\"pj_name\":\"test\",\"is_view\":1}}', 1643092750);
INSERT INTO `t_admin_operation_log` VALUES (69, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":10,\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":2,\"create_time\":1643015269,\"update_time\":1643024058},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":3,\"update_time\":1643095514}}', 1643095514);
INSERT INTO `t_admin_operation_log` VALUES (70, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_name\":\"test\",\"login_pwd\":\"0192023a7bbd73250516f069df18b500\",\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"role_id\":null},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"update_time\":1643098640}}', 1643098640);
INSERT INTO `t_admin_operation_log` VALUES (73, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_name\":\"test\",\"login_pwd\":\"0192023a7bbd73250516f069df18b500\",\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"role_id\":null},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"update_time\":1643099095,\"role_id\":2}}', 1643099096);
INSERT INTO `t_admin_operation_log` VALUES (74, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_name\":\"test\",\"login_pwd\":\"0192023a7bbd73250516f069df18b500\",\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"role_id\":null},\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\",\"status\":2,\"update_time\":1643099169,\"role_id\":2},\"add\":{\"admin_id\":2,\"role_id\":2}}', 1643099169);
INSERT INTO `t_admin_operation_log` VALUES (75, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd54\",\"login_name\":\"test4\",\"login_pwd\":\"86985e105f79b95d6bc918fb45ec7727\",\"status\":1,\"create_time\":1643099246,\"update_time\":1643099246,\"salt\":\"323d35b5150fb2f8513ead9daca2dca1\"}}', 1643099246);
INSERT INTO `t_admin_operation_log` VALUES (76, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u7528\\u6237\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"15\",\"data\":\"\\/index\\/User\\/userDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"52\"}]}}', 1643100593);
INSERT INTO `t_admin_operation_log` VALUES (77, 'app\\index\\logic\\User::userDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"login_name\":\"test4\",\"login_pwd\":\"86985e105f79b95d6bc918fb45ec7727\",\"real_name\":\"\\u6d4b\\u8bd54\",\"status\":1,\"role_id\":null}}', 1643100603);
INSERT INTO `t_admin_operation_log` VALUES (78, 'app\\index\\logic\\User::userDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"login_name\":\"test4\",\"login_pwd\":\"86985e105f79b95d6bc918fb45ec7727\",\"real_name\":\"\\u6d4b\\u8bd54\",\"status\":3,\"role_id\":null}}', 1643100654);
INSERT INTO `t_admin_operation_log` VALUES (79, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"login_name\":\"test5\",\"login_pwd\":\"e3d704f3542b44a621ebed70dc0efe13\",\"status\":1,\"create_time\":1643100794,\"update_time\":1643100794,\"salt\":\"ea145d8e80c765fc8c69eb7c4d1ee36a\"},\"add\":{\"admin_id\":\"13\",\"role_id\":2}}', 1643100795);
INSERT INTO `t_admin_operation_log` VALUES (80, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":10,\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":3,\"create_time\":1643015269,\"update_time\":1643095514},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":1,\"update_time\":1643101076}}', 1643101076);
INSERT INTO `t_admin_operation_log` VALUES (81, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":10,\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":1,\"create_time\":1643015269,\"update_time\":1643101076},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\\u5b50\\u7ea7\",\"role_pid\":2,\"status\":3,\"update_time\":1643101401}}', 1643101401);
INSERT INTO `t_admin_operation_log` VALUES (82, 'app\\index\\logic\\Role::roleDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":2,\"create_time\":0,\"update_time\":1643013201}}', 1643101433);
INSERT INTO `t_admin_operation_log` VALUES (83, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":3,\"create_time\":0,\"update_time\":1643101433},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":2,\"update_time\":1643101442}}', 1643101443);
INSERT INTO `t_admin_operation_log` VALUES (84, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"2\":{\"node_title\":\"\\u89d2\\u8272\\u6743\\u9650\\u7f16\\u8f91\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/idnex\\/Role\\/rolePer.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"\\u89d2\\u8272\\u6743\\u9650\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/idnex\\/Role\\/rolePerSave.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"53\"},{\"role_id\":1,\"node_id\":\"54\"}]}}', 1643102947);
INSERT INTO `t_admin_operation_log` VALUES (85, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":1},\"update\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":2,\"update_time\":1643162854},\"add\":{\"admin_id\":13,\"role_id\":2}}', 1643162854);
INSERT INTO `t_admin_operation_log` VALUES (86, 'app\\index\\logic\\User::userDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"admin_id\":13,\"login_name\":\"test5\",\"login_pwd\":\"e3d704f3542b44a621ebed70dc0efe13\",\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":2,\"salt\":\"ea145d8e80c765fc8c69eb7c4d1ee36a\",\"create_time\":0,\"update_time\":1643101442,\"laston_ip\":\"\",\"laston_time\":0,\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1}}', 1643162861);
INSERT INTO `t_admin_operation_log` VALUES (87, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":3},\"update\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":3,\"update_time\":1643162874},\"add\":{\"admin_id\":13,\"role_id\":1}}', 1643162874);
INSERT INTO `t_admin_operation_log` VALUES (88, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":3},\"update\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":3,\"update_time\":1643162882},\"add\":{\"admin_id\":13,\"role_id\":2}}', 1643162883);
INSERT INTO `t_admin_operation_log` VALUES (89, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"data\":[\"1\",\"8\",\"27\",\"34\",\"35\",\"36\",\"37\",\"38\",\"13\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643164513);
INSERT INTO `t_admin_operation_log` VALUES (90, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[1,8,13,27,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"data\":[\"1\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643164553);
INSERT INTO `t_admin_operation_log` VALUES (91, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":2,\"create_time\":0,\"update_time\":1643101442},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":1,\"update_time\":1643164614}}', 1643164614);
INSERT INTO `t_admin_operation_log` VALUES (92, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[],\"data\":[\"1\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643164703);
INSERT INTO `t_admin_operation_log` VALUES (93, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[38,39,40,41,42,43,44],\"data\":[\"1\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643164828);
INSERT INTO `t_admin_operation_log` VALUES (94, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[1,13,14,16,17,18,19,20,30,39,40,41,42,43,44,45,46,47,48,49,50],\"data\":[\"51\"]}', 1643164880);
INSERT INTO `t_admin_operation_log` VALUES (95, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[51],\"data\":[\"1\",\"13\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643164957);
INSERT INTO `t_admin_operation_log` VALUES (96, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[46,47,48,49,50],\"data\":[\"1\",\"13\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643169413);
INSERT INTO `t_admin_operation_log` VALUES (97, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[],\"data\":[]}', 1643169582);
INSERT INTO `t_admin_operation_log` VALUES (98, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[],\"data\":[\"1\",\"13\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643169598);
INSERT INTO `t_admin_operation_log` VALUES (99, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[46,47,48,49,50],\"data\":[]}', 1643169612);
INSERT INTO `t_admin_operation_log` VALUES (100, 'app\\index\\logic\\Menu::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"\\u7ee7\\u627f\\u7236\\u89d2\\u8272\\u7ec4\\u6743\\u9650\",\"show_type\":\"3\",\"node_type\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/roleExt.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"\\u7ee7\\u627f\\u7236\\u89d2\\u8272\\u7ec4\\u6743\\u9650\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"27\",\"data\":\"\\/index\\/Role\\/roleExtSave.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"55\"},{\"role_id\":1,\"node_id\":\"56\"}]}}', 1643176655);
INSERT INTO `t_admin_operation_log` VALUES (101, 'app\\index\\logic\\Menu::menuDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"node_id\":55,\"pj_id\":0,\"node_title\":\"\\u7ee7\\u627f\\u7236\\u89d2\\u8272\\u7ec4\\u6743\\u9650\",\"show_type\":3,\"node_pid\":27,\"node_type\":1,\"data\":\"\\/index\\/Role\\/roleExt.html\",\"status\":1,\"sort\":0,\"level\":4,\"remark\":\"\"}}', 1643176904);
INSERT INTO `t_admin_operation_log` VALUES (102, 'app\\index\\logic\\Role::roleExtSave', 'yanghuan', '{\"type\":1,\"oldData\":[1,13,39,40,41,42,43,44,45,46,47,48,49,50],\"data\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,27,28,29,30,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,52,53,54,56]}', 1643177388);
INSERT INTO `t_admin_operation_log` VALUES (103, 'app\\index\\logic\\Role::roleExtSave', 'yanghuan', '{\"type\":1,\"oldData\":[],\"data\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,27,28,29,30,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,52,53,54,56]}', 1643177418);
INSERT INTO `t_admin_operation_log` VALUES (104, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[3,4,5,6,7,9,10,11,12,16,17,18,19,20,28,29,30,34,35,36,37,38,40,41,42,43,44,46,47,48,49,50,52,53,54,56],\"data\":[\"1\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643177431);
INSERT INTO `t_admin_operation_log` VALUES (105, 'app\\index\\logic\\Role::roleExtSave', 'yanghuan', '{\"type\":1,\"oldData\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,27,28,29,30,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,52,53,54,56],\"data\":[1,13,14,16,17,18,19,20,30,39,40,41,42,43,44,45,46,47,48,49,50]}', 1643177439);
INSERT INTO `t_admin_operation_log` VALUES (106, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"login_name\":\"testadmin\",\"login_pwd\":\"0192023a7bbd73250516f069df18b500\",\"status\":1,\"create_time\":1643177642,\"update_time\":1643177642,\"salt\":\"fe58d8038d457d58b6dda004bac75660\"},\"add\":{\"admin_id\":\"15\",\"role_id\":2}}', 1643177642);
INSERT INTO `t_admin_operation_log` VALUES (107, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[16,17,18,19,20,30,40,41,42,43,44,46,47,48,49,50],\"data\":[\"1\",\"8\",\"15\",\"9\",\"10\",\"11\",\"12\",\"52\",\"27\",\"28\",\"34\",\"35\",\"36\",\"37\",\"38\",\"53\",\"54\",\"56\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643177661);
INSERT INTO `t_admin_operation_log` VALUES (108, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[9,10,11,12,16,17,18,19,20,28,30,34,35,36,37,38,40,41,42,43,44,46,47,48,49,50,52,53,54,56],\"data\":[\"1\",\"4\",\"8\",\"15\",\"9\",\"10\",\"11\",\"12\",\"52\",\"27\",\"28\",\"34\",\"35\",\"36\",\"37\",\"38\",\"53\",\"54\",\"56\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643177666);
INSERT INTO `t_admin_operation_log` VALUES (109, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[4,9,10,11,12,16,17,18,19,20,28,30,34,35,36,37,38,40,41,42,43,44,46,47,48,49,50,52,53,54,56],\"data\":[\"1\",\"4\",\"8\",\"15\",\"9\",\"10\",\"11\",\"12\",\"52\",\"27\",\"28\",\"34\",\"35\",\"36\",\"37\",\"38\",\"53\",\"54\",\"56\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643177668);
INSERT INTO `t_admin_operation_log` VALUES (110, 'app\\index\\logic\\User::userDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"admin_id\":15,\"login_name\":\"testadmin\",\"login_pwd\":\"80ca583297d1218b0241e8ff53327738\",\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1,\"salt\":\"bbbc7a7a48d3ac0eb3a6ffd707f24059\",\"create_time\":0,\"update_time\":1643164614,\"laston_ip\":\"127.0.0.1\",\"laston_time\":1643178176,\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1}}', 1643178183);
INSERT INTO `t_admin_operation_log` VALUES (111, 'app\\index\\logic\\User::userDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"admin_id\":15,\"login_name\":\"testadmin\",\"login_pwd\":\"80ca583297d1218b0241e8ff53327738\",\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1,\"salt\":\"bbbc7a7a48d3ac0eb3a6ffd707f24059\",\"create_time\":0,\"update_time\":1643164614,\"laston_ip\":\"127.0.0.1\",\"laston_time\":1643178176,\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1}}', 1643178258);
INSERT INTO `t_admin_operation_log` VALUES (112, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":3},\"update\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1,\"update_time\":1643178281},\"add\":{\"admin_id\":15,\"role_id\":2}}', 1643178281);
INSERT INTO `t_admin_operation_log` VALUES (113, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"login_name\":\"testadmin\",\"login_pwd\":\"5b502f396910345aff7ab2891db7236b\",\"status\":1,\"create_time\":1643178367,\"update_time\":1643178367,\"salt\":\"b90b492e5d5ad30c0403782915bbbe1b\"},\"add\":{\"admin_id\":\"16\",\"role_id\":2}}', 1643178367);
INSERT INTO `t_admin_operation_log` VALUES (114, 'app\\index\\logic\\User::userAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"login_name\":\"testadmin\",\"salt\":\"4469e3edb7d18d3be872201fefec2db7\",\"login_pwd\":\"13c33ed280d84810222cb0b77b964162\",\"status\":1,\"create_time\":1643178539,\"update_time\":1643178539},\"add\":{\"admin_id\":\"17\",\"role_id\":2}}', 1643178539);
INSERT INTO `t_admin_operation_log` VALUES (115, 'app\\index\\logic\\Role::roleAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"role_name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u5458\",\"role_pid\":1,\"status\":1,\"create_time\":1643178844,\"update_time\":1643178844}}', 1643178844);
INSERT INTO `t_admin_operation_log` VALUES (116, 'app\\index\\logic\\Role::roleEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":1,\"status\":1,\"create_time\":0,\"update_time\":1643164614},\"data\":{\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":12,\"status\":1,\"update_time\":1643178852}}', 1643178852);
INSERT INTO `t_admin_operation_log` VALUES (117, 'app\\index\\logic\\Role::roleExtSave', 'yanghuan', '{\"type\":1,\"oldData\":[],\"data\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,27,28,29,30,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,52,53,54,56]}', 1643179043);
INSERT INTO `t_admin_operation_log` VALUES (118, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[4,9,10,11,12,16,17,18,19,20,28,30,34,35,36,37,38,40,41,42,43,44,46,47,48,49,50,52,53,54,56],\"data\":[\"1\",\"4\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643179052);
INSERT INTO `t_admin_operation_log` VALUES (119, 'app\\index\\logic\\Role::rolePerSave', 'yanghuan', '{\"type\":1,\"oldData\":[16,17,18,19,20,30,40,41,42,43,44,46,47,48,49,50],\"data\":[\"1\",\"13\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643179061);
INSERT INTO `t_admin_operation_log` VALUES (120, 'app\\index\\logic\\User::userEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1},\"update\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1,\"update_time\":1643179071},\"add\":{\"admin_id\":17,\"role_id\":12}}', 1643179071);
INSERT INTO `t_admin_operation_log` VALUES (121, 'app\\index\\logic\\User::userEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":3},\"update\":{\"real_name\":\"\\u6d4b\\u8bd55\",\"status\":2,\"update_time\":1643179167},\"add\":{\"admin_id\":13,\"role_id\":2}}', 1643179167);
INSERT INTO `t_admin_operation_log` VALUES (122, 'app\\index\\logic\\Menu::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":2,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":1,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643179613);
INSERT INTO `t_admin_operation_log` VALUES (123, 'app\\index\\logic\\Menu::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":2,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643179621);
INSERT INTO `t_admin_operation_log` VALUES (124, 'app\\index\\logic\\Config::paramDele', 'yanghuan', '{\"type\":3,\"oldData\":{\"id\":13,\"name\":\"fdasfa\",\"value\":\"fdasfdas\",\"msg\":\"fdasfda\",\"update_time\":1643077821,\"create_time\":1643077727,\"status\":2}}', 1643179736);
INSERT INTO `t_admin_operation_log` VALUES (125, 'app\\index\\logic\\Menu::menuEditSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"node_id\":27,\"pj_id\":0,\"node_title\":\"\\u89d2\\u8272\\u5217\\u8868\",\"show_type\":2,\"node_pid\":8,\"node_type\":1,\"data\":\"\\/index\\/Role\\/roleList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u89d2\\u8272\\u5217\\u8868\",\"node_pid\":8,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/User\\/roleList.html\"}}', 1643182055);
INSERT INTO `t_admin_operation_log` VALUES (126, 'app\\index\\logic\\User::roleAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"role_name\":\"aaa\",\"role_pid\":10,\"status\":1,\"create_time\":1643182680,\"update_time\":1643182680}}', 1643182680);
INSERT INTO `t_admin_operation_log` VALUES (127, 'app\\index\\logic\\User::roleDele', 'testadmin', '{\"type\":3,\"oldData\":{\"role_id\":2,\"role_name\":\"\\u6d4b\\u8bd5\",\"role_pid\":12,\"status\":1,\"create_time\":0,\"update_time\":1643178852}}', 1643182718);
INSERT INTO `t_admin_operation_log` VALUES (128, 'app\\index\\logic\\User::roleEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"role_id\":13,\"role_name\":\"aaa\",\"role_pid\":10,\"status\":1,\"create_time\":1643182680,\"update_time\":1643182680},\"data\":{\"role_name\":\"aaa\",\"role_pid\":12,\"status\":1,\"update_time\":1643182729}}', 1643182729);
INSERT INTO `t_admin_operation_log` VALUES (129, 'app\\index\\logic\\User::roleExtSave', 'testadmin', '{\"type\":1,\"oldData\":[],\"data\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,27,28,29,30,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,52,53,54,56]}', 1643182741);
INSERT INTO `t_admin_operation_log` VALUES (130, 'app\\index\\logic\\User::rolePerSave', 'testadmin', '{\"type\":1,\"oldData\":[3,4,5,6,7,9,10,11,12,16,17,18,19,20,28,29,30,34,35,36,37,38,40,41,42,43,44,46,47,48,49,50,52,53,54,56],\"data\":[\"1\",\"13\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643182754);
INSERT INTO `t_admin_operation_log` VALUES (131, 'app\\index\\logic\\User::roleEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"role_id\":13,\"role_name\":\"aaa\",\"role_pid\":12,\"status\":1,\"create_time\":1643182680,\"update_time\":1643182729},\"data\":{\"role_name\":\"\\u5f00\\u53d1\\u4eba\\u5458\",\"role_pid\":12,\"status\":1,\"update_time\":1643184318}}', 1643184318);
INSERT INTO `t_admin_operation_log` VALUES (132, 'app\\index\\logic\\User::rolePerSave', 'testadmin', '{\"type\":1,\"oldData\":[46,47,48,49,50],\"data\":[\"1\",\"4\",\"8\",\"15\",\"9\",\"10\",\"11\",\"12\",\"52\",\"27\",\"28\",\"34\",\"35\",\"36\",\"37\",\"38\",\"53\",\"54\",\"56\",\"13\",\"14\",\"16\",\"17\",\"18\",\"19\",\"20\",\"30\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\",\"47\",\"48\",\"49\",\"50\"]}', 1643184330);
INSERT INTO `t_admin_operation_log` VALUES (133, 'app\\index\\logic\\User::userEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1},\"update\":{\"real_name\":\"\\u6d4b\\u8bd5\\u8d26\\u53f7\",\"status\":1,\"update_time\":1643184338},\"add\":{\"admin_id\":17,\"role_id\":13}}', 1643184339);
INSERT INTO `t_admin_operation_log` VALUES (134, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":2,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":1,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643184668);
INSERT INTO `t_admin_operation_log` VALUES (135, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":51,\"pj_id\":0,\"node_title\":\"test\",\"show_type\":1,\"node_pid\":0,\"node_type\":1,\"data\":\"\\/test\\/test\\/test.html\",\"status\":1,\"sort\":0,\"level\":1,\"remark\":\"\"},\"data\":{\"node_title\":\"test\",\"show_type\":1,\"node_type\":1,\"status\":2,\"data\":\"\\/test\\/test\\/test.html\"}}', 1643185333);
INSERT INTO `t_admin_operation_log` VALUES (136, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":8,\"pj_id\":0,\"node_title\":\"\\u7528\\u6237\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":7,\"level\":2,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u7528\\u6237\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":7,\"remark\":\"layui-icon layui-icon-user\"}}', 1643185835);
INSERT INTO `t_admin_operation_log` VALUES (137, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":13,\"pj_id\":0,\"node_title\":\"\\u901a\\u7528\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":12,\"level\":2,\"remark\":\"\"},\"data\":{\"node_title\":\"\\u901a\\u7528\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":12,\"remark\":\"layui-icon layui-icon-set\"}}', 1643185850);
INSERT INTO `t_admin_operation_log` VALUES (138, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":8,\"pj_id\":0,\"node_title\":\"\\u7528\\u6237\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":7,\"level\":2,\"remark\":\"layui-icon layui-icon-user\"},\"data\":{\"node_title\":\"\\u7528\\u6237\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":7,\"remark\":\"layui-icon-user\"}}', 1643185893);
INSERT INTO `t_admin_operation_log` VALUES (139, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":8,\"pj_id\":0,\"node_title\":\"\\u7528\\u6237\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":7,\"level\":2,\"remark\":\"layui-icon-user\"},\"data\":{\"node_title\":\"\\u7528\\u6237\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":7,\"remark\":\"layui-icon-user\"}}', 1643185894);
INSERT INTO `t_admin_operation_log` VALUES (140, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":13,\"pj_id\":0,\"node_title\":\"\\u901a\\u7528\",\"show_type\":2,\"node_pid\":1,\"node_type\":1,\"data\":\"\",\"status\":1,\"sort\":12,\"level\":2,\"remark\":\"layui-icon layui-icon-set\"},\"data\":{\"node_title\":\"\\u901a\\u7528\",\"node_pid\":1,\"show_type\":2,\"node_type\":1,\"status\":1,\"sort\":12,\"remark\":\"layui-icon-set\"}}', 1643185901);
INSERT INTO `t_admin_operation_log` VALUES (141, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"test222\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"51\",\"data\":\"\\/test222\\/test\\/test222.html\",\"pj_id\":0,\"status\":1,\"level\":2}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"58\"},{\"role_id\":12,\"node_id\":\"58\"},{\"role_id\":13,\"node_id\":\"58\"}]}}', 1643262327);
INSERT INTO `t_admin_operation_log` VALUES (142, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":58,\"pj_id\":0,\"node_title\":\"test222\",\"show_type\":3,\"node_pid\":51,\"node_type\":1,\"data\":\"\\/test222\\/test\\/test222.html\",\"status\":1,\"sort\":0,\"level\":2,\"remark\":\"\",\"is_shortcut\":1},\"data\":{\"node_title\":\"test222\",\"node_pid\":51,\"show_type\":3,\"node_type\":1,\"status\":1,\"data\":\"\\/test222\\/test\\/test222.html\"}}', 1643262519);
INSERT INTO `t_admin_operation_log` VALUES (143, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":58,\"pj_id\":0,\"node_title\":\"test222\",\"show_type\":3,\"node_pid\":51,\"node_type\":1,\"data\":\"\\/test222\\/test\\/test222.html\",\"status\":1,\"sort\":0,\"level\":2,\"remark\":\"\",\"is_shortcut\":1},\"data\":{\"node_title\":\"test222\",\"node_pid\":51,\"show_type\":3,\"node_type\":1,\"status\":1,\"data\":\"\\/test222\\/test\\/test222.html\",\"is_shortcut\":2}}', 1643262595);
INSERT INTO `t_admin_operation_log` VALUES (144, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":3,\"pj_id\":0,\"node_title\":\"\\u6d4b\\u8bd5\\u4e8c\\u7ea7\",\"show_type\":3,\"node_pid\":2,\"node_type\":1,\"data\":\"\\/index\\/Index\\/test2.html\",\"status\":1,\"sort\":3,\"level\":3,\"remark\":\"\",\"is_shortcut\":2},\"data\":{\"node_title\":\"\\u6d4b\\u8bd5\\u4e8c\\u7ea7\",\"node_pid\":2,\"show_type\":3,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Index\\/test2.html\",\"sort\":3,\"is_shortcut\":1}}', 1643264101);
INSERT INTO `t_admin_operation_log` VALUES (145, 'app\\index\\logic\\Config::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u7528\\u6237\\u4fee\\u6539\\u5bc6\\u7801\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"is_shortcut\":\"2\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"15\",\"data\":\"\\/index\\/User\\/changePwdSave.html\",\"pj_id\":0,\"status\":1,\"level\":4}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"59\"},{\"role_id\":12,\"node_id\":\"59\"},{\"role_id\":13,\"node_id\":\"59\"}]}}', 1643267880);
INSERT INTO `t_admin_operation_log` VALUES (146, 'app\\index\\logic\\User::changePwdSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_pwd\":\"3b280b4d380facd4f0f5b6c717d79005\",\"salt\":\"0cabc555ad4221b844e04b9f88681896\"},\"update\":{\"salt\":\"5f195777718c75a1f1b00e6b326e4904\",\"login_pwd\":\"7a6f3a0144b7303ba916862e32382463\",\"update_time\":1643269861}}', 1643269861);
INSERT INTO `t_admin_operation_log` VALUES (147, 'app\\index\\logic\\User::changePwdSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_pwd\":\"7a6f3a0144b7303ba916862e32382463\",\"salt\":\"5f195777718c75a1f1b00e6b326e4904\"},\"update\":{\"salt\":\"6e4d6ea9bbc46318297846b20cfba489\",\"login_pwd\":\"1522f42a630e52d61b86e3395cac62c8\",\"update_time\":1643269985}}', 1643269985);
INSERT INTO `t_admin_operation_log` VALUES (148, 'app\\index\\logic\\User::changePwdSave', 'yanghuan', '{\"type\":1,\"oldData\":{\"login_pwd\":\"1522f42a630e52d61b86e3395cac62c8\",\"salt\":\"6e4d6ea9bbc46318297846b20cfba489\"},\"update\":{\"salt\":\"a64845e407e99484d9f9cf2bc455f974\",\"login_pwd\":\"f3aef94277c86777918c97e8210a8dcd\",\"update_time\":1643270015}}', 1643270015);
INSERT INTO `t_admin_operation_log` VALUES (149, 'app\\index\\logic\\Config::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"DB\\u5e93\\u7ba1\\u7406\",\"show_type\":\"2\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"13\",\"data\":\"\\/index\\/Config\\/dbList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"60\"},{\"role_id\":12,\"node_id\":\"60\"},{\"role_id\":13,\"node_id\":\"60\"}]}}', 1643270445);
INSERT INTO `t_admin_operation_log` VALUES (150, 'app\\index\\logic\\Config::menuAddSave', 'yanghuan', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"db\\u5e93\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"60\",\"data\":\"\\/index\\/Config\\/dbListData.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"db\\u5e93\\u65b0\\u589e\\uff0c\\u7f16\\u8f91\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"60\",\"data\":\"\\/index\\/Config\\/dbEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"db\\u5e93\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"60\",\"data\":\"\\/index\\/Config\\/dbAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"db\\u5e93\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"60\",\"data\":\"\\/index\\/Config\\/dbEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"5\":{\"node_title\":\"db\\u5e93\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"4\",\"remark\":\"\",\"node_pid\":\"60\",\"data\":\"\\/index\\/Config\\/dbDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"61\"},{\"role_id\":12,\"node_id\":\"61\"},{\"role_id\":13,\"node_id\":\"61\"},{\"role_id\":1,\"node_id\":\"62\"},{\"role_id\":12,\"node_id\":\"62\"},{\"role_id\":13,\"node_id\":\"62\"},{\"role_id\":1,\"node_id\":\"63\"},{\"role_id\":12,\"node_id\":\"63\"},{\"role_id\":13,\"node_id\":\"63\"},{\"role_id\":1,\"node_id\":\"64\"},{\"role_id\":12,\"node_id\":\"64\"},{\"role_id\":13,\"node_id\":\"64\"},{\"role_id\":1,\"node_id\":\"65\"},{\"role_id\":12,\"node_id\":\"65\"},{\"role_id\":13,\"node_id\":\"65\"}]}}', 1643270740);
INSERT INTO `t_admin_operation_log` VALUES (151, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":60,\"pj_id\":0,\"node_title\":\"DB\\u5e93\\u7ba1\\u7406\",\"show_type\":2,\"node_pid\":13,\"node_type\":1,\"data\":\"\\/index\\/Config\\/dbList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"\",\"is_shortcut\":1},\"data\":{\"node_title\":\"DB\\u5e93\\u7ba1\\u7406\",\"node_pid\":13,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/dbList.html\",\"is_shortcut\":2}}', 1643271508);
INSERT INTO `t_admin_operation_log` VALUES (152, 'app\\index\\logic\\Config::dbAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"db_id\":2,\"type\":1,\"db_name\":\"issue\",\"msg\":\"\\u53d1\\u884c\\u7ba1\\u7406\\u7cfb\\u7edf\"}}', 1644291734);
INSERT INTO `t_admin_operation_log` VALUES (153, 'app\\index\\logic\\Config::dbEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"db_id\":2,\"db_name\":\"issue\",\"type\":1,\"msg\":\"\\u53d1\\u884c\\u7ba1\\u7406\\u7cfb\\u7edf\"},\"data\":{\"type\":2,\"db_name\":\"issue\",\"msg\":\"\\u53d1\\u884c\\u7ba1\\u7406\\u7cfb\\u7edf\"}}', 1644291917);
INSERT INTO `t_admin_operation_log` VALUES (154, 'app\\index\\logic\\Config::dbAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"db_id\":3,\"type\":1,\"db_name\":\"3\",\"msg\":\"3\"}}', 1644292254);
INSERT INTO `t_admin_operation_log` VALUES (155, 'app\\index\\logic\\Config::dbDele', 'testadmin', '{\"type\":3,\"oldData\":{\"db_id\":3,\"db_name\":\"3\",\"type\":1,\"msg\":\"3\"}}', 1644292258);
INSERT INTO `t_admin_operation_log` VALUES (156, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\",\"show_type\":\"2\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"layui-icon-component\",\"node_pid\":\"13\",\"data\":\"\\/index\\/Config\\/pjDatabaseList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"66\"},{\"role_id\":12,\"node_id\":\"66\"},{\"role_id\":13,\"node_id\":\"66\"}]}}', 1644302245);
INSERT INTO `t_admin_operation_log` VALUES (157, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":61,\"pj_id\":0,\"node_title\":\"db\\u5e93\\u5217\\u8868\\u6570\\u636e\",\"show_type\":3,\"node_pid\":60,\"node_type\":1,\"data\":\"\\/index\\/Config\\/dbListData.html\",\"status\":1,\"sort\":0,\"level\":4,\"remark\":\"\",\"is_shortcut\":1},\"data\":{\"node_title\":\"db\\u5e93\\u5217\\u8868\\u6570\\u636e\",\"node_pid\":60,\"show_type\":3,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/dbListData.html\",\"is_shortcut\":2}}', 1644302451);
INSERT INTO `t_admin_operation_log` VALUES (158, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseListData.html\",\"pj_id\":0,\"status\":1,\"level\":4}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"67\"},{\"role_id\":12,\"node_id\":\"67\"},{\"role_id\":13,\"node_id\":\"67\"}]}}', 1644302599);
INSERT INTO `t_admin_operation_log` VALUES (159, 'app\\index\\logic\\Config::paramAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"name\":\"dbAuthType\",\"value\":\"{&#34;1&#34;:&#34;\\u53ea\\u8bfb&#34;,&#34;2&#34;:&#34;\\u53ea\\u589e&#34;,&#34;3&#34;:&#34;\\u53ea\\u6539&#34;,&#34;4&#34;:&#34;\\u53ea\\u5220&#34;,&#34;5&#34;:&#34;\\u589e\\u6539\\u5220&#34;,&#34;99&#34;:&#34;ALL&#34;}\",\"msg\":\"\\u6570\\u636e\\u5e93\\u6743\\u9650\\u7c7b\\u578b\",\"status\":1,\"create_time\":1644304596,\"update_time\":1644304596}}', 1644304596);
INSERT INTO `t_admin_operation_log` VALUES (160, 'app\\index\\logic\\Config::paramAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"name\":\"dbType\",\"value\":\"{&#34;1&#34;:&#34;mysql&#34;}\",\"msg\":\"\\u6570\\u636e\\u5e93\\u7c7b\\u578b\",\"status\":1,\"create_time\":1644304942,\"update_time\":1644304942}}', 1644304942);
INSERT INTO `t_admin_operation_log` VALUES (161, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u65b0\\u589e\\uff0c\\u7f16\\u8f91\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"2\",\"is_shortcut\":\"1\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"3\",\"is_shortcut\":\"1\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u590d\\u7528\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseCopy.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"5\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"4\",\"is_shortcut\":\"1\",\"sort\":\"4\",\"remark\":\"\",\"node_pid\":\"66\",\"data\":\"\\/index\\/Config\\/pjDatabaseDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"68\"},{\"role_id\":12,\"node_id\":\"68\"},{\"role_id\":13,\"node_id\":\"68\"},{\"role_id\":1,\"node_id\":\"69\"},{\"role_id\":12,\"node_id\":\"69\"},{\"role_id\":13,\"node_id\":\"69\"},{\"role_id\":1,\"node_id\":\"70\"},{\"role_id\":12,\"node_id\":\"70\"},{\"role_id\":13,\"node_id\":\"70\"},{\"role_id\":1,\"node_id\":\"71\"},{\"role_id\":12,\"node_id\":\"71\"},{\"role_id\":13,\"node_id\":\"71\"},{\"role_id\":1,\"node_id\":\"72\"},{\"role_id\":12,\"node_id\":\"72\"},{\"role_id\":13,\"node_id\":\"72\"}]}}', 1644308558);
INSERT INTO `t_admin_operation_log` VALUES (162, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":66,\"pj_id\":0,\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\",\"show_type\":2,\"node_pid\":13,\"node_type\":1,\"data\":\"\\/index\\/Config\\/pjDatabaseList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"layui-icon-component\",\"is_shortcut\":1},\"data\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\",\"node_pid\":13,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/pjDatabaseList.html\",\"remark\":\"layui-icon-component\",\"is_shortcut\":2}}', 1644309459);
INSERT INTO `t_admin_operation_log` VALUES (163, 'app\\index\\logic\\Config::menuEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"node_id\":66,\"pj_id\":0,\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\",\"show_type\":2,\"node_pid\":13,\"node_type\":1,\"data\":\"\\/index\\/Config\\/pjDatabaseList.html\",\"status\":1,\"sort\":0,\"level\":3,\"remark\":\"layui-icon-component\",\"is_shortcut\":2},\"data\":{\"node_title\":\"\\u9879\\u76ee\\u6570\\u636e\\u5e93\",\"node_pid\":13,\"show_type\":2,\"node_type\":1,\"status\":1,\"data\":\"\\/index\\/Config\\/pjDatabaseList.html\",\"remark\":\"layui-icon-component\",\"is_shortcut\":1}}', 1644309667);
INSERT INTO `t_admin_operation_log` VALUES (164, 'app\\index\\logic\\Config::pjDatabaseAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":2,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":4,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"issue\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644312459);
INSERT INTO `t_admin_operation_log` VALUES (165, 'app\\index\\logic\\Config::pjDatabaseEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"id\":6,\"type\":2,\"environ_id\":1,\"auth_id\":4,\"db_type\":1,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_user\":\"root\",\"db_pwd\":\"root\",\"db_name\":\"issue\",\"db_charset\":\"utf8\"},\"data\":{\"type\":2,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":99,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"issue\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644312561);
INSERT INTO `t_admin_operation_log` VALUES (166, 'app\\index\\logic\\Config::pjDatabaseEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"id\":6,\"type\":2,\"environ_id\":1,\"auth_id\":99,\"db_type\":1,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_user\":\"root\",\"db_pwd\":\"root\",\"db_name\":\"issue\",\"db_charset\":\"utf8\"},\"data\":{\"type\":2,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":99,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"issue\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644313829);
INSERT INTO `t_admin_operation_log` VALUES (167, 'app\\index\\logic\\Config::pjDatabaseEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"id\":6,\"type\":2,\"environ_id\":1,\"auth_id\":99,\"db_type\":1,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_user\":\"root\",\"db_pwd\":\"root\",\"db_name\":\"issue\",\"db_charset\":\"utf8\"},\"data\":{\"type\":2,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":4,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"issue\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644313964);
INSERT INTO `t_admin_operation_log` VALUES (168, 'app\\index\\logic\\Config::pjDatabaseEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"id\":6,\"type\":2,\"environ_id\":1,\"auth_id\":4,\"db_type\":1,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_user\":\"root\",\"db_pwd\":\"root\",\"db_name\":\"issue\",\"db_charset\":\"utf8\"},\"data\":{\"type\":2,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":99,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"issue\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644313972);
INSERT INTO `t_admin_operation_log` VALUES (169, 'app\\index\\logic\\Config::pjDatabaseAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":1,\"db_host\":\"test\",\"db_port\":\"test\",\"db_name\":\"test\",\"db_user\":\"test\",\"db_pwd\":\"tes\"}}', 1644314004);
INSERT INTO `t_admin_operation_log` VALUES (170, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":2,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644375622);
INSERT INTO `t_admin_operation_log` VALUES (171, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":3,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644375801);
INSERT INTO `t_admin_operation_log` VALUES (172, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":3,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644375886);
INSERT INTO `t_admin_operation_log` VALUES (173, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":3,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644375934);
INSERT INTO `t_admin_operation_log` VALUES (174, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":1,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644376068);
INSERT INTO `t_admin_operation_log` VALUES (175, 'app\\index\\logic\\Config::pjDatabaseCopySave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"type\":1,\"environ_id\":\"1\",\"db_type\":\"1\",\"auth_id\":99,\"db_host\":\"127.0.0.1\",\"db_port\":\"3306\",\"db_name\":\"system\",\"db_user\":\"root\",\"db_pwd\":\"root\"}}', 1644376081);
INSERT INTO `t_admin_operation_log` VALUES (176, 'app\\index\\logic\\Config::pjDatabaseDele', 'testadmin', '{\"type\":3,\"oldData\":{\"id\":7,\"type\":1,\"environ_id\":1,\"auth_id\":1,\"db_type\":1,\"db_host\":\"test\",\"db_port\":\"test\",\"db_user\":\"test\",\"db_pwd\":\"tes\",\"db_name\":\"test\",\"db_charset\":\"utf8\"}}', 1644376370);
INSERT INTO `t_admin_operation_log` VALUES (177, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":[{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\",\"show_type\":\"2\",\"node_type\":\"1\",\"is_shortcut\":\"1\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"13\",\"data\":\"\\/index\\/Config\\/pjServerList.html\",\"pj_id\":0,\"status\":1,\"level\":3}],\"roleAccess\":[{\"role_id\":1,\"node_id\":\"73\"},{\"role_id\":12,\"node_id\":\"73\"},{\"role_id\":13,\"node_id\":\"73\"}]}}', 1644376504);
INSERT INTO `t_admin_operation_log` VALUES (178, 'app\\index\\logic\\Config::menuAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"actionName\":{\"0\":{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\\u5217\\u8868\\u6570\\u636e\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"\",\"remark\":\"\",\"node_pid\":\"73\",\"data\":\"\\/index\\/Config\\/pjServerListData.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"2\":{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\\u65b0\\u589e\\uff0c\\u7f16\\u8f91\\u9875\\u9762\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"1\",\"remark\":\"\",\"node_pid\":\"73\",\"data\":\"\\/index\\/Config\\/pjServerEdit.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"3\":{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\\u65b0\\u589e\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"2\",\"remark\":\"\",\"node_pid\":\"73\",\"data\":\"\\/index\\/Config\\/pjServerAddSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"4\":{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\\u7f16\\u8f91\\u4fdd\\u5b58\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"3\",\"remark\":\"\",\"node_pid\":\"73\",\"data\":\"\\/index\\/Config\\/pjServerEditSave.html\",\"pj_id\":0,\"status\":1,\"level\":4},\"5\":{\"node_title\":\"\\u9879\\u76ee\\u670d\\u52a1\\u5668\\u5220\\u9664\",\"show_type\":\"3\",\"node_type\":\"1\",\"is_shortcut\":\"2\",\"sort\":\"4\",\"remark\":\"\",\"node_pid\":\"73\",\"data\":\"\\/index\\/Config\\/pjServerDele.html\",\"pj_id\":0,\"status\":1,\"level\":4}},\"roleAccess\":[{\"role_id\":1,\"node_id\":\"74\"},{\"role_id\":12,\"node_id\":\"74\"},{\"role_id\":13,\"node_id\":\"74\"},{\"role_id\":1,\"node_id\":\"75\"},{\"role_id\":12,\"node_id\":\"75\"},{\"role_id\":13,\"node_id\":\"75\"},{\"role_id\":1,\"node_id\":\"76\"},{\"role_id\":12,\"node_id\":\"76\"},{\"role_id\":13,\"node_id\":\"76\"},{\"role_id\":1,\"node_id\":\"77\"},{\"role_id\":12,\"node_id\":\"77\"},{\"role_id\":13,\"node_id\":\"77\"},{\"role_id\":1,\"node_id\":\"78\"},{\"role_id\":12,\"node_id\":\"78\"},{\"role_id\":13,\"node_id\":\"78\"}]}}', 1644376709);
INSERT INTO `t_admin_operation_log` VALUES (179, 'app\\index\\logic\\Config::pjAddSave', 'testadmin', '{\"type\":2,\"oldData\":[],\"data\":{\"pj_id\":1,\"environ_id\":2,\"pj_logo\":\"issue\",\"pj_name\":\"\\u53d1\\u884c\\u540e\\u53f0 - \\u5916\\u6d4b\",\"is_view\":1}}', 1644389129);
INSERT INTO `t_admin_operation_log` VALUES (180, 'app\\index\\logic\\Config::pjEditSave', 'testadmin', '{\"type\":1,\"oldData\":{\"id\":7,\"pj_id\":2,\"environ_id\":1,\"pj_logo\":\"sdk\",\"pj_name\":\"sdk - \\u5185\\u7f51\",\"is_view\":1},\"data\":[]}', 1644389141);

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
  UNIQUE INDEX `role_name`(`role_name`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `role_pid`(`role_pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限组' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_role
-- ----------------------------
INSERT INTO `t_admin_role` VALUES (1, '超级管理员', 0, 1, 0, 0);
INSERT INTO `t_admin_role` VALUES (2, '测试', 12, 3, 0, 1643182718);
INSERT INTO `t_admin_role` VALUES (10, '测试子级', 2, 3, 1643015269, 1643101401);
INSERT INTO `t_admin_role` VALUES (12, '后台管理员', 1, 1, 1643178844, 1643178844);
INSERT INTO `t_admin_role` VALUES (13, '开发人员', 12, 1, 1643182680, 1643184318);

-- ----------------------------
-- Table structure for t_admin_role_access
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role_access`;
CREATE TABLE `t_admin_role_access`  (
  `role_id` smallint(6) UNSIGNED NOT NULL COMMENT '角色ID',
  `node_id` smallint(6) UNSIGNED NOT NULL COMMENT '节点ID',
  PRIMARY KEY (`role_id`, `node_id`) USING BTREE,
  INDEX `group_id`(`role_id`) USING BTREE,
  INDEX `node_id`(`node_id`) USING BTREE
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
INSERT INTO `t_admin_role_access` VALUES (1, 34);
INSERT INTO `t_admin_role_access` VALUES (1, 35);
INSERT INTO `t_admin_role_access` VALUES (1, 36);
INSERT INTO `t_admin_role_access` VALUES (1, 37);
INSERT INTO `t_admin_role_access` VALUES (1, 38);
INSERT INTO `t_admin_role_access` VALUES (1, 39);
INSERT INTO `t_admin_role_access` VALUES (1, 40);
INSERT INTO `t_admin_role_access` VALUES (1, 41);
INSERT INTO `t_admin_role_access` VALUES (1, 42);
INSERT INTO `t_admin_role_access` VALUES (1, 43);
INSERT INTO `t_admin_role_access` VALUES (1, 44);
INSERT INTO `t_admin_role_access` VALUES (1, 45);
INSERT INTO `t_admin_role_access` VALUES (1, 46);
INSERT INTO `t_admin_role_access` VALUES (1, 47);
INSERT INTO `t_admin_role_access` VALUES (1, 48);
INSERT INTO `t_admin_role_access` VALUES (1, 49);
INSERT INTO `t_admin_role_access` VALUES (1, 50);
INSERT INTO `t_admin_role_access` VALUES (1, 52);
INSERT INTO `t_admin_role_access` VALUES (1, 53);
INSERT INTO `t_admin_role_access` VALUES (1, 54);
INSERT INTO `t_admin_role_access` VALUES (1, 56);
INSERT INTO `t_admin_role_access` VALUES (1, 58);
INSERT INTO `t_admin_role_access` VALUES (1, 59);
INSERT INTO `t_admin_role_access` VALUES (1, 60);
INSERT INTO `t_admin_role_access` VALUES (1, 61);
INSERT INTO `t_admin_role_access` VALUES (1, 62);
INSERT INTO `t_admin_role_access` VALUES (1, 63);
INSERT INTO `t_admin_role_access` VALUES (1, 64);
INSERT INTO `t_admin_role_access` VALUES (1, 65);
INSERT INTO `t_admin_role_access` VALUES (1, 66);
INSERT INTO `t_admin_role_access` VALUES (1, 67);
INSERT INTO `t_admin_role_access` VALUES (1, 68);
INSERT INTO `t_admin_role_access` VALUES (1, 69);
INSERT INTO `t_admin_role_access` VALUES (1, 70);
INSERT INTO `t_admin_role_access` VALUES (1, 71);
INSERT INTO `t_admin_role_access` VALUES (1, 72);
INSERT INTO `t_admin_role_access` VALUES (1, 73);
INSERT INTO `t_admin_role_access` VALUES (1, 74);
INSERT INTO `t_admin_role_access` VALUES (1, 75);
INSERT INTO `t_admin_role_access` VALUES (1, 76);
INSERT INTO `t_admin_role_access` VALUES (1, 77);
INSERT INTO `t_admin_role_access` VALUES (1, 78);
INSERT INTO `t_admin_role_access` VALUES (2, 1);
INSERT INTO `t_admin_role_access` VALUES (2, 4);
INSERT INTO `t_admin_role_access` VALUES (2, 13);
INSERT INTO `t_admin_role_access` VALUES (2, 14);
INSERT INTO `t_admin_role_access` VALUES (2, 16);
INSERT INTO `t_admin_role_access` VALUES (2, 17);
INSERT INTO `t_admin_role_access` VALUES (2, 18);
INSERT INTO `t_admin_role_access` VALUES (2, 19);
INSERT INTO `t_admin_role_access` VALUES (2, 20);
INSERT INTO `t_admin_role_access` VALUES (2, 30);
INSERT INTO `t_admin_role_access` VALUES (2, 39);
INSERT INTO `t_admin_role_access` VALUES (2, 40);
INSERT INTO `t_admin_role_access` VALUES (2, 41);
INSERT INTO `t_admin_role_access` VALUES (2, 42);
INSERT INTO `t_admin_role_access` VALUES (2, 43);
INSERT INTO `t_admin_role_access` VALUES (2, 44);
INSERT INTO `t_admin_role_access` VALUES (2, 45);
INSERT INTO `t_admin_role_access` VALUES (2, 46);
INSERT INTO `t_admin_role_access` VALUES (2, 47);
INSERT INTO `t_admin_role_access` VALUES (2, 48);
INSERT INTO `t_admin_role_access` VALUES (2, 49);
INSERT INTO `t_admin_role_access` VALUES (2, 50);
INSERT INTO `t_admin_role_access` VALUES (10, 1);
INSERT INTO `t_admin_role_access` VALUES (10, 13);
INSERT INTO `t_admin_role_access` VALUES (10, 45);
INSERT INTO `t_admin_role_access` VALUES (10, 46);
INSERT INTO `t_admin_role_access` VALUES (10, 47);
INSERT INTO `t_admin_role_access` VALUES (10, 48);
INSERT INTO `t_admin_role_access` VALUES (10, 49);
INSERT INTO `t_admin_role_access` VALUES (10, 50);
INSERT INTO `t_admin_role_access` VALUES (12, 1);
INSERT INTO `t_admin_role_access` VALUES (12, 2);
INSERT INTO `t_admin_role_access` VALUES (12, 3);
INSERT INTO `t_admin_role_access` VALUES (12, 4);
INSERT INTO `t_admin_role_access` VALUES (12, 5);
INSERT INTO `t_admin_role_access` VALUES (12, 6);
INSERT INTO `t_admin_role_access` VALUES (12, 7);
INSERT INTO `t_admin_role_access` VALUES (12, 8);
INSERT INTO `t_admin_role_access` VALUES (12, 9);
INSERT INTO `t_admin_role_access` VALUES (12, 10);
INSERT INTO `t_admin_role_access` VALUES (12, 11);
INSERT INTO `t_admin_role_access` VALUES (12, 12);
INSERT INTO `t_admin_role_access` VALUES (12, 13);
INSERT INTO `t_admin_role_access` VALUES (12, 14);
INSERT INTO `t_admin_role_access` VALUES (12, 15);
INSERT INTO `t_admin_role_access` VALUES (12, 16);
INSERT INTO `t_admin_role_access` VALUES (12, 17);
INSERT INTO `t_admin_role_access` VALUES (12, 18);
INSERT INTO `t_admin_role_access` VALUES (12, 19);
INSERT INTO `t_admin_role_access` VALUES (12, 20);
INSERT INTO `t_admin_role_access` VALUES (12, 27);
INSERT INTO `t_admin_role_access` VALUES (12, 28);
INSERT INTO `t_admin_role_access` VALUES (12, 29);
INSERT INTO `t_admin_role_access` VALUES (12, 30);
INSERT INTO `t_admin_role_access` VALUES (12, 34);
INSERT INTO `t_admin_role_access` VALUES (12, 35);
INSERT INTO `t_admin_role_access` VALUES (12, 36);
INSERT INTO `t_admin_role_access` VALUES (12, 37);
INSERT INTO `t_admin_role_access` VALUES (12, 38);
INSERT INTO `t_admin_role_access` VALUES (12, 39);
INSERT INTO `t_admin_role_access` VALUES (12, 40);
INSERT INTO `t_admin_role_access` VALUES (12, 41);
INSERT INTO `t_admin_role_access` VALUES (12, 42);
INSERT INTO `t_admin_role_access` VALUES (12, 43);
INSERT INTO `t_admin_role_access` VALUES (12, 44);
INSERT INTO `t_admin_role_access` VALUES (12, 45);
INSERT INTO `t_admin_role_access` VALUES (12, 46);
INSERT INTO `t_admin_role_access` VALUES (12, 47);
INSERT INTO `t_admin_role_access` VALUES (12, 48);
INSERT INTO `t_admin_role_access` VALUES (12, 49);
INSERT INTO `t_admin_role_access` VALUES (12, 50);
INSERT INTO `t_admin_role_access` VALUES (12, 52);
INSERT INTO `t_admin_role_access` VALUES (12, 53);
INSERT INTO `t_admin_role_access` VALUES (12, 54);
INSERT INTO `t_admin_role_access` VALUES (12, 56);
INSERT INTO `t_admin_role_access` VALUES (12, 58);
INSERT INTO `t_admin_role_access` VALUES (12, 59);
INSERT INTO `t_admin_role_access` VALUES (12, 60);
INSERT INTO `t_admin_role_access` VALUES (12, 61);
INSERT INTO `t_admin_role_access` VALUES (12, 62);
INSERT INTO `t_admin_role_access` VALUES (12, 63);
INSERT INTO `t_admin_role_access` VALUES (12, 64);
INSERT INTO `t_admin_role_access` VALUES (12, 65);
INSERT INTO `t_admin_role_access` VALUES (12, 66);
INSERT INTO `t_admin_role_access` VALUES (12, 67);
INSERT INTO `t_admin_role_access` VALUES (12, 68);
INSERT INTO `t_admin_role_access` VALUES (12, 69);
INSERT INTO `t_admin_role_access` VALUES (12, 70);
INSERT INTO `t_admin_role_access` VALUES (12, 71);
INSERT INTO `t_admin_role_access` VALUES (12, 72);
INSERT INTO `t_admin_role_access` VALUES (12, 73);
INSERT INTO `t_admin_role_access` VALUES (12, 74);
INSERT INTO `t_admin_role_access` VALUES (12, 75);
INSERT INTO `t_admin_role_access` VALUES (12, 76);
INSERT INTO `t_admin_role_access` VALUES (12, 77);
INSERT INTO `t_admin_role_access` VALUES (12, 78);
INSERT INTO `t_admin_role_access` VALUES (13, 1);
INSERT INTO `t_admin_role_access` VALUES (13, 4);
INSERT INTO `t_admin_role_access` VALUES (13, 8);
INSERT INTO `t_admin_role_access` VALUES (13, 9);
INSERT INTO `t_admin_role_access` VALUES (13, 10);
INSERT INTO `t_admin_role_access` VALUES (13, 11);
INSERT INTO `t_admin_role_access` VALUES (13, 12);
INSERT INTO `t_admin_role_access` VALUES (13, 13);
INSERT INTO `t_admin_role_access` VALUES (13, 14);
INSERT INTO `t_admin_role_access` VALUES (13, 15);
INSERT INTO `t_admin_role_access` VALUES (13, 16);
INSERT INTO `t_admin_role_access` VALUES (13, 17);
INSERT INTO `t_admin_role_access` VALUES (13, 18);
INSERT INTO `t_admin_role_access` VALUES (13, 19);
INSERT INTO `t_admin_role_access` VALUES (13, 20);
INSERT INTO `t_admin_role_access` VALUES (13, 27);
INSERT INTO `t_admin_role_access` VALUES (13, 28);
INSERT INTO `t_admin_role_access` VALUES (13, 30);
INSERT INTO `t_admin_role_access` VALUES (13, 34);
INSERT INTO `t_admin_role_access` VALUES (13, 35);
INSERT INTO `t_admin_role_access` VALUES (13, 36);
INSERT INTO `t_admin_role_access` VALUES (13, 37);
INSERT INTO `t_admin_role_access` VALUES (13, 38);
INSERT INTO `t_admin_role_access` VALUES (13, 39);
INSERT INTO `t_admin_role_access` VALUES (13, 40);
INSERT INTO `t_admin_role_access` VALUES (13, 41);
INSERT INTO `t_admin_role_access` VALUES (13, 42);
INSERT INTO `t_admin_role_access` VALUES (13, 43);
INSERT INTO `t_admin_role_access` VALUES (13, 44);
INSERT INTO `t_admin_role_access` VALUES (13, 45);
INSERT INTO `t_admin_role_access` VALUES (13, 46);
INSERT INTO `t_admin_role_access` VALUES (13, 47);
INSERT INTO `t_admin_role_access` VALUES (13, 48);
INSERT INTO `t_admin_role_access` VALUES (13, 49);
INSERT INTO `t_admin_role_access` VALUES (13, 50);
INSERT INTO `t_admin_role_access` VALUES (13, 52);
INSERT INTO `t_admin_role_access` VALUES (13, 53);
INSERT INTO `t_admin_role_access` VALUES (13, 54);
INSERT INTO `t_admin_role_access` VALUES (13, 56);
INSERT INTO `t_admin_role_access` VALUES (13, 58);
INSERT INTO `t_admin_role_access` VALUES (13, 59);
INSERT INTO `t_admin_role_access` VALUES (13, 60);
INSERT INTO `t_admin_role_access` VALUES (13, 61);
INSERT INTO `t_admin_role_access` VALUES (13, 62);
INSERT INTO `t_admin_role_access` VALUES (13, 63);
INSERT INTO `t_admin_role_access` VALUES (13, 64);
INSERT INTO `t_admin_role_access` VALUES (13, 65);
INSERT INTO `t_admin_role_access` VALUES (13, 66);
INSERT INTO `t_admin_role_access` VALUES (13, 67);
INSERT INTO `t_admin_role_access` VALUES (13, 68);
INSERT INTO `t_admin_role_access` VALUES (13, 69);
INSERT INTO `t_admin_role_access` VALUES (13, 70);
INSERT INTO `t_admin_role_access` VALUES (13, 71);
INSERT INTO `t_admin_role_access` VALUES (13, 72);
INSERT INTO `t_admin_role_access` VALUES (13, 73);
INSERT INTO `t_admin_role_access` VALUES (13, 74);
INSERT INTO `t_admin_role_access` VALUES (13, 75);
INSERT INTO `t_admin_role_access` VALUES (13, 76);
INSERT INTO `t_admin_role_access` VALUES (13, 77);
INSERT INTO `t_admin_role_access` VALUES (13, 78);

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
  UNIQUE INDEX `salt`(`salt`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin_user
-- ----------------------------
INSERT INTO `t_admin_user` VALUES (1, 'yanghuan', 'f3aef94277c86777918c97e8210a8dcd', '杨欢', 1, 'a64845e407e99484d9f9cf2bc455f974', 1642575022, 1643270015, '127.0.0.1', 1644288779);
INSERT INTO `t_admin_user` VALUES (2, 'test', '0192023a7bbd73250516f069df18b500', '测试', 2, '9deed250a088da2a040c2bab4a1fcbb9', 1642586545, 1643099169, '127.0.0.1', 0);
INSERT INTO `t_admin_user` VALUES (10, 'test2', '0192023a7bbd73250516f069df18b500', '测试2', 3, '0ee5466f7e480f81c1d2b56a6e555c13', 1642592256, 1642642154, '127.0.0.1', 0);
INSERT INTO `t_admin_user` VALUES (11, 'test3', '8ad8757baa8564dc136c1e07507f4a98', '测试3', 3, '6bb8070a3bdfca18d9b62e40545038e5', 1642642534, 1642643985, '', 0);
INSERT INTO `t_admin_user` VALUES (12, 'test4', '86985e105f79b95d6bc918fb45ec7727', '测试4', 3, '323d35b5150fb2f8513ead9daca2dca1', 1643099246, 1643100654, '', 0);
INSERT INTO `t_admin_user` VALUES (13, 'test5', 'e3d704f3542b44a621ebed70dc0efe13', '测试5', 2, 'ea145d8e80c765fc8c69eb7c4d1ee36a', 1643100794, 1643179167, '', 0);
INSERT INTO `t_admin_user` VALUES (17, 'testadmin', '13c33ed280d84810222cb0b77b964162', '测试账号', 1, '4469e3edb7d18d3be872201fefec2db7', 1643178539, 1643184338, '127.0.0.1', 1644389724);

-- ----------------------------
-- Table structure for t_bind_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_bind_admin_role`;
CREATE TABLE `t_bind_admin_role`  (
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `role_id` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色与用户关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bind_admin_role
-- ----------------------------
INSERT INTO `t_bind_admin_role` VALUES (1, 1);
INSERT INTO `t_bind_admin_role` VALUES (2, 2);
INSERT INTO `t_bind_admin_role` VALUES (13, 2);
INSERT INTO `t_bind_admin_role` VALUES (17, 13);

-- ----------------------------
-- Table structure for t_config_db_library
-- ----------------------------
DROP TABLE IF EXISTS `t_config_db_library`;
CREATE TABLE `t_config_db_library`  (
  `db_id` int(11) NOT NULL,
  `db_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据库名称',
  `type` int(2) NOT NULL COMMENT '类型 1system管理系统 2 issue业务系统 3官网系统 4广告系统',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '说明',
  PRIMARY KEY (`db_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'DB库管理' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_db_library
-- ----------------------------
INSERT INTO `t_config_db_library` VALUES (1, 'system', 1, '系统基本配置库');
INSERT INTO `t_config_db_library` VALUES (2, 'issue', 2, '发行管理系统');

-- ----------------------------
-- Table structure for t_config_params
-- ----------------------------
DROP TABLE IF EXISTS `t_config_params`;
CREATE TABLE `t_config_params`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '属性名',
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '键值',
  `msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数含义',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后更新时间',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置参数表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_params
-- ----------------------------
INSERT INTO `t_config_params` VALUES (1, 'authSign', '{\"0\":\"IwteRGXK33oiCnnR\"}', 'auto秘钥', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (2, 'jwtSign', '{\"0\":\"BQETsZPCUKVI6F00\"}', 'jwt秘钥', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (3, 'status', '{\"1\":\"启用\",\"2\":\"停用\"}', '通用状态', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (4, 'environType', '{\"1\":\"内网\",\"2\":\"外测\",\"3\":\"正式\"}', '环境类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (5, 'showType', '{\"1\":\"导航栏\",\"2\":\"列表菜单\",\"3\":\"不显示\"}', '菜单显示类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (6, 'nodeType', '{\"1\":\"查看\",\"2\":\"新增\",\"3\":\"修改\",\"4\":\"删除\",\"5\":\"导出\",\"6\":\"导入\",\"7\":\"审核\"}', '节点类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (7, 'whiteListMenu', '{\"0\":\"1\"}', '白名单菜单(不可修改)', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (8, 'whiteListRole', '{\"0\":\"1\",\"1\":\"12\",\"2\":\"13\"}', '白名单角色组(不可操作)', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (14, 'whiteListUser', '{\"0\":\"1\"}', '白名单用户(不可操作)', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (15, 'ipWhiteList', '{\"0\":\"127.0.0.1\",\"1\":\"192.168.70.39\"}', 'ip白名单', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (16, 'userWhiteList', '{\"0\":\"yanghuan\",\"1\":\"testadmin\"}', '白名单用户', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (17, 'shortcutType', '{\"1\":\"显示\",\"2\":\"不显示\"}', '是否存在快捷显示(控制台页面)', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (18, 'dbLibraryType', '{\"1\":\"system管理系统\",\"2\":\"issue业务系统\",\"3\":\"官网系统\",\"4\":\"广告系统\"}', 'db库类型', 0, 0, 1);
INSERT INTO `t_config_params` VALUES (19, 'dbAuthType', '{\"1\":\"增\",\"2\":\"删\",\"3\":\"改\",\"4\":\"查\",\"99\":\"ALL\"}', '数据库权限类型', 1644304596, 1644304596, 1);
INSERT INTO `t_config_params` VALUES (20, 'dbType', '{\"1\":\"mysql\"}', '数据库类型', 1644304942, 1644304942, 1);

-- ----------------------------
-- Table structure for t_config_pj
-- ----------------------------
DROP TABLE IF EXISTS `t_config_pj`;
CREATE TABLE `t_config_pj`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pj_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'pjId',
  `environ_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '环境ID 标识 1内测 2外测 3正式环境',
  `pj_logo` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目标志',
  `pj_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `is_view` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有管理界面',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pj_id`(`pj_id`) USING BTREE,
  INDEX `environ_id`(`environ_id`) USING BTREE,
  INDEX `is_view`(`is_view`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_pj
-- ----------------------------
INSERT INTO `t_config_pj` VALUES (1, 0, 1, 'system', '系统后台 - 内网', 1);
INSERT INTO `t_config_pj` VALUES (2, 0, 2, 'system', '系统后台 - 外测', 1);
INSERT INTO `t_config_pj` VALUES (3, 0, 3, 'system', '系统后台 - 正式', 1);
INSERT INTO `t_config_pj` VALUES (4, 1, 1, 'issue', '发行后台 - 内网', 1);
INSERT INTO `t_config_pj` VALUES (7, 2, 1, 'sdk', 'sdk - 内网', 1);
INSERT INTO `t_config_pj` VALUES (8, 1, 2, 'issue', '发行后台 - 外测', 1);

-- ----------------------------
-- Table structure for t_config_pj_database
-- ----------------------------
DROP TABLE IF EXISTS `t_config_pj_database`;
CREATE TABLE `t_config_pj_database`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `environ_id` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `auth_id` tinyint(1) UNSIGNED NOT NULL DEFAULT 99,
  `db_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `db_host` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `db_port` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `db_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `db_pwd` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `db_name` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `db_charset` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'utf8',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`type`, `environ_id`, `auth_id`, `db_type`, `db_host`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `environ_id`(`environ_id`) USING BTREE,
  INDEX `auth_id`(`auth_id`) USING BTREE,
  INDEX `db_type`(`db_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据库配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_config_pj_database
-- ----------------------------
INSERT INTO `t_config_pj_database` VALUES (1, 1, 1, 4, 1, '127.0.0.1', '3306', 'root', 'root', 'system', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (2, 1, 2, 4, 1, '120.24.63.166', '3306', 'yanghuan', '5rRyLBQZP01OThM2', 'system', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (5, 1, 3, 4, 1, 'xxx', 'xxx', 'xxx', 'xxx', 'xxx', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (6, 2, 1, 99, 1, '127.0.0.1', '3306', 'root', 'root', 'issue', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (8, 1, 1, 2, 1, '127.0.0.1', '3306', 'root', 'root', 'system', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (11, 1, 1, 3, 1, '127.0.0.1', '3306', 'root', 'root', 'system', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (13, 1, 1, 1, 1, '127.0.0.1', '3306', 'root', 'root', 'system', 'utf8');
INSERT INTO `t_config_pj_database` VALUES (14, 1, 1, 99, 1, '127.0.0.1', '3306', 'root', 'root', 'system', 'utf8');

-- ----------------------------
-- Table structure for t_config_pj_server
-- ----------------------------
DROP TABLE IF EXISTS `t_config_pj_server`;
CREATE TABLE `t_config_pj_server`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pj_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `environ_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pj_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pj_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目的IP负载列表',
  `pj_while_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目的白名单IP列表',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pj_id`(`pj_id`) USING BTREE,
  INDEX `environ_id`(`environ_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目服务器域名配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_config_pj_server
-- ----------------------------
INSERT INTO `t_config_pj_server` VALUES (1, 0, 1, 'tp5-system-test3', '127.0.0.1', '127.0.0.1');
INSERT INTO `t_config_pj_server` VALUES (2, 0, 2, 'tp5-system-test3', '127.0.0.1', '127.0.0.1');

SET FOREIGN_KEY_CHECKS = 1;
