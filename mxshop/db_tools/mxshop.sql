-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: mxshop1
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can view group',2,'view_group'),(8,'Can view permission',1,'view_permission'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add session',4,'add_session'),(14,'Can change session',4,'change_session'),(15,'Can delete session',4,'delete_session'),(16,'Can view session',4,'view_session'),(17,'Can add 用户',5,'add_userprofile'),(18,'Can change 用户',5,'change_userprofile'),(19,'Can delete 用户',5,'delete_userprofile'),(20,'Can add 会员等级',6,'add_member'),(21,'Can change 会员等级',6,'change_member'),(22,'Can delete 会员等级',6,'delete_member'),(23,'Can add 短信验证码',7,'add_verifycode'),(24,'Can change 短信验证码',7,'change_verifycode'),(25,'Can delete 短信验证码',7,'delete_verifycode'),(26,'Can view 会员等级',6,'view_member'),(27,'Can view 用户',5,'view_userprofile'),(28,'Can view 短信验证码',7,'view_verifycode'),(29,'Can add 轮播商品',8,'add_banner'),(30,'Can change 轮播商品',8,'change_banner'),(31,'Can delete 轮播商品',8,'delete_banner'),(32,'Can add 商品',9,'add_goods'),(33,'Can change 商品',9,'change_goods'),(34,'Can delete 商品',9,'delete_goods'),(35,'Can add 商品类别',10,'add_goodscategory'),(36,'Can change 商品类别',10,'change_goodscategory'),(37,'Can delete 商品类别',10,'delete_goodscategory'),(38,'Can add 品牌',11,'add_goodscategorybrand'),(39,'Can change 品牌',11,'change_goodscategorybrand'),(40,'Can delete 品牌',11,'delete_goodscategorybrand'),(41,'Can add 商品图片',12,'add_goodsimage'),(42,'Can change 商品图片',12,'change_goodsimage'),(43,'Can delete 商品图片',12,'delete_goodsimage'),(44,'Can add 热搜词',13,'add_hotsearchwords'),(45,'Can change 热搜词',13,'change_hotsearchwords'),(46,'Can delete 热搜词',13,'delete_hotsearchwords'),(47,'Can add 首页商品类别广告',14,'add_indexad'),(48,'Can change 首页商品类别广告',14,'change_indexad'),(49,'Can delete 首页商品类别广告',14,'delete_indexad'),(50,'Can view 轮播商品',8,'view_banner'),(51,'Can view 商品',9,'view_goods'),(52,'Can view 商品类别',10,'view_goodscategory'),(53,'Can view 品牌',11,'view_goodscategorybrand'),(54,'Can view 商品图片',12,'view_goodsimage'),(55,'Can view 热搜词',13,'view_hotsearchwords'),(56,'Can view 首页商品类别广告',14,'view_indexad'),(57,'Can add 订单商品',15,'add_ordergoods'),(58,'Can change 订单商品',15,'change_ordergoods'),(59,'Can delete 订单商品',15,'delete_ordergoods'),(60,'Can add 订单',16,'add_orderinfo'),(61,'Can change 订单',16,'change_orderinfo'),(62,'Can delete 订单',16,'delete_orderinfo'),(63,'Can add 购物车',17,'add_shoppingcart'),(64,'Can change 购物车',17,'change_shoppingcart'),(65,'Can delete 购物车',17,'delete_shoppingcart'),(66,'Can view 订单商品',15,'view_ordergoods'),(67,'Can view 订单',16,'view_orderinfo'),(68,'Can view 购物车',17,'view_shoppingcart'),(69,'Can add 收货地址',18,'add_useraddress'),(70,'Can change 收货地址',18,'change_useraddress'),(71,'Can delete 收货地址',18,'delete_useraddress'),(72,'Can add 用户收藏',19,'add_userfav'),(73,'Can change 用户收藏',19,'change_userfav'),(74,'Can delete 用户收藏',19,'delete_userfav'),(75,'Can add 用户留言',20,'add_userleavingmessage'),(76,'Can change 用户留言',20,'change_userleavingmessage'),(77,'Can delete 用户留言',20,'delete_userleavingmessage'),(78,'Can view 收货地址',18,'view_useraddress'),(79,'Can view 用户收藏',19,'view_userfav'),(80,'Can view 用户留言',20,'view_userleavingmessage'),(81,'Can add Bookmark',21,'add_bookmark'),(82,'Can change Bookmark',21,'change_bookmark'),(83,'Can delete Bookmark',21,'delete_bookmark'),(84,'Can add User Setting',22,'add_usersettings'),(85,'Can change User Setting',22,'change_usersettings'),(86,'Can delete User Setting',22,'delete_usersettings'),(87,'Can add User Widget',23,'add_userwidget'),(88,'Can change User Widget',23,'change_userwidget'),(89,'Can delete User Widget',23,'delete_userwidget'),(90,'Can add log entry',24,'add_log'),(91,'Can change log entry',24,'change_log'),(92,'Can delete log entry',24,'delete_log'),(93,'Can view Bookmark',21,'view_bookmark'),(94,'Can view log entry',24,'view_log'),(95,'Can view User Setting',22,'view_usersettings'),(96,'Can view User Widget',23,'view_userwidget'),(97,'Can add Token',25,'add_token'),(98,'Can change Token',25,'change_token'),(99,'Can delete Token',25,'delete_token'),(100,'Can view Token',25,'view_token'),(101,'Can add association',26,'add_association'),(102,'Can change association',26,'change_association'),(103,'Can delete association',26,'delete_association'),(104,'Can add code',27,'add_code'),(105,'Can change code',27,'change_code'),(106,'Can delete code',27,'delete_code'),(107,'Can add nonce',28,'add_nonce'),(108,'Can change nonce',28,'change_nonce'),(109,'Can delete nonce',28,'delete_nonce'),(110,'Can add user social auth',29,'add_usersocialauth'),(111,'Can change user social auth',29,'change_usersocialauth'),(112,'Can delete user social auth',29,'delete_usersocialauth'),(113,'Can add partial',30,'add_partial'),(114,'Can change partial',30,'change_partial'),(115,'Can delete partial',30,'delete_partial'),(116,'Can view association',26,'view_association'),(117,'Can view code',27,'view_code'),(118,'Can view nonce',28,'view_nonce'),(119,'Can view partial',30,'view_partial'),(120,'Can view user social auth',29,'view_usersocialauth'),(121,'Can add user dashboard module',31,'add_userdashboardmodule'),(122,'Can change user dashboard module',31,'change_userdashboardmodule'),(123,'Can delete user dashboard module',31,'delete_userdashboardmodule'),(124,'Can view user dashboard module',31,'view_userdashboardmodule'),(125,'Can add bookmark',32,'add_bookmark'),(126,'Can change bookmark',32,'change_bookmark'),(127,'Can delete bookmark',32,'delete_bookmark'),(128,'Can add pinned application',33,'add_pinnedapplication'),(129,'Can change pinned application',33,'change_pinnedapplication'),(130,'Can delete pinned application',33,'delete_pinnedapplication'),(131,'Can view bookmark',32,'view_bookmark'),(132,'Can view pinned application',33,'view_pinnedapplication'),(133,'Can add log entry',34,'add_logentry'),(134,'Can change log entry',34,'change_logentry'),(135,'Can delete log entry',34,'delete_logentry'),(136,'Can view log entry',34,'view_logentry'),(137,'Can add 评论',35,'add_goodscomment'),(138,'Can change 评论',35,'change_goodscomment'),(139,'Can delete 评论',35,'delete_goodscomment'),(140,'Can add 评论图片',36,'add_goodscommentiamge'),(141,'Can change 评论图片',36,'change_goodscommentiamge'),(142,'Can delete 评论图片',36,'delete_goodscommentiamge'),(143,'Can add 会员等级规则',37,'add_membership'),(144,'Can change 会员等级规则',37,'change_membership'),(145,'Can delete 会员等级规则',37,'delete_membership'),(146,'Can add 会员资料',38,'add_usermembershipinfo'),(147,'Can change 会员资料',38,'change_usermembershipinfo'),(148,'Can delete 会员资料',38,'delete_usermembershipinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('96f467972a8c25009b71b26d740f7f82b696763c','2018-04-12 14:26:28.237512',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_userdashboardmodule`
--

DROP TABLE IF EXISTS `dashboard_userdashboardmodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_userdashboardmodule`
--

LOCK TABLES `dashboard_userdashboardmodule` WRITE;
/*!40000 ALTER TABLE `dashboard_userdashboardmodule` DISABLE KEYS */;
INSERT INTO `dashboard_userdashboardmodule` VALUES (1,'Quick links','jet.dashboard.modules.LinkList',NULL,1,0,0,'{\"draggable\": false, \"deletable\": false, \"collapsible\": false, \"layout\": \"inline\"}','[{\"title\": \"Return to site\", \"url\": \"/\"}, {\"title\": \"\\u4fee\\u6539\\u5bc6\\u7801\", \"url\": \"/admin/password_change/\"}, {\"title\": \"\\u6ce8\\u9500\", \"url\": \"/admin/logout/\"}]',0),(2,'Applications','jet.dashboard.modules.AppList',NULL,1,1,0,'{\"models\": null, \"exclude\": [\"auth.*\"]}','',0),(3,'管理','jet.dashboard.modules.AppList',NULL,1,2,0,'{\"models\": [\"auth.*\"], \"exclude\": null}','',0),(5,'Latest Django News','jet.dashboard.modules.Feed',NULL,1,1,1,'{\"feed_url\": \"http://www.djangoproject.com/rss/weblog/\", \"limit\": 5}','',0),(6,'Support','jet.dashboard.modules.LinkList',NULL,1,2,1,'{\"draggable\": true, \"deletable\": true, \"collapsible\": true, \"layout\": \"stacked\"}','[{\"title\": \"Django documentation\", \"url\": \"http://docs.djangoproject.com/\", \"external\": true}, {\"title\": \"Django \\\"django-users\\\" mailing list\", \"url\": \"http://groups.google.com/group/django-users\", \"external\": true}, {\"title\": \"Django irc channel\", \"url\": \"irc://irc.freenode.net/django\", \"external\": true}]',0),(7,'Application models','jet.dashboard.modules.ModelList','users',1,0,0,'{\"models\": [\"users.*\"], \"exclude\": null}','',0),(9,'Application models','jet.dashboard.modules.ModelList','user_operation',1,0,0,'{\"models\": [\"user_operation.*\"], \"exclude\": null}','',0),(10,'Recent Actions','jet.dashboard.modules.RecentActions','user_operation',1,1,0,'{\"limit\": 10, \"include_list\": [\"user_operation.*\"], \"exclude_list\": null, \"user\": null}','',0);
/*!40000 ALTER TABLE `dashboard_userdashboardmodule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-04-17 14:26:50.180013','1','普通',1,'[{\"added\": {}}]',37,1),(2,'2018-04-17 15:04:11.419709','1','1234',1,'[{\"added\": {}}]',7,1),(3,'2018-04-18 10:14:51.421982','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),(4,'2018-04-18 10:16:03.566865','1','1234',2,'[{\"changed\": {\"fields\": [\"add_time\"]}}]',7,1),(5,'2018-04-18 10:33:04.024949','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),(6,'2018-04-18 19:02:56.110580','8','1',3,'',18,1),(7,'2018-04-18 19:02:56.153013','7','1',3,'',18,1),(8,'2018-04-18 19:02:56.191971','6','1',3,'',18,1),(9,'2018-04-18 19:03:54.811974','9','1',3,'',18,1),(10,'2018-04-18 19:30:31.022137','11','1',3,'',18,1),(11,'2018-04-18 19:30:31.075713','10','1',3,'',18,1),(12,'2018-04-19 10:46:39.320268','1','1234',2,'[{\"changed\": {\"fields\": [\"mobile\", \"add_time\"]}}]',7,1),(13,'2018-04-19 14:36:06.047710','57','蔬菜水果',2,'[{\"changed\": {\"fields\": [\"desc\", \"is_tab\"]}}]',10,1),(14,'2018-04-25 12:01:15.555151','52','融氏纯玉米胚芽油5l桶',2,'[{\"changed\": {\"fields\": [\"goods_num\"]}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (34,'admin','logentry'),(2,'auth','group'),(1,'auth','permission'),(25,'authtoken','token'),(3,'contenttypes','contenttype'),(31,'dashboard','userdashboardmodule'),(8,'goods','banner'),(9,'goods','goods'),(10,'goods','goodscategory'),(11,'goods','goodscategorybrand'),(35,'goods','goodscomment'),(36,'goods','goodscommentiamge'),(12,'goods','goodsimage'),(13,'goods','hotsearchwords'),(14,'goods','indexad'),(32,'jet','bookmark'),(33,'jet','pinnedapplication'),(4,'sessions','session'),(26,'social_django','association'),(27,'social_django','code'),(28,'social_django','nonce'),(30,'social_django','partial'),(29,'social_django','usersocialauth'),(15,'trade','ordergoods'),(16,'trade','orderinfo'),(17,'trade','shoppingcart'),(6,'users','member'),(5,'users','userprofile'),(7,'users','verifycode'),(37,'user_operation','membership'),(18,'user_operation','useraddress'),(19,'user_operation','userfav'),(20,'user_operation','userleavingmessage'),(38,'user_operation','usermembershipinfo'),(21,'xadmin','bookmark'),(24,'xadmin','log'),(22,'xadmin','usersettings'),(23,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-04-09 20:11:54.389460'),(2,'contenttypes','0002_remove_content_type_name','2018-04-09 20:11:54.473307'),(3,'auth','0001_initial','2018-04-09 20:11:54.756056'),(4,'auth','0002_alter_permission_name_max_length','2018-04-09 20:11:54.820943'),(5,'auth','0003_alter_user_email_max_length','2018-04-09 20:11:54.840576'),(6,'auth','0004_alter_user_username_opts','2018-04-09 20:11:54.856494'),(7,'auth','0005_alter_user_last_login_null','2018-04-09 20:11:54.876587'),(8,'auth','0006_require_contenttypes_0002','2018-04-09 20:11:54.881252'),(9,'auth','0007_alter_validators_add_error_messages','2018-04-09 20:11:54.899449'),(10,'auth','0008_alter_user_username_max_length','2018-04-09 20:11:54.915229'),(11,'auth','0009_alter_user_last_name_max_length','2018-04-09 20:11:54.929479'),(12,'users','0001_initial','2018-04-09 20:11:55.319987'),(13,'admin','0001_initial','2018-04-09 20:11:55.465044'),(14,'admin','0002_logentry_remove_auto_add','2018-04-09 20:11:55.487905'),(15,'authtoken','0001_initial','2018-04-09 20:11:55.577709'),(16,'authtoken','0002_auto_20160226_1747','2018-04-09 20:11:55.700627'),(17,'dashboard','0001_initial','2018-04-09 20:11:55.743086'),(18,'goods','0001_initial','2018-04-09 20:11:56.336750'),(19,'jet','0001_initial','2018-04-09 20:11:56.434137'),(20,'jet','0002_delete_userdashboardmodule','2018-04-09 20:11:56.452008'),(21,'sessions','0001_initial','2018-04-09 20:11:56.509177'),(22,'default','0001_initial','2018-04-09 20:11:56.853171'),(23,'social_auth','0001_initial','2018-04-09 20:11:56.859050'),(24,'default','0002_add_related_name','2018-04-09 20:11:56.943703'),(25,'social_auth','0002_add_related_name','2018-04-09 20:11:56.949040'),(26,'default','0003_alter_email_max_length','2018-04-09 20:11:57.013181'),(27,'social_auth','0003_alter_email_max_length','2018-04-09 20:11:57.019337'),(28,'default','0004_auto_20160423_0400','2018-04-09 20:11:57.045903'),(29,'social_auth','0004_auto_20160423_0400','2018-04-09 20:11:57.051787'),(30,'social_auth','0005_auto_20160727_2333','2018-04-09 20:11:57.078335'),(31,'social_django','0006_partial','2018-04-09 20:11:57.130213'),(32,'social_django','0007_code_timestamp','2018-04-09 20:11:57.197500'),(33,'social_django','0008_partial_timestamp','2018-04-09 20:11:57.259742'),(34,'trade','0001_initial','2018-04-09 20:11:57.418588'),(35,'trade','0002_auto_20180409_2011','2018-04-09 20:11:57.904018'),(36,'user_operation','0001_initial','2018-04-09 20:11:57.993307'),(37,'user_operation','0002_auto_20180409_2011','2018-04-09 20:11:58.482099'),(38,'xadmin','0001_initial','2018-04-09 20:11:58.859744'),(39,'xadmin','0002_log','2018-04-09 20:11:59.040434'),(40,'xadmin','0003_auto_20160715_0100','2018-04-09 20:11:59.148886'),(41,'social_django','0004_auto_20160423_0400','2018-04-09 20:11:59.157932'),(42,'social_django','0005_auto_20160727_2333','2018-04-09 20:11:59.163409'),(43,'social_django','0003_alter_email_max_length','2018-04-09 20:11:59.175601'),(44,'social_django','0002_add_related_name','2018-04-09 20:11:59.186271'),(45,'social_django','0001_initial','2018-04-09 20:11:59.192576'),(46,'goods','0002_goodscomment_goodscommentiamge','2018-04-17 11:54:59.344273'),(47,'user_operation','0003_membership_usermembershipinfo','2018-04-17 11:54:59.550781'),(48,'users','0002_userprofile_image','2018-04-17 11:54:59.657639'),(49,'users','0003_auto_20180417_1116','2018-04-17 11:55:00.138835'),(50,'user_operation','0004_auto_20180417_1411','2018-04-17 14:11:20.760256'),(51,'user_operation','0005_auto_20180417_1648','2018-04-17 16:48:44.417714'),(52,'goods','0003_auto_20180418_1845','2018-04-18 18:45:11.631191'),(53,'user_operation','0006_auto_20180418_1845','2018-04-18 18:45:11.747611'),(54,'user_operation','0007_auto_20180426_1033','2018-04-26 10:33:55.469074');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8rlkt1x0c3v630u54cowavztu1vgej53','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-02 19:09:59.434801'),('cd5q75gaidlp7swjlat705njw36sz90s','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-10 10:09:26.906830'),('eejxwu9bjctf4ec4z7foxwbtotusu2nr','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-03 09:49:28.609541'),('o90z0yrju7waf9hhvmchi0i2wibwsyj0','MTM1N2Y0YTZmNjg2MGE3YTg0NWM0MTI0OTlhNDc5YzNmZTkyMTZmMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYiLCJ3ZWlib19zdGF0ZSI6IlR4c1dvdlEyVTFMa2RNeHRubTNQRk1uZzRXQjdYNnVvIn0=','2018-05-03 16:34:05.805801'),('xfjdpwedtldpk85ep0qkrrv3ifwf4htu','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-09 12:00:59.104648'),('yobt0w1cp6mores2fgtuscm7rkgq53p3','NzE0NDE1ODg5MDczODg5MzA4NWU2ZDc5OGVmZDFmMTdjYjQzZjQ1Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYwYWMxNzNkODc0MWRmMmYwNmRlMzYzYjE1ZWNiZmY1OTA1MmM0ZmYifQ==','2018-05-03 09:53:24.112685');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_banner`
--

DROP TABLE IF EXISTS `goods_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_banner`
--

LOCK TABLES `goods_banner` WRITE;
/*!40000 ALTER TABLE `goods_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goods`
--

DROP TABLE IF EXISTS `goods_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_sn` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `click_num` int(11) NOT NULL,
  `sold_num` int(11) NOT NULL,
  `fav_num` int(11) NOT NULL,
  `goods_num` int(11) NOT NULL,
  `market_price` double NOT NULL,
  `shop_price` double NOT NULL,
  `goods_brief` longtext NOT NULL,
  `goods_desc` longtext NOT NULL,
  `ship_free` tinyint(1) NOT NULL,
  `goods_front_image` varchar(100) DEFAULT NULL,
  `is_new` tinyint(1) NOT NULL,
  `is_hot` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goods_category_id_da3507dd_fk_goods_goodscategory_id` (`category_id`),
  CONSTRAINT `goods_goods_category_id_da3507dd_fk_goods_goodscategory_id` FOREIGN KEY (`category_id`) REFERENCES `goods_goodscategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goods`
--

LOCK TABLES `goods_goods` WRITE;
/*!40000 ALTER TABLE `goods_goods` DISABLE KEYS */;
INSERT INTO `goods_goods` VALUES (1,'','新鲜水果甜蜜香脆单果约800克',4,0,2,0,232,156,'食用百香果可以增加胃部饱腹感，减少余热量的摄入，还可以吸附胆固醇和胆汁之类有机分子，抑制人体对脂肪的吸收。因此，长期食用有利于改善人体营养吸收结构，降低体内脂肪，塑造健康优美体态。','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/1_P_1449024889889.jpg',0,0,'2018-04-09 20:14:28.879095',20),(2,'','田然牛肉大黄瓜条生鲜牛肉冷冻真空黄牛',0,0,0,0,106,88,'前腿+后腿+羊排共8斤，原生态大山放牧羊羔，曾经的皇室贡品，央视推荐，2005年北京招待全球财金首脑。五层专用包装箱+真空包装+冰袋+保鲜箱+顺丰冷链发货，路途保质期8天','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/2_P_1448945810202.jpg',0,0,'2018-04-09 20:14:28.927716',7),(3,'','酣畅家庭菲力牛排10片澳洲生鲜牛肉团购套餐',0,0,0,0,286,238,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/7_P_1448945104883.jpg',0,0,'2018-04-09 20:14:28.946451',15),(4,'','日本蒜蓉粉丝扇贝270克6只装',0,0,0,0,156,108,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/47_P_1448946213263.jpg',0,0,'2018-04-09 20:14:28.962952',20),(5,'','内蒙新鲜牛肉1斤清真生鲜牛肉火锅食材',0,0,0,0,106,88,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/10_P_1448944572085.jpg',0,0,'2018-04-09 20:14:28.977817',7),(6,'','乌拉圭进口牛肉卷特级肥牛卷',0,0,0,0,90,75,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/4_P_1448945381985.jpg',0,0,'2018-04-09 20:14:28.997606',21),(7,'','五星眼肉牛排套餐8片装原味原切生鲜牛肉',0,0,0,0,150,125,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/8_P_1448945032810.jpg',0,0,'2018-04-09 20:14:29.011052',23),(8,'','澳洲进口120天谷饲牛仔骨4份原味生鲜',0,0,0,0,31,26,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/11_P_1448944388277.jpg',0,0,'2018-04-09 20:14:29.023256',7),(9,'','潮香村澳洲进口牛排家庭团购套餐20片',0,0,0,0,239,199,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/6_P_1448945167279.jpg',0,0,'2018-04-09 20:14:29.038915',22),(10,'','爱食派内蒙古呼伦贝尔冷冻生鲜牛腱子肉1000g',0,0,0,0,202,168,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/9_P_1448944791617.jpg',0,0,'2018-04-09 20:14:29.052021',20),(11,'','澳洲进口牛尾巴300g新鲜肥牛肉',0,0,0,0,306,255,'新鲜羊羔肉整只共15斤，原生态大山放牧羊羔，曾经的皇室贡品，央视推荐，2005年北京招待全球财金首脑。五层专用包装箱+真空包装+冰袋+保鲜箱+顺丰冷链发货，路途保质期8天','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/3_P_1448945490837.jpg',0,0,'2018-04-09 20:14:29.073783',2),(12,'','新疆巴尔鲁克生鲜牛排眼肉牛扒1200g',0,0,0,0,126,88,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/48_P_1448943988970.jpg',0,0,'2018-04-09 20:14:29.088969',7),(13,'','澳洲进口安格斯牛切片上脑牛排1000g',0,0,0,0,144,120,'澳大利亚是国际公认的没有疯牛病和口蹄疫的国家。为了保持澳大利亚产品的高标准，澳大利亚牛肉业和各级政府共同努力简历了严格的标准和体系，以保证生产的整体化和产品的可追溯性','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/5_P_1448945270390.jpg',0,0,'2018-04-09 20:14:29.107391',12),(14,'','帐篷出租',0,0,0,0,120,100,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'images/201705/goods_img/53_P_1495068879687.jpg',0,0,'2018-04-09 20:14:29.126113',21),(15,'','52度茅台集团国隆双喜酒500mlx6',0,0,0,0,23,19,'贵州茅台酒厂（集团）保健酒业有限公司生产，是以“龙”字打头的酒水。中国龙文化上下8000年，源远而流长，龙的形象是一种符号、一种意绪、一种血肉相联的情感。','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/16_P_1448947194687.jpg',0,0,'2018-04-09 20:14:29.137086',37),(16,'','52度水井坊臻酿八號500ml',0,0,0,0,43,36,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/14_P_1448947354031.jpg',0,0,'2018-04-09 20:14:29.148103',36),(17,'','53度茅台仁酒500ml',0,0,0,0,190,158,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/12_P_1448947547989.jpg',0,0,'2018-04-09 20:14:29.163334',32),(18,'','双响炮洋酒JimBeamwhiskey美国白占边',0,0,0,0,38,28,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/46_P_1448946598711.jpg',0,0,'2018-04-09 20:14:29.174676',29),(19,'','西夫拉姆进口洋酒小酒版',0,0,0,0,55,46,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/21_P_1448946793276.jpg',0,0,'2018-04-09 20:14:29.189568',36),(20,'','茅台53度飞天茅台500ml',0,0,0,0,22,18,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/15_P_1448947257324.jpg',0,0,'2018-04-09 20:14:29.204036',30),(21,'','52度兰陵·紫气东来1600mL山东名酒',0,0,0,0,42,35,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/13_P_1448947460386.jpg',0,0,'2018-04-09 20:14:29.218340',29),(22,'','JohnnieWalker尊尼获加黑牌威士忌',0,0,0,0,24,20,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/50_P_1448946543091.jpg',0,0,'2018-04-09 20:14:29.236886',36),(23,'','人头马CLUB特优香槟干邑350ml',0,0,0,0,31,26,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/51_P_1448946466595.jpg',0,0,'2018-04-09 20:14:29.251652',30),(24,'','张裕干红葡萄酒750ml*6支',0,0,0,0,54,45,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/17_P_1448947102246.jpg',0,0,'2018-04-09 20:14:29.266270',31),(25,'','原瓶原装进口洋酒烈酒法国云鹿XO白兰地',0,0,0,0,46,38,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/20_P_1448946850602.jpg',0,0,'2018-04-09 20:14:29.276759',29),(26,'','法国原装进口圣贝克干红葡萄酒750ml',0,0,0,0,82,68,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/19_P_1448946951581.jpg',0,0,'2018-04-09 20:14:29.287153',25),(27,'','法国百利威干红葡萄酒AOP级6支装',0,0,0,0,67,56,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/18_P_1448947011435.jpg',0,0,'2018-04-09 20:14:29.302595',25),(28,'','芝华士12年苏格兰威士忌700ml',0,0,0,0,71,59,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/22_P_1448946729629.jpg',0,0,'2018-04-09 20:14:29.311868',30),(29,'','深蓝伏特加巴维兰利口酒送预调酒',0,0,0,0,31,18,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/45_P_1448946661303.jpg',0,0,'2018-04-09 20:14:29.322158',36),(30,'','赣南脐橙特级果10斤装',0,0,0,0,43,36,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/32_P_1448948525620.jpg',0,0,'2018-04-09 20:14:29.333305',62),(31,'','泰国菠萝蜜16-18斤1个装',0,0,0,0,11,9,'【懒人吃法】菠萝蜜果肉，冰袋保鲜，收货就吃，冰爽Q脆甜，2斤装，全国顺丰空运包邮，发出后48小时内可达，一线城市基本隔天可达','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/30_P_1448948663450.jpg',0,0,'2018-04-09 20:14:29.344015',66),(32,'','四川双流草莓新鲜水果礼盒2盒',0,0,0,0,22,18,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/31_P_1448948598947.jpg',0,0,'2018-04-09 20:14:29.362434',70),(33,'','新鲜头茬非洲冰草冰菜',0,0,0,0,67,56,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/35_P_1448948333610.jpg',0,0,'2018-04-09 20:14:29.376140',58),(34,'','仿真蔬菜水果果蔬菜模型',0,0,0,0,6,5,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/36_P_1448948234405.jpg',0,0,'2018-04-09 20:14:29.390648',58),(35,'','现摘芭乐番石榴台湾珍珠芭乐',0,0,0,0,28,23,'海南产精品释迦果,\n        释迦是水果中的贵族,\n        产量少,\n        味道很甜,\n        奶香十足,\n        非常可口,\n        果裹果园顺丰空运,\n        保证新鲜.果子个大,\n        一斤1-2个左右,\n        大个头的果子更尽兴!\n        ','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/33_P_1448948479966.jpg',0,0,'2018-04-09 20:14:29.403901',62),(36,'','潍坊萝卜5斤/箱礼盒',0,0,0,0,46,38,'脐橙规格是65-90MM左右（标准果果径平均70MM左右，精品果果径平均80MM左右），一斤大概有2-4个左右，脐橙产自江西省赣州市信丰县安西镇，全过程都是采用农家有机肥种植，生态天然','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/34_P_1448948399009.jpg',0,0,'2018-04-09 20:14:29.418969',70),(37,'','休闲零食膨化食品焦糖/奶油/椒麻味',0,0,0,0,154,99,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/43_P_1448948762645.jpg',0,0,'2018-04-09 20:14:29.430476',74),(38,'','蒙牛未来星儿童成长牛奶骨力型190ml*15盒',0,0,0,0,84,70,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/38_P_1448949220255.jpg',0,0,'2018-04-09 20:14:29.442628',105),(39,'','蒙牛特仑苏有机奶250ml×12盒',0,0,0,0,70,32,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/44_P_1448948850187.jpg',0,0,'2018-04-09 20:14:29.454560',103),(40,'','1元支付测试商品',0,0,0,0,1,1,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'images/201511/goods_img/49_P_1448162819889.jpg',0,0,'2018-04-09 20:14:29.465950',102),(41,'','德运全脂新鲜纯牛奶1L*10盒装整箱',0,0,0,0,70,58,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/40_P_1448949038702.jpg',0,0,'2018-04-09 20:14:29.476057',103),(42,'','木糖醇红枣早餐奶即食豆奶粉538g',0,0,0,0,38,32,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/39_P_1448949115481.jpg',0,0,'2018-04-09 20:14:29.486937',106),(43,'','高钙液体奶200ml*24盒',0,0,0,0,26,22,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/41_P_1448948980358.jpg',0,0,'2018-04-09 20:14:29.496830',107),(44,'','新西兰进口全脂奶粉900g',0,0,0,0,720,600,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/37_P_1448949284365.jpg',0,0,'2018-04-09 20:14:29.507701',104),(45,'','伊利官方直营全脂营养舒化奶250ml*12盒*2提',0,0,0,0,43,36,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/42_P_1448948895193.jpg',0,0,'2018-04-09 20:14:29.518440',103),(46,'','维纳斯橄榄菜籽油5L/桶',0,0,0,0,187,156,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/27_P_1448947771805.jpg',0,0,'2018-04-09 20:14:29.534986',51),(47,'','糙米450gx3包粮油米面',0,0,0,0,18,15,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/23_P_1448948070348.jpg',0,0,'2018-04-09 20:14:29.544003',41),(48,'','精炼一级大豆油5L色拉油粮油食用油',0,0,0,0,54,45,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/26_P_1448947825754.jpg',0,0,'2018-04-09 20:14:29.554638',56),(49,'','橄榄玉米油5L*2桶',0,0,0,0,31,26,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/28_P_1448947699948.jpg',0,0,'2018-04-09 20:14:29.564277',54),(50,'','山西黑米农家黑米4斤',0,0,0,0,11,9,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/24_P_1448948023823.jpg',0,0,'2018-04-09 20:14:29.576241',55),(51,'','稻园牌稻米油粮油米糠油绿色植物油',0,0,0,0,14,12,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/25_P_1448947875346.jpg',0,0,'2018-04-09 20:14:29.594080',47),(52,'','融氏纯玉米胚芽油5l桶',0,0,0,1,14,12,'','<p><img src=\"/media/goods/images/2_20170719161405_249.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161414_628.jpg\" title=\"\" alt=\"2.jpg\"/></p><p><img src=\"/media/goods/images/2_20170719161435_381.jpg\" title=\"\" alt=\"2.jpg\"/></p>',1,'goods/images/29_P_1448947631994.jpg',0,0,'2018-04-09 20:14:29.606811',41);
/*!40000 ALTER TABLE `goods_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goodsbrand`
--

DROP TABLE IF EXISTS `goods_goodsbrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goodsbrand`
--

LOCK TABLES `goods_goodsbrand` WRITE;
/*!40000 ALTER TABLE `goods_goodsbrand` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_goodsbrand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goodscategory`
--

DROP TABLE IF EXISTS `goods_goodscategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goodscategory`
--

LOCK TABLES `goods_goodscategory` WRITE;
/*!40000 ALTER TABLE `goods_goodscategory` DISABLE KEYS */;
INSERT INTO `goods_goodscategory` VALUES (1,'生鲜食品','sxsp','',1,0,'2018-04-09 20:14:19.377456',NULL),(2,'精品肉类','jprl','',2,0,'2018-04-09 20:14:19.396740',1),(3,'羊肉','yr','',3,0,'2018-04-09 20:14:19.402547',2),(4,'禽类','ql','',3,0,'2018-04-09 20:14:19.406351',2),(5,'猪肉','zr','',3,0,'2018-04-09 20:14:19.410300',2),(6,'牛肉','nr','',3,0,'2018-04-09 20:14:19.414129',2),(7,'海鲜水产','hxsc','',2,0,'2018-04-09 20:14:19.418153',1),(8,'参鲍','cb','',3,0,'2018-04-09 20:14:19.422103',7),(9,'鱼','yu','',3,0,'2018-04-09 20:14:19.429065',7),(10,'虾','xia','',3,0,'2018-04-09 20:14:19.432736',7),(11,'蟹/贝','xb','',3,0,'2018-04-09 20:14:19.436638',7),(12,'蛋制品','dzp','',2,0,'2018-04-09 20:14:19.440566',1),(13,'松花蛋/咸鸭蛋','xhd_xyd','',3,0,'2018-04-09 20:14:19.445635',12),(14,'鸡蛋','jd','',3,0,'2018-04-09 20:14:19.449757',12),(15,'叶菜类','ycl','',2,0,'2018-04-09 20:14:19.453628',1),(16,'生菜','sc','',3,0,'2018-04-09 20:14:19.459654',15),(17,'菠菜','bc','',3,0,'2018-04-09 20:14:19.463421',15),(18,'圆椒','yj','',3,0,'2018-04-09 20:14:19.467248',15),(19,'西兰花','xlh','',3,0,'2018-04-09 20:14:19.471208',15),(20,'根茎类','gjl','',2,0,'2018-04-09 20:14:19.474969',1),(21,'茄果类','qgl','',2,0,'2018-04-09 20:14:19.478743',1),(22,'菌菇类','jgl','',2,0,'2018-04-09 20:14:19.482840',1),(23,'进口生鲜','jksx','',2,0,'2018-04-09 20:14:19.486897',1),(24,'酒水饮料','jsyl','',1,0,'2018-04-09 20:14:19.490988',NULL),(25,'白酒','bk','',2,0,'2018-04-09 20:14:19.494785',24),(26,'五粮液','wly','',3,0,'2018-04-09 20:14:19.498891',25),(27,'泸州老窖','lzlj','',3,0,'2018-04-09 20:14:19.503027',25),(28,'茅台','mt','',3,0,'2018-04-09 20:14:19.507216',25),(29,'葡萄酒','ptj','',2,0,'2018-04-09 20:14:19.513591',24),(30,'洋酒','yj','',2,0,'2018-04-09 20:14:19.517796',24),(31,'啤酒','pj','',2,0,'2018-04-09 20:14:19.523254',24),(32,'其他酒品','qtjp','',2,0,'2018-04-09 20:14:19.527213',24),(33,'其他品牌','qtpp','',3,0,'2018-04-09 20:14:19.530993',32),(34,'黄酒','hj','',3,0,'2018-04-09 20:14:19.534860',32),(35,'养生酒','ysj','',3,0,'2018-04-09 20:14:19.538886',32),(36,'饮料/水','yls','',2,0,'2018-04-09 20:14:19.544164',24),(37,'红酒','hj','',2,0,'2018-04-09 20:14:19.547884',24),(38,'白兰地','bld','',3,0,'2018-04-09 20:14:19.551250',37),(39,'威士忌','wsj','',3,0,'2018-04-09 20:14:19.554714',37),(40,'粮油副食','粮油副食','',1,0,'2018-04-09 20:14:19.558129',NULL),(41,'食用油','食用油','',2,0,'2018-04-09 20:14:19.561675',40),(42,'其他食用油','其他食用油','',3,0,'2018-04-09 20:14:19.564063',41),(43,'菜仔油','菜仔油','',3,0,'2018-04-09 20:14:19.567321',41),(44,'花生油','花生油','',3,0,'2018-04-09 20:14:19.570687',41),(45,'橄榄油','橄榄油','',3,0,'2018-04-09 20:14:19.574118',41),(46,'礼盒','礼盒','',3,0,'2018-04-09 20:14:19.577479',41),(47,'米面杂粮','米面杂粮','',2,0,'2018-04-09 20:14:19.579855',40),(48,'面粉/面条','面粉/面条','',3,0,'2018-04-09 20:14:19.583455',47),(49,'大米','大米','',3,0,'2018-04-09 20:14:19.587348',47),(50,'意大利面','意大利面','',3,0,'2018-04-09 20:14:19.591280',47),(51,'厨房调料','厨房调料','',2,0,'2018-04-09 20:14:19.595366',40),(52,'调味油/汁','调味油/汁','',3,0,'2018-04-09 20:14:19.599107',51),(53,'酱油/醋','酱油/醋','',3,0,'2018-04-09 20:14:19.602830',51),(54,'南北干货','南北干货','',2,0,'2018-04-09 20:14:19.606789',40),(55,'方便速食','方便速食','',2,0,'2018-04-09 20:14:19.610775',40),(56,'调味品','调味品','',2,0,'2018-04-09 20:14:19.614501',40),(57,'蔬菜水果','蔬菜水果','水果',1,1,'2018-04-09 20:14:00.000000',NULL),(58,'有机蔬菜','有机蔬菜','',2,0,'2018-04-09 20:14:19.630805',57),(59,'西红柿','西红柿','',3,0,'2018-04-09 20:14:19.637029',58),(60,'韭菜','韭菜','',3,0,'2018-04-09 20:14:19.641063',58),(61,'青菜','青菜','',3,0,'2018-04-09 20:14:19.644625',58),(62,'精选蔬菜','精选蔬菜','',2,0,'2018-04-09 20:14:19.648372',57),(63,'甘蓝','甘蓝','',3,0,'2018-04-09 20:14:19.652233',62),(64,'胡萝卜','胡萝卜','',3,0,'2018-04-09 20:14:19.658604',62),(65,'黄瓜','黄瓜','',3,0,'2018-04-09 20:14:19.662536',62),(66,'进口水果','进口水果','',2,0,'2018-04-09 20:14:19.666571',57),(67,'火龙果','火龙果','',3,0,'2018-04-09 20:14:19.670519',66),(68,'菠萝蜜','菠萝蜜','',3,0,'2018-04-09 20:14:19.674839',66),(69,'奇异果','奇异果','',3,0,'2018-04-09 20:14:19.678799',66),(70,'国产水果','国产水果','',2,0,'2018-04-09 20:14:19.682683',57),(71,'水果礼盒','水果礼盒','',3,0,'2018-04-09 20:14:19.686569',70),(72,'苹果','苹果','',3,0,'2018-04-09 20:14:19.690268',70),(73,'雪梨','雪梨','',3,0,'2018-04-09 20:14:19.694483',70),(74,'休闲食品','休闲食品','',1,0,'2018-04-09 20:14:19.698297',NULL),(75,'休闲零食','休闲零食','',2,0,'2018-04-09 20:14:19.701919',74),(76,'果冻','果冻','',3,0,'2018-04-09 20:14:19.705539',75),(77,'枣类','枣类','',3,0,'2018-04-09 20:14:19.708386',75),(78,'蜜饯','蜜饯','',3,0,'2018-04-09 20:14:19.712314',75),(79,'肉类零食','肉类零食','',3,0,'2018-04-09 20:14:19.716022',75),(80,'坚果炒货','坚果炒货','',3,0,'2018-04-09 20:14:19.720075',75),(81,'糖果','糖果','',2,0,'2018-04-09 20:14:19.723830',74),(82,'创意喜糖','创意喜糖','',3,0,'2018-04-09 20:14:19.728020',81),(83,'口香糖','口香糖','',3,0,'2018-04-09 20:14:19.731931',81),(84,'软糖','软糖','',3,0,'2018-04-09 20:14:19.735860',81),(85,'棒棒糖','棒棒糖','',3,0,'2018-04-09 20:14:19.739817',81),(86,'巧克力','巧克力','',2,0,'2018-04-09 20:14:19.743665',74),(87,'夹心巧克力','夹心巧克力','',3,0,'2018-04-09 20:14:19.747734',86),(88,'白巧克力','白巧克力','',3,0,'2018-04-09 20:14:19.751652',86),(89,'松露巧克力','松露巧克力','',3,0,'2018-04-09 20:14:19.755437',86),(90,'黑巧克力','黑巧克力','',3,0,'2018-04-09 20:14:19.759283',86),(91,'肉干肉脯/豆干','肉干肉脯/豆干','',2,0,'2018-04-09 20:14:19.763404',74),(92,'牛肉干','牛肉干','',3,0,'2018-04-09 20:14:19.767433',91),(93,'猪肉脯','猪肉脯','',3,0,'2018-04-09 20:14:19.771455',91),(94,'牛肉粒','牛肉粒','',3,0,'2018-04-09 20:14:19.775579',91),(95,'猪肉干','猪肉干','',3,0,'2018-04-09 20:14:19.779806',91),(96,'鱿鱼丝/鱼干','鱿鱼丝/鱼干','',2,0,'2018-04-09 20:14:19.783746',74),(97,'鱿鱼足','鱿鱼足','',3,0,'2018-04-09 20:14:19.787673',96),(98,'鱿鱼丝','鱿鱼丝','',3,0,'2018-04-09 20:14:19.795022',96),(99,'墨鱼/乌贼','墨鱼/乌贼','',3,0,'2018-04-09 20:14:19.798932',96),(100,'鱿鱼仔','鱿鱼仔','',3,0,'2018-04-09 20:14:19.802597',96),(101,'鱿鱼片','鱿鱼片','',3,0,'2018-04-09 20:14:19.806307',96),(102,'奶类食品','奶类食品','',1,0,'2018-04-09 20:14:19.810150',NULL),(103,'进口奶品','进口奶品','',2,0,'2018-04-09 20:14:19.814068',102),(104,'国产奶品','国产奶品','',2,0,'2018-04-09 20:14:19.818037',102),(105,'奶粉','奶粉','',2,0,'2018-04-09 20:14:19.821817',102),(106,'有机奶','有机奶','',2,0,'2018-04-09 20:14:19.825741',102),(107,'原料奶','原料奶','',2,0,'2018-04-09 20:14:19.829597',102),(108,'天然干货','天然干货','',1,0,'2018-04-09 20:14:19.835630',NULL),(109,'菌菇类','菌菇类','',2,0,'2018-04-09 20:14:19.840740',108),(110,'腌干海产','腌干海产','',2,0,'2018-04-09 20:14:19.844449',108),(111,'汤料','汤料','',2,0,'2018-04-09 20:14:19.848266',108),(112,'豆类','豆类','',2,0,'2018-04-09 20:14:19.852176',108),(113,'干菜/菜干','干菜/菜干','',2,0,'2018-04-09 20:14:19.856463',108),(114,'干果/果干','干果/果干','',2,0,'2018-04-09 20:14:19.860430',108),(115,'豆制品','豆制品','',2,0,'2018-04-09 20:14:19.864243',108),(116,'腊味','腊味','',2,0,'2018-04-09 20:14:19.868180',108),(117,'精选茗茶','精选茗茶','',1,0,'2018-04-09 20:14:19.872269',NULL),(118,'白茶','白茶','',2,0,'2018-04-09 20:14:19.875847',117),(119,'红茶','红茶','',2,0,'2018-04-09 20:14:19.879845',117),(120,'绿茶','绿茶','',2,0,'2018-04-09 20:14:19.883750',117);
/*!40000 ALTER TABLE `goods_goodscategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goodscomment`
--

DROP TABLE IF EXISTS `goods_goodscomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goodscomment`
--

LOCK TABLES `goods_goodscomment` WRITE;
/*!40000 ALTER TABLE `goods_goodscomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_goodscomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goodscommentiamge`
--

DROP TABLE IF EXISTS `goods_goodscommentiamge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_goodscommentiamge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodscommentia_comment_id_126e96c1_fk_goods_goo` (`comment_id`),
  CONSTRAINT `goods_goodscommentia_comment_id_126e96c1_fk_goods_goo` FOREIGN KEY (`comment_id`) REFERENCES `goods_goodscomment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goodscommentiamge`
--

LOCK TABLES `goods_goodscommentiamge` WRITE;
/*!40000 ALTER TABLE `goods_goodscommentiamge` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_goodscommentiamge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_goodsimage`
--

DROP TABLE IF EXISTS `goods_goodsimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_goodsimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_goodsimage_goods_id_08cb23b1_fk_goods_goods_id` (`goods_id`),
  CONSTRAINT `goods_goodsimage_goods_id_08cb23b1_fk_goods_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_goodsimage`
--

LOCK TABLES `goods_goodsimage` WRITE;
/*!40000 ALTER TABLE `goods_goodsimage` DISABLE KEYS */;
INSERT INTO `goods_goodsimage` VALUES (1,'goods/images/1_P_1449024889889.jpg','2018-04-09 20:14:28.907368',1),(2,'goods/images/1_P_1449024889264.jpg','2018-04-09 20:14:28.911863',1),(3,'goods/images/1_P_1449024889726.jpg','2018-04-09 20:14:28.915866',1),(4,'goods/images/1_P_1449024889018.jpg','2018-04-09 20:14:28.919946',1),(5,'goods/images/1_P_1449024889287.jpg','2018-04-09 20:14:28.923703',1),(6,'goods/images/2_P_1448945810202.jpg','2018-04-09 20:14:28.938296',2),(7,'goods/images/2_P_1448945810814.jpg','2018-04-09 20:14:28.942295',2),(8,'goods/images/7_P_1448945104883.jpg','2018-04-09 20:14:28.953731',3),(9,'goods/images/7_P_1448945104734.jpg','2018-04-09 20:14:28.958695',3),(10,'goods/images/47_P_1448946213263.jpg','2018-04-09 20:14:28.970310',4),(11,'goods/images/47_P_1448946213157.jpg','2018-04-09 20:14:28.973973',4),(12,'goods/images/10_P_1448944572085.jpg','2018-04-09 20:14:28.985056',5),(13,'goods/images/10_P_1448944572532.jpg','2018-04-09 20:14:28.988788',5),(14,'goods/images/10_P_1448944572872.jpg','2018-04-09 20:14:28.993752',5),(15,'goods/images/4_P_1448945381985.jpg','2018-04-09 20:14:29.004514',6),(16,'goods/images/4_P_1448945381013.jpg','2018-04-09 20:14:29.007781',6),(17,'goods/images/8_P_1448945032810.jpg','2018-04-09 20:14:29.017401',7),(18,'goods/images/8_P_1448945032646.jpg','2018-04-09 20:14:29.019769',7),(19,'goods/images/11_P_1448944388277.jpg','2018-04-09 20:14:29.029395',8),(20,'goods/images/11_P_1448944388034.jpg','2018-04-09 20:14:29.032001',8),(21,'goods/images/11_P_1448944388201.jpg','2018-04-09 20:14:29.035513',8),(22,'goods/images/6_P_1448945167279.jpg','2018-04-09 20:14:29.044829',9),(23,'goods/images/6_P_1448945167015.jpg','2018-04-09 20:14:29.048603',9),(24,'goods/images/9_P_1448944791617.jpg','2018-04-09 20:14:29.058903',10),(25,'goods/images/9_P_1448944791129.jpg','2018-04-09 20:14:29.062418',10),(26,'goods/images/9_P_1448944791077.jpg','2018-04-09 20:14:29.066262',10),(27,'goods/images/9_P_1448944791229.jpg','2018-04-09 20:14:29.070042',10),(28,'goods/images/3_P_1448945490837.jpg','2018-04-09 20:14:29.080912',11),(29,'goods/images/3_P_1448945490084.jpg','2018-04-09 20:14:29.084694',11),(30,'goods/images/48_P_1448943988970.jpg','2018-04-09 20:14:29.095903',12),(31,'goods/images/48_P_1448943988898.jpg','2018-04-09 20:14:29.099848',12),(32,'goods/images/48_P_1448943988439.jpg','2018-04-09 20:14:29.103416',12),(33,'goods/images/5_P_1448945270390.jpg','2018-04-09 20:14:29.114739',13),(34,'goods/images/5_P_1448945270067.jpg','2018-04-09 20:14:29.118480',13),(35,'goods/images/5_P_1448945270432.jpg','2018-04-09 20:14:29.122228',13),(36,'images/201705/goods_img/53_P_1495068879687.jpg','2018-04-09 20:14:29.133278',14),(37,'goods/images/16_P_1448947194687.jpg','2018-04-09 20:14:29.144091',15),(38,'goods/images/14_P_1448947354031.jpg','2018-04-09 20:14:29.155072',16),(39,'goods/images/14_P_1448947354433.jpg','2018-04-09 20:14:29.159008',16),(40,'goods/images/12_P_1448947547989.jpg','2018-04-09 20:14:29.170579',17),(41,'goods/images/46_P_1448946598711.jpg','2018-04-09 20:14:29.182465',18),(42,'goods/images/46_P_1448946598301.jpg','2018-04-09 20:14:29.185935',18),(43,'goods/images/21_P_1448946793276.jpg','2018-04-09 20:14:29.196551',19),(44,'goods/images/21_P_1448946793153.jpg','2018-04-09 20:14:29.200168',19),(45,'goods/images/15_P_1448947257324.jpg','2018-04-09 20:14:29.211380',20),(46,'goods/images/15_P_1448947257580.jpg','2018-04-09 20:14:29.214809',20),(47,'goods/images/13_P_1448947460386.jpg','2018-04-09 20:14:29.225442',21),(48,'goods/images/13_P_1448947460276.jpg','2018-04-09 20:14:29.229288',21),(49,'goods/images/13_P_1448947460353.jpg','2018-04-09 20:14:29.233207',21),(50,'goods/images/50_P_1448946543091.jpg','2018-04-09 20:14:29.243873',22),(51,'goods/images/50_P_1448946542182.jpg','2018-04-09 20:14:29.247653',22),(52,'goods/images/51_P_1448946466595.jpg','2018-04-09 20:14:29.258677',23),(53,'goods/images/51_P_1448946466208.jpg','2018-04-09 20:14:29.262566',23),(54,'goods/images/17_P_1448947102246.jpg','2018-04-09 20:14:29.272973',24),(55,'goods/images/20_P_1448946850602.jpg','2018-04-09 20:14:29.283637',25),(56,'goods/images/19_P_1448946951581.jpg','2018-04-09 20:14:29.294237',26),(57,'goods/images/19_P_1448946951726.jpg','2018-04-09 20:14:29.298020',26),(58,'goods/images/18_P_1448947011435.jpg','2018-04-09 20:14:29.309424',27),(59,'goods/images/22_P_1448946729629.jpg','2018-04-09 20:14:29.318442',28),(60,'goods/images/45_P_1448946661303.jpg','2018-04-09 20:14:29.328857',29),(61,'goods/images/32_P_1448948525620.jpg','2018-04-09 20:14:29.340229',30),(62,'goods/images/30_P_1448948663450.jpg','2018-04-09 20:14:29.351073',31),(63,'goods/images/30_P_1448948662571.jpg','2018-04-09 20:14:29.354734',31),(64,'goods/images/30_P_1448948663221.jpg','2018-04-09 20:14:29.358618',31),(65,'goods/images/31_P_1448948598947.jpg','2018-04-09 20:14:29.369625',32),(66,'goods/images/31_P_1448948598475.jpg','2018-04-09 20:14:29.372430',32),(67,'goods/images/35_P_1448948333610.jpg','2018-04-09 20:14:29.383080',33),(68,'goods/images/35_P_1448948333313.jpg','2018-04-09 20:14:29.386912',33),(69,'goods/images/36_P_1448948234405.jpg','2018-04-09 20:14:29.397747',34),(70,'goods/images/36_P_1448948234250.jpg','2018-04-09 20:14:29.400248',34),(71,'goods/images/33_P_1448948479966.jpg','2018-04-09 20:14:29.411146',35),(72,'goods/images/33_P_1448948479886.jpg','2018-04-09 20:14:29.414951',35),(73,'goods/images/34_P_1448948399009.jpg','2018-04-09 20:14:29.426333',36),(74,'goods/images/43_P_1448948762645.jpg','2018-04-09 20:14:29.437833',37),(75,'goods/images/38_P_1448949220255.jpg','2018-04-09 20:14:29.450758',38),(76,'goods/images/44_P_1448948850187.jpg','2018-04-09 20:14:29.462033',39),(77,'images/201511/goods_img/49_P_1448162819889.jpg','2018-04-09 20:14:29.472433',40),(78,'goods/images/40_P_1448949038702.jpg','2018-04-09 20:14:29.483032',41),(79,'goods/images/39_P_1448949115481.jpg','2018-04-09 20:14:29.493671',42),(80,'goods/images/41_P_1448948980358.jpg','2018-04-09 20:14:29.503799',43),(81,'goods/images/37_P_1448949284365.jpg','2018-04-09 20:14:29.514618',44),(82,'goods/images/42_P_1448948895193.jpg','2018-04-09 20:14:29.528532',45),(83,'goods/images/27_P_1448947771805.jpg','2018-04-09 20:14:29.540874',46),(84,'goods/images/23_P_1448948070348.jpg','2018-04-09 20:14:29.551129',47),(85,'goods/images/26_P_1448947825754.jpg','2018-04-09 20:14:29.561641',48),(86,'goods/images/28_P_1448947699948.jpg','2018-04-09 20:14:29.570119',49),(87,'goods/images/28_P_1448947699777.jpg','2018-04-09 20:14:29.572524',49),(88,'goods/images/24_P_1448948023823.jpg','2018-04-09 20:14:29.583595',50),(89,'goods/images/24_P_1448948023977.jpg','2018-04-09 20:14:29.587099',50),(90,'goods/images/25_P_1448947875346.jpg','2018-04-09 20:14:29.602047',51),(91,'goods/images/29_P_1448947631994.jpg','2018-04-09 20:14:29.614285',52);
/*!40000 ALTER TABLE `goods_goodsimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_hotsearchwords`
--

DROP TABLE IF EXISTS `goods_hotsearchwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_hotsearchwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(20) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_hotsearchwords`
--

LOCK TABLES `goods_hotsearchwords` WRITE;
/*!40000 ALTER TABLE `goods_hotsearchwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_hotsearchwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_indexad`
--

DROP TABLE IF EXISTS `goods_indexad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_indexad`
--

LOCK TABLES `goods_indexad` WRITE;
/*!40000 ALTER TABLE `goods_indexad` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_indexad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jet_bookmark`
--

DROP TABLE IF EXISTS `jet_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jet_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jet_bookmark`
--

LOCK TABLES `jet_bookmark` WRITE;
/*!40000 ALTER TABLE `jet_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `jet_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jet_pinnedapplication`
--

DROP TABLE IF EXISTS `jet_pinnedapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jet_pinnedapplication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(255) NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `date_add` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jet_pinnedapplication`
--

LOCK TABLES `jet_pinnedapplication` WRITE;
/*!40000 ALTER TABLE `jet_pinnedapplication` DISABLE KEYS */;
/*!40000 ALTER TABLE `jet_pinnedapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_association`
--

DROP TABLE IF EXISTS `social_auth_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_association`
--

LOCK TABLES `social_auth_association` WRITE;
/*!40000 ALTER TABLE `social_auth_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_code`
--

DROP TABLE IF EXISTS `social_auth_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_code`
--

LOCK TABLES `social_auth_code` WRITE;
/*!40000 ALTER TABLE `social_auth_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_nonce`
--

DROP TABLE IF EXISTS `social_auth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_nonce`
--

LOCK TABLES `social_auth_nonce` WRITE;
/*!40000 ALTER TABLE `social_auth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_partial`
--

DROP TABLE IF EXISTS `social_auth_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_partial`
--

LOCK TABLES `social_auth_partial` WRITE;
/*!40000 ALTER TABLE `social_auth_partial` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_partial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_usersocialauth`
--

DROP TABLE IF EXISTS `social_auth_usersocialauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_usersocialauth`
--

LOCK TABLES `social_auth_usersocialauth` WRITE;
/*!40000 ALTER TABLE `social_auth_usersocialauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_usersocialauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trade_ordergoods`
--

DROP TABLE IF EXISTS `trade_ordergoods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trade_ordergoods`
--

LOCK TABLES `trade_ordergoods` WRITE;
/*!40000 ALTER TABLE `trade_ordergoods` DISABLE KEYS */;
/*!40000 ALTER TABLE `trade_ordergoods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trade_orderinfo`
--

DROP TABLE IF EXISTS `trade_orderinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trade_orderinfo`
--

LOCK TABLES `trade_orderinfo` WRITE;
/*!40000 ALTER TABLE `trade_orderinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `trade_orderinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trade_shoppingcart`
--

DROP TABLE IF EXISTS `trade_shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trade_shoppingcart`
--

LOCK TABLES `trade_shoppingcart` WRITE;
/*!40000 ALTER TABLE `trade_shoppingcart` DISABLE KEYS */;
INSERT INTO `trade_shoppingcart` VALUES (1,1,'2018-04-25 12:01:31.653028','0',52,1);
/*!40000 ALTER TABLE `trade_shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_membership`
--

DROP TABLE IF EXISTS `user_operation_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_membership`
--

LOCK TABLES `user_operation_membership` WRITE;
/*!40000 ALTER TABLE `user_operation_membership` DISABLE KEYS */;
INSERT INTO `user_operation_membership` VALUES (1,'普通',0,0,0,'white','user/decorate/订单状态.png','user/banner/购物车view--serializer过程.png',0,0,0,0);
/*!40000 ALTER TABLE `user_operation_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_useraddress`
--

DROP TABLE IF EXISTS `user_operation_useraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_useraddress`
--

LOCK TABLES `user_operation_useraddress` WRITE;
/*!40000 ALTER TABLE `user_operation_useraddress` DISABLE KEYS */;
INSERT INTO `user_operation_useraddress` VALUES (12,'3333333333','3','3','3','3','13925848593','2018-04-18 19:37:21.251338',1,'1'),(13,'1','1','1','1','1','13925848599','2018-04-18 19:38:21.447546',1,'0'),(14,'31','13','31','13','31','13925848591','2018-04-18 19:39:10.161205',1,'0');
/*!40000 ALTER TABLE `user_operation_useraddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_userfav`
--

DROP TABLE IF EXISTS `user_operation_userfav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_userfav`
--

LOCK TABLES `user_operation_userfav` WRITE;
/*!40000 ALTER TABLE `user_operation_userfav` DISABLE KEYS */;
INSERT INTO `user_operation_userfav` VALUES (1,'2018-04-18 16:27:41.823154',1,4),(2,'2018-04-18 19:09:11.443431',1,1);
/*!40000 ALTER TABLE `user_operation_userfav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_userleavingmessage`
--

DROP TABLE IF EXISTS `user_operation_userleavingmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_userleavingmessage`
--

LOCK TABLES `user_operation_userleavingmessage` WRITE;
/*!40000 ALTER TABLE `user_operation_userleavingmessage` DISABLE KEYS */;
INSERT INTO `user_operation_userleavingmessage` VALUES (1,5,'pro','pro','message/images/会员积分等级设计.pdf','2018-04-18 17:04:13.224414',2);
/*!40000 ALTER TABLE `user_operation_userleavingmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_usermembershipinfo`
--

DROP TABLE IF EXISTS `user_operation_usermembershipinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_usermembershipinfo`
--

LOCK TABLES `user_operation_usermembershipinfo` WRITE;
/*!40000 ALTER TABLE `user_operation_usermembershipinfo` DISABLE KEYS */;
INSERT INTO `user_operation_usermembershipinfo` VALUES (4,0,0,56,1,1,0,'2018-04-26 10:35:51.811403',4),(7,0,0,6,1,2,0,'2018-04-19 11:15:28.163744',0);
/*!40000 ALTER TABLE `user_operation_usermembershipinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
INSERT INTO `users_userprofile` VALUES (1,'pbkdf2_sha256$100000$as15N3Fv793u$vl9hVZgZFPYHk3uwVwKvKtCMrhFuOQXYpfbHjqOLXDU=','2018-04-26 10:09:26.858351',1,'admin','','',1,1,'2018-04-09 20:12:48.423408',NULL,NULL,'female',NULL,'admin@qq.com',''),(2,'pbkdf2_sha256$100000$gmTrMcCUxzzq$J4Zi1jANs0bmUNr4qN7YNJr95J6gW2KVdbm7YnTh9gM=','2018-04-19 10:48:32.050979',0,'13925848599','','',0,1,'2018-04-17 15:04:35.459427','',NULL,'male','13925848599','',''),(3,'pbkdf2_sha256$100000$QeF6sMHkgRkR$VTztVyJqEibRHHfIG3Qff9QNgRSSEAuUvda03URRG2U=','2018-04-18 10:16:32.124556',0,'13925848590','','',0,1,'2018-04-18 10:16:08.569717',NULL,NULL,'female','13925848590',NULL,''),(4,'pbkdf2_sha256$100000$Yz3NCNBxIaej$y+qSUrGyi+bReBuaVbErgLTbRumnI5pJzg6i43OtLHY=','2018-04-18 10:34:36.820559',0,'13925848591','','',0,1,'2018-04-18 10:33:56.356067',NULL,NULL,'female','13925848591',NULL,'');
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_groups`
--

DROP TABLE IF EXISTS `users_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_groups`
--

LOCK TABLES `users_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `users_userprofile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `users_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_user_permissions`
--

LOCK TABLES `users_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_verifycode`
--

DROP TABLE IF EXISTS `users_verifycode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_verifycode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_verifycode`
--

LOCK TABLES `users_verifycode` WRITE;
/*!40000 ALTER TABLE `users_verifycode` DISABLE KEYS */;
INSERT INTO `users_verifycode` VALUES (1,'1234','13925848599','2018-04-19 10:46:00.000000');
/*!40000 ALTER TABLE `users_verifycode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-05 10:53:51
