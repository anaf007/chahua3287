/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Version : 50625
 Source Host           : localhost
 Source Database       : chahua3287

 Target Server Version : 50625
 File Encoding         : utf-8

 Date: 06/11/2017 12:19:17 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `alembic_version`
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` VALUES ('be813c861f5d');
COMMIT;

-- ----------------------------
--  Table structure for `articles`
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `show` tinyint(1) DEFAULT NULL,
  `click` int(11) DEFAULT NULL,
  `thumbnail` text,
  `seokey` varchar(128) DEFAULT NULL,
  `seoDescription` varchar(200) DEFAULT NULL,
  `body` text,
  `timestamp` datetime DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `ix_articles_timestamp` (`timestamp`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categorys` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `articles`
-- ----------------------------
BEGIN;
INSERT INTO `articles` VALUES ('39', '新闻资讯news', '1', '144', 'SRAKF_201706021535288814.jpg', null, null, '<p>新闻资讯</p>\r\n\r\n<p>新闻资讯</p>\r\n\r\n<p>新闻资讯新闻资讯</p>\r\n', '2017-06-10 07:10:30', '8', '5'), ('40', '国内新闻news', '1', '159', null, null, null, '<p>&nbsp;</p>\r\n\r\n<p>国内新闻国内新闻</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>国内新闻国内新闻</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>国内新闻国内新闻</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2017-06-10 07:12:39', '8', '5'), ('41', 'hangyexingwennew', '1', '140', 'MJOSY_201706021535288814.jpg', null, null, '<p>hangyexingwennew</p>\r\n\r\n<p>hangyexingwennew</p>\r\n\r\n<p>hangyexingwennew</p>\r\n\r\n<p>hangyexingwennew</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2017-06-10 15:32:09', '8', '6');
COMMIT;

-- ----------------------------
--  Table structure for `category_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `category_attribute`;
CREATE TABLE `category_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `category_attribute`
-- ----------------------------
BEGIN;
INSERT INTO `category_attribute` VALUES ('1', '栏目列表页'), ('2', '内容展示页'), ('3', '外部链接页');
COMMIT;

