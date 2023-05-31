/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : vue_store

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 28/04/2023 13:43:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uId` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `county` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addressDetail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isDefault` int(11) NULL DEFAULT NULL,
  `areaCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (32, 11, '阿斯顿', '17677465304', '辽宁省', '沈阳市', '和平区', '阿斯顿', 0, '210102');
INSERT INTO `address` VALUES (33, 11, '张君源', '17677465304', '广西壮族自治区', '南宁市', '青秀区', '南宁学院', 0, '450103');
INSERT INTO `address` VALUES (37, 10, '张君源', '17677465304', '广西壮族自治区', '南宁市', '邕宁区', '南宁学院', 1, '450109');
INSERT INTO `address` VALUES (38, 10, '阿斯顿', '17677465333', '江西省', '南昌市', '东湖区', '阿斯顿', 0, '360102');
INSERT INTO `address` VALUES (42, 14, '张君源', '17677465304', '浙江省', '杭州市', '上城区', '阿斯顿', 1, '330102');
INSERT INTO `address` VALUES (43, 13, '张君源', '17677465304', '山西省', '太原市', '小店区', '阿斯顿', 1, '140105');
INSERT INTO `address` VALUES (44, 17, '456', '17677465304', '北京市', '北京市', '东城区', '111', 0, '110101');
INSERT INTO `address` VALUES (45, 16, '123', '17677465304', '北京市', '北京市', '东城区', '312312', 1, '110101');
INSERT INTO `address` VALUES (46, 17, '王冠乔', '15164650120', '黑龙江省', '齐齐哈尔市', '龙沙区', '1111', 1, '230202');
INSERT INTO `address` VALUES (47, 18, '王冠乔', '15164650120', '台湾省', '台北市', '中正区', '1', 1, '710101');
INSERT INTO `address` VALUES (48, 19, '王冠乔', '15164650120', '黑龙江省', '齐齐哈尔市', '龙沙区', '翻斗花园', 1, '230202');
INSERT INTO `address` VALUES (49, 19, '王冠乔', '18617827128', '黑龙江省', '齐齐哈尔市', '龙沙区', '123', 0, '230202');

-- ----------------------------
-- Table structure for goods_cart
-- ----------------------------
DROP TABLE IF EXISTS `goods_cart`;
CREATE TABLE `goods_cart`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uId` int(11) NULL DEFAULT NULL,
  `goods_id` int(11) NULL DEFAULT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_imgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_cart
-- ----------------------------
INSERT INTO `goods_cart` VALUES (170, 16, 1, '祁门红茶-璀璨礼盒', '138', '2', '/images/goods1.jpg');
INSERT INTO `goods_cart` VALUES (171, 16, 2, '红茶习茶系列·入门版', '243', '2', '/images/goods-list1.jpeg');
INSERT INTO `goods_cart` VALUES (173, 18, 3, '黄山太平猴魁绿茶1号', '991', '1', '/images/goods3.jpg');
INSERT INTO `goods_cart` VALUES (176, 19, 4, '绿茶-清新珍稀白茶', '555', '1', '/images/goods4.jpg');

-- ----------------------------
-- Table structure for goods_list
-- ----------------------------
DROP TABLE IF EXISTS `goods_list`;
CREATE TABLE `goods_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_list
-- ----------------------------
INSERT INTO `goods_list` VALUES (1, '祁门红茶-璀璨礼盒', NULL, '138', '1', '/images/goods1.jpg', NULL);
INSERT INTO `goods_list` VALUES (2, '红茶习茶系列·入门版', NULL, '243', '2', '/images/goods-list1.jpeg', NULL);
INSERT INTO `goods_list` VALUES (3, '黄山太平猴魁绿茶1号', NULL, '991', '3', '/images/goods3.jpg', NULL);
INSERT INTO `goods_list` VALUES (4, '绿茶-清新珍稀白茶', NULL, '555', '4', '/images/goods4.jpg', NULL);

-- ----------------------------
-- Table structure for new_table
-- ----------------------------
DROP TABLE IF EXISTS `new_table`;
CREATE TABLE `new_table`  (
  `ID` int(11) NOT NULL,
  `boor` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of new_table
-- ----------------------------
INSERT INTO `new_table` VALUES (1, '2000-10-21', '2', '男');
INSERT INTO `new_table` VALUES (2, '2002-10-3', '4', '女');
INSERT INTO `new_table` VALUES (3, '2005-6-10', '1', '男');
INSERT INTO `new_table` VALUES (4, '2009-5-6', '3', '男');

-- ----------------------------
-- Table structure for orderpj
-- ----------------------------
DROP TABLE IF EXISTS `orderpj`;
CREATE TABLE `orderpj`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NULL DEFAULT NULL,
  `Pj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderpj
