/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : 192.168.0.16:3306
Source Database       : wxapp

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2017-01-20 19:20:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wx_app
-- ----------------------------
DROP TABLE IF EXISTS `wx_app`;
CREATE TABLE `wx_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `qrcode` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `pics` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `collection_count` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `creator` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_app
-- ----------------------------
INSERT INTO `wx_app` VALUES ('2', 'aaaa', null, null, 'aaaa', null, 'aaaa', 'aaaa', '2', '0', '0', '0', '0', null, null, null);
INSERT INTO `wx_app` VALUES ('3', 'bbbb', '/uploads/2017/01/1484826406308.png', '/uploads/2017/01/1484826406738.png', 'bbbbbb', '/uploads/2017/01/1484826408210.png,/uploads/2017/01/1484826416135.png,/uploads/2017/01/1484826416146.png,/uploads/2017/01/14848264161461.png,/uploads/2017/01/1484826416147.png', 'bbb', 'bbb,ccc', '1', '0', '0', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for wx_app_category
-- ----------------------------
DROP TABLE IF EXISTS `wx_app_category`;
CREATE TABLE `wx_app_category` (
  `app_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_app_category
-- ----------------------------

-- ----------------------------
-- Table structure for wx_category
-- ----------------------------
DROP TABLE IF EXISTS `wx_category`;
CREATE TABLE `wx_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `parent` int(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_category
-- ----------------------------
INSERT INTO `wx_category` VALUES ('1', '金融', 'jinrong', '0', '1');
INSERT INTO `wx_category` VALUES ('2', '商业服务', 'shangyefuwu', '0', '1');
INSERT INTO `wx_category` VALUES ('3', '公益', 'gongyi', '0', '1');

-- ----------------------------
-- Table structure for wx_channel
-- ----------------------------
DROP TABLE IF EXISTS `wx_channel`;
CREATE TABLE `wx_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `leftv` int(11) NOT NULL,
  `rightv` int(11) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_channel
-- ----------------------------
INSERT INTO `wx_channel` VALUES ('1', '留学', '2', '5', '1', '2016-08-26 10:19:12');
INSERT INTO `wx_channel` VALUES ('2', 'Root', '1', '8', '0', '2014-12-18 19:37:58');
INSERT INTO `wx_channel` VALUES ('3', '测试', '3', '4', '1', '2016-09-02 16:23:28');

-- ----------------------------
-- Table structure for wx_collection
-- ----------------------------
DROP TABLE IF EXISTS `wx_collection`;
CREATE TABLE `wx_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_collection
-- ----------------------------

-- ----------------------------
-- Table structure for wx_comment
-- ----------------------------
DROP TABLE IF EXISTS `wx_comment`;
CREATE TABLE `wx_comment` (
  `id` int(11) NOT NULL,
  `content` varchar(200) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `url` varchar(80) NOT NULL,
  `agent` varchar(120) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `status` enum('wait','approve','reject','trash') NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comment_post` (`post_id`),
  KEY `index_parent` (`parent`) USING BTREE,
  CONSTRAINT `fk_comment` FOREIGN KEY (`parent`) REFERENCES `wx_comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comment_post` FOREIGN KEY (`post_id`) REFERENCES `wx_post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_comment
-- ----------------------------

-- ----------------------------
-- Table structure for wx_link
-- ----------------------------
DROP TABLE IF EXISTS `wx_link`;
CREATE TABLE `wx_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `url` varchar(100) NOT NULL,
  `note` varchar(150) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `creator` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_link
-- ----------------------------
INSERT INTO `wx_link` VALUES ('1', 'JavaTalk', 'http://www.zhouhaocheng.cn', null, '1', '1', '2015-01-06 00:00:00');

-- ----------------------------
-- Table structure for wx_option
-- ----------------------------
DROP TABLE IF EXISTS `wx_option`;
CREATE TABLE `wx_option` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_option
-- ----------------------------
INSERT INTO `wx_option` VALUES ('allowComment', 'allowComment', 'true');
INSERT INTO `wx_option` VALUES ('description', 'description', 'Spring Mybatis Ehcache Shiro Lucene FreeMarker');
INSERT INTO `wx_option` VALUES ('maxshow', 'maxshow', '10');
INSERT INTO `wx_option` VALUES ('postid', 'postid', '8');
INSERT INTO `wx_option` VALUES ('subtitle', 'subtitle', 'Just another zblog website');
INSERT INTO `wx_option` VALUES ('title', 'title', 'Zblog');