-- ----------------------------
--  Table structure for `category_attribute_register`
-- ----------------------------
DROP TABLE IF EXISTS `category_attribute_register`;
CREATE TABLE `category_attribute_register` (
  `category_id` int(11) DEFAULT NULL,
  `category_attribute_id` int(11) DEFAULT NULL,
  KEY `category_id` (`category_id`),
  KEY `category_attribute_id` (`category_attribute_id`),
  CONSTRAINT `category_attribute_register_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categorys` (`id`),
  CONSTRAINT `category_attribute_register_ibfk_2` FOREIGN KEY (`category_attribute_id`) REFERENCES `category_attribute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `category_top`
-- ----------------------------
DROP TABLE IF EXISTS `category_top`;
CREATE TABLE `category_top` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `show` tinyint(1) DEFAULT NULL,
  `nlink` text,
  `template` varchar(64) DEFAULT NULL,
  `seoKey` varchar(200) DEFAULT NULL,
  `seoDescription` varchar(200) DEFAULT NULL,
  `body` text,
  `category_attribute_id` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_attribute_id` (`category_attribute_id`),
  CONSTRAINT `category_top_ibfk_1` FOREIGN KEY (`category_attribute_id`) REFERENCES `category_attribute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `category_top`
-- ----------------------------
BEGIN;
INSERT INTO `category_top` VALUES ('2', '公司简介', '1', '', 'jianjie.html', null, null, '<p><img alt=\"\" src=\"/static/uploads/main/201706101605044504.jpg\" style=\"height:120px; width:192px\" /></p>\r\n', '2', '10'), ('3', '新闻资讯', '1', '', 'xinwenzixun.html', null, null, '<p>xinwenzixun.html</p>\r\n\r\n<p>xinwenzixun.html</p>\r\n\r\n<p>xinwenzixun.html</p>\r\n\r\n<p>xinwenzixun.html</p>\r\n\r\n<p>&nbsp;</p>\r\n', '1', '9');
COMMIT;

-- ----------------------------
--  Table structure for `categorys`
-- ----------------------------
DROP TABLE IF EXISTS `categorys`;
CREATE TABLE `categorys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `show` tinyint(1) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `pubd` datetime DEFAULT NULL,
  `nlink` text,
  `template` varchar(64) DEFAULT NULL,
  `body` text,
  `seoKey` varchar(200) DEFAULT NULL,
  `seoDescription` varchar(200) DEFAULT NULL,
  `category_attribute_id` int(11) DEFAULT NULL,
  `category_top_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_attribute_id` (`category_attribute_id`),
  KEY `category_top_id` (`category_top_id`),
  CONSTRAINT `categorys_ibfk_1` FOREIGN KEY (`category_attribute_id`) REFERENCES `category_attribute` (`id`),
  CONSTRAINT `categorys_ibfk_2` FOREIGN KEY (`category_top_id`) REFERENCES `category_top` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `categorys`
-- ----------------------------
BEGIN;
INSERT INTO `categorys` VALUES ('3', '公司简介', '1', '100', '2017-06-10 06:36:58', '', 'gongsizuzhi.html', '', null, null, '2', '2'), ('4', '公司组织', '1', '100', '2017-06-10 07:01:26', '', 'gongsizuzhi.html', '', null, null, '2', '2'), ('5', '国内新闻', '1', '100', '2017-06-10 07:10:24', '', 'xinwen.html', '', null, null, '1', '3'), ('6', '行业新闻', '1', '100', '2017-06-10 13:25:52', '', 'xinwen.html', '', null, null, '1', '3');
COMMIT;

-- ----------------------------
--  Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text,
  `body_html` text,
  `timestamp` datetime DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `article_id` (`article_id`),
  KEY `ix_comments_timestamp` (`timestamp`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('1', '', '', '2017-06-07 10:15:06', '0', '3', null);
COMMIT;

-- ----------------------------
--  Table structure for `follows`
-- ----------------------------
DROP TABLE IF EXISTS `follows`;
CREATE TABLE `follows` (
  `follower_id` int(11) NOT NULL,
  `followed_id` int(11) NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`follower_id`,`followed_id`),
  KEY `followed_id` (`followed_id`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`),
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`followed_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `permissions` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_roles_default` (`default`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `roles`
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES ('1', '管理员', '0', '7'), ('2', '超级管理员', '0', '255'), ('3', '普通用户', '1', '3');
COMMIT;

-- ----------------------------
--  Table structure for `user_msgs`
-- ----------------------------
DROP TABLE IF EXISTS `user_msgs`;
CREATE TABLE `user_msgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `body` text,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `about_me` text,
  `member_since` datetime DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `avatar_hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('2', '163', '163', null, '163name', 'dizhi', '<p>163ziwoabout_me</p>\r\n', '2017-06-07 00:23:12', '2017-06-07 00:25:52', null), ('3', 'avarat', 'avarat', null, 'avarat', 'avarat', '<p>avaratavarat</p>\r\n\r\n<p>avarat</p>\r\n\r\n<p>avarat</p>\r\n\r\n<p>avarat</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2017-06-07 00:26:47', '2017-06-07 00:27:07', null), ('4', 'UserUser', 'UserUser', null, 'UserUser', 'UserUser', '<p>User</p>\r\n\r\n<p>User</p>\r\n\r\n<p>User</p>\r\n\r\n<p>User</p>\r\n', '2017-06-07 00:28:57', '2017-06-07 00:29:19', null), ('5', '165', '165', null, '165', '165', '<p>165</p>\r\n\r\n<p>165</p>\r\n', '2017-06-07 14:58:57', '2017-06-07 14:58:57', null), ('6', '166', 'pbkdf2:sha256:50000$SjdvdQRE$fed9eb8ad98cf9f4833b7499eb6df216998e795cf91c06a8a95e0aacedb522e7', null, '166', '166', '<p>166</p>\r\n\r\n<p>166166</p>\r\n', '2017-06-08 01:40:14', '2017-06-08 01:40:14', null), ('7', '167', 'pbkdf2:sha256:50000$PRmDiNCs$6f00a1b8906bbcc3a5ae85356838805cd38bde0998e51c5d2ddd0408711c283b', null, '167', '167', '<p>167</p>\r\n\r\n<p>167</p>\r\n\r\n<p>167</p>\r\n\r\n<p>167</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2017-06-08 01:42:34', '2017-06-08 01:42:34', '5878a7ab84fb43402106c575658472fa'), ('8', '168', 'pbkdf2:sha256:50000$q6gONghD$24c2405d402467ddf4bca57aafd811d175f2885c175e5e461ae4af0d462b7ffa', '2', '168', '168', '<p><img alt=\"\" src=\"/static/uploads/main/201706080946142861.png\" style=\"height:133px; width:75px\" /></p>\r\n\r\n<p>168</p>\r\n\r\n<p>168</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>图片</p>\r\n', '2017-06-08 01:46:45', '2017-06-10 15:47:07', '006f52e9102a8d3be2fe5614f42ba989'), ('9', '169', 'pbkdf2:sha256:50000$8z53LuwW$e74d5e32cbd552402fbe9899c0b25585544a79e6627ac16990ce7ea115bad9fd', '1', '169', null, '<p>169</p>\r\n\r\n<p>169</p>\r\n\r\n<p>169</p>\r\n\r\n<p>169</p>\r\n', '2017-06-09 06:26:44', '2017-06-09 06:26:44', '3636638817772e42b59d74cff571fbb3');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
