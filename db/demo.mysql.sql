-- MySQL dump 10.15  Distrib 10.0.25-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	10.0.25-MariaDB

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
-- Table structure for table `call_comments`
--

DROP TABLE IF EXISTS `call_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_comments` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `callid` int(4) NOT NULL DEFAULT '0',
  `comment` mediumtext,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `date_cr` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_comments`
--

LOCK TABLES `call_comments` WRITE;
/*!40000 ALTER TABLE `call_comments` DISABLE KEYS */;
INSERT INTO `call_comments` VALUES (1,1,'хотела услышать песенку',0,'0000-00-00 00:00:00',3),(2,51,'Все записи удалены. MWA-HA-HA!!!',0,'0000-00-00 00:00:00',3),(3,35,'То, что Саудовская Аравия финансирует ядерную программу Пакистана, секретом не является.',0,'0000-00-00 00:00:00',1),(4,83,'абыр!',0,'2015-08-13 14:06:59',1),(5,1344,'Ошибся номером',0,'0000-00-00 00:00:00',1);
/*!40000 ALTER TABLE `call_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(32) DEFAULT '',
  `parent` varchar(32) DEFAULT '',
  `descr` varchar(128) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `location` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'main','','Main router','10.0.0.1','серверная',0),(2,'1th_floor_router','main','1th floor router','10.0.1.1','1 этаж',0),(3,'2th_floor_router','main','2th_floor_router','10.0.2.1','2 этаж',0),(4,'main_switch','main','Main switch','10.0.0.254','серверная',0),(5,'1th_floor_switch_1','1th_floor_router','1th floor switch 1','10.0.1.2','1 этаж',1),(6,'1th_floor_switch_2','1th_floor_router','1th floor switch 2','10.0.1.3','1 этаж',0),(7,'2th_floor_switch_1','2th_floor_router','2th floor switch 1','10.0.2.2','2 этаж',0),(8,'1th_floor_switch_3','1th_floor_switch_1','1th floor switch 3','10.0.1.4','1 этаж',1);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ed`
--

DROP TABLE IF EXISTS `ed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ed` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `query_id` int(11) DEFAULT '1',
  `name` varchar(128) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `q_select` text,
  `q_update` text,
  `q_insert` text,
  `q_delete` text,
  `q_check` text,
  `var` text,
  `check_form_js` text,
  `form_template` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ed`
--

