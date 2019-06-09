# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.23)
# Database: mxshop1
# Generation Time: 2019-06-07 01:18:49 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table auth_group_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`)
VALUES
	(1,'Can add permission',1,'add_permission'),
	(2,'Can change permission',1,'change_permission'),
	(3,'Can delete permission',1,'delete_permission'),
	(4,'Can add group',2,'add_group'),
	(5,'Can change group',2,'change_group'),
	(6,'Can delete group',2,'delete_group'),
	(7,'Can view group',2,'view_group'),
	(8,'Can view permission',1,'view_permission'),
	(9,'Can add content type',3,'add_contenttype'),
	(10,'Can change content type',3,'change_contenttype'),
	(11,'Can delete content type',3,'delete_contenttype'),
	(12,'Can view content type',3,'view_contenttype'),
	(13,'Can add session',4,'add_session'),
	(14,'Can change session',4,'change_session'),
	(15,'Can delete session',4,'delete_session'),
	(16,'Can view session',4,'view_session'),
	(17,'Can add 用户',5,'add_userprofile'),
	(18,'Can change 用户',5,'change_userprofile'),
	(19,'Can delete 用户',5,'delete_userprofile'),
	(20,'Can add 会员等级',6,'add_member'),
	(21,'Can change 会员等级',6,'change_member'),
	(22,'Can delete 会员等级',6,'delete_member'),
	(23,'Can add 短信验证码',7,'add_verifycode'),
	(24,'Can change 短信验证码',7,'change_verifycode'),
	(25,'Can delete 短信验证码',7,'delete_verifycode'),
	(26,'Can view 会员等级',6,'view_member'),
	(27,'Can view 用户',5,'view_userprofile'),
	(28,'Can view 短信验证码',7,'view_verifycode'),
	(29,'Can add 轮播商品',8,'add_banner'),
	(30,'Can change 轮播商品',8,'change_banner'),
	(31,'Can delete 轮播商品',8,'delete_banner'),
	(32,'Can add 商品',9,'add_goods'),
	(33,'Can change 商品',9,'change_goods'),
	(34,'Can delete 商品',9,'delete_goods'),
	(35,'Can add 商品类别',10,'add_goodscategory'),
	(36,'Can change 商品类别',10,'change_goodscategory'),
	(37,'Can delete 商品类别',10,'delete_goodscategory'),
	(38,'Can add 品牌',11,'add_goodscategorybrand'),
	(39,'Can change 品牌',11,'change_goodscategorybrand'),
	(40,'Can delete 品牌',11,'delete_goodscategorybrand'),
	(41,'Can add 商品图片',12,'add_goodsimage'),
	(42,'Can change 商品图片',12,'change_goodsimage'),
	(43,'Can delete 商品图片',12,'delete_goodsimage'),
	(44,'Can add 热搜词',13,'add_hotsearchwords'),
	(45,'Can change 热搜词',13,'change_hotsearchwords'),
	(46,'Can delete 热搜词',13,'delete_hotsearchwords'),
	(47,'Can add 首页商品类别广告',14,'add_indexad'),
	(48,'Can change 首页商品类别广告',14,'change_indexad'),
	(49,'Can delete 首页商品类别广告',14,'delete_indexad'),
	(50,'Can view 轮播商品',8,'view_banner'),
	(51,'Can view 商品',9,'view_goods'),
	(52,'Can view 商品类别',10,'view_goodscategory'),
	(53,'Can view 品牌',11,'view_goodscategorybrand'),
	(54,'Can view 商品图片',12,'view_goodsimage'),
	(55,'Can view 热搜词',13,'view_hotsearchwords'),
	(56,'Can view 首页商品类别广告',14,'view_indexad'),
	(57,'Can add 订单商品',15,'add_ordergoods'),
	(58,'Can change 订单商品',15,'change_ordergoods'),
	(59,'Can delete 订单商品',15,'delete_ordergoods'),
	(60,'Can add 订单',16,'add_orderinfo'),
	(61,'Can change 订单',16,'change_orderinfo'),
	(62,'Can delete 订单',16,'delete_orderinfo'),
	(63,'Can add 购物车',17,'add_shoppingcart'),
	(64,'Can change 购物车',17,'change_shoppingcart'),
	(65,'Can delete 购物车',17,'delete_shoppingcart'),
	(66,'Can view 订单商品',15,'view_ordergoods'),
	(67,'Can view 订单',16,'view_orderinfo'),
	(68,'Can view 购物车',17,'view_shoppingcart'),
	(69,'Can add 收货地址',18,'add_useraddress'),
	(70,'Can change 收货地址',18,'change_useraddress'),
	(71,'Can delete 收货地址',18,'delete_useraddress'),
	(72,'Can add 用户收藏',19,'add_userfav'),
	(73,'Can change 用户收藏',19,'change_userfav'),
	(74,'Can delete 用户收藏',19,'delete_userfav'),
	(75,'Can add 用户留言',20,'add_userleavingmessage'),
	(76,'Can change 用户留言',20,'change_userleavingmessage'),
	(77,'Can delete 用户留言',20,'delete_userleavingmessage'),
	(78,'Can view 收货地址',18,'view_useraddress'),
	(79,'Can view 用户收藏',19,'view_userfav'),
	(80,'Can view 用户留言',20,'view_userleavingmessage'),
	(81,'Can add Bookmark',21,'add_bookmark'),
	(82,'Can change Bookmark',21,'change_bookmark'),
	(83,'Can delete Bookmark',21,'delete_bookmark'),
	(84,'Can add User Setting',22,'add_usersettings'),
	(85,'Can change User Setting',22,'change_usersettings'),
	(86,'Can delete User Setting',22,'delete_usersettings'),
	(87,'Can add User Widget',23,'add_userwidget'),
	(88,'Can change User Widget',23,'change_userwidget'),
	(89,'Can delete User Widget',23,'delete_userwidget'),
	(90,'Can add log entry',24,'add_log'),
	(91,'Can change log entry',24,'change_log'),
	(92,'Can delete log entry',24,'delete_log'),
	(93,'Can view Bookmark',21,'view_bookmark'),
	(94,'Can view log entry',24,'view_log'),
	(95,'Can view User Setting',22,'view_usersettings'),
	(96,'Can view User Widget',23,'view_userwidget'),
	(97,'Can add Token',25,'add_token'),
	(98,'Can change Token',25,'change_token'),
	(99,'Can delete Token',25,'delete_token'),
	(100,'Can view Token',25,'view_token'),
	(101,'Can add association',26,'add_association'),
	(102,'Can change association',26,'change_association'),
	(103,'Can delete association',26,'delete_association'),
	(104,'Can add code',27,'add_code'),
	(105,'Can change code',27,'change_code'),
	(106,'Can delete code',27,'delete_code'),
	(107,'Can add nonce',28,'add_nonce'),
	(108,'Can change nonce',28,'change_nonce'),
	(109,'Can delete nonce',28,'delete_nonce'),
	(110,'Can add user social auth',29,'add_usersocialauth'),
	(111,'Can change user social auth',29,'change_usersocialauth'),
	(112,'Can delete user social auth',29,'delete_usersocialauth'),
	(113,'Can add partial',30,'add_partial'),
	(114,'Can change partial',30,'change_partial'),
	(115,'Can delete partial',30,'delete_partial'),
	(116,'Can view association',26,'view_association'),
	(117,'Can view code',27,'view_code'),
	(118,'Can view nonce',28,'view_nonce'),
	(119,'Can view partial',30,'view_partial'),
	(120,'Can view user social auth',29,'view_usersocialauth'),
	(121,'Can add user dashboard module',31,'add_userdashboardmodule'),
	(122,'Can change user dashboard module',31,'change_userdashboardmodule'),
	(123,'Can delete user dashboard module',31,'delete_userdashboardmodule'),
	(124,'Can view user dashboard module',31,'view_userdashboardmodule'),
	(125,'Can add bookmark',32,'add_bookmark'),
	(126,'Can change bookmark',32,'change_bookmark'),
	(127,'Can delete bookmark',32,'delete_bookmark'),
	(128,'Can add pinned application',33,'add_pinnedapplication'),
	(129,'Can change pinned application',33,'change_pinnedapplication'),
	(130,'Can delete pinned application',33,'delete_pinnedapplication'),
	(131,'Can view bookmark',32,'view_bookmark'),
	(132,'Can view pinned application',33,'view_pinnedapplication'),
	(133,'Can add log entry',34,'add_logentry'),
	(134,'Can change log entry',34,'change_logentry'),
	(135,'Can delete log entry',34,'delete_logentry'),
	(136,'Can view log entry',34,'view_logentry'),
	(137,'Can add 评论',35,'add_goodscomment'),
	(138,'Can change 评论',35,'change_goodscomment'),
	(139,'Can delete 评论',35,'delete_goodscomment'),
	(140,'Can add 评论图片',36,'add_goodscommentiamge'),
	(141,'Can change 评论图片',36,'change_goodscommentiamge'),
	(142,'Can delete 评论图片',36,'delete_goodscommentiamge'),
	(143,'Can add 会员等级规则',37,'add_membership'),
	(144,'Can change 会员等级规则',37,'change_membership'),
	(145,'Can delete 会员等级规则',37,'delete_membership'),
	(146,'Can add 会员资料',38,'add_usermembershipinfo'),
	(147,'Can change 会员资料',38,'change_usermembershipinfo'),
	(148,'Can delete 会员资料',38,'delete_usermembershipinfo'),
	(149,'Can view 评论图片',36,'view_goodscommentiamge'),
	(150,'Can add sku具体商品',39,'add_sku'),
	(151,'Can change sku具体商品',39,'change_sku'),
	(152,'Can delete sku具体商品',39,'delete_sku'),
	(153,'Can view sku具体商品',39,'view_sku'),
	(154,'Can view 评论',35,'view_goodscomment'),
	(155,'Can add 规格(属性)',40,'add_spec'),
	(156,'Can change 规格(属性)',40,'change_spec'),
	(157,'Can delete 规格(属性)',40,'delete_spec'),
	(158,'Can view 规格(属性)',40,'view_spec'),
	(159,'Can add sku值',41,'add_skuvalue'),
	(160,'Can change sku值',41,'change_skuvalue'),
	(161,'Can delete sku值',41,'delete_skuvalue'),
	(162,'Can view sku值',41,'view_skuvalue'),
	(163,'Can add 规格(属性)值',42,'add_specvalue'),
	(164,'Can change 规格(属性)值',42,'change_specvalue'),
	(165,'Can delete 规格(属性)值',42,'delete_specvalue'),
	(166,'Can view 规格(属性)值',42,'view_specvalue');

/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table authtoken_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `authtoken_token`;

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`)
VALUES
	('96f467972a8c25009b71b26d740f7f82b696763c','2018-04-12 14:26:28.237512',1);

/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dashboard_userdashboardmodule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dashboard_userdashboardmodule`;

CREATE TABLE `dashboard_userdashboardmodule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `module` varchar(255) NOT NULL,
  `app_label` varchar(255) DEFAULT NULL,
  `user` int(10) unsigned NOT NULL,
  `column` int(10) unsigned NOT NULL,
  `order` int(11) NOT NULL,
  `settings` longtext NOT NULL,
  `children` longtext NOT NULL,
  `collapsed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `dashboard_userdashboardmodule` WRITE;
/*!40000 ALTER TABLE `dashboard_userdashboardmodule` DISABLE KEYS */;