-- ----------------------------
-- Table structure for wx_post
-- ----------------------------
DROP TABLE IF EXISTS `wx_post`;
CREATE TABLE `wx_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(350) DEFAULT NULL,
  `content` mediumtext NOT NULL,
  `type` enum('post','page') NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `comment_status` varchar(10) NOT NULL,
  `comment_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_post_user` (`creator`),
  KEY `index_post_channel` (`channel_id`) USING BTREE,
  CONSTRAINT `fk_post_channel` FOREIGN KEY (`channel_id`) REFERENCES `wx_channel` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_post_user` FOREIGN KEY (`creator`) REFERENCES `wx_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_post
-- ----------------------------
INSERT INTO `wx_post` VALUES ('5', '测试测试测试测试', '测试测试测试测试测试测试', '<p>测试测试测试测试测试测试</p>', 'post', '0', '3', 'publish', 'open', '0', '0', '1', '2017-01-12 15:18:08', '2017-01-12 15:18:08');
INSERT INTO `wx_post` VALUES ('6', '测试222222222222222222', '测试222222222222222222测试222222222222222222测试222222222222222222 测试222222222222222222测试222222222222222222 测试222222222222222222 测试222222222222222222 测试222222222222222222测试222222222222222222 测试222222222222222222 测试222222222222222222', '<p>测试222222222222222222测试222222222222222222测试222222222222222222</p>\n<p>测试222222222222222222测试222222222222222222</p>\n<p><br></p>\n<p>测试222222222222222222</p>\n<p>测试222222222222222222</p>\n<p>测试222222222222222222测试222222222222222222</p>\n<p>测试222222222222222222</p>\n<p><br></p>\n<p><br></p>\n<p>测试222222222222222222</p>', 'post', '0', '1', 'publish', 'open', '0', '0', '1', '2017-01-12 17:15:30', '2017-01-12 17:15:30');
INSERT INTO `wx_post` VALUES ('7', '测试3333333333', '测试3333333333测试3333333333测试3333333333 测试3333333333 测试3333333333 测试3333333333 测试3333333333 测试3333333333测试3333333333测试3333333333 测试3333333333 测试3333333333', '<p>测试3333333333测试3333333333测试3333333333</p>\n<p>测试3333333333</p>\n<p>测试3333333333</p>\n<p><br></p>\n<p>测试3333333333</p>\n<p>测试3333333333</p>\n<p><br></p>\n<p><br></p>\n<p>测试3333333333测试3333333333测试3333333333</p>\n<p>测试3333333333</p>\n<p>测试3333333333</p>', 'post', '0', '1', 'publish', 'open', '0', '0', '1', '2017-01-12 17:26:25', '2017-01-12 17:26:25');
INSERT INTO `wx_post` VALUES ('8', '测试44444', '测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444', '<p>测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444测试44444</p>', 'post', '0', '1', 'publish', 'open', '0', '0', '1', '2017-01-12 17:27:41', '2017-01-12 17:27:41');
INSERT INTO `wx_post` VALUES ('9', '测试5555555555', '测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试', '<p>测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555测试5555555555</p>', 'post', '0', '1', 'publish', 'open', '0', '0', '1', '2017-01-12 17:28:40', '2017-01-12 17:28:40');

-- ----------------------------
-- Table structure for wx_tag
-- ----------------------------
DROP TABLE IF EXISTS `wx_tag`;
CREATE TABLE `wx_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `post_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_postid` (`post_id`) USING BTREE,
  CONSTRAINT `fk_tag_post` FOREIGN KEY (`post_id`) REFERENCES `wx_post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_tag
-- ----------------------------
INSERT INTO `wx_tag` VALUES ('1', '测试', '5', '2017-01-12 15:18:08');
INSERT INTO `wx_tag` VALUES ('2', '测试2', '6', '2017-01-12 17:15:30');
INSERT INTO `wx_tag` VALUES ('3', '测试3', '7', '2017-01-12 17:26:25');
INSERT INTO `wx_tag` VALUES ('4', '测试4', '8', '2017-01-12 17:27:41');
INSERT INTO `wx_tag` VALUES ('5', '测试5', '9', '2017-01-12 17:28:40');

-- ----------------------------
-- Table structure for wx_upload
-- ----------------------------
DROP TABLE IF EXISTS `wx_upload`;
CREATE TABLE `wx_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `path` varchar(100) NOT NULL,
  `post_id` int(11) DEFAULT NULL,
  `creator` varchar(25) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_upload_post` (`post_id`) USING BTREE,
  CONSTRAINT `fk_upload_post` FOREIGN KEY (`post_id`) REFERENCES `wx_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_upload
-- ----------------------------
INSERT INTO `wx_upload` VALUES ('1', 'MiddleSchoolVideoProd-6.jpg', '/post/uploads/2016/09/MiddleSchoolVideoProd-6.jpg', null, '1', '2016-09-06 17:50:38');
INSERT INTO `wx_upload` VALUES ('2', 'Schoology-logo.png', '/post/uploads/2016/09/Schoology-logo1.png', null, '1', '2016-09-06 15:57:51');
INSERT INTO `wx_upload` VALUES ('3', 'Schoology-logo.png', '/post/uploads/2016/09/Schoology-logo.png', null, '1', '2016-09-06 15:14:07');
INSERT INTO `wx_upload` VALUES ('4', 'SCS-home-pre.jpg', '/post/uploads/2016/09/SCS-home-pre.jpg', null, '1', '2016-09-06 16:58:54');
INSERT INTO `wx_upload` VALUES ('5', 'logo.png', '/post/uploads/2016/09/logo1.png', null, '1', '2016-09-06 16:57:11');
INSERT INTO `wx_upload` VALUES ('6', 'southlands.jpg', '/post/uploads/2016/09/southlands.jpg', null, '1', '2016-09-06 16:59:16');
INSERT INTO `wx_upload` VALUES ('7', 'logo.png', '/post/uploads/2016/09/logo.png', null, '1', '2016-09-06 15:14:17');

-- ----------------------------
-- Table structure for wx_user
-- ----------------------------
DROP TABLE IF EXISTS `wx_user`;
CREATE TABLE `wx_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(32) NOT NULL,
  `avatar` varchar(60) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `role` enum('admin','editor','contributor') NOT NULL,
  `status` varchar(10) NOT NULL,
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_user
-- ----------------------------
INSERT INTO `wx_user` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', null, null, 'manager@zblog.com', '', 'admin', 'N', '2014-12-31 18:49:48', '2014-12-31 18:49:44');

-- ----------------------------
-- View structure for view_channel
-- ----------------------------
DROP VIEW IF EXISTS `view_channel`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `view_channel` AS select `n`.`id` AS `id`,`n`.`name` AS `name`,count(`n`.`id`) AS `level`,`n`.`visible` AS `visible` from (`wx_channel` `n` join `wx_channel` `p`) where (`n`.`leftv` between `p`.`leftv` and `p`.`rightv`) group by `n`.`id` order by `n`.`leftv` ;