LOCK TABLES `ed` WRITE;
/*!40000 ALTER TABLE `ed` DISABLE KEYS */;
INSERT INTO `ed` VALUES (1,14,'Карта_клиента',0,'select\n users.id,\n users.contract,\n users.name,\n users.address,\n users.info,\n users.passport,\n users.phone,\n users.phones,\n users.status,\n users.date_birth,\n user_details.place_birth,\n users.date_con,\n users.deseases,\n users.blood\nfrom users, user_details\nwhere\n users.id=user_details.uid\n and users.id=$ID','update users, user_details set\n users.contract=$users.contract$,\n users.name=$users.name$,\n users.address=$users.address$,\n users.info=$users.info$,\n users.passport=$users.passport$,\n users.phone=$users.phone$,\n users.phones=$users.phones$,\n users.status=$users.status$,\n users.date_birth=$users.date_birth$,\n user_details.place_birth=$user_details.place_birth$,\n users.date_con=$users.date_con$,\n users.deseases=$users.deseases$,\n users.blood=$users.blood$\nwhere\n users.id=user_details.uid\n and users.id=$ID','insert into users(\n contract,name, address, info, passport,\n phone, phones, status, date_birth, date_con,\n deseases,blood\n)\nvalues(\n $users.contract$, $users.name$, $users.address$, $users.info$,\n $users.passport$, $users.phone$, $users.phones$, $users.status$,\n $users.date_birth$, $users.date_con$,\n $users.deseases$, $users.blood$\n);\n\ninsert into user_details(uid,place_birth)\nvalues($INSERTID0, $user_details.place_birth$)',NULL,NULL,'\"zone\":{\n  \"12\":1, \"13\":1\n},\n\"value_style\":{\n  \"1\":\"color:blue;font-weight:bold\",\n  \"2\":\"color:brown\"\n},\n\"subquery\":1,\n\"placeholder_ed\":{\n    \"users.phone\":\"+X (XXX) XXX XXXX\"\n}','','$0$\n<tr>\n<td colspan=2><a href=\"javascript: if(document.forms[\'ed\'][\'users.status\'].value==1){vis(\'z1\');}else{vis(\'z2\');}\" title=\'показать\'>Дополнительно</a></td>\n</tr>\n<tr id=\'z1\' style=\'display: none\'>\n   <td colspan=2>\n	<table border=0 cellspacing=1 cellpadding=1>\n	  $1(<tr><th align=right>#NAME </th><td>#VALUE</td></tr>)$\n	</table>\n   </td>\n</tr>\n<tr id=\'z2\' style=\'display: none\'>\n   <td colspan=2>\n       Это уже никому не интересно\n   </td>\n</tr>'),(2,28,'Сети обменников',0,'select\n networks.id,\n inet_ntoa(networks.ip) as ip,\n networks.mask,\n networks.description,\n networks.dc_id,\n networks.status\nfrom networks\nwhere networks.id=\'$ID\'','update networks set\n ip=inet_aton($inet_ntoa(networks.ip)$),\n mask=$networks.mask$,\n description=$networks.description$,\n dc_id=$networks.dc_id$,\n status=$networks.status$\nwhere id=$networks.id$	\n','insert into networks(ip,mask,description,dc_id,status) values(inet_aton($inet_ntoa(networks.ip)$), $networks.mask$, $networks.description$, $networks.dc_id$, $networks.status$)',NULL,NULL,'INSERTIF:networks.id=0',NULL,NULL),(3,27,'Интерфейсы',0,'select\n interfaces.id,\n inet_ntoa(interfaces.ip),\n interfaces.serverid,\n interfaces.description,\n interfaces.dc_id,\n interfaces.type,\n interfaces.loading,\n interfaces.bandwidth,\n interfaces.cost,\n interfaces.url,\n interfaces.status\nfrom interfaces\nwhere interfaces.id=\'$ID\'','update interfaces set\n ip=inet_aton($inet_ntoa(interfaces.ip)$),\n serverid=$interfaces.serverid$,\n description=$interfaces.description$,\n dc_id=$interfaces.dc_id$,\n status=$interfaces.status$,\n type=$interfaces.type$,\n url=$interfaces.url$,\n loading=$interfaces.loading$,\n bandwidth=$interfaces.bandwidth$,\n cost=$interfaces.cost$\nwhere id=$interfaces.id$	\n','insert into interfaces(\n  ip,serverid,description,\n  dc_id,type,loading,bandwidth,\n  cost,url,status\n)\nvalues(\n  inet_aton($inet_ntoa(interfaces.ip)$),\n  $interfaces.serverid$,\n  $interfaces.description$,\n  $interfaces.dc_id$,\n  $interfaces.type$,\n  $interfaces.loading$,\n  $interfaces.bandwidth$,\n  $interfaces.cost$, $intefaces.url$,\n  $interfaces.status$\n)',NULL,NULL,'INSERTIF:interfaces.id=0','',''),(5,6,'Юзеры',0,'select\n moderators.id,\n moderators.uid,\n moderators.login,\n char(null),\n moderators.ip,\n moderators.datel,\n moderators.status,\n moderators.member,\n moderators.moder,\n moderators.fio,\n moderators.gr\nfrom moderators\nwhere moderators.id=$ID','update moderators set\n  uid=$moderators.uid$,\n  login=$moderators.login$,\n  moderators.password=IF($char(null)$>\'\',md5($char(null)$),moderators.password),\n  ip=$moderators.ip$,\n  status=$moderators.status$,\n  member=$moderators.member$,\n  moder=$moderators.moder$,\n  fio=$moderators.fio$,\n  gr=$moderators.gr$\nwhere id=$moderators.id$	\n','insert into moderators\n(uid,login,password,status,member,moder,fio,gr)\nvalues(\n  $moderators.uid$, $moderators.login$,\n  md5($char(null)$), $moderators.status$,\n  $moderators.member$, $moderators.moder$,\n  $moderators.fio$, $moderators.gr$\n)',NULL,NULL,'\"INSERTIF\":\"moderators.id=0\",\n\"debug\":0','','');
/*!40000 ALTER TABLE `ed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ed_subquery`
--

DROP TABLE IF EXISTS `ed_subquery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ed_subquery` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `query_id` int(4) NOT NULL DEFAULT '1',
  `name` varchar(128) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `query` text,
  `query_s` text,
  `q_update` text,
  `q_insert` text,
  `q_delete` varchar(255) DEFAULT '',
  `q_check` text,
  `select_fields` varchar(255) DEFAULT '',
  `position` tinyint(4) NOT NULL DEFAULT '0',
  `link` varchar(255) DEFAULT NULL,
  `link_show` text,
  `link_delete` varchar(255) DEFAULT '',
  `rownames` varchar(255) DEFAULT NULL,
  `var` text,
  `editor` varchar(64) DEFAULT 'subed',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ed_subquery`
--

LOCK TABLES `ed_subquery` WRITE;
/*!40000 ALTER TABLE `ed_subquery` DISABLE KEYS */;
INSERT INTO `ed_subquery` VALUES (1,14,'<i>Доверенные лица</i>',1,'select\n user_friends.id,\n user_friends.name as ФИО,\n user_friends.phone as телефон\nfrom  user_friends\nwhere\n uid=$ID','','update  user_friends set\n user_friends.name=$user_friends.name$,\n user_friends.phone=$user_friends.phone$\nwhere\n  user_friends.id=$user_friends.id$','insert into  user_friends(name, phone, uid)\nvalues($user_friends.name$, $user_friends.phone$, \'$ID\')','IF_NULL($user_friends.name$)\ndelete from user_friends\nwhere  user_friends.id=$user_friends.id$','select concat(\"this number belongs to \", user_friends.name)\nfrom user_friends\nwhere\n user_friends.phone = $user_friends.phone$\nand user_friends.id != $user_friends.id$','',13,'<a href=\"javascript:sed(1,$QID,$ID,\'subed\',$RID)\" title=\'Редактировать\'><img src=\'/img/ico/pencil.png\' style=\'width:16px;margin-top:0;\' border=0 align=right></a>','<img src=\'/img/ico/toggle-small.png\' style=\'margin-top:0;\' border=0 title=\'Hide\' onclick=\"slook(1,$QID,$ID,\'subed\', 99999, this,\'/img/ico/toggle-small-expand.png\',\'/img/ico/toggle-small.png\')\" align=left>\n<a href=\"javascript:sed(1,$QID,$ID,\'subed\',0)\" title=\'Добавить\'><img src=\'/img/ico/pencil--plus.png\' style=\'width: 16;margin-top:0;\' border=0 align=right></a>','','ФИО,телефон','','Subed'),(2,14,'<i>Комментарии</i>',2,'select\n user_comments.id,\n user_comments.date_cr as время,\n user_comments.comment as текст,\n moderators.fio as автор\nfrom  user_comments, moderators\nwhere\n user_comments.author=moderators.id and\n user_comments.uid=$ID','select\n  user_comments.id,\n  user_comments.date_cr as время,\n  user_comments.comment as текст,\n  user_comments.author as автор\n from  user_comments\n where  user_comments.uid=$ID','update  user_comments set\n user_comments.date_cr=$user_comments.date_cr$,\n user_comments.comment=$user_comments.comment$,\n user_comments.author=$user_comments.author$\nwhere\n  user_comments.id=$user_comments.id$','insert into  user_comments(date_cr,comment,author, uid)\nvalues(NOW(), $user_comments.comment$, \'$MODERID\', \'$ID\')','IF_NULL($user_comments.comment$)\ndelete from user_comments\nwhere  user_comments.id=$user_comments.id$',NULL,'user_comments.author,moderators,moderators.fio,id',13,'<a href=\"javascript:sed(2,$QID,$ID,\'subed\',$RID)\" title=\'Редактировать\'><img src=\'/img/ico/pencil.png\' style=width: 16;margin-top:0;\' border=0 align=right></a>','<img src=\'/img/ico/toggle-small-expand.png\' style=\'margin-top:0;\' border=0 title=\'Show\' onclick=\"slook(2,$QID,$ID,\'subed\', 99999, this,\'/img/ico/toggle-small-expand.png\',\'/img/ico/toggle-small.png\')\" align=left>\n<a href=\"javascript:sed(2,$QID,$ID,\'subed\',0)\" title=\'Добавить\'><img src=\'/img/ico/pencil--plus.png\' style=width: 16;margin-top:0;\' border=0 align=right></a>','','','\"textarea\":{ \"2\":{} },\n\"text\":{ \"1\":1, \"3\":1 },\n\"select_fields\":{\n    \"user_comments.author\":{\n        \"table\":\"moderators\",\n        \"col_value\":\"moderators.fio\",\n        \"col_id\":\"id\"\n    }\n}','Subed');
/*!40000 ALTER TABLE `ed_subquery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qid` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rec_id` int(10) unsigned NOT NULL DEFAULT '0',
  `record` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (26,25,1,'2016-09-18 14:30:13',3,'body{@@ -45,7 +45,7 @@\n <b>gr</b> - Название группы. Разделы одной группы будут графически объединены в главном меню.\n \n \n-<b>var</b> - Поле для задания прочих переменных. Формат: JSON\n+<b>var</b> - Поле для задания прочих переменных. Формат: JSON.\n Сейчас обрабатываются следующие переменные:\n \n <code>select_fields</code> - Поля, которые нужно представить в виде выпадающего списка.\n}; ');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_levels`
--

DROP TABLE IF EXISTS `member_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_levels` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `descr` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_levels`
--

LOCK TABLES `member_levels` WRITE;
/*!40000 ALTER TABLE `member_levels` DISABLE KEYS */;
INSERT INTO `member_levels` VALUES (1,'ничего'),(2,'только свои'),(3,'своей группы'),(4,'своей группы и неопр.'),(5,'все');
/*!40000 ALTER TABLE `member_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moder_levels`
--

DROP TABLE IF EXISTS `moder_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moder_levels` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `descr` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moder_levels`
--

LOCK TABLES `moder_levels` WRITE;
/*!40000 ALTER TABLE `moder_levels` DISABLE KEYS */;
INSERT INTO `moder_levels` VALUES (1,'ничего'),(2,'r'),(3,'r/w'),(99,'мегаадмин');
/*!40000 ALTER TABLE `moder_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderators`
--

DROP TABLE IF EXISTS `moderators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `login` varchar(20) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `sid` varchar(14) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `datel` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `member` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `moder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fio` varchar(100) DEFAULT NULL,
  `gr` tinyint(4) DEFAULT '1',
  `c` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderators`
--

LOCK TABLES `moderators` WRITE;
/*!40000 ALTER TABLE `moderators` DISABLE KEYS */;
INSERT INTO `moderators` VALUES (1,401,'admin','79a073387cb7fab6d52e57a1d35278ca','11V4yHoclVcIk','','2016-08-05 12:15:13',0,5,99,'Админ',1,0),(2,402,'brujo','7e067a4a98b7e157f6840e862eca65ce','11jcQ.GuMD.QM','89.223.103.12','2013-06-04 14:13:35',0,5,3,'El Brujo',1,0),(3,404,'observer','89cdc6f1a840e5ba2b504ed3f70c6d91','11GdmYJ9fk3hs','89.223.103.12','2016-03-09 16:46:35',0,5,2,'Смотритель',1,0),(4,403,'alex','8aaca574f3f329b0b9ed85dd73833a60','11MEdJFAeF9t2','','2014-02-19 21:55:16',0,5,3,'Пушкин Александр Сергеевич',1,0);
/*!40000 ALTER TABLE `moderators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_groups`
--

DROP TABLE IF EXISTS `query_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_groups` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `order_id` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tail` text,
  `users` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_groups`
--

LOCK TABLES `query_groups` WRITE;
/*!40000 ALTER TABLE `query_groups` DISABLE KEYS */;
INSERT INTO `query_groups` VALUES (1,'Статистика',10,0,'',''),(2,'Биллинг',20,0,NULL,NULL),(3,'Админка',30,0,NULL,NULL),(4,'Клиенты',40,0,NULL,NULL),(5,'<a href=/?gr=5>Urfin</a>, the Asterisk Commander',50,0,'<hr>\n<img src=\'/img/ico/arrow-180-small.png\'><a href=\"javascript:xed(\'ud\',\'astsync\',\'s=users\')\" title=\'Применить\'><img src=\'/img/ico/user-nude-female.png\'> Перенести SIP-аккаунты из БД в конфиг</a><br>\n<img src=\'/img/ico/arrow-180-small.png\'><a href=\"javascript:xed(\'ud\',\'astsync\',\'s=contexts\')\" title=\'Применить\'><img src=\'/img/ico/cards.png\'> Перенести контексты из БД в конфиг</a><br>\n<img src=\'/img/ico/arrow-180-small.png\'><a href=\"javascript:xed(\'ud\',\'astsync\',\'s=queues\')\" title=\'Применить\'><img src=\'/img/ico/stairs.png\'> Перенести очереди из БД в конфиг</a><br><br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=reload\')\" title=\'Reload\'><img src=\'/img/ico/arrow-circle.png\'> Перезагрузить конфиги и показать \"sip show peers\"</a>\n<br><br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=channels\',1)\" title=\'Channels\'><img src=\'/img/ico/application-terminal.png\'> CLI \"core show channels\"</a>\n<br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=peers\',1)\" title=\'SIP peers\'><img src=\'/img/ico/application-terminal.png\'> CLI \"sip show peers\"</a>\n<br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=inuse\',1)\" title=\'Inuse\'><img src=\'/img/ico/application-terminal.png\'> CLI \"sip show inuse\"</a>\n<br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=log\',1)\" title=\'Log\'><img src=\'/img/ico/application-terminal.png\'> grep full logfile</a>\n<br><br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=extensions\')\" title=\'extensions.conf\'><img src=\'/img/ico/blue-document-attribute-e.png\'> Показать extensions.conf</a>\n    \n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=sip\')\" title=\'sip.conf\'><img src=\'/img/ico/blue-document-attribute-s.png\'> Показать sip.conf</a>\n<br>\n<br>\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=record\')\" title=\'Record\'><img src=\'/img/ico/cassette.png\'> Звукозапись</a><br>','{99}'),(6,'Другое',60,0,NULL,NULL),(7,'Мощный DNS',70,0,'','(1)(4)');
/*!40000 ALTER TABLE `query_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_help`
--

DROP TABLE IF EXISTS `query_help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_help` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `chapter` int(4) DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `head` varchar(128) DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_help`
--

LOCK TABLES `query_help` WRITE;
/*!40000 ALTER TABLE `query_help` DISABLE KEYS */;
INSERT INTO `query_help` VALUES (1,11,1,'Журнал изменений','Здесь можно отфильтровать изменения, сделанные в настоящем редакторе.\n\nДля того, чтобы эти изменения фиксировались, необходимо установить поле <b>log=1</b> для соответствующего раздела в таблице \"Запросы\".'),(2,1000,1,'Инструкция оператора','<li>1. <b>Общие сведения.</b></li>\n\nСистема представляет собой настраиваемый веб-интерфейс к данным, хранящимися в БД.\n\nНастройки (данные о разделах) хранятся в специальной таблице. А именно: имя раздела, группа, имя редактора и информация для него, SQL-запрос и т.д.\n\nПервоначально выдается список активных разделов, после выбора любого из них выводится таблица с данными, вызванными SQL-запросом данного раздела. Поля в заголовке позволяют осуществлять последующую фильтрацию и сортировку данных.\n\nЕсли в свойствах раздела указаны соответствующие параметры, возможно редактирование данных и добавление новых записей.\n\nДля редактируемых разделов можно включить журналирование (все изменения данных фиксируются в специальную таблицу).\n\n\n<li>2. <b>Поиск нужных записей.</b></li>\n\nДля фильтрации используются поля в заголовке таблицы.\nПо умолчанию введенный в поля фильтрации текст представляется в запросе так: <code>like \'%[text]%\'</code> - то есть текст может находиться в любом месте.\nЕсли подразумевается, что текст находится в начале или в конце строки, нужно добавить <code>\'%\'</code> соответственно после или перед введенного текста.\nДля задания точного соответствия надо добавить <code>\'=\'</code> перед текстом.\nТакже можно задавать условия:\n\"больше\" или \"меньше\" - <code>\'>\', \'<\'</code>,\n\"не равно\" -  <code>\'!=\'</code>,\n\"не содержит подстроку\" -  <code>\'!~\'</code> (интерпретируется как <code>not like \'%[text]%\'</code>).\nЧтобы указать диапазон, нужно использовать символ <code>\',\'</code> - фильтр вида \'a,b\' обрабатывается как \'a>=value=>b\'.\nЕсли необходимо задать несколько условий фильтрации по одной колонке (и/или), надо использовать разделители <code>\'&&\' или \'||\'</code>.\nПример: <code>\"!~dog&&!~cat\"</code> интерпретируется как <code>\"(COLNAME not like \'%dog%\' and COLNAME not like \'%cat%\'\")</code>\n\nДля сортировки нужно нанести щелчок мышью в заголовок колонки:\nодиночный - фон пожелтеет - сортировка по возрастанию,\nдвойной - фон позеленеет - сортировка по убыванию.\n\nПосле указания правил фильтрации и сортировки нужно отправить форму, нажав кнопку \"Запрос\" или клавишу \"Enter\"\n\nКлик мыши в выбранную строку открывает соответвующую ей запись для редактирования.\n\n\n<li>3. <b>Редактирование записей.</b></li>\n\nВыбор записи для редактирования производится:\n1) щелчком мыши;\n2) комбинацией клавиш <code>ctrl + arrow_up(стрелка вверх)</code> или <code>ctrl + arrow_down(стрелка вниз)</code>\n3) комбинацией клавиш <code>ctrl + [1 - 9]</code> - в этом случае откроется форма редактирования текущей (подсвеченной желтым) или первой строки. Фокус будет помещен в поле с соответствующим номером. При последующих вызовах редактора фокус будет находиться в поле с тем же номером.\n\nЕсли в разделе разрешено добавление новых данных, можно выбрать опцию \"новая запись\".\n\nНажатие кнопки \"Записать\" или клавиши \"Enter\" сохраняет данные.\nФорма редактора закрывается, а измененные/добавленные данные отображаются в таблице.\nКлавиша \"Esc\" закрывает форму редактирования.'),(4,2005,1,'Урфин, начальник Астериска','Предназначен для удобства и автоматизации конфигурирования Asterisk.\n\nВ отличие от, например, FreePBX, Урфин требует понимания логики и синтаксиса файлов конфигурации Asterisk.\n\nВсе данные хранятся и редактируются в БД MySQL, после соответствующих команд они переносятся во вложенные файлы конфигурации (с постфиксом _urfin.conf). При этом, в случае появления изменений, автоматически создается бекап старого файла.\n\nПри нажатии \"Перезагрузить конфиги и показать \"sip show peers\" \" через AMI посылаются команды \"reload\" и \"sip show peers\", результат будет выведен.\n\nВ базовую конфигурацию включены различные макросы и типовые настройки, готовые и рекомендуемые к применению.'),(3,1001,1,'Инструкция администратора','<li><b>Значения полей таблицы запросов.</b></li>\n<b>id</b> - Идентификатор запроса (autoindex);\n<b>name</b> - Название.\n<b>active</b> - Активность.\nВозможные значения:\n0 - не активен\n1 - активен\n2 - активен + в заголовке добавляется ссылка \"Файл\", позволяющая скачать результат запроса в формате .csv.\n<b>qdb</b> - SQL-запрос.\nПоскольку запрос будет модифицироваться при указании последующей фильтрации или сортировки, существуют следующие ограничения:\n- поля следует разделять \",\"+пробел или \",\"+перенос,\n- если среди полей имеются функции, их парамеры следует разделять только запятой, без пробела,\n- нельзя делать перенос строки после \"order by\".\n\n<b>f_lenghts</b> - Длины полей ввода фильтров в абсолютных величинах. По умолчанию, или если=0, длины принимаются как length=\"98%\".\n<b>editor</b> - Редактор.\nФормат: {id-ключевое поле},{имя файла-редактора},{имя таблицы}\nПример: <code>id,Aed,db.payments</code>\n\n<b>colnames</b> - Список имен полей, отображаемый в редакторе (разделитель - \",\"). Если не заполнить, будут отображаться имена полей таблицы.\n\n<b>a_update</b> - Доступ на изменения.\nВозможные значения:\n0 - нельзя никому\n1 - можно всем\n2 - можно только членам и модераторам\n3 - можно только модераторам\n<b>a_insert</b> - Доступ на добавление новых записей.\nВозможные значения:\n0 - нельзя никому\n1 - можно всем\n2 - можно только членам и модераторам\n3 - можно только модераторам \n<b>focus</b> - Номер поля, в которое следует помещасть фокус при вызове редактора.\nВозможные значения:\n[1-126] - номер поля\n127 - не отображать форму последующей фильтрации\n<b>order_id</b> - Число, определяющее порядок сортировки разделов в главном меню.\n<b>log</b> - Журнал изменений: 0 - не вести , 1 - вести.\n<b>host</b> - DSN из конфига, если не указан - base,\n<b>sum</b> - Номера колонок, по которым нужно произвести суммирование.\n<b>users</b> - id пользователей, которым будет доступен данный раздел.\nПример: <code>(3)(8)(11)</code> - Раздел будут видеть только пользователи с указанными id.\nЕсли не указывать, раздел доступен всем.\n<b>gr</b> - Название группы. Разделы одной группы будут графически объединены в главном меню.\n\n\n<b>var</b> - Поле для задания прочих переменных. Формат: JSON.\nСейчас обрабатываются следующие переменные:\n\n<code>select_fields</code> - Поля, которые нужно представить в виде выпадающего списка.\nЭто хеш, ключами которого являются иена этих полей (или их порядклвый номер). Внутри задаются таблица, из которой берется список, ключевое поле и поле значения.\nПример:\n<pre>\"select_fields\":{\n  \"moderators.moder\":{\n    \"table\":\"moder_levels\",\n    \"col_id\":\"id\",\n    \"col_value\":\"descr\"\n  }\n}</pre>\n\n<code>textarea</code> - имя или № поля в редакторе, которое следует представлять как textarea. Формат тот же, что и в примере выше.\nМожно привязать редактор с подсветкой синтаксиса Ace.\nПример:\n<pre>\"textarea\":{\n  \"qdb\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"var\":{\n      \"ace\":{\"mode\":\"javascript\", \"height\":460}\n   }\n}</pre>\n\n<code>grcol</code> - № колонки, по значению которой делать группировку выделением фона\nПример:\n<pre>\"grcol\":{\"column\":1,\"color\":\"#dfdfdf\"}</pre>\n\n<code>qdb</code> - вывести в конце страницы SQL-запрос, возможные значения: 0/1\n<code>* link</code> - добавить в первую ячейку каждой строки ссылку. Чтобы включить в ссылку значения любой колонки, нужно использовать запись \'$N\', где N - номер колонки\n\n<code>* ltitle</code> - всплывающая подсказка для этой ссылки\nПример: <code>link:?a=2&id=107&limit=999&c1=$2,ltitle:IP адреса сети</code>\n<i>Чтобы дать ссылку на внешний хост, надо начать URL так: \'http-//\', ибо \':\' у нас разделитель.</i>\n\n\n  <code>date</code> - Поле в редакторе, в которое следует включать js-календарь\n\n  <code>checkbox</code> - Поле в редакторе, которое следует представлять как checkbox\nПример:\n<pre>\"checkbox\":{\n \"c_nat\":[\"yes\",\"no\"],\n \"11\":[1,0]\n}</pre>\n\n  <code>limit</code> - Лимит\n\n  <code>* postscript</code> - Скрипт для постобработки. Добавится кнопка \"Обработать\", которая будет кидать методом POST полученный фильтр-запрос на этот скрипт. Доступно только админам.\n\n  <code>* s</code> - замена подстроки в поле заданной колонки\nПример: <code>s:0=-TO\\:</code> - заменяет все \"-\" на \":\" в поле 0-й колонки\n\n  <code>autoopen_ed</code> - автоматически запускать редактор в случае, если отфильтровалась одна запись\n\n  <code>width</code> - ширина редактора в px.\n\n  <code>iwidth</code> - дефолтная ширина полей ввода (параметр size)\n\n  <code>hideradio</code> - скрыть радиокнопки переписать/новая запись\n\n  <code>ed_bgcolor</code> - цвет фона редактора\n\n  <code>text</code> - отобразить поле с данным номером как текст.\nПример: <code>text:6-11-18</code>\n\n  <code>placeholder</code> - задать плейсхолдер в данном поле/полях фильтра\n  <code>placeholder_ed</code> - задать плейсхолдер в данном поле/полях ввода редактора\nПример:\n<pre>\"placeholder_ed\":{\n    \"users.phone\":\"+X (XXX) XXX XXXX\"\n}</pre>\n\n  <code>unlock_ed</code> - если задать, при запуске редактора его базовый слой будет в плавающем режиме (таракан с лапками) - т.е. его сразу можно таскать и прокручивать.\n\n  <code>key2val</code> - включить подстановку id значением из таблицы для данного поля.\nПример:\n<pre>\"key2val\":{\n  \"2\":{\n     \"table\":\"asterisk.operators\",\n     \"col_id\":\"uid\",\n     \"col_value\":\"name\"\n     }\n}</pre>\nПри этом соответствующее поле фильтрации будет заменено на выпадающее меню.\n\n<code>logtable</code> - если указать, логи изменений будут писаться не в таблицу log, а сюда.\n\n<code>subeditor</code> - только для расширенного редактора - включить использование подредакторов.\n\n\n<li><b>Деревья</b></li>\nДобавлена возможность выводить результат запроса в виде дерева.\nДля этого необходимо следующее:\n1) Запрос должен возвращать следующие поля:\nid, kid, parent, [kidname], info1,..,infoN\n2) Следует включить следующие значения в хеше <b>tree</b>:\n<b>root</b> - Идентификатор корневой записи;\n<b>kid</b> - Номер колонки идентификаторов деток; <code>(Нумерация колонок начинается с 0)</code>\n<b>parent</b> - Номер колонки идентификаторов родителей;\n<b>kidname</b> - Номер колонки имен деток;\n<b>kidinfo</b> - Номер колонки, начиная с которого значение всех колонок будет выведено как доп. информация;\nЕсли поля <b>kid</b> - <b>kidinfo</b> не указаны, назначаются следующие значения - \nkid:1,parent:2,kidname:1,kidinfo:3.\n<b>icons_dir</b> - каталог с набором иконок внутри /tree/. Сейчас доступны каталоги \"1\", \"2\", \"3\".\nПеременная <code>link</code> также работает, только ссылка добавляется в конец строки с текстом значения <code>ltitle</code>\nПолный пример:\n<pre>\"tree\":{\n  \"root\":\"main\",\n  \"kid\":1,\n  \"parent\":2,\n  \"kidname\":3,\n  \"kidinfo\":4,\n  \"status\":6,\n  \"link\":\"?a=2&id=107&limit=999&c1=$2\",\n  \"ltitle\":\"(Devices)\"\n  \"icons_dir\":2\n}</pre>\n\n\n<li><b>Расширенный редактор</b></li>\n\nЧтобы подключить его, нужно указать в поле <code>editor</code> <b>Aedx</b>.\nДанный редактор может работать с любой структурой данных, имеет встроенный шаблонизатор, позволяющий произвольно настраивать внешний вид формы.\nВключены блекджек, гетеры и JS-валидатор формы.\nТакже есть возможность добавить к главной форме произвольное количество связанных с ней второстепенных (подредакторы).\n\nНастройки редактора задаются в отдельной таблице <b>AED-x</b>.\n\nОписание полей:\n\n<b>q_select</b> - Select - запрос, определяющий, в том числе, имена и порядок полей в форме (все, что между select и from).\nВ запросе нужно использовать встроенную переменную <code>$ID</code> - это переменная id, переданная редактору.\n\n<b>q_update</b> - Update - запрос. В качестве значений следует использовать теги формата <code>${FieldName}$</code>\n  Пример: <code>tblUsers.nContract=$tblUsers.nContract$</code>\n\n<b>q_insert</b> - Insert - запрос, добавление новых записей.\nДопустимо внести несколько запросов, (разделитель - ;).\nКаждый запрос после выполнения сохранит insert_id в переменную <code>$INSERTID{N}</code> (N - номер запроса в этом списке, начинается с 0),\nкаковую можно использовать тут же в последующих запросах.\n\n<b>var</b> - параметры. Формат тот же, что и в queryes.other. На самом деле, параметры из queryes.other будут помещены в тот же хеш, то есть для редактора неважно, куда они будут помещены.\n\nК перечисленным ранее параметрам <b>other</b> добавляются следующие:\n\n <code>subeditor</code> - разрешить добавление подредакторов. Данный параметр следует добавлять в queryes.other.\n <code>value_style</code> - задается CSS-стиль поля с сответствующим порядковым номером.\n  Пример:\n<pre>\"value_style\":{\n  \"1\":\"color:R/G;font-weight:bold\",\n  \"2\":\"color:brown\"\n}</pre>\n  (Здесь R/G  - спец. шаблон, цвета red/green, которые будут назначаться в зависимости от знака значения)\n\n <code>zone</code> - привязка полей к зонам шаблонизатора. Не перечисленные поля привязываются к 0 зоне.\n Пример:\n <pre>\"zone\":{\n  \"11\":1, \"12\":1, \"13\":1,\n  \"3\":2, \"5\":2\n}</pre>\n\n<b>check_form_js</b> - тело javascript-функции, запускаемой на onsubmit формы.\n Пример: <pre>if(!document.forms.ed[\'tblUsers.nContract\'].value){\n alert(\'Укажите номер договора!\');\n this[\'tblUsers.nContract\'].focus();\n return false;\n}</pre>\n\n <b>form_template</b> - шаблон формы. Поля, сгруппированные по зонам, включаются в шаблон следующими способами:\n1)\n<code><cpan><</cpan>table border=0 cellspacing=1 cellpadding=0>\n	$2$\n<cpan><</cpan>/table>\n</code>\n- в этом случае все поля, входящие в зону 2 будут выведены в формате\n<code><cpan><</cpan>tr><cpan><</cpan>th align=right>#NAME <cpan><</cpan>/th><cpan><</cpan>td>#VALUE<cpan><</cpan>/td><cpan><</cpan>/tr></code>\n\n2)\n<code>$3(#NAME #VALUE)$</code>\n- в этом случае теги ячеек таблицы автоматически подставляться не будут, внутри () вы сами можете определить формат, окружив #NAME и #VALUE\nнужными тегами.\n#VALUE будет выведен внутри <code><cpan><</cpan>input type=text></code>, повлиять на его внешний вид можно, задавая стиль в var.value_style.\n\nМожно <b>form_template</b> не определить вообще. В этом случае будет применен шаблон по умолчанию:\n<code><cpan><</cpan>table border=0 cellspacing=1 cellpadding=0>\n	$0$\n<cpan><</cpan>/table>\n</code>\n\n<li><b>Подредактор</b></li>\n\nПри использовании расширеного редактора можно подключить произвольное кол-во подредакторов.\nНастройки хранятся в таблице <b>SQ-x</b>. В основном, они аналогичны настройкам AED-X.\n\n<b>query_id</b> - ID соответствующй записи в таблице \"Запросы\" - то же, что и в <b>AED-x</b>.\n\n<b>editor</b> - в этом поле можно указать другой редактор для данного подраздела. По умолчанию - \"Subed\".\n\n'),(5,6,1,'Пользователи','Здесь редактируются пользователи, задаются их пароли, уровни доступа и т.д.\n\nПояснения к полям:\n\n<code>UID</code> - идентификатор оператора, он же его внутренний телефонный номер.\nЕсли пользователь будет использовать телефонию, необходимо созать соответствующую запись в таблице <b>Операторы</b> с этим UID.\n\n<code>Записи</code> - доступ к прослушиванию записей разговоров.\n\nОстальное и так понятно.'),(6,29,1,'Операторы','Если пользователь будет использовать телефонию, необходимо созать соответствующую запись с его UID в этой таблице.\n\nДанный уровень абстракции добавлен для возможности оператора работать с разных телефонов (как внутренних, так и внешних). При этом обеспечивается аутентификация оператора, что необходимо для фиксации результатов его работы.\n\nПояснения к полям:\n\n<code>UID</code> - идентификатор оператора, он же его внутренний телефонный номер.\n\n<code>Телефон</code> - номер, на который будет переадресован звонок, пришедший на <b>UID</b>.\nЭтот телефон может быть изменен как здесь, так и самим оператором в ходе регистрации/разрегистрации в системе:\nрегистрация: вызов <b>000XXXXXX</b>, где XXXXXX - пароль оператора.\nразрегистрация: вызов <b>0009</b> с ранее зарегистрированного телефона, поле \"Телефон\" после этого будет очищено.\n\n<code>Пароль</code> - 6-значный числовой пароль. Обязательно должен быть уникален для каждого оператора.\n\nОстальное и так понятно.');
/*!40000 ALTER TABLE `query_help` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queryes`
--

DROP TABLE IF EXISTS `queryes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queryes` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `qdb` text,
  `f_lenghts` varchar(255) DEFAULT '',
  `editor` varchar(48) DEFAULT NULL,
  `colnames` text,
  `a_update` tinyint(3) unsigned DEFAULT '0',
  `a_insert` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `focus` tinyint(1) NOT NULL DEFAULT '1',
  `order_id` int(11) NOT NULL DEFAULT '0',
  `log` tinyint(4) NOT NULL DEFAULT '0',
  `sum` varchar(16) NOT NULL DEFAULT '',
  `users` varchar(32) NOT NULL DEFAULT '',
  `grp` int(11) DEFAULT '1',
  `icon` varchar(32) DEFAULT NULL,
  `dsn` varchar(32) NOT NULL,
  `var` text,
  `tail` varchar(255) DEFAULT NULL,
  `ed_tail` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queryes`
--

LOCK TABLES `queryes` WRITE;
/*!40000 ALTER TABLE `queryes` DISABLE KEYS */;
INSERT INTO `queryes` VALUES (1,'Лог регистрации операторов',1,'select\n from_unixtime(log.dat) as время,\n log.uid, log.uid, events.event ,\n log.number as откуда\nfrom\n asterisk.log, asterisk.events\nwhere\n log.event=events.id\n order by log.id desc','','','',0,0,0,10,0,'','',1,'','','\"key2val\":{\n  \"2\":{\n     \"table\":\"asterisk.operators\",\n     \"col_id\":\"uid\",\n     \"col_value\":\"name\"\n     }\n}','',''),(2,' Почасовая статистика количества звонков',1,'select\n substr(from_unixtime(stime),1,13) as час,\n count(cid) as \'кол-во\'\nfrom asterisk.qhistory where disposition!=7 group by substr(from_unixtime(stime),1,13) order by stime desc','','','',0,0,1,20,0,'2','',1,'','','\"graph\":{\n    \"1\":{}\n},\n\"inactive\":{\n   \"1\":{}\n}','',''),(6,'Юзеры',1,'select\n moderators.id, moderators.uid,\n moderators.login as логин, moderators.fio as ФИО,\n member_levels.descr as \'записи\',\n moder_levels.descr as \'админ\',\n gr as \'группа\'\nfrom\n moderators, member_levels, moder_levels\nwhere\n moderators.member=member_levels.id and\n moderators.moder=moder_levels.id','','id,Aedx,moderators','ID,UID,Логин,Пароль,IP,Посл.вход,Блокирован,Записи,Права,ФИО,Группа',1,1,1,300,1,'','(1),(4)',3,'','','\"select_fields\":{\n  \"moderators.moder\":{\n    \"table\":\"moder_levels\",\n    \"col_id\":\"id\",\n    \"col_value\":\"descr\"\n  },\n  \"moderators.member\":{\n    \"table\":\"member_levels\",\n    \"col_id\":\"id\",\n    \"col_value\":\"descr\"\n  }\n},\n\"checkbox\":{\n  \"moderators.status\":[1,0]\n},\n\"password\":{\n  \"3\":1\n},\n\"help\":1,\n\"grcol\":{\"column\":1,\"color\":\"#dfdfdf\"}','',''),(7,'Звонки',1,'select\n calldate as Время,\n src as Откуда, dst as Куда,\n duration as Длительность,\n billsec as Разговор, disposition as Результат,\n accountcode, IF(amaflags=2,IF(substr(userfield,1,5)=\'audio\', substr(userfield,7), concat(DATE_FORMAT(from_unixtime(substr(uniqueid,1,10)), \"%Y%m%d-%H%i%s\"),\'-\',uniqueid,\'.wav\') ),\'\') as Запись\nfrom asterisk.cdr\n order by calldate desc','','','Время,Откуда,Куда,Длительность,Разговор,Результат,AccountCode,Запись',0,0,1,60,0,'5','',1,'','','\"play\":8','',''),(8,'Запросы',1,'select\n id, name, active, qdb, f_lenghts, editor,\n colnames, a_update, a_insert, focus, order_id,\n log, sum, users, grp, dsn, var\nfrom queryes','','id,Aed,queryes','',3,3,1,304,1,'','(1)(4)',3,'','','\"select_fields\":{\n  \"grp\":{\n     \"table\":\"query_groups\",\n     \"col_value\":\"name\",\n     \"col_id\":\"id\",\n     \"query_postfix\":\"order by id\"\n  }\n},\n\"iwidth\":80,\n\"help\":1001,\n\"textarea\":{\n  \"qdb\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"var\":{\n      \"ace\":{\"mode\":\"javascript\", \"height\":460}\n   }\n},\n\"checkbox\":{ \"log\":[1,0] }','',''),(10,'Комментарии к звонкам',1,'select id, callid, comment\nfrom call_comments','','id,Aed,call_comments','id,callid,текст,status,время,автор',1,1,2,401,1,'','(1)',4,'','','\"textarea\":{\n  \"comment\":{}\n},\n\"hide\":{\n  \"3\":{}\n},\n\"hidinput\":{\n  \"1\":{}\n},\n\"text\":{\n  \"4\":{}\n}','',''),(11,'Журнал',1,'select\n  log.id, moderators.login,\n  queryes.name, log.rec_id,\n  log.record, log.date\nfrom moderators, queryes, log\nwhere\n  log.qid=queryes.id and\n  log.uid=moderators.id\norder by log.id desc','','id,Aed,log','',3,3,1,302,1,'','(1)(4)',3,'','','\"focus\":2,\n\"help\":1','',''),(12,'Анкеты',1,'select * from user_details','','id,Aed,user_details','',3,3,1,900,0,'','(1)',4,'','','','',''),(13,'Друзья',1,'select * from user_friends','','id,Aed,user_friends','',3,3,1,901,0,'','(1)',4,'','','','',''),(14,'Клиенты',1,'select\n users.id,\n users.contract as \'№ дог.\',\n users.name as \'ФИО\',\n users.address as \'адрес\',\n users.info as \'информация\',\n users.phone as \'телефон\',\n users.phones as \'другие номера\',\n user_statuses.status as \'статус\',\n users.date_con as \'дата з. дог.\'\nfrom users, user_statuses\nwhere\n users.status=user_statuses.id\norder by users.id','','id,Aedx,users','ID,№ дог.,ФИО,адрес,информация,паспорт,телефон,другие номера,статус,дата рождения,место рождения,дата закл. дог.,заболевания,группа крови',1,1,1,400,1,'','',4,'','','\"select_fields\":{\n    \"users.status\":{\n        \"table\":\"user_statuses\",\n        \"col_value\":\"status\",\n        \"col_id\":\"id\"\n    }\n},\n\"date\":{ \"9\":1, \"11\":1 },\n\"textarea\":{ \"3\":{}, \"5\":{}, \"12\":{} },\n\"grcol\":{\n    \"column\":1,\n    \"color\":\"#efefef\"\n},\n\"ed_bgcolor\":\"#f5f5f5\",\n\"subeditor\":1,\n\"autoopen_ed\":1,\n\"iwidth\":70,\n\"width\":700,\n\"hideradio\":1','','<a href=\"javascript:ud(\'$0\')\"><img src=\'/pic/details.png\'> Анкета</a><br>\n	<a href=\"javascript:ow(\'/calls.html?d=all&cid=$6\',990,900,0,\'Звонки\')\"><img src=\'/pic/phonep.png\'> История вызовов клиента</a>'),(15,'AED-x',1,'select\n id, query_id, name, status,\n q_select, q_update,\n q_insert, var\nfrom ed','','id,Aed,ed','',3,3,1,306,0,'','(1)(4)',3,'','','\"iwidth\":80,\n\"textarea\":{\n  \"q_select\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"q_update\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"q_insert\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"var\":{\n      \"ace\":{\"mode\":\"javascript\", \"height\":460}\n   }\n}','','<a href=\'?a=2&id=16&o=&limit=100&c1=%3D$1\' target=sq>Подзапросы</a>'),(16,'SQ-x',1,'select\n id, query_id, name,\n status, query, query_s,\n q_update, q_insert, q_delete,\n select_fields, position, link,\n rownames, var,editor\nfrom ed_subquery','','id,Aed,ed_subquery','',3,3,1,307,0,'','(1)(4)',3,'','','\"iwidth\":80,\n\"textarea\":{\n  \"query\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"q_update\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"q_insert\":{\n      \"ace\":{\"mode\":\"mysql\", \"height\":460}\n   },\n  \"var\":{\n      \"ace\":{\"mode\":\"javascript\", \"height\":460}\n   }\n}','',''),(17,'Тарифицированные звонки',1,'select\n cdr_u.id, cdr_u.calldate,\n cdr_u.accountcode, cdr_u.src,\n cdr_u.dst, cdr_u.disposition,\n cdr_u.duration, cdr_u.billsec,\n cdr_u.cost, cdr_u.bill, cdr_u.prefix,\n costs.descr\nfrom asterisk.cdr_u, asterisk.costs\n where costs.id=cdr_u.cost_id\norder by cdr_u.id desc','','id,Aed,asterisk.cdr_u','',3,3,1,200,1,'8,10','',2,'','','','',''),(18,'Тарифы',1,'select\n tarifes.id, tarifes.name,\n tarifes.parent, tarifes.mul,\n tarifes.additive, tarifes.free_thr,\n tarifes.rounding\nfrom asterisk.tarifes','','id,Aed,asterisk.tarifes','',3,3,1,201,1,'','',2,'','','','',''),(19,'Тариф/Направление/Шлюз/Цена',1,'select\n id, tarif, country_code,\n prefix, descr, cost, level, gw,\n zone\nfrom asterisk.costs','','id,Aed,asterisk.costs','',3,3,1,202,1,'','',2,'','','','',''),(20,'SIP accounts',1,'select\n id, extension, name as contract,\n description,\n c_callerid as callerid,\n c_context	as context,\n disable as off\nfrom asterisk.users','','id,Aed,asterisk.users','id,extension,name,secret,type,host,nat,callerid,context,deny,permit,canreinvite,allowtransfer,callcounter,recording,dtmfmode,qualify,other <br>parameters,disable,description',3,3,1,500,1,'','(1)(4)',5,'/img/ico/user-nude-female.png','','\"checkbox\":{\n \"c_nat\":[\"yes\",\"no\"],\n \"11\":[\"yes\",\"no\"],\n \"12\":[\"yes\",\"no\"],\n \"13\":[\"yes\",\"no\"],\n \"16\":[\"yes\",\"no\"],\n \"18\":[1,0]\n},\n\"textarea\":{\n  \"permit\":{\n      \"ace\":{\"mode\":\"assembly_x86\", \"height\":30}\n   },\n  \"17\":{}\n},\n\"hide\":{\n \"20\":1,\"21\":1,\"22\":1,\"23\":1\n},\n\"subeditor\":1,\n\"grmenu\":1,\n\"select_fields\":{\n  \"c_amaflags\":{\n     \"table\":\"asterisk.amaflags\",\n     \"col_value\":\"descr\",\n     \"col_id\":\"value\",\n     \"query_postfix\":\"order by descr\"\n  }\n}\n','','<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=users\')\" title=\'Применить\'><img src=\'/img/ico/user-nude-female.png\'> Перенести SIP-аккаунты из БД в конфиг</a><br>\n\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=reload\')\" title=\'Reload\'><img src=\'/img/ico/arrow-circle.png\'> Перезагрузить конфиги и показать \"sip show peers\"</a><br>'),(24,'Привязка номер-аккаунт',1,'select\n id, account, number, active, descr\nfrom asterisk.numbers','','id,Aed,asterisk.numbers','',3,3,1,204,1,'','',2,'','','','',''),(21,'Contexts',1,'select\n id, context, descr, other\nfrom asterisk.contexts','','id,Aed,asterisk.contexts','',3,3,1,501,1,'','',5,'/img/ico/cards.png','','\"textarea\":{\n    \"other\":{\n        \"ace\":{\n            \"mode\":\"julia\",\n            \"height\":460\n          }\n    }\n},\n\"checkbox\":{\n    \"4\":[1,0]\n},\n\"subeditor\":1,\n\"grmenu\":1,\n\"iwidth\":120','','<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=contexts\')\" title=\'Применить\'><img src=\'/img/ico/cards.png\'> Перенести контексты из БД в конфиг</a><br>\n\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=reload\')\" title=\'Reload\'><img src=\'/img/ico/arrow-circle.png\'> Перезагрузить конфиги и показать \"sip show peers\"</a><br>'),(22,'Queues',1,'select\n id, extension, descr, c_strategy as strategy,	\n c_announce as announce,\n c_retry as retry,\n c_servicelevel as servicelevel,\n c_timeout as timeout, c_weight as weight\nfrom asterisk.queues','','id,Aed,asterisk.queues','id,extension,description,strategy,musicclass,announce,announce_frequency,announce_holdtime,announce_position,autofill,joinempty,leavewhenempty,maxlen,monitor_type,monitor_format,periodic_announce_frequency,reportholdtime,retry,ringinuse,servicelevel,timeout,weight,wrapuptime,members,other  <br>parameters,disable',3,3,1,502,1,'','(1)(4)',5,'/img/ico/stairs.png','','\"iwidth\":80,\n\"textarea\":{ \"23\":{},\"24\":{} },\n\"grmenu\":1,\n\"checkbox\":{\n    \"7\":[\"yes\",\"no\"],\n    \"8\":[\"yes\",\"no\"],\n    \"9\":[\"yes\",\"no\"],\n    \"10\":[\"yes\",\"no\"],\n    \"11\":[\"yes\",\"no\"],\n    \"16\":[\"yes\",\"no\"],\n    \"18\":[\"yes\",\"no\"],\n    \"25\":[1,0]\n}','','<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=queues\')\" title=\'Применить\'><img src=\'/img/ico/stairs.png\'> Перенести очереди из БД в конфиг</a><br>\n\n<a href=\"javascript:xed(\'ud\',\'astsync\',\'s=reload\')\" title=\'Reload\'><img src=\'/img/ico/arrow-circle.png\'> Перезагрузить конфиги и показать \"sip show peers\"</a><br>'),(23,'Группы запросов',1,'select id, name, order_id, status, tail\nfrom query_groups','','id,Aed,query_groups','',3,3,1,305,0,'','(1)(4)',3,'','','textarea:4,iwidth:120,ace:tail(html;460)','',''),(25,'Инструкции',1,'select id, chapter, status, head, body\nfrom query_help','','id,Aed,query_help','',3,3,1,309,1,'','(1)(4)',3,'','','\"textarea\":{\n  \"body\":{ \"ace\":{ \"mode\":\"html\", \"height\":640 } }\n},\n\"iwidth\":140','',''),(29,'Операторы',1,'select\n id as ID, uid as UID,\n name as ФИО, cnumber as Телефон,\n active as Активен, gr Группа\nfrom asterisk.operators','','id,Aed,asterisk.operators','ID,UID,Имя,Пароль,Телефон,Активен,Группа',3,3,1,301,1,'','(1)(4)',3,'','','\"pwd\":3,\n\"help\":1','',''),(30,'Дерево',1,'select\n  id,\n  hostname,\n  parent,\n  descr,\n  ip,\n  location,\n  status\nfrom devices\norder by parent\n','','id,Aed,devices','',3,3,1,902,0,'','(1)',6,'','','\"tree\":{\n  \"root\":\"main\",\n  \"kid\":1,\n  \"parent\":2,\n  \"kidname\":3,\n  \"kidinfo\":4,\n  \"status\":6,\n  \"icons_dir\":2\n}\n','','');
/*!40000 ALTER TABLE `queryes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_comments`
--

DROP TABLE IF EXISTS `user_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_comments` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `head` varchar(255) DEFAULT '',
  `comment` mediumtext,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `date_cr` datetime DEFAULT NULL,
  `author` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_comments`
--

LOCK TABLES `user_comments` WRITE;
/*!40000 ALTER TABLE `user_comments` DISABLE KEYS */;
INSERT INTO `user_comments` VALUES (2,2,'','Корова паслась на небольшой возвышенности прямо над домом несчастного бразильца и по непонятной причине упала с холма вниз. Крыша дома была сделала из асбеста и не смогла выдержать удар туши весом в несколько сотен килограммов. В результате хозяин дома был придавлен коровой, получил обширное внутреннее кровоизлияние и скончался. Родные считают, что его можно было бы спасти, если бы врачи прибыли на место трагедии быстрее, передает РИА Новости.\n\nСупруга бразильца, спавшая рядом, не пострадала. Сама корова не получила в результате падения повреждений и сейчас продолжает мирно пастись рядом с домом, хозяина которого она убила. ',0,'2013-07-14 12:10:27',2),(3,1,'','<i>Министр обороны</i> Египта Абдул-Фаттах ас-Сиси объявил о низложении президента Мухаммеда Мурси; исполняющим обязанности президента назначен председатель Высшего конституционного суда  Адли Мансур.',0,'2013-07-09 12:43:27',3),(4,1,'','Секвенирован самый древний, на сегодняшний день, полный геном — лошади, жившей в среднем плейстоцене.',0,'2013-07-09 12:44:38',2),(5,4,'',' Реформа полиции, которую инициировал Дмитрий Медведев во время пребывания на посту президента, не удовлетворила ни экспертов, ни общество, поэтому в ближайшее время может быть запущен механизм «контрреформирования» ведомства.\n\nПо данным «Независимой газеты», в июле должно состояться первое заседание рабочей группы по мониторингу Закона о полиции, в состав которой войдут депутаты Госдумы, а также представители силовых ведомств. На нем будут рассмотрены предложения по совершенствованию закона, поскольку на данный момент уже подготовлено около 100 инициатив. Фактически, пишет издание, речь идет о новой реформе ведомства. ',0,'2013-06-24 02:14:03',3);
/*!40000 ALTER TABLE `user_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_contacts`
--

DROP TABLE IF EXISTS `user_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_contacts` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `descr` varchar(64) DEFAULT '',
  `name` varchar(64) DEFAULT '',
  `phones` varchar(128) DEFAULT '',
  `address` varchar(255) DEFAULT '',
  `email` varchar(64) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `date_cr` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_contacts`
--

LOCK TABLES `user_contacts` WRITE;
/*!40000 ALTER TABLE `user_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `place_birth` varchar(128) DEFAULT '',
  `address_reg` varchar(255) DEFAULT '',
  `dacha` tinyint(4) NOT NULL DEFAULT '0',
  `dacha_address` varchar(255) DEFAULT '',
  `recepient` varchar(128) DEFAULT '',
  `emergency` varchar(255) DEFAULT NULL,
  `height` int(4) NOT NULL DEFAULT '0',
  `weight` int(4) NOT NULL DEFAULT '0',
  `pressure` varchar(24) DEFAULT '',
  `hospital1` varchar(64) DEFAULT '',
  `hospital1_addr` varchar(128) DEFAULT '',
  `hospital1_card` varchar(16) DEFAULT '',
  `hospital1_doctor` varchar(128) DEFAULT '',
  `hospital2` varchar(64) DEFAULT '',
  `hospital2_addr` varchar(128) DEFAULT '',
  `hospital2_card` varchar(16) DEFAULT '',
  `hospital2_doctor` varchar(128) DEFAULT '',
  `heart_d` tinyint(4) NOT NULL DEFAULT '0',
  `vascular_d` tinyint(4) NOT NULL DEFAULT '0',
  `brearth_d` tinyint(4) NOT NULL DEFAULT '0',
  `guts_d` tinyint(4) NOT NULL DEFAULT '0',
  `urologia_d` tinyint(4) NOT NULL DEFAULT '0',
  `aids_d` tinyint(4) NOT NULL DEFAULT '0',
  `infected_d` tinyint(4) NOT NULL DEFAULT '0',
  `psyho_d` tinyint(4) NOT NULL DEFAULT '0',
  `lor_d` tinyint(4) NOT NULL DEFAULT '0',
  `eyes_d` tinyint(4) NOT NULL DEFAULT '0',
  `bones_d` tinyint(4) NOT NULL DEFAULT '0',
  `diabet_d` tinyint(4) NOT NULL DEFAULT '0',
  `cancer_d` tinyint(4) DEFAULT '0',
  `blood_d` tinyint(4) DEFAULT '0',
  `any_deseases_s` tinyint(4) NOT NULL DEFAULT '0',
  `defects_d` tinyint(4) NOT NULL DEFAULT '0',
  `operations_d` tinyint(4) NOT NULL DEFAULT '0',
  `dispanser_d` tinyint(4) NOT NULL DEFAULT '0',
  `drugs_d` tinyint(4) NOT NULL DEFAULT '0',
  `currently_ill` tinyint(4) NOT NULL DEFAULT '0',
  `temporary_disability` tinyint(4) NOT NULL DEFAULT '0',
  `temporary_disability_4w` tinyint(4) NOT NULL DEFAULT '0',
  `invalid` tinyint(4) NOT NULL DEFAULT '0',
  `info_d` mediumtext,
  `c1_name` varchar(128) DEFAULT '',
  `c1_phone` varchar(64) DEFAULT '',
  `c1_info` varchar(64) DEFAULT '',
  `c2_name` varchar(128) DEFAULT '',
  `c2_phone` varchar(64) DEFAULT '',
  `c2_info` varchar(64) DEFAULT '',
  `c3_name` varchar(128) DEFAULT '',
  `c3_phone` varchar(64) DEFAULT '',
  `c3_info` varchar(64) DEFAULT '',
  `date_cr` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` int(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,1,'Шангри-Лa','Сорренто, пр. Карла Маркса, д.10',1,'Пупышево','','Просверлить дырочку в правом боку, слить отстой',150,12,'120/90','h1','','','','','','','',1,0,0,0,1,0,0,1,1,0,0,0,0,1,0,0,0,0,1,0,1,0,1,'asdcadsa','','','','','','','','','','2014-09-12 08:57:00',0),(2,2,'г.Норильск','ул. Вязов д.1, кв. 663',1,'остров Св. Елены','','дать пендаля',150,120,'220Мпа','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2013-07-05 06:43:52',1),(3,3,'г.Туркестан','',0,'','','',215,152,'1500/2000','Норильский КВД','ул. Талнахская д.69','666','Менгеле Й.','б2','','','д2',1,0,0,1,1,0,1,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,1,'да','','','','','','','','','','2013-07-14 21:54:32',1),(4,4,'Шангри-Ла','',0,'','','водочная клизма',30,5,'','ИЭМ','ул. ак. Павлова-12','42','Павлов И.П.','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,'не дождетесь!!!','','','','','','','','','','2013-07-14 21:58:59',1),(5,5,'Москва','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2013-06-06 10:09:45',0),(6,6,'г.Биробиджан','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2013-06-06 11:50:45',0),(7,7,'roma','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2014-09-19 08:25:18',0),(8,8,'СПБ','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2014-09-12 09:10:41',0),(9,9,'wse','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2014-09-12 10:39:06',0),(10,10,'edged','',0,'','',NULL,0,0,'','','','','','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,'','','','','','','','','','2014-09-12 10:48:09',0);
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_friends`
--

DROP TABLE IF EXISTS `user_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_friends` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `name` varchar(128) DEFAULT '',
  `phone` varchar(24) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `date_cr` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_friends`
--

LOCK TABLES `user_friends` WRITE;
/*!40000 ALTER TABLE `user_friends` DISABLE KEYS */;
INSERT INTO `user_friends` VALUES (1,1,'Алиса Иосифовна Фокс','8124546984',1,'2013-05-25 14:52:59'),(2,1,'Джузеппе Гарибальди','8124546880',1,'2016-09-15 13:54:24'),(11,1,'Базилио','77846565',1,'2016-09-15 14:20:39'),(4,2,'Тортилла Генриховна Супп','03',0,'2013-07-05 22:32:33'),(5,3,'Дуремар','784212365',0,'2013-05-28 13:25:54'),(6,2,'Алиса Иосифовна Фокс','8124546984',1,'2013-07-05 06:36:09'),(7,7,'Брут','75482632',1,'2014-09-12 09:08:10');
/*!40000 ALTER TABLE `user_friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_statuses`
--

DROP TABLE IF EXISTS `user_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `status` varchar(24) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_statuses`
--

LOCK TABLES `user_statuses` WRITE;
/*!40000 ALTER TABLE `user_statuses` DISABLE KEYS */;
INSERT INTO `user_statuses` VALUES (1,'активен'),(2,'расторгнут'),(3,'приостановлен');
/*!40000 ALTER TABLE `user_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `contract` int(4) NOT NULL DEFAULT '0',
  `name` varchar(64) DEFAULT '',
  `date_birth` date DEFAULT NULL,
  `address` varchar(255) DEFAULT '',
  `passport` varchar(128) DEFAULT NULL,
  `info` varchar(255) DEFAULT '',
  `phone` varchar(24) DEFAULT NULL,
  `phones` varchar(128) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `date_con` date DEFAULT NULL,
  `deseases` mediumtext,
  `blood` varchar(32) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1001,'Поленофф Буратин Карлович','0000-00-00','ул. Вязов д.13, каморка папы Карло','8959 654842','Характер скверный, неженат','79111851928','4541414,79210962935',1,'2013-05-09','почечная избыточность','2(+)'),(2,1002,'Барабас Мальвина Артемоновна','2013-05-01','ул. Вязов д.2, кв. 666','1010  20202\nВыдан 05.04.1958 ГУВД г. Рим','Маг 80-го уровня, беспощадна к врагам Луны','4546984','',1,'2013-05-09','Ветрянка\nВолчанка\nЧесотка','3(+)'),(3,1003,'Барабас Карабас Аббасович','1905-05-02','ул. Вязов д.2, кв. 666','0000  20202\nВыдан 01.01.1758 ГУВД г. Рим','Тайный властелин двух галактик','79218775645','79214077720',1,'2013-05-01','мозг рака','1(++)'),(5,1005,'Котуньо Базилио Васильевич','1980-07-09','ул. Вязов д.1, кв. 66','усы и хвост, выданы 01.01.1958 ГУВД г. Москва','Невосприимчив к метанолу, мышьяку и цианидам','79218775501','911',3,'2013-05-18','',''),(4,1004,'Шариков Артемон Мухтарович','1905-01-01','ул. Вязов д.3, кв. 666','0001  000001\nВыдан 01.01.1916 ГУВД г. Петроград','Капитан запаса ВВ','79218775502','02',1,'2013-05-16','','1(+)'),(6,1006,'Фокс Алиса Иосифовна','0000-00-00','ул. Вязов д.1, кв. 2','','Почетный акцептор','','78126470806',1,'2013-06-06','','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-18 17:31:14