INSERT INTO `dashboard_userdashboardmodule` (`id`, `title`, `module`, `app_label`, `user`, `column`, `order`, `settings`, `children`, `collapsed`)
VALUES
	(1,'Quick links','jet.dashboard.modules.LinkList',NULL,1,0,0,'{\"draggable\": false, \"deletable\": false, \"collapsible\": false, \"layout\": \"inline\"}','[{\"title\": \"Return to site\", \"url\": \"/\"}, {\"title\": \"\\u4fee\\u6539\\u5bc6\\u7801\", \"url\": \"/admin/password_change/\"}, {\"title\": \"\\u6ce8\\u9500\", \"url\": \"/admin/logout/\"}]',0),
	(2,'Applications','jet.dashboard.modules.AppList',NULL,1,1,0,'{\"models\": null, \"exclude\": [\"auth.*\"]}','',0),
	(3,'管理','jet.dashboard.modules.AppList',NULL,1,2,0,'{\"models\": [\"auth.*\"], \"exclude\": null}','',0),
	(5,'Latest Django News','jet.dashboard.modules.Feed',NULL,1,1,1,'{\"feed_url\": \"http://www.djangoproject.com/rss/weblog/\", \"limit\": 5}','',0),
	(6,'Support','jet.dashboard.modules.LinkList',NULL,1,2,1,'{\"draggable\": true, \"deletable\": true, \"collapsible\": true, \"layout\": \"stacked\"}','[{\"title\": \"Django documentation\", \"url\": \"http://docs.djangoproject.com/\", \"external\": true}, {\"title\": \"Django \\\"django-users\\\" mailing list\", \"url\": \"http://groups.google.com/group/django-users\", \"external\": true}, {\"title\": \"Django irc channel\", \"url\": \"irc://irc.freenode.net/django\", \"external\": true}]',0),
	(7,'Application models','jet.dashboard.modules.ModelList','users',1,0,0,'{\"models\": [\"users.*\"], \"exclude\": null}','',0),
	(9,'Application models','jet.dashboard.modules.ModelList','user_operation',1,0,0,'{\"models\": [\"user_operation.*\"], \"exclude\": null}','',0),
	(10,'Recent Actions','jet.dashboard.modules.RecentActions','user_operation',1,1,0,'{\"limit\": 10, \"include_list\": [\"user_operation.*\"], \"exclude_list\": null, \"user\": null}','',0),
	(11,'Application models','jet.dashboard.modules.ModelList','goods',1,0,0,'{\"models\": [\"goods.*\"], \"exclude\": null}','',0),
	(12,'Recent Actions','jet.dashboard.modules.RecentActions','goods',1,1,0,'{\"limit\": 10, \"include_list\": [\"goods.*\"], \"exclude_list\": null, \"user\": null}','',0);

/*!40000 ALTER TABLE `dashboard_userdashboardmodule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`)
VALUES
	(1,'2018-04-17 14:26:50.180013','1','普通',1,'[{\"added\": {}}]',37,1),
	(2,'2018-04-17 15:04:11.419709','1','1234',1,'[{\"added\": {}}]',7,1),
	(3,'2018-04-18 10:14:51.421982','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),
	(4,'2018-04-18 10:16:03.566865','1','1234',2,'[{\"changed\": {\"fields\": [\"add_time\"]}}]',7,1),
	(5,'2018-04-18 10:33:04.024949','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),
	(6,'2018-04-18 19:02:56.110580','8','1',3,'',18,1),
	(7,'2018-04-18 19:02:56.153013','7','1',3,'',18,1),
	(8,'2018-04-18 19:02:56.191971','6','1',3,'',18,1),
	(9,'2018-04-18 19:03:54.811974','9','1',3,'',18,1),
	(10,'2018-04-18 19:30:31.022137','11','1',3,'',18,1),
	(11,'2018-04-18 19:30:31.075713','10','1',3,'',18,1),
	(12,'2018-04-19 10:46:39.320268','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),
	(13,'2018-04-19 14:36:06.047710','57','蔬菜水果',2,'[{\"changed\": {\"fields\": [\"desc\", \"is_tab\"]}}]',10,1),
	(14,'2018-04-25 12:01:15.555151','52','融氏纯玉米胚芽油5l桶',2,'[{\"changed\": {\"fields\": [\"goods_num\"]}}]',9,1),
	(15,'2018-10-12 11:57:15.220748','1','Mac',1,'[{\"added\": {}}]',11,1),
	(16,'2019-05-29 10:18:24.576721','1','颜色',1,'[{\"added\": {}}, {\"added\": {\"name\": \"\\u89c4\\u683c(\\u5c5e\\u6027)\\u503c\", \"object\": \"\\u767d\\u8272\"}}, {\"added\": {\"name\": \"\\u89c4\\u683c(\\u5c5e\\u6027)\\u503c\", \"object\": \"\\u9ed1\\u8272\"}}]',40,1),
	(17,'2019-05-29 10:19:30.115361','2','内存',1,'[{\"added\": {}}, {\"added\": {\"name\": \"\\u89c4\\u683c(\\u5c5e\\u6027)\\u503c\", \"object\": \"6\"}}, {\"added\": {\"name\": \"\\u89c4\\u683c(\\u5c5e\\u6027)\\u503c\", \"object\": \"8\"}}, {\"added\": {\"name\": \"\\u89c4\\u683c(\\u5c5e\\u6027)\\u503c\", \"object\": \"16\"}}]',40,1),
	(18,'2019-05-29 10:20:16.309730','1','新鲜水果甜蜜香脆单果约800克',2,'[{\"changed\": {\"fields\": [\"goods_sn\", \"spec\", \"specvalue\"]}}]',9,1),
	(19,'2019-05-29 10:51:26.110205','2','新鲜水果甜蜜香脆单果约800克 白色 6',1,'[{\"added\": {}}, {\"added\": {\"name\": \"sku\\u503c\", \"object\": \"\\u767d\\u8272\"}}, {\"added\": {\"name\": \"sku\\u503c\", \"object\": \"6\"}}]',39,1),
	(20,'2019-05-31 16:24:56.339907','3','新鲜水果甜蜜香脆单果约800克 黑色 16',1,'[{\"added\": {}}, {\"added\": {\"name\": \"sku\\u503c\", \"object\": \"\\u9ed1\\u8272\"}}, {\"added\": {\"name\": \"sku\\u503c\", \"object\": \"16\"}}]',39,1);

/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_content_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`)
VALUES
	(34,'admin','logentry'),
	(2,'auth','group'),
	(1,'auth','permission'),
	(25,'authtoken','token'),
	(3,'contenttypes','contenttype'),
	(31,'dashboard','userdashboardmodule'),
	(8,'goods','banner'),
	(9,'goods','goods'),
	(10,'goods','goodscategory'),
	(11,'goods','goodscategorybrand'),
	(35,'goods','goodscomment'),
	(36,'goods','goodscommentiamge'),
	(12,'goods','goodsimage'),
	(13,'goods','hotsearchwords'),
	(14,'goods','indexad'),
	(39,'goods','sku'),
	(41,'goods','skuvalue'),
	(40,'goods','spec'),
	(42,'goods','specvalue'),
	(32,'jet','bookmark'),
	(33,'jet','pinnedapplication'),
	(4,'sessions','session'),
	(26,'social_django','association'),
	(27,'social_django','code'),
	(28,'social_django','nonce'),
	(30,'social_django','partial'),
	(29,'social_django','usersocialauth'),
	(15,'trade','ordergoods'),
	(16,'trade','orderinfo'),
	(17,'trade','shoppingcart'),
	(6,'users','member'),
	(5,'users','userprofile'),
	(7,'users','verifycode'),
	(37,'user_operation','membership'),
	(18,'user_operation','useraddress'),
	(19,'user_operation','userfav'),
	(20,'user_operation','userleavingmessage'),
	(38,'user_operation','usermembershipinfo'),
	(21,'xadmin','bookmark'),
	(24,'xadmin','log'),
	(22,'xadmin','usersettings'),
	(23,'xadmin','userwidget');

/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`)
VALUES
	(1,'contenttypes','0001_initial','2018-04-09 20:11:54.389460'),
	(2,'contenttypes','0002_remove_content_type_name','2018-04-09 20:11:54.473307'),
	(3,'auth','0001_initial','2018-04-09 20:11:54.756056'),
	(4,'auth','0002_alter_permission_name_max_length','2018-04-09 20:11:54.820943'),
	(5,'auth','0003_alter_user_email_max_length','2018-04-09 20:11:54.840576'),
	(6,'auth','0004_alter_user_username_opts','2018-04-09 20:11:54.856494'),
	(7,'auth','0005_alter_user_last_login_null','2018-04-09 20:11:54.876587'),
	(8,'auth','0006_require_contenttypes_0002','2018-04-09 20:11:54.881252'),
	(9,'auth','0007_alter_validators_add_error_messages','2018-04-09 20:11:54.899449'),
	(10,'auth','0008_alter_user_username_max_length','2018-04-09 20:11:54.915229'),
	(11,'auth','0009_alter_user_last_name_max_length','2018-04-09 20:11:54.929479'),
	(12,'users','0001_initial','2018-04-09 20:11:55.319987'),
	(13,'admin','0001_initial','2018-04-09 20:11:55.465044'),
	(14,'admin','0002_logentry_remove_auto_add','2018-04-09 20:11:55.487905'),
	(15,'authtoken','0001_initial','2018-04-09 20:11:55.577709'),
	(16,'authtoken','0002_auto_20160226_1747','2018-04-09 20:11:55.700627'),
	(17,'dashboard','0001_initial','2018-04-09 20:11:55.743086'),
	(18,'goods','0001_initial','2018-04-09 20:11:56.336750'),
	(19,'jet','0001_initial','2018-04-09 20:11:56.434137'),
	(20,'jet','0002_delete_userdashboardmodule','2018-04-09 20:11:56.452008'),
	(21,'sessions','0001_initial','2018-04-09 20:11:56.509177'),
	(22,'default','0001_initial','2018-04-09 20:11:56.853171'),
	(23,'social_auth','0001_initial','2018-04-09 20:11:56.859050'),
	(24,'default','0002_add_related_name','2018-04-09 20:11:56.943703'),
	(25,'social_auth','0002_add_related_name','2018-04-09 20:11:56.949040'),
	(26,'default','0003_alter_email_max_length','2018-04-09 20:11:57.013181'),
	(27,'social_auth','0003_alter_email_max_length','2018-04-09 20:11:57.019337'),
	(28,'default','0004_auto_20160423_0400','2018-04-09 20:11:57.045903'),
	(29,'social_auth','0004_auto_20160423_0400','2018-04-09 20:11:57.051787'),
	(30,'social_auth','0005_auto_20160727_2333','2018-04-09 20:11:57.078335'),
	(31,'social_django','0006_partial','2018-04-09 20:11:57.130213'),
	(32,'social_django','0007_code_timestamp','2018-04-09 20:11:57.197500'),
	(33,'social_django','0008_partial_timestamp','2018-04-09 20:11:57.259742'),
	(34,'trade','0001_initial','2018-04-09 20:11:57.418588'),
	(35,'trade','0002_auto_20180409_2011','2018-04-09 20:11:57.904018'),
	(36,'user_operation','0001_initial','2018-04-09 20:11:57.993307'),
	(37,'user_operation','0002_auto_20180409_2011','2018-04-09 20:11:58.482099'),
	(38,'xadmin','0001_initial','2018-04-09 20:11:58.859744'),
	(39,'xadmin','0002_log','2018-04-09 20:11:59.040434'),
	(40,'xadmin','0003_auto_20160715_0100','2018-04-09 20:11:59.148886'),
	(41,'social_django','0004_auto_20160423_0400','2018-04-09 20:11:59.157932'),
	(42,'social_django','0005_auto_20160727_2333','2018-04-09 20:11:59.163409'),
	(43,'social_django','0003_alter_email_max_length','2018-04-09 20:11:59.175601'),
	(44,'social_django','0002_add_related_name','2018-04-09 20:11:59.186271'),
	(45,'social_django','0001_initial','2018-04-09 20:11:59.192576'),
	(46,'goods','0002_goodscomment_goodscommentiamge','2018-04-17 11:54:59.344273'),
	(47,'user_operation','0003_membership_usermembershipinfo','2018-04-17 11:54:59.550781'),
	(48,'users','0002_userprofile_image','2018-04-17 11:54:59.657639'),
	(49,'users','0003_auto_20180417_1116','2018-04-17 11:55:00.138835'),
	(50,'user_operation','0004_auto_20180417_1411','2018-04-17 14:11:20.760256'),
	(51,'user_operation','0005_auto_20180417_1648','2018-04-17 16:48:44.417714'),
	(52,'goods','0003_auto_20180418_1845','2018-04-18 18:45:11.631191'),
	(53,'user_operation','0006_auto_20180418_1845','2018-04-18 18:45:11.747611'),
	(54,'user_operation','0007_auto_20180426_1033','2018-04-26 10:33:55.469074'),
	(55,'goods','0002_auto_20181012_0946','2019-05-29 10:00:49.341124'),
	(57,'goods','0003_auto_20190529_1000','2019-05-29 10:01:53.690027');

/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`)
VALUES
	('3tujr6w7yaguk4m0mo1gqcxp2tvn7trv','MDY5ODA5ZGQ1NTc1NjdlNDM1NDE5ZTRlYzhhOGY1NjExYThhODNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYTliMDhmMjIyMDQ0ZTlhMDQwM2QzMWZlYTI5ZjZhZGI2MjEzZDkyIn0=','2019-01-09 15:28:01.383863'),
	('8rlkt1x0c3v630u54cowavztu1vgej53','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-02 19:09:59.434801'),
	('8vbktjyshf4ziwro33nbzw0tai078jsp','MDY5ODA5ZGQ1NTc1NjdlNDM1NDE5ZTRlYzhhOGY1NjExYThhODNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYTliMDhmMjIyMDQ0ZTlhMDQwM2QzMWZlYTI5ZjZhZGI2MjEzZDkyIn0=','2019-01-09 18:43:21.358610'),
	('cd5q75gaidlp7swjlat705njw36sz90s','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-10 10:09:26.906830'),
	('dwwijqd1ebov3ue464p81ffmqbvu9ygq','MDY5ODA5ZGQ1NTc1NjdlNDM1NDE5ZTRlYzhhOGY1NjExYThhODNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYTliMDhmMjIyMDQ0ZTlhMDQwM2QzMWZlYTI5ZjZhZGI2MjEzZDkyIn0=','2019-01-09 16:31:12.755802'),
	('eejxwu9bjctf4ec4z7foxwbtotusu2nr','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-03 09:49:28.609541'),
	('o90z0yrju7waf9hhvmchi0i2wibwsyj0','MTM1N2Y0YTZmNjg2MGE3YTg0NWM0MTI0OTlhNDc5YzNmZTkyMTZmMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYiLCJ3ZWlib19zdGF0ZSI6IlR4c1dvdlEyVTFMa2RNeHRubTNQRk1uZzRXQjdYNnVvIn0=','2018-05-03 16:34:05.805801'),
	('ql1l4328q5gqazg9ympsyq8op7lz776w','MDY5ODA5ZGQ1NTc1NjdlNDM1NDE5ZTRlYzhhOGY1NjExYThhODNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYTliMDhmMjIyMDQ0ZTlhMDQwM2QzMWZlYTI5ZjZhZGI2MjEzZDkyIn0=','2018-10-26 11:09:04.586029'),
	('vczfv0wtbrq0ufasbao9rf5bxo44w3yn','MDY5ODA5ZGQ1NTc1NjdlNDM1NDE5ZTRlYzhhOGY1NjExYThhODNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYTliMDhmMjIyMDQ0ZTlhMDQwM2QzMWZlYTI5ZjZhZGI2MjEzZDkyIn0=','2019-01-11 18:56:45.470444'),
	('xfjdpwedtldpk85ep0qkrrv3ifwf4htu','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-09 12:00:59.104648'),
	('yobt0w1cp6mores2fgtuscm7rkgq53p3','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-03 09:53:24.112685');

/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_site
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;

INSERT INTO `django_site` (`id`, `domain`, `name`)
VALUES
	(1,'example.com','example.com');

/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_banner
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_banner`;

CREATE TABLE `goods_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_banner_goods_id_99e23129_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `goods_banner_goods_id_99e23129_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods_goods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goods`;

CREATE TABLE `goods_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_sn` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `click_num` int(11) NOT NULL,
  `sold_num` int(11) NOT NULL,
  `fav_num` int(11) NOT NULL,
  `goods_num` int(11) NOT NULL,
  `market_price` double NOT NULL,
  `shop_price` double NOT NULL,
  `goods_brief` longtext COLLATE utf8mb4_bin NOT NULL,
  `goods_desc` longtext COLLATE utf8mb4_bin NOT NULL,
  `ship_free` tinyint(1) NOT NULL,
  `goods_front_image` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_new` tinyint(1) NOT NULL,
  `is_hot` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goods_category_id_da3507dd_fk_goods_goodscategory_id` (`category_id`),
  CONSTRAINT `goods_goods_category_id_da3507dd_fk_goods_goodscategory_id` FOREIGN KEY (`category_id`) REFERENCES `goods_goodscategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

LOCK TABLES `goods_goods` WRITE;
/*!40000 ALTER TABLE `goods_goods` DISABLE KEYS */;