-- ----------------------------
INSERT INTO `orderpj` VALUES (7, 1, '好', '17677465304', 'Wed Aug 02 2022 09:38:36 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (22, 2, '好喝', '17677465304', 'Wed Aug 02 2022 09:53:24 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (23, 4, '不好喝', '17677465304', 'Wed Aug 02 2022 09:53:44 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (25, 3, 'dddd', '17677465300', 'Wed Sep 21 2022 14:54:25 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (26, 2, '不好喝', '17677465300', 'Mon Mar 27 2023 11:37:35 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (27, 4, '好喝', '15164650120', 'Fri Apr 14 2023 12:36:46 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (28, 2, '不好喝', '15164650120', 'Wed Apr 19 2023 12:06:14 GMT+0800 (中国标准时间)');
INSERT INTO `orderpj` VALUES (29, 4, '不好喝', '15164650120', 'Thu Apr 27 2023 19:51:53 GMT+0800 (中国标准时间)');

-- ----------------------------
-- Table structure for store_order
-- ----------------------------
DROP TABLE IF EXISTS `store_order`;
CREATE TABLE `store_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uId` int(11) NULL DEFAULT NULL,
  `goods_imgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 184 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store_order
-- ----------------------------
INSERT INTO `store_order` VALUES (152, '20221213113616179268', '祁门红茶-璀璨礼盒,红茶习茶系列·入门版', '381', '2', '2', 16, '/images/goods1.jpg,/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (153, '20221213114942934802', '祁门红茶-璀璨礼盒', '276', '2', '2', 16, '/images/goods1.jpg');
INSERT INTO `store_order` VALUES (154, '20230209100658296888', '祁门红茶-璀璨礼盒,红茶习茶系列·入门版', '762', '4', '1', 16, '/images/goods1.jpg,/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (155, '20230326151238691486', '红茶习茶系列·入门版', '243', '1', '5', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (156, '20230326151444815329', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (157, '20230326151718596871', '黄山太平猴魁绿茶1号', '991', '1', '1', 18, '/images/goods3.jpg');
INSERT INTO `store_order` VALUES (158, '20230326151758838220', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (159, '2023032615341062554', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (160, '20230326161505548344', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (161, '20230326161547359598', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (162, '20230326161627915068', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (163, '20230326161946328575', '红茶习茶系列·入门版', '486', '2', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (164, '20230326162217297788', '红茶习茶系列·入门版', '243', '1', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (165, '20230326162616803621', '红茶习茶系列·入门版', '243', '1', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (166, '20230326162726724987', '红茶习茶系列·入门版', '243', '1', '2', 17, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (167, '20230326162811103438', '黄山太平猴魁绿茶1号', '991', '1', '1', 18, '/images/goods3.jpg');
INSERT INTO `store_order` VALUES (168, '20230326162839139239', '黄山太平猴魁绿茶1号', '991', '1', '2', 18, '/images/goods3.jpg');
INSERT INTO `store_order` VALUES (169, '20230326163643361522', '红茶习茶系列·入门版,绿茶-清新珍稀白茶', '798', '2', '2', 17, '/images/goods-list1.jpeg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (170, '20230326164117913607', '红茶习茶系列·入门版,绿茶-清新珍稀白茶', '798', '2', '2', 17, '/images/goods-list1.jpeg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (171, '20230326171854857687', '红茶习茶系列·入门版,绿茶-清新珍稀白茶', '798', '2', '2', 17, '/images/goods-list1.jpeg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (172, '20230327112754337792', '红茶习茶系列·入门版,绿茶-清新珍稀白茶', '798', '2', '2', 17, '/images/goods-list1.jpeg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (173, '20230327112840661674', '红茶习茶系列·入门版,绿茶-清新珍稀白茶', '798', '2', '4', 17, '/images/goods-list1.jpeg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (174, '20230402135035487568', '祁门红茶-璀璨礼盒', '138', '1', '2', 17, '/images/goods1.jpg');
INSERT INTO `store_order` VALUES (175, '20230411191747181098', '祁门红茶-璀璨礼盒', '138', '1', '3', 17, '/images/goods1.jpg');
INSERT INTO `store_order` VALUES (176, '20230411192105168094', '黄山太平猴魁绿茶1号', '991', '1', '1', 19, '/images/goods3.jpg');
INSERT INTO `store_order` VALUES (177, '20230411192150217732', '黄山太平猴魁绿茶1号', '991', '1', '2', 19, '/images/goods3.jpg');
INSERT INTO `store_order` VALUES (178, '2023041412344024251', '绿茶-清新珍稀白茶', '555', '1', '5', 19, '/images/goods4.jpg');
INSERT INTO `store_order` VALUES (179, '20230419115213924539', '红茶习茶系列·入门版', '243', '1', '5', 19, '/images/goods-list1.jpeg');
INSERT INTO `store_order` VALUES (180, '20230419123137503067', '黄山太平猴魁绿茶1号,绿茶-清新珍稀白茶', '1546', '2', '1', 19, '/images/goods3.jpg,/images/goods4.jpg');
INSERT INTO `store_order` VALUES (181, '20230419132755417942', '绿茶-清新珍稀白茶', '1110', '2', '5', 19, '/images/goods4.jpg');
INSERT INTO `store_order` VALUES (182, '20230419133436136270', '绿茶-清新珍稀白茶', '555', '1', '2', 19, '/images/goods4.jpg');
INSERT INTO `store_order` VALUES (183, '20230427195037119968', '绿茶-清新珍稀白茶', '555', '1', '2', 19, '/images/goods4.jpg');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tel` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgUrl` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickName` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (17, '17677465300', '666666', '/images/user.jpeg', '17677465300', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZWwiOiIxNzY3NzQ2NTMwMCIsImlhdCI6MTY3OTg5MTgxMSwiZXhwIjoxNjc5ODkxODcxfQ.9MKuiZ3TOMiQX4jzGEUyaf3ZYpC0scZVco1-OQkfK5M');
INSERT INTO `user` VALUES (18, '17677465304', '666666', '/images/user.jpeg', '17677465304', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZWwiOiIxNzY3NzQ2NTMwNCIsImlhdCI6MTY3OTgxOTI4NywiZXhwIjoxNjc5ODE5MzQ3fQ.xMEfGkA6Nyxhhy8FZZfV3NFppNM0i2Hevv6DcMw0mIw');
INSERT INTO `user` VALUES (19, '15164650120', '666666', 'src\\assets\\images\\user.jpeg', '15164650120', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZWwiOiIxNTE2NDY1MDEyMCIsImlhdCI6MTY4MTg4MjQ3MCwiZXhwIjoxNjgxODgyNTMwfQ.bQddRtctFfNSbQ7YM6JE4dF-hRt0oZpemtWgd9K-gT8');
INSERT INTO `user` VALUES (20, '18617827120', '123456', '/images/user.jpeg', '18617827120', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZWwiOiIxODYxNzgyNzEyMCIsImlhdCI6MTY4MTg4MjQyMywiZXhwIjoxNjgxODgyNDgzfQ.dpYg1Muw4Pdxx6KKiDxZDzJ8R6QHkUUnF-fAnZVzKK8');

-- ----------------------------
-- Table structure for userimg
-- ----------------------------
DROP TABLE IF EXISTS `userimg`;
CREATE TABLE `userimg`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userimg
-- ----------------------------
INSERT INTO `userimg` VALUES (15, 16, '/IMGURL/1676728090396_é©¬.jpeg');
INSERT INTO `userimg` VALUES (16, 17, '略略略到诊断');

SET FOREIGN_KEY_CHECKS = 1;