INSERT INTO `goods_goods` (`id`, `goods_sn`, `name`, `click_num`, `sold_num`, `fav_num`, `goods_num`, `market_price`, `shop_price`, `goods_brief`, `goods_desc`, `ship_free`, `goods_front_image`, `is_new`, `is_hot`, `add_time`, `category_id`)
VALUES
	(1,X'31',X'E696B0E9B29CE6B0B4E69E9CE7949CE89C9CE9A699E88486E58D95E69E9CE7BAA6383030E5858B',21,0,2,0,232,156,X'E9A39FE794A8E799BEE9A699E69E9CE58FAFE4BBA5E5A29EE58AA0E88383E983A8E9A5B1E885B9E6849FEFBC8CE5878FE5B091E4BD99E783ADE9878FE79A84E69184E585A5EFBC8CE8BF98E58FAFE4BBA5E590B8E99984E88386E59BBAE98687E5928CE88386E6B181E4B98BE7B1BBE69C89E69CBAE58886E5AD90EFBC8CE68A91E588B6E4BABAE4BD93E5AFB9E88482E882AAE79A84E590B8E694B6E38082E59BA0E6ADA4EFBC8CE995BFE69C9FE9A39FE794A8E69C89E588A9E4BA8EE694B9E59684E4BABAE4BD93E890A5E585BBE590B8E694B6E7BB93E69E84EFBC8CE9998DE4BD8EE4BD93E58685E88482E882AAEFBC8CE5A191E980A0E581A5E5BAB7E4BC98E7BE8EE4BD93E68081E38082',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F315F505F313434393032343838393838392E6A7067',0,0,'2018-04-09 20:14:00.000000',20),
	(2,X'',X'E794B0E784B6E7899BE88289E5A4A7E9BB84E7939CE69DA1E7949FE9B29CE7899BE88289E586B7E586BBE79C9FE7A9BAE9BB84E7899B',0,0,0,0,106,88,X'E5898DE885BF2BE5908EE885BF2BE7BE8AE68E92E585B138E696A4EFBC8CE58E9FE7949FE68081E5A4A7E5B1B1E694BEE789A7E7BE8AE7BE94EFBC8CE69BBEE7BB8FE79A84E79A87E5AEA4E8B4A1E59381EFBC8CE5A4AEE8A786E68EA8E88D90EFBC8C32303035E5B9B4E58C97E4BAACE68B9BE5BE85E585A8E79083E8B4A2E98791E9A696E88491E38082E4BA94E5B182E4B893E794A8E58C85E8A385E7AEB12BE79C9FE7A9BAE58C85E8A3852BE586B0E8A28B2BE4BF9DE9B29CE7AEB12BE9A1BAE4B8B0E586B7E993BEE58F91E8B4A7EFBC8CE8B7AFE98094E4BF9DE8B4A8E69C9F38E5A4A9',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F325F505F313434383934353831303230322E6A7067',0,0,'2018-04-09 20:14:28.927716',7),
	(3,X'',X'E985A3E79585E5AEB6E5BAADE88FB2E58A9BE7899BE68E923130E78987E6BEB3E6B4B2E7949FE9B29CE7899BE88289E59BA2E8B4ADE5A597E9A490',0,0,0,0,286,238,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F375F505F313434383934353130343838332E6A7067',0,0,'2018-04-09 20:14:28.946451',15),
	(4,X'',X'E697A5E69CACE8929CE89389E7B289E4B89DE68987E8B49D323730E5858B36E58FAAE8A385',0,0,0,0,156,108,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34375F505F313434383934363231333236332E6A7067',0,0,'2018-04-09 20:14:28.962952',20),
	(5,X'',X'E58685E89299E696B0E9B29CE7899BE8828931E696A4E6B885E79C9FE7949FE9B29CE7899BE88289E781ABE99485E9A39FE69D90',0,0,0,0,106,88,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31305F505F313434383934343537323038352E6A7067',0,0,'2018-04-09 20:14:28.977817',7),
	(6,X'',X'E4B98CE68B89E59CADE8BF9BE58FA3E7899BE88289E58DB7E789B9E7BAA7E882A5E7899BE58DB7',0,0,0,0,90,75,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F345F505F313434383934353338313938352E6A7067',0,0,'2018-04-09 20:14:28.997606',21),
	(7,X'',X'E4BA94E6989FE79CBCE88289E7899BE68E92E5A597E9A49038E78987E8A385E58E9FE591B3E58E9FE58887E7949FE9B29CE7899BE88289',0,0,0,0,150,125,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F385F505F313434383934353033323831302E6A7067',0,0,'2018-04-09 20:14:29.011052',23),
	(8,X'',X'E6BEB3E6B4B2E8BF9BE58FA3313230E5A4A9E8B0B7E9A5B2E7899BE4BB94E9AAA834E4BBBDE58E9FE591B3E7949FE9B29C',0,0,0,0,31,26,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31315F505F313434383934343338383237372E6A7067',0,0,'2018-04-09 20:14:29.023256',7),
	(9,X'',X'E6BDAEE9A699E69D91E6BEB3E6B4B2E8BF9BE58FA3E7899BE68E92E5AEB6E5BAADE59BA2E8B4ADE5A597E9A4903230E78987',0,0,0,0,239,199,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F365F505F313434383934353136373237392E6A7067',0,0,'2018-04-09 20:14:29.038915',22),
	(10,X'',X'E788B1E9A39FE6B4BEE58685E89299E58FA4E591BCE4BCA6E8B49DE5B094E586B7E586BBE7949FE9B29CE7899BE885B1E5AD90E882893130303067',0,0,0,0,202,168,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F395F505F313434383934343739313631372E6A7067',0,0,'2018-04-09 20:14:29.052021',20),
	(11,X'',X'E6BEB3E6B4B2E8BF9BE58FA3E7899BE5B0BEE5B7B433303067E696B0E9B29CE882A5E7899BE88289',0,0,0,0,306,255,X'E696B0E9B29CE7BE8AE7BE94E88289E695B4E58FAAE585B13135E696A4EFBC8CE58E9FE7949FE68081E5A4A7E5B1B1E694BEE789A7E7BE8AE7BE94EFBC8CE69BBEE7BB8FE79A84E79A87E5AEA4E8B4A1E59381EFBC8CE5A4AEE8A786E68EA8E88D90EFBC8C32303035E5B9B4E58C97E4BAACE68B9BE5BE85E585A8E79083E8B4A2E98791E9A696E88491E38082E4BA94E5B182E4B893E794A8E58C85E8A385E7AEB12BE79C9FE7A9BAE58C85E8A3852BE586B0E8A28B2BE4BF9DE9B29CE7AEB12BE9A1BAE4B8B0E586B7E993BEE58F91E8B4A7EFBC8CE8B7AFE98094E4BF9DE8B4A8E69C9F38E5A4A9',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F335F505F313434383934353439303833372E6A7067',0,0,'2018-04-09 20:14:29.073783',2),
	(12,X'',X'E696B0E79686E5B7B4E5B094E9B281E5858BE7949FE9B29CE7899BE68E92E79CBCE88289E7899BE689923132303067',0,0,0,0,126,88,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34385F505F313434383934333938383937302E6A7067',0,0,'2018-04-09 20:14:29.088969',7),
	(13,X'',X'E6BEB3E6B4B2E8BF9BE58FA3E5AE89E6A0BCE696AFE7899BE58887E78987E4B88AE88491E7899BE68E923130303067',0,0,0,0,144,120,X'E6BEB3E5A4A7E588A9E4BA9AE698AFE59BBDE99985E585ACE8AEA4E79A84E6B2A1E69C89E796AFE7899BE79785E5928CE58FA3E8B984E796ABE79A84E59BBDE5AEB6E38082E4B8BAE4BA86E4BF9DE68C81E6BEB3E5A4A7E588A9E4BA9AE4BAA7E59381E79A84E9AB98E6A087E58786EFBC8CE6BEB3E5A4A7E588A9E4BA9AE7899BE88289E4B89AE5928CE59084E7BAA7E694BFE5BA9CE585B1E5908CE58AAAE58A9BE7AE80E58E86E4BA86E4B8A5E6A0BCE79A84E6A087E58786E5928CE4BD93E7B3BBEFBC8CE4BBA5E4BF9DE8AF81E7949FE4BAA7E79A84E695B4E4BD93E58C96E5928CE4BAA7E59381E79A84E58FAFE8BFBDE6BAAFE680A7',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F355F505F313434383934353237303339302E6A7067',0,0,'2018-04-09 20:14:29.107391',12),
	(14,X'',X'E5B890E7AFB7E587BAE7A79F',0,0,0,0,120,100,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'696D616765732F3230313730352F676F6F64735F696D672F35335F505F313439353036383837393638372E6A7067',0,0,'2018-04-09 20:14:29.126113',21),
	(15,X'',X'3532E5BAA6E88C85E58FB0E99B86E59BA2E59BBDE99A86E58F8CE5969CE985923530306D6C7836',0,0,0,0,23,19,X'E8B4B5E5B79EE88C85E58FB0E98592E58E82EFBC88E99B86E59BA2EFBC89E4BF9DE581A5E98592E4B89AE69C89E99990E585ACE58FB8E7949FE4BAA7EFBC8CE698AFE4BBA5E2809CE9BE99E2809DE5AD97E68993E5A4B4E79A84E98592E6B0B4E38082E4B8ADE59BBDE9BE99E69687E58C96E4B88AE4B88B38303030E5B9B4EFBC8CE6BA90E8BF9CE8808CE6B581E995BFEFBC8CE9BE99E79A84E5BDA2E8B1A1E698AFE4B880E7A78DE7ACA6E58FB7E38081E4B880E7A78DE6848FE7BBAAE38081E4B880E7A78DE8A180E88289E79BB8E88194E79A84E68385E6849FE38082',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31365F505F313434383934373139343638372E6A7067',0,0,'2018-04-09 20:14:29.137086',37),
	(16,X'',X'3532E5BAA6E6B0B4E4BA95E59D8AE887BBE985BFE585ABE8999F3530306D6C',0,0,0,0,43,36,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31345F505F313434383934373335343033312E6A7067',0,0,'2018-04-09 20:14:29.148103',36),
	(17,X'',X'3533E5BAA6E88C85E58FB0E4BB81E985923530306D6C',0,0,0,0,190,158,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31325F505F313434383934373534373938392E6A7067',0,0,'2018-04-09 20:14:29.163334',32),
	(18,X'',X'E58F8CE5938DE782AEE6B48BE985924A696D4265616D776869736B6579E7BE8EE59BBDE799BDE58DA0E8BEB9',0,0,0,0,38,28,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34365F505F313434383934363539383731312E6A7067',0,0,'2018-04-09 20:14:29.174676',29),
	(19,X'',X'E8A5BFE5A4ABE68B89E5A786E8BF9BE58FA3E6B48BE98592E5B08FE98592E78988',0,0,0,0,55,46,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32315F505F313434383934363739333237362E6A7067',0,0,'2018-04-09 20:14:29.189568',36),
	(20,X'',X'E88C85E58FB03533E5BAA6E9A39EE5A4A9E88C85E58FB03530306D6C',0,0,0,0,22,18,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31355F505F313434383934373235373332342E6A7067',0,0,'2018-04-09 20:14:29.204036',30),
	(21,X'',X'3532E5BAA6E585B0E999B5C2B7E7B4ABE6B094E4B89CE69DA5313630306D4CE5B1B1E4B89CE5908DE98592',0,0,0,0,42,35,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31335F505F313434383934373436303338362E6A7067',0,0,'2018-04-09 20:14:29.218340',29),
	(22,X'',X'4A6F686E6E696557616C6B6572E5B08AE5B0BCE88EB7E58AA0E9BB91E7898CE5A881E5A3ABE5BF8C',0,0,0,0,24,20,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F35305F505F313434383934363534333039312E6A7067',0,0,'2018-04-09 20:14:29.236886',36),
	(23,X'',X'E4BABAE5A4B4E9A9AC434C5542E789B9E4BC98E9A699E6A79FE5B9B2E982913335306D6C',0,0,0,0,31,26,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F35315F505F313434383934363436363539352E6A7067',0,0,'2018-04-09 20:14:29.251652',30),
	(24,X'',X'E5BCA0E8A395E5B9B2E7BAA2E891A1E89084E985923735306D6C2A36E694AF',0,0,0,0,54,45,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31375F505F313434383934373130323234362E6A7067',0,0,'2018-04-09 20:14:29.266270',31),
	(25,X'',X'E58E9FE793B6E58E9FE8A385E8BF9BE58FA3E6B48BE98592E78388E98592E6B395E59BBDE4BA91E9B9BF584FE799BDE585B0E59CB0',0,0,0,0,46,38,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32305F505F313434383934363835303630322E6A7067',0,0,'2018-04-09 20:14:29.276759',29),
	(26,X'',X'E6B395E59BBDE58E9FE8A385E8BF9BE58FA3E59CA3E8B49DE5858BE5B9B2E7BAA2E891A1E89084E985923735306D6C',0,0,0,0,82,68,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31395F505F313434383934363935313538312E6A7067',0,0,'2018-04-09 20:14:29.287153',25),
	(27,X'',X'E6B395E59BBDE799BEE588A9E5A881E5B9B2E7BAA2E891A1E89084E98592414F50E7BAA736E694AFE8A385',0,0,0,0,67,56,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F31385F505F313434383934373031313433352E6A7067',0,0,'2018-04-09 20:14:29.302595',25),
	(28,X'',X'E88A9DE58D8EE5A3AB3132E5B9B4E88B8FE6A0BCE585B0E5A881E5A3ABE5BF8C3730306D6C',0,0,0,0,71,59,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32325F505F313434383934363732393632392E6A7067',0,0,'2018-04-09 20:14:29.311868',30),
	(29,X'',X'E6B7B1E8939DE4BC8FE789B9E58AA0E5B7B4E7BBB4E585B0E588A9E58FA3E98592E98081E9A284E8B083E98592',0,0,0,0,31,18,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34355F505F313434383934363636313330332E6A7067',0,0,'2018-04-09 20:14:29.322158',36),
	(30,X'',X'E8B5A3E58D97E88490E6A999E789B9E7BAA7E69E9C3130E696A4E8A385',0,0,0,0,43,36,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33325F505F313434383934383532353632302E6A7067',0,0,'2018-04-09 20:14:29.333305',62),
	(31,X'',X'E6B3B0E59BBDE88FA0E8909DE89C9C31362D3138E696A431E4B8AAE8A385',0,0,0,0,11,9,X'E38090E68792E4BABAE59083E6B395E38091E88FA0E8909DE89C9CE69E9CE88289EFBC8CE586B0E8A28BE4BF9DE9B29CEFBC8CE694B6E8B4A7E5B0B1E59083EFBC8CE586B0E788BD51E88486E7949CEFBC8C32E696A4E8A385EFBC8CE585A8E59BBDE9A1BAE4B8B0E7A9BAE8BF90E58C85E982AEEFBC8CE58F91E587BAE5908E3438E5B08FE697B6E58685E58FAFE8BEBEEFBC8CE4B880E7BABFE59F8EE5B882E59FBAE69CACE99A94E5A4A9E58FAFE8BEBE',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33305F505F313434383934383636333435302E6A7067',0,0,'2018-04-09 20:14:29.344015',66),
	(32,X'',X'E59B9BE5B79DE58F8CE6B581E88D89E88E93E696B0E9B29CE6B0B4E69E9CE7A4BCE79B9232E79B92',0,0,0,0,22,18,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33315F505F313434383934383539383934372E6A7067',0,0,'2018-04-09 20:14:29.362434',70),
	(33,X'',X'E696B0E9B29CE5A4B4E88CACE99D9EE6B4B2E586B0E88D89E586B0E88F9C',0,0,0,0,67,56,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33355F505F313434383934383333333631302E6A7067',0,0,'2018-04-09 20:14:29.376140',58),
	(34,X'',X'E4BBBFE79C9FE894ACE88F9CE6B0B4E69E9CE69E9CE894ACE88F9CE6A8A1E59E8B',0,0,0,0,6,5,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33365F505F313434383934383233343430352E6A7067',0,0,'2018-04-09 20:14:29.390648',58),
	(35,X'',X'E78EB0E69198E88AADE4B990E795AAE79FB3E6A6B4E58FB0E6B9BEE78F8DE78FA0E88AADE4B990',0,0,0,0,28,23,X'E6B5B7E58D97E4BAA7E7B2BEE59381E9878AE8BFA6E69E9C2C0A2020202020202020E9878AE8BFA6E698AFE6B0B4E69E9CE4B8ADE79A84E8B4B5E6978F2C0A2020202020202020E4BAA7E9878FE5B0912C0A2020202020202020E591B3E98193E5BE88E7949C2C0A2020202020202020E5A5B6E9A699E58D81E8B6B32C0A2020202020202020E99D9EE5B8B8E58FAFE58FA32C0A2020202020202020E69E9CE8A3B9E69E9CE59BADE9A1BAE4B8B0E7A9BAE8BF902C0A2020202020202020E4BF9DE8AF81E696B0E9B29C2EE69E9CE5AD90E4B8AAE5A4A72C0A2020202020202020E4B880E696A4312D32E4B8AAE5B7A6E58FB32C0A2020202020202020E5A4A7E4B8AAE5A4B4E79A84E69E9CE5AD90E69BB4E5B0BDE585B4210A2020202020202020',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33335F505F313434383934383437393936362E6A7067',0,0,'2018-04-09 20:14:29.403901',62),
	(36,X'',X'E6BD8DE59D8AE8909DE58D9C35E696A42FE7AEB1E7A4BCE79B92',0,0,0,0,46,38,X'E88490E6A999E8A784E6A0BCE698AF36352D39304D4DE5B7A6E58FB3EFBC88E6A087E58786E69E9CE69E9CE5BE84E5B9B3E59D8737304D4DE5B7A6E58FB3EFBC8CE7B2BEE59381E69E9CE69E9CE5BE84E5B9B3E59D8738304D4DE5B7A6E58FB3EFBC89EFBC8CE4B880E696A4E5A4A7E6A682E69C89322D34E4B8AAE5B7A6E58FB3EFBC8CE88490E6A999E4BAA7E887AAE6B19FE8A5BFE79C81E8B5A3E5B79EE5B882E4BFA1E4B8B0E58EBFE5AE89E8A5BFE99587EFBC8CE585A8E8BF87E7A88BE983BDE698AFE98787E794A8E5869CE5AEB6E69C89E69CBAE882A5E7A78DE6A48DEFBC8CE7949FE68081E5A4A9E784B6',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33345F505F313434383934383339393030392E6A7067',0,0,'2018-04-09 20:14:29.418969',70),
	(37,X'',X'E4BC91E997B2E99BB6E9A39FE886A8E58C96E9A39FE59381E784A6E7B3962FE5A5B6E6B2B92FE6A492E9BABBE591B3',0,0,0,0,154,99,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34335F505F313434383934383736323634352E6A7067',0,0,'2018-04-09 20:14:29.430476',74),
	(38,X'',X'E89299E7899BE69CAAE69DA5E6989FE584BFE7ABA5E68890E995BFE7899BE5A5B6E9AAA8E58A9BE59E8B3139306D6C2A3135E79B92',0,0,0,0,84,70,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33385F505F313434383934393232303235352E6A7067',0,0,'2018-04-09 20:14:29.442628',105),
	(39,X'',X'E89299E7899BE789B9E4BB91E88B8FE69C89E69CBAE5A5B63235306D6CC3973132E79B92',0,0,0,0,70,32,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34345F505F313434383934383835303138372E6A7067',0,0,'2018-04-09 20:14:29.454560',103),
	(40,X'',X'31E58583E694AFE4BB98E6B58BE8AF95E59586E59381',0,0,0,0,1,1,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'696D616765732F3230313531312F676F6F64735F696D672F34395F505F313434383136323831393838392E6A7067',0,0,'2018-04-09 20:14:29.465950',102),
	(41,X'',X'E5BEB7E8BF90E585A8E88482E696B0E9B29CE7BAAFE7899BE5A5B6314C2A3130E79B92E8A385E695B4E7AEB1',0,0,0,0,70,58,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34305F505F313434383934393033383730322E6A7067',0,0,'2018-04-09 20:14:29.476057',103),
	(42,X'',X'E69CA8E7B396E98687E7BAA2E69EA3E697A9E9A490E5A5B6E58DB3E9A39FE8B186E5A5B6E7B28935333867',0,0,0,0,38,32,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33395F505F313434383934393131353438312E6A7067',0,0,'2018-04-09 20:14:29.486937',106),
	(43,X'',X'E9AB98E99299E6B6B2E4BD93E5A5B63230306D6C2A3234E79B92',0,0,0,0,26,22,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34315F505F313434383934383938303335382E6A7067',0,0,'2018-04-09 20:14:29.496830',107),
	(44,X'',X'E696B0E8A5BFE585B0E8BF9BE58FA3E585A8E88482E5A5B6E7B28939303067',0,0,0,0,720,600,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F33375F505F313434383934393238343336352E6A7067',0,0,'2018-04-09 20:14:29.507701',104),
	(45,X'',X'E4BC8AE588A9E5AE98E696B9E79BB4E890A5E585A8E88482E890A5E585BBE88892E58C96E5A5B63235306D6C2A3132E79B922A32E68F90',0,0,0,0,43,36,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F34325F505F313434383934383839353139332E6A7067',0,0,'2018-04-09 20:14:29.518440',103),
	(46,X'',X'E7BBB4E7BAB3E696AFE6A984E6A684E88F9CE7B1BDE6B2B9354C2FE6A1B6',0,0,0,0,187,156,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32375F505F313434383934373737313830352E6A7067',0,0,'2018-04-09 20:14:29.534986',51),
	(47,X'',X'E7B399E7B1B3343530677833E58C85E7B2AEE6B2B9E7B1B3E99DA2',0,0,0,0,18,15,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32335F505F313434383934383037303334382E6A7067',0,0,'2018-04-09 20:14:29.544003',41),
	(48,X'',X'E7B2BEE782BCE4B880E7BAA7E5A4A7E8B186E6B2B9354CE889B2E68B89E6B2B9E7B2AEE6B2B9E9A39FE794A8E6B2B9',0,0,0,0,54,45,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32365F505F313434383934373832353735342E6A7067',0,0,'2018-04-09 20:14:29.554638',56),
	(49,X'',X'E6A984E6A684E78E89E7B1B3E6B2B9354C2A32E6A1B6',0,0,0,0,31,26,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32385F505F313434383934373639393934382E6A7067',0,0,'2018-04-09 20:14:29.564277',54),
	(50,X'',X'E5B1B1E8A5BFE9BB91E7B1B3E5869CE5AEB6E9BB91E7B1B334E696A4',0,0,0,0,11,9,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32345F505F313434383934383032333832332E6A7067',0,0,'2018-04-09 20:14:29.576241',55),
	(51,X'',X'E7A8BBE59BADE7898CE7A8BBE7B1B3E6B2B9E7B2AEE6B2B9E7B1B3E7B3A0E6B2B9E7BBBFE889B2E6A48DE789A9E6B2B9',0,0,0,0,14,12,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32355F505F313434383934373837353334362E6A7067',0,0,'2018-04-09 20:14:29.594080',47),
	(52,X'',X'E89E8DE6B08FE7BAAFE78E89E7B1B3E8839AE88ABDE6B2B9356CE6A1B6',0,0,0,1,14,12,'',X'3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313430355F3234392E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313431345F3632382E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E3C703E3C696D67207372633D222F6D656469612F676F6F64732F696D616765732F325F32303137303731393136313433355F3338312E6A706722207469746C653D222220616C743D22322E6A7067222F3E3C2F703E',1,X'676F6F64732F696D616765732F32395F505F313434383934373633313939342E6A7067',0,0,'2018-04-09 20:14:29.606811',41);

/*!40000 ALTER TABLE `goods_goods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_goods_spec
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goods_spec`;

CREATE TABLE `goods_goods_spec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_goods_spec_goods_id_spec_id_30a4355f_uniq` (`goods_id`,`spec_id`),
  KEY `goods_goods_spec_spec_id_f626ca3e_fk_goods_spec_id` (`spec_id`),
  CONSTRAINT `goods_goods_spec_goods_id_17f86470_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`),
  CONSTRAINT `goods_goods_spec_spec_id_f626ca3e_fk_goods_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `goods_spec` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_goods_spec` WRITE;
/*!40000 ALTER TABLE `goods_goods_spec` DISABLE KEYS */;

INSERT INTO `goods_goods_spec` (`id`, `goods_id`, `spec_id`)
VALUES
	(1,1,1),
	(2,1,2);

/*!40000 ALTER TABLE `goods_goods_spec` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_goods_specvalue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goods_specvalue`;

CREATE TABLE `goods_goods_specvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `specvalue_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_goods_specvalue_goods_id_specvalue_id_d2174361_uniq` (`goods_id`,`specvalue_id`),
  KEY `goods_goods_specvalu_specvalue_id_71368c89_fk_goods_spe` (`specvalue_id`),
  CONSTRAINT `goods_goods_specvalu_specvalue_id_71368c89_fk_goods_spe` FOREIGN KEY (`specvalue_id`) REFERENCES `goods_specvalue` (`id`),
  CONSTRAINT `goods_goods_specvalue_goods_id_9b72f359_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_goods_specvalue` WRITE;
/*!40000 ALTER TABLE `goods_goods_specvalue` DISABLE KEYS */;

INSERT INTO `goods_goods_specvalue` (`id`, `goods_id`, `specvalue_id`)
VALUES
	(1,1,1),
	(2,1,2),
	(3,1,3),
	(4,1,4),
	(5,1,5);

/*!40000 ALTER TABLE `goods_goods_specvalue` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_goodsbrand
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goodsbrand`;

CREATE TABLE `goods_goodsbrand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `desc` longtext NOT NULL,
  `image` varchar(200) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodsbrand_category_id_6fc84a73_fk_goods_goodscategory_id` (`category_id`),
  CONSTRAINT `goods_goodsbrand_category_id_6fc84a73_fk_goods_goodscategory_id` FOREIGN KEY (`category_id`) REFERENCES `goods_goodscategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `goods_goodsbrand` WRITE;
/*!40000 ALTER TABLE `goods_goodsbrand` DISABLE KEYS */;

INSERT INTO `goods_goodsbrand` (`id`, `name`, `desc`, `image`, `add_time`, `category_id`)
VALUES
	(1,'Mac','f','brands/下载.png','2018-10-12 11:56:00.000000',NULL);

/*!40000 ALTER TABLE `goods_goodsbrand` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_goodscategory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goodscategory`;

CREATE TABLE `goods_goodscategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `code` varchar(30) NOT NULL,
  `desc` longtext NOT NULL,
  `category_type` int(11) NOT NULL,
  `is_tab` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodscategory_parent_category_id_ccec2509_fk_goods_goo` (`parent_category_id`),
  CONSTRAINT `goods_goodscategory_parent_category_id_ccec2509_fk_goods_goo` FOREIGN KEY (`parent_category_id`) REFERENCES `goods_goodscategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `goods_goodscategory` WRITE;
/*!40000 ALTER TABLE `goods_goodscategory` DISABLE KEYS */;

INSERT INTO `goods_goodscategory` (`id`, `name`, `code`, `desc`, `category_type`, `is_tab`, `add_time`, `parent_category_id`)
VALUES
	(1,'生鲜食品','sxsp','',1,0,'2018-04-09 20:14:19.377456',NULL),
	(2,'精品肉类','jprl','',2,0,'2018-04-09 20:14:19.396740',1),
	(3,'羊肉','yr','',3,0,'2018-04-09 20:14:19.402547',2),
	(4,'禽类','ql','',3,0,'2018-04-09 20:14:19.406351',2),
	(5,'猪肉','zr','',3,0,'2018-04-09 20:14:19.410300',2),
	(6,'牛肉','nr','',3,0,'2018-04-09 20:14:19.414129',2),
	(7,'海鲜水产','hxsc','',2,0,'2018-04-09 20:14:19.418153',1),
	(8,'参鲍','cb','',3,0,'2018-04-09 20:14:19.422103',7),
	(9,'鱼','yu','',3,0,'2018-04-09 20:14:19.429065',7),
	(10,'虾','xia','',3,0,'2018-04-09 20:14:19.432736',7),
	(11,'蟹/贝','xb','',3,0,'2018-04-09 20:14:19.436638',7),
	(12,'蛋制品','dzp','',2,0,'2018-04-09 20:14:19.440566',1),
	(13,'松花蛋/咸鸭蛋','xhd_xyd','',3,0,'2018-04-09 20:14:19.445635',12),
	(14,'鸡蛋','jd','',3,0,'2018-04-09 20:14:19.449757',12),
	(15,'叶菜类','ycl','',2,0,'2018-04-09 20:14:19.453628',1),
	(16,'生菜','sc','',3,0,'2018-04-09 20:14:19.459654',15),
	(17,'菠菜','bc','',3,0,'2018-04-09 20:14:19.463421',15),
	(18,'圆椒','yj','',3,0,'2018-04-09 20:14:19.467248',15),
	(19,'西兰花','xlh','',3,0,'2018-04-09 20:14:19.471208',15),
	(20,'根茎类','gjl','',2,0,'2018-04-09 20:14:19.474969',1),
	(21,'茄果类','qgl','',2,0,'2018-04-09 20:14:19.478743',1),
	(22,'菌菇类','jgl','',2,0,'2018-04-09 20:14:19.482840',1),
	(23,'进口生鲜','jksx','',2,0,'2018-04-09 20:14:19.486897',1),
	(24,'酒水饮料','jsyl','',1,0,'2018-04-09 20:14:19.490988',NULL),
	(25,'白酒','bk','',2,0,'2018-04-09 20:14:19.494785',24),
	(26,'五粮液','wly','',3,0,'2018-04-09 20:14:19.498891',25),
	(27,'泸州老窖','lzlj','',3,0,'2018-04-09 20:14:19.503027',25),
	(28,'茅台','mt','',3,0,'2018-04-09 20:14:19.507216',25),
	(29,'葡萄酒','ptj','',2,0,'2018-04-09 20:14:19.513591',24),
	(30,'洋酒','yj','',2,0,'2018-04-09 20:14:19.517796',24),
	(31,'啤酒','pj','',2,0,'2018-04-09 20:14:19.523254',24),
	(32,'其他酒品','qtjp','',2,0,'2018-04-09 20:14:19.527213',24),
	(33,'其他品牌','qtpp','',3,0,'2018-04-09 20:14:19.530993',32),
	(34,'黄酒','hj','',3,0,'2018-04-09 20:14:19.534860',32),
	(35,'养生酒','ysj','',3,0,'2018-04-09 20:14:19.538886',32),
	(36,'饮料/水','yls','',2,0,'2018-04-09 20:14:19.544164',24),
	(37,'红酒','hj','',2,0,'2018-04-09 20:14:19.547884',24),
	(38,'白兰地','bld','',3,0,'2018-04-09 20:14:19.551250',37),
	(39,'威士忌','wsj','',3,0,'2018-04-09 20:14:19.554714',37),
	(40,'粮油副食','粮油副食','',1,0,'2018-04-09 20:14:19.558129',NULL),
	(41,'食用油','食用油','',2,0,'2018-04-09 20:14:19.561675',40),
	(42,'其他食用油','其他食用油','',3,0,'2018-04-09 20:14:19.564063',41),
	(43,'菜仔油','菜仔油','',3,0,'2018-04-09 20:14:19.567321',41),
	(44,'花生油','花生油','',3,0,'2018-04-09 20:14:19.570687',41),
	(45,'橄榄油','橄榄油','',3,0,'2018-04-09 20:14:19.574118',41),
	(46,'礼盒','礼盒','',3,0,'2018-04-09 20:14:19.577479',41),
	(47,'米面杂粮','米面杂粮','',2,0,'2018-04-09 20:14:19.579855',40),
	(48,'面粉/面条','面粉/面条','',3,0,'2018-04-09 20:14:19.583455',47),
	(49,'大米','大米','',3,0,'2018-04-09 20:14:19.587348',47),
	(50,'意大利面','意大利面','',3,0,'2018-04-09 20:14:19.591280',47),
	(51,'厨房调料','厨房调料','',2,0,'2018-04-09 20:14:19.595366',40),
	(52,'调味油/汁','调味油/汁','',3,0,'2018-04-09 20:14:19.599107',51),
	(53,'酱油/醋','酱油/醋','',3,0,'2018-04-09 20:14:19.602830',51),
	(54,'南北干货','南北干货','',2,0,'2018-04-09 20:14:19.606789',40),
	(55,'方便速食','方便速食','',2,0,'2018-04-09 20:14:19.610775',40),
	(56,'调味品','调味品','',2,0,'2018-04-09 20:14:19.614501',40),
	(57,'蔬菜水果','蔬菜水果','水果',1,1,'2018-04-09 20:14:00.000000',NULL),
	(58,'有机蔬菜','有机蔬菜','',2,0,'2018-04-09 20:14:19.630805',57),
	(59,'西红柿','西红柿','',3,0,'2018-04-09 20:14:19.637029',58),
	(60,'韭菜','韭菜','',3,0,'2018-04-09 20:14:19.641063',58),
	(61,'青菜','青菜','',3,0,'2018-04-09 20:14:19.644625',58),
	(62,'精选蔬菜','精选蔬菜','',2,0,'2018-04-09 20:14:19.648372',57),
	(63,'甘蓝','甘蓝','',3,0,'2018-04-09 20:14:19.652233',62),
	(64,'胡萝卜','胡萝卜','',3,0,'2018-04-09 20:14:19.658604',62),
	(65,'黄瓜','黄瓜','',3,0,'2018-04-09 20:14:19.662536',62),
	(66,'进口水果','进口水果','',2,0,'2018-04-09 20:14:19.666571',57),
	(67,'火龙果','火龙果','',3,0,'2018-04-09 20:14:19.670519',66),
	(68,'菠萝蜜','菠萝蜜','',3,0,'2018-04-09 20:14:19.674839',66),
	(69,'奇异果','奇异果','',3,0,'2018-04-09 20:14:19.678799',66),
	(70,'国产水果','国产水果','',2,0,'2018-04-09 20:14:19.682683',57),
	(71,'水果礼盒','水果礼盒','',3,0,'2018-04-09 20:14:19.686569',70),
	(72,'苹果','苹果','',3,0,'2018-04-09 20:14:19.690268',70),
	(73,'雪梨','雪梨','',3,0,'2018-04-09 20:14:19.694483',70),
	(74,'休闲食品','休闲食品','',1,0,'2018-04-09 20:14:19.698297',NULL),
	(75,'休闲零食','休闲零食','',2,0,'2018-04-09 20:14:19.701919',74),
	(76,'果冻','果冻','',3,0,'2018-04-09 20:14:19.705539',75),
	(77,'枣类','枣类','',3,0,'2018-04-09 20:14:19.708386',75),
	(78,'蜜饯','蜜饯','',3,0,'2018-04-09 20:14:19.712314',75),
	(79,'肉类零食','肉类零食','',3,0,'2018-04-09 20:14:19.716022',75),
	(80,'坚果炒货','坚果炒货','',3,0,'2018-04-09 20:14:19.720075',75),
	(81,'糖果','糖果','',2,0,'2018-04-09 20:14:19.723830',74),
	(82,'创意喜糖','创意喜糖','',3,0,'2018-04-09 20:14:19.728020',81),
	(83,'口香糖','口香糖','',3,0,'2018-04-09 20:14:19.731931',81),
	(84,'软糖','软糖','',3,0,'2018-04-09 20:14:19.735860',81),
	(85,'棒棒糖','棒棒糖','',3,0,'2018-04-09 20:14:19.739817',81),
	(86,'巧克力','巧克力','',2,0,'2018-04-09 20:14:19.743665',74),
	(87,'夹心巧克力','夹心巧克力','',3,0,'2018-04-09 20:14:19.747734',86),
	(88,'白巧克力','白巧克力','',3,0,'2018-04-09 20:14:19.751652',86),
	(89,'松露巧克力','松露巧克力','',3,0,'2018-04-09 20:14:19.755437',86),
	(90,'黑巧克力','黑巧克力','',3,0,'2018-04-09 20:14:19.759283',86),
	(91,'肉干肉脯/豆干','肉干肉脯/豆干','',2,0,'2018-04-09 20:14:19.763404',74),
	(92,'牛肉干','牛肉干','',3,0,'2018-04-09 20:14:19.767433',91),
	(93,'猪肉脯','猪肉脯','',3,0,'2018-04-09 20:14:19.771455',91),
	(94,'牛肉粒','牛肉粒','',3,0,'2018-04-09 20:14:19.775579',91),
	(95,'猪肉干','猪肉干','',3,0,'2018-04-09 20:14:19.779806',91),
	(96,'鱿鱼丝/鱼干','鱿鱼丝/鱼干','',2,0,'2018-04-09 20:14:19.783746',74),
	(97,'鱿鱼足','鱿鱼足','',3,0,'2018-04-09 20:14:19.787673',96),
	(98,'鱿鱼丝','鱿鱼丝','',3,0,'2018-04-09 20:14:19.795022',96),
	(99,'墨鱼/乌贼','墨鱼/乌贼','',3,0,'2018-04-09 20:14:19.798932',96),
	(100,'鱿鱼仔','鱿鱼仔','',3,0,'2018-04-09 20:14:19.802597',96),
	(101,'鱿鱼片','鱿鱼片','',3,0,'2018-04-09 20:14:19.806307',96),
	(102,'奶类食品','奶类食品','',1,0,'2018-04-09 20:14:19.810150',NULL),
	(103,'进口奶品','进口奶品','',2,0,'2018-04-09 20:14:19.814068',102),
	(104,'国产奶品','国产奶品','',2,0,'2018-04-09 20:14:19.818037',102),
	(105,'奶粉','奶粉','',2,0,'2018-04-09 20:14:19.821817',102),
	(106,'有机奶','有机奶','',2,0,'2018-04-09 20:14:19.825741',102),
	(107,'原料奶','原料奶','',2,0,'2018-04-09 20:14:19.829597',102),
	(108,'天然干货','天然干货','',1,0,'2018-04-09 20:14:19.835630',NULL),
	(109,'菌菇类','菌菇类','',2,0,'2018-04-09 20:14:19.840740',108),
	(110,'腌干海产','腌干海产','',2,0,'2018-04-09 20:14:19.844449',108),
	(111,'汤料','汤料','',2,0,'2018-04-09 20:14:19.848266',108),
	(112,'豆类','豆类','',2,0,'2018-04-09 20:14:19.852176',108),
	(113,'干菜/菜干','干菜/菜干','',2,0,'2018-04-09 20:14:19.856463',108),
	(114,'干果/果干','干果/果干','',2,0,'2018-04-09 20:14:19.860430',108),
	(115,'豆制品','豆制品','',2,0,'2018-04-09 20:14:19.864243',108),
	(116,'腊味','腊味','',2,0,'2018-04-09 20:14:19.868180',108),
	(117,'精选茗茶','精选茗茶','',1,0,'2018-04-09 20:14:19.872269',NULL),
	(118,'白茶','白茶','',2,0,'2018-04-09 20:14:19.875847',117),
	(119,'红茶','红茶','',2,0,'2018-04-09 20:14:19.879845',117),
	(120,'绿茶','绿茶','',2,0,'2018-04-09 20:14:19.883750',117);

/*!40000 ALTER TABLE `goods_goodscategory` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_goodscomment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goodscomment`;

CREATE TABLE `goods_goodscomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodscomment_goods_id_0452aa64_fk_goods_goods_id` (`goods_id`),
  KEY `goods_goodscomment_users_id_c7aff3ce_fk_users_userprofile_id` (`users_id`),
  CONSTRAINT `goods_goodscomment_goods_id_0452aa64_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`),
  CONSTRAINT `goods_goodscomment_users_id_c7aff3ce_fk_users_userprofile_id` FOREIGN KEY (`users_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods_goodscommentiamge
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goodscommentiamge`;

CREATE TABLE `goods_goodscommentiamge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodscommentia_comment_id_126e96c1_fk_goods_goo` (`comment_id`),
  CONSTRAINT `goods_goodscommentia_comment_id_126e96c1_fk_goods_goo` FOREIGN KEY (`comment_id`) REFERENCES `goods_goodscomment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods_goodsimage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_goodsimage`;

CREATE TABLE `goods_goodsimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodsimage_goods_id_08cb23b1_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `goods_goodsimage_goods_id_08cb23b1_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `goods_goodsimage` WRITE;
/*!40000 ALTER TABLE `goods_goodsimage` DISABLE KEYS */;

INSERT INTO `goods_goodsimage` (`id`, `image`, `add_time`, `goods_id`)
VALUES
	(1,'goods/images/1_P_1449024889889.jpg','2018-04-09 20:14:28.907368',1),
	(2,'goods/images/1_P_1449024889264.jpg','2018-04-09 20:14:28.911863',1),
	(3,'goods/images/1_P_1449024889726.jpg','2018-04-09 20:14:28.915866',1),
	(4,'goods/images/1_P_1449024889018.jpg','2018-04-09 20:14:28.919946',1),
	(5,'goods/images/1_P_1449024889287.jpg','2018-04-09 20:14:28.923703',1),
	(6,'goods/images/2_P_1448945810202.jpg','2018-04-09 20:14:28.938296',2),
	(7,'goods/images/2_P_1448945810814.jpg','2018-04-09 20:14:28.942295',2),
	(8,'goods/images/7_P_1448945104883.jpg','2018-04-09 20:14:28.953731',3),
	(9,'goods/images/7_P_1448945104734.jpg','2018-04-09 20:14:28.958695',3),
	(10,'goods/images/47_P_1448946213263.jpg','2018-04-09 20:14:28.970310',4),
	(11,'goods/images/47_P_1448946213157.jpg','2018-04-09 20:14:28.973973',4),
	(12,'goods/images/10_P_1448944572085.jpg','2018-04-09 20:14:28.985056',5),
	(13,'goods/images/10_P_1448944572532.jpg','2018-04-09 20:14:28.988788',5),
	(14,'goods/images/10_P_1448944572872.jpg','2018-04-09 20:14:28.993752',5),
	(15,'goods/images/4_P_1448945381985.jpg','2018-04-09 20:14:29.004514',6),
	(16,'goods/images/4_P_1448945381013.jpg','2018-04-09 20:14:29.007781',6),
	(17,'goods/images/8_P_1448945032810.jpg','2018-04-09 20:14:29.017401',7),
	(18,'goods/images/8_P_1448945032646.jpg','2018-04-09 20:14:29.019769',7),
	(19,'goods/images/11_P_1448944388277.jpg','2018-04-09 20:14:29.029395',8),
	(20,'goods/images/11_P_1448944388034.jpg','2018-04-09 20:14:29.032001',8),
	(21,'goods/images/11_P_1448944388201.jpg','2018-04-09 20:14:29.035513',8),
	(22,'goods/images/6_P_1448945167279.jpg','2018-04-09 20:14:29.044829',9),
	(23,'goods/images/6_P_1448945167015.jpg','2018-04-09 20:14:29.048603',9),
	(24,'goods/images/9_P_1448944791617.jpg','2018-04-09 20:14:29.058903',10),
	(25,'goods/images/9_P_1448944791129.jpg','2018-04-09 20:14:29.062418',10),
	(26,'goods/images/9_P_1448944791077.jpg','2018-04-09 20:14:29.066262',10),
	(27,'goods/images/9_P_1448944791229.jpg','2018-04-09 20:14:29.070042',10),
	(28,'goods/images/3_P_1448945490837.jpg','2018-04-09 20:14:29.080912',11),
	(29,'goods/images/3_P_1448945490084.jpg','2018-04-09 20:14:29.084694',11),
	(30,'goods/images/48_P_1448943988970.jpg','2018-04-09 20:14:29.095903',12),
	(31,'goods/images/48_P_1448943988898.jpg','2018-04-09 20:14:29.099848',12),
	(32,'goods/images/48_P_1448943988439.jpg','2018-04-09 20:14:29.103416',12),
	(33,'goods/images/5_P_1448945270390.jpg','2018-04-09 20:14:29.114739',13),
	(34,'goods/images/5_P_1448945270067.jpg','2018-04-09 20:14:29.118480',13),
	(35,'goods/images/5_P_1448945270432.jpg','2018-04-09 20:14:29.122228',13),
	(36,'images/201705/goods_img/53_P_1495068879687.jpg','2018-04-09 20:14:29.133278',14),
	(37,'goods/images/16_P_1448947194687.jpg','2018-04-09 20:14:29.144091',15),
	(38,'goods/images/14_P_1448947354031.jpg','2018-04-09 20:14:29.155072',16),
	(39,'goods/images/14_P_1448947354433.jpg','2018-04-09 20:14:29.159008',16),
	(40,'goods/images/12_P_1448947547989.jpg','2018-04-09 20:14:29.170579',17),
	(41,'goods/images/46_P_1448946598711.jpg','2018-04-09 20:14:29.182465',18),
	(42,'goods/images/46_P_1448946598301.jpg','2018-04-09 20:14:29.185935',18),
	(43,'goods/images/21_P_1448946793276.jpg','2018-04-09 20:14:29.196551',19),
	(44,'goods/images/21_P_1448946793153.jpg','2018-04-09 20:14:29.200168',19),
	(45,'goods/images/15_P_1448947257324.jpg','2018-04-09 20:14:29.211380',20),
	(46,'goods/images/15_P_1448947257580.jpg','2018-04-09 20:14:29.214809',20),
	(47,'goods/images/13_P_1448947460386.jpg','2018-04-09 20:14:29.225442',21),
	(48,'goods/images/13_P_1448947460276.jpg','2018-04-09 20:14:29.229288',21),
	(49,'goods/images/13_P_1448947460353.jpg','2018-04-09 20:14:29.233207',21),
	(50,'goods/images/50_P_1448946543091.jpg','2018-04-09 20:14:29.243873',22),
	(51,'goods/images/50_P_1448946542182.jpg','2018-04-09 20:14:29.247653',22),
	(52,'goods/images/51_P_1448946466595.jpg','2018-04-09 20:14:29.258677',23),
	(53,'goods/images/51_P_1448946466208.jpg','2018-04-09 20:14:29.262566',23),
	(54,'goods/images/17_P_1448947102246.jpg','2018-04-09 20:14:29.272973',24),
	(55,'goods/images/20_P_1448946850602.jpg','2018-04-09 20:14:29.283637',25),
	(56,'goods/images/19_P_1448946951581.jpg','2018-04-09 20:14:29.294237',26),
	(57,'goods/images/19_P_1448946951726.jpg','2018-04-09 20:14:29.298020',26),
	(58,'goods/images/18_P_1448947011435.jpg','2018-04-09 20:14:29.309424',27),
	(59,'goods/images/22_P_1448946729629.jpg','2018-04-09 20:14:29.318442',28),
	(60,'goods/images/45_P_1448946661303.jpg','2018-04-09 20:14:29.328857',29),
	(61,'goods/images/32_P_1448948525620.jpg','2018-04-09 20:14:29.340229',30),
	(62,'goods/images/30_P_1448948663450.jpg','2018-04-09 20:14:29.351073',31),
	(63,'goods/images/30_P_1448948662571.jpg','2018-04-09 20:14:29.354734',31),
	(64,'goods/images/30_P_1448948663221.jpg','2018-04-09 20:14:29.358618',31),
	(65,'goods/images/31_P_1448948598947.jpg','2018-04-09 20:14:29.369625',32),
	(66,'goods/images/31_P_1448948598475.jpg','2018-04-09 20:14:29.372430',32),
	(67,'goods/images/35_P_1448948333610.jpg','2018-04-09 20:14:29.383080',33),
	(68,'goods/images/35_P_1448948333313.jpg','2018-04-09 20:14:29.386912',33),
	(69,'goods/images/36_P_1448948234405.jpg','2018-04-09 20:14:29.397747',34),
	(70,'goods/images/36_P_1448948234250.jpg','2018-04-09 20:14:29.400248',34),
	(71,'goods/images/33_P_1448948479966.jpg','2018-04-09 20:14:29.411146',35),
	(72,'goods/images/33_P_1448948479886.jpg','2018-04-09 20:14:29.414951',35),
	(73,'goods/images/34_P_1448948399009.jpg','2018-04-09 20:14:29.426333',36),
	(74,'goods/images/43_P_1448948762645.jpg','2018-04-09 20:14:29.437833',37),
	(75,'goods/images/38_P_1448949220255.jpg','2018-04-09 20:14:29.450758',38),
	(76,'goods/images/44_P_1448948850187.jpg','2018-04-09 20:14:29.462033',39),
	(77,'images/201511/goods_img/49_P_1448162819889.jpg','2018-04-09 20:14:29.472433',40),
	(78,'goods/images/40_P_1448949038702.jpg','2018-04-09 20:14:29.483032',41),
	(79,'goods/images/39_P_1448949115481.jpg','2018-04-09 20:14:29.493671',42),
	(80,'goods/images/41_P_1448948980358.jpg','2018-04-09 20:14:29.503799',43),
	(81,'goods/images/37_P_1448949284365.jpg','2018-04-09 20:14:29.514618',44),
	(82,'goods/images/42_P_1448948895193.jpg','2018-04-09 20:14:29.528532',45),
	(83,'goods/images/27_P_1448947771805.jpg','2018-04-09 20:14:29.540874',46),
	(84,'goods/images/23_P_1448948070348.jpg','2018-04-09 20:14:29.551129',47),
	(85,'goods/images/26_P_1448947825754.jpg','2018-04-09 20:14:29.561641',48),
	(86,'goods/images/28_P_1448947699948.jpg','2018-04-09 20:14:29.570119',49),
	(87,'goods/images/28_P_1448947699777.jpg','2018-04-09 20:14:29.572524',49),
	(88,'goods/images/24_P_1448948023823.jpg','2018-04-09 20:14:29.583595',50),
	(89,'goods/images/24_P_1448948023977.jpg','2018-04-09 20:14:29.587099',50),
	(90,'goods/images/25_P_1448947875346.jpg','2018-04-09 20:14:29.602047',51),
	(91,'goods/images/29_P_1448947631994.jpg','2018-04-09 20:14:29.614285',52);

/*!40000 ALTER TABLE `goods_goodsimage` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_hotsearchwords
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_hotsearchwords`;

CREATE TABLE `goods_hotsearchwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(20) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods_indexad
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_indexad`;

CREATE TABLE `goods_indexad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_indexad_category_id_cf834e34_fk_goods_goodscategory_id` (`category_id`),
  KEY `goods_indexad_goods_id_e1361e4f_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `goods_indexad_category_id_cf834e34_fk_goods_goodscategory_id` FOREIGN KEY (`category_id`) REFERENCES `goods_goodscategory` (`id`),
  CONSTRAINT `goods_indexad_goods_id_e1361e4f_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table goods_sku
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_sku`;

CREATE TABLE `goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(126) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_sku_goods_id_29d98d3b_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `goods_sku_goods_id_29d98d3b_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_sku` WRITE;
/*!40000 ALTER TABLE `goods_sku` DISABLE KEYS */;

INSERT INTO `goods_sku` (`id`, `name`, `price`, `stock`, `goods_id`)
VALUES
	(2,'新鲜水果甜蜜香脆单果约800克 白色 6',6.00,6,1),
	(3,'新鲜水果甜蜜香脆单果约800克 黑色 16',16.00,16,1);

/*!40000 ALTER TABLE `goods_sku` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_skuvalue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_skuvalue`;

CREATE TABLE `goods_skuvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku_id` int(11) NOT NULL,
  `specvalue_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `specvalue_id` (`specvalue_id`),
  KEY `goods_skuvalue_sku_id_6ccd8f9b_fk_goods_sku_id` (`sku_id`),
  CONSTRAINT `goods_skuvalue_sku_id_6ccd8f9b_fk_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `goods_sku` (`id`),
  CONSTRAINT `goods_skuvalue_specvalue_id_dc3ea613_fk_goods_specvalue_id` FOREIGN KEY (`specvalue_id`) REFERENCES `goods_specvalue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_skuvalue` WRITE;
/*!40000 ALTER TABLE `goods_skuvalue` DISABLE KEYS */;

INSERT INTO `goods_skuvalue` (`id`, `sku_id`, `specvalue_id`)
VALUES
	(3,2,1),
	(4,2,3),
	(5,3,2),
	(6,3,5);

/*!40000 ALTER TABLE `goods_skuvalue` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_spec
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_spec`;

CREATE TABLE `goods_spec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(126) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_spec` WRITE;
/*!40000 ALTER TABLE `goods_spec` DISABLE KEYS */;

INSERT INTO `goods_spec` (`id`, `name`)
VALUES
	(1,'颜色'),
	(2,'内存');

/*!40000 ALTER TABLE `goods_spec` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods_specvalue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods_specvalue`;

CREATE TABLE `goods_specvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(126) COLLATE utf8mb4_unicode_ci NOT NULL,
  `spec_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_specvalue_spec_id_abaebf51_fk_goods_spec_id` (`spec_id`),
  CONSTRAINT `goods_specvalue_spec_id_abaebf51_fk_goods_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `goods_spec` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `goods_specvalue` WRITE;
/*!40000 ALTER TABLE `goods_specvalue` DISABLE KEYS */;

INSERT INTO `goods_specvalue` (`id`, `value`, `spec_id`)
VALUES
	(1,'白色',1),
	(2,'黑色',1),
	(3,'6',2),
	(4,'8',2),
	(5,'16',2);

/*!40000 ALTER TABLE `goods_specvalue` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table jet_bookmark
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jet_bookmark`;

CREATE TABLE `jet_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table jet_pinnedapplication
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jet_pinnedapplication`;

CREATE TABLE `jet_pinnedapplication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table social_auth_association
# ------------------------------------------------------------

DROP TABLE IF EXISTS `social_auth_association`;

CREATE TABLE `social_auth_association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table social_auth_code
# ------------------------------------------------------------

DROP TABLE IF EXISTS `social_auth_code`;

CREATE TABLE `social_auth_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  KEY `social_auth_code_code_a2393167` (`code`),
  KEY `social_auth_code_timestamp_176b341f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table social_auth_nonce
# ------------------------------------------------------------

DROP TABLE IF EXISTS `social_auth_nonce`;

CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table social_auth_partial
# ------------------------------------------------------------

DROP TABLE IF EXISTS `social_auth_partial`;

CREATE TABLE `social_auth_partial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) unsigned NOT NULL,
  `backend` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_auth_partial_token_3017fea3` (`token`),
  KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table social_auth_usersocialauth
# ------------------------------------------------------------

DROP TABLE IF EXISTS `social_auth_usersocialauth`;

CREATE TABLE `social_auth_usersocialauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  KEY `social_auth_usersoci_user_id_17d28448_fk_users_use` (`user_id`),
  CONSTRAINT `social_auth_usersoci_user_id_17d28448_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trade_ordergoods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trade_ordergoods`;

CREATE TABLE `trade_ordergoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_num` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trade_ordergoods_goods_id_e77dc520_fk_goods_goods_id` (`goods_id`),
  KEY `trade_ordergoods_order_id_e046f633_fk_trade_orderinfo_id` (`order_id`),
  CONSTRAINT `trade_ordergoods_goods_id_e77dc520_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`),
  CONSTRAINT `trade_ordergoods_order_id_e046f633_fk_trade_orderinfo_id` FOREIGN KEY (`order_id`) REFERENCES `trade_orderinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trade_orderinfo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trade_orderinfo`;

CREATE TABLE `trade_orderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(30) DEFAULT NULL,
  `trade_no` varchar(100) DEFAULT NULL,
  `pay_status` varchar(30) NOT NULL,
  `post_script` varchar(200) NOT NULL,
  `order_amount` double NOT NULL,
  `pay_time` datetime(6) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `signer_name` varchar(20) NOT NULL,
  `signer_mobile` varchar(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  UNIQUE KEY `trade_no` (`trade_no`),
  KEY `trade_orderinfo_user_id_08ffa22c_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `trade_orderinfo_user_id_08ffa22c_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table trade_shoppingcart
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trade_shoppingcart`;

CREATE TABLE `trade_shoppingcart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nums` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `status` varchar(1) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trade_shoppingcart_goods_id_8b0f3cb4_fk_goods_goods_id` (`goods_id`),
  KEY `trade_shoppingcart_user_id_da423c9c_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `trade_shoppingcart_goods_id_8b0f3cb4_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`),
  CONSTRAINT `trade_shoppingcart_user_id_da423c9c_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `trade_shoppingcart` WRITE;
/*!40000 ALTER TABLE `trade_shoppingcart` DISABLE KEYS */;

INSERT INTO `trade_shoppingcart` (`id`, `nums`, `add_time`, `status`, `goods_id`, `user_id`)
VALUES
	(1,1,'2018-04-25 12:01:31.653028','0',52,1);

/*!40000 ALTER TABLE `trade_shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_operation_membership
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_operation_membership`;

CREATE TABLE `user_operation_membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(20) NOT NULL,
  `min_bonus_point` int(11) NOT NULL,
  `min_owned` int(11) NOT NULL,
  `min_shared` int(11) NOT NULL,
  `color` varchar(10) NOT NULL,
  `decorate_image` varchar(100) NOT NULL,
  `banner_image` varchar(100) NOT NULL,
  `discount_rate` double NOT NULL,
  `is_exc_shipment_free` tinyint(1) NOT NULL,
  `is_exc_new` tinyint(1) NOT NULL,
  `is_special_available` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tier_name` (`tier_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_operation_membership` WRITE;
/*!40000 ALTER TABLE `user_operation_membership` DISABLE KEYS */;

INSERT INTO `user_operation_membership` (`id`, `tier_name`, `min_bonus_point`, `min_owned`, `min_shared`, `color`, `decorate_image`, `banner_image`, `discount_rate`, `is_exc_shipment_free`, `is_exc_new`, `is_special_available`)
VALUES
	(1,'普通',0,0,0,'white','user/decorate/订单状态.png','user/banner/购物车view--serializer过程.png',0,0,0,0);

/*!40000 ALTER TABLE `user_operation_membership` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_operation_useraddress
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_operation_useraddress`;

CREATE TABLE `user_operation_useraddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `signer_name` varchar(100) NOT NULL,
  `signer_mobile` varchar(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `default_address` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_operation_usera_user_id_fe128593_fk_users_use` (`user_id`),
  CONSTRAINT `user_operation_usera_user_id_fe128593_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_operation_useraddress` WRITE;
/*!40000 ALTER TABLE `user_operation_useraddress` DISABLE KEYS */;

INSERT INTO `user_operation_useraddress` (`id`, `province`, `city`, `district`, `address`, `signer_name`, `signer_mobile`, `add_time`, `user_id`, `default_address`)
VALUES
	(12,'3333333333','3','3','3','3','13925848593','2018-04-18 19:37:21.251338',1,'1'),
	(13,'1','1','1','1','1','13925848599','2018-04-18 19:38:21.447546',1,'0'),
	(14,'31','13','31','13','31','13925848591','2018-04-18 19:39:10.161205',1,'0');

/*!40000 ALTER TABLE `user_operation_useraddress` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_operation_userfav
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_operation_userfav`;

CREATE TABLE `user_operation_userfav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_operation_userfav_user_id_goods_id_2dbadda7_uniq` (`user_id`,`goods_id`),
  KEY `user_operation_userfav_goods_id_57fc554f_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `user_operation_userfav_goods_id_57fc554f_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`),
  CONSTRAINT `user_operation_userfav_user_id_4e4de070_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_operation_userfav` WRITE;
/*!40000 ALTER TABLE `user_operation_userfav` DISABLE KEYS */;

INSERT INTO `user_operation_userfav` (`id`, `add_time`, `goods_id`, `user_id`)
VALUES
	(1,'2018-04-18 16:27:41.823154',1,4),
	(2,'2018-04-18 19:09:11.443431',1,1);

/*!40000 ALTER TABLE `user_operation_userfav` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_operation_userleavingmessage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_operation_userleavingmessage`;

CREATE TABLE `user_operation_userleavingmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_type` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `file` varchar(100) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_operation_userl_user_id_70d909d6_fk_users_use` (`user_id`),
  CONSTRAINT `user_operation_userl_user_id_70d909d6_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_operation_userleavingmessage` WRITE;
/*!40000 ALTER TABLE `user_operation_userleavingmessage` DISABLE KEYS */;

INSERT INTO `user_operation_userleavingmessage` (`id`, `message_type`, `subject`, `message`, `file`, `add_time`, `user_id`)
VALUES
	(1,5,'pro','pro','message/images/会员积分等级设计.pdf','2018-04-18 17:04:13.224414',2);

/*!40000 ALTER TABLE `user_operation_userleavingmessage` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_operation_usermembershipinfo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_operation_usermembershipinfo`;

CREATE TABLE `user_operation_usermembershipinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owned_sum` int(11) NOT NULL,
  `shared_sum` int(11) NOT NULL,
  `check_in_sum` int(11) NOT NULL,
  `membership_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `check_in_status` tinyint(1) NOT NULL,
  `last_check_in_time` datetime(6) NOT NULL,
  `bonus_point` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_id` (`user_id`),
  KEY `user_operation_userm_membership_id_f245fe2c_fk_user_oper` (`membership_id`),
  CONSTRAINT `user_operation_userm_membership_id_f245fe2c_fk_user_oper` FOREIGN KEY (`membership_id`) REFERENCES `user_operation_membership` (`id`),
  CONSTRAINT `user_operation_userm_user_id_3f21b089_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_operation_usermembershipinfo` WRITE;
/*!40000 ALTER TABLE `user_operation_usermembershipinfo` DISABLE KEYS */;

INSERT INTO `user_operation_usermembershipinfo` (`id`, `owned_sum`, `shared_sum`, `check_in_sum`, `membership_id`, `user_id`, `check_in_status`, `last_check_in_time`, `bonus_point`)
VALUES
	(4,0,0,56,1,1,0,'2018-04-26 10:35:51.811403',4),
	(7,0,0,6,1,2,0,'2018-04-19 11:15:28.163744',0);

/*!40000 ALTER TABLE `user_operation_usermembershipinfo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users_userprofile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_userprofile`;

CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(6) NOT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;

INSERT INTO `users_userprofile` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `name`, `birthday`, `gender`, `mobile`, `email`, `image`)
VALUES
	(1,'pbkdf2_sha256$150000$Y6HGqHQCkm0g$seTBmvzIr65+kwsUKIcu6JBXm28NEpVcWdv9W5oCVAI=','2019-05-29 10:09:44.088724',1,'admin','','',1,1,'2018-04-09 20:12:48.423408',NULL,NULL,'female',NULL,'admin@qq.com',''),
	(2,'pbkdf2_sha256$100000$gmTrMcCUxzzq$J4Zi1jANs0bmUNr4qN7YNJr95J6gW2KVdbm7YnTh9gM=','2018-04-19 10:48:32.050979',0,'13925848599','','',0,1,'2018-04-17 15:04:35.459427','',NULL,'male','13925848599','',''),
	(3,'pbkdf2_sha256$100000$QeF6sMHkgRkR$VTztVyJqEibRHHfIG3Qff9QNgRSSEAuUvda03URRG2U=','2018-04-18 10:16:32.124556',0,'13925848590','','',0,1,'2018-04-18 10:16:08.569717',NULL,NULL,'female','13925848590',NULL,''),
	(4,'pbkdf2_sha256$100000$Yz3NCNBxIaej$y+qSUrGyi+bReBuaVbErgLTbRumnI5pJzg6i43OtLHY=','2018-04-18 10:34:36.820559',0,'13925848591','','',0,1,'2018-04-18 10:33:56.356067',NULL,NULL,'female','13925848591',NULL,'');

/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users_userprofile_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_userprofile_groups`;

CREATE TABLE `users_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_groups_userprofile_id_group_id_823cf2fc_uniq` (`userprofile_id`,`group_id`),
  KEY `users_userprofile_groups_group_id_3de53dbf_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_userprofile_gr_userprofile_id_a4496a80_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`),
  CONSTRAINT `users_userprofile_groups_group_id_3de53dbf_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users_userprofile_user_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_userprofile_user_permissions`;

CREATE TABLE `users_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_user_p_userprofile_id_permissio_d0215190_uniq` (`userprofile_id`,`permission_id`),
  KEY `users_userprofile_us_permission_id_393136b6_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_userprofile_us_permission_id_393136b6_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_userprofile_us_userprofile_id_34544737_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users_verifycode
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_verifycode`;

CREATE TABLE `users_verifycode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users_verifycode` WRITE;
/*!40000 ALTER TABLE `users_verifycode` DISABLE KEYS */;

INSERT INTO `users_verifycode` (`id`, `code`, `mobile`, `add_time`)
VALUES
	(1,'1234','13925848599','2018-04-19 10:46:00.000000');

/*!40000 ALTER TABLE `users_verifycode` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table xadmin_bookmark
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xadmin_bookmark`;

CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table xadmin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xadmin_log`;

CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table xadmin_usersettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xadmin_usersettings`;

CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table xadmin_userwidget
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xadmin_userwidget`;

CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
