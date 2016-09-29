-- MySQL dump 10.15  Distrib 10.0.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: asterisk
-- ------------------------------------------------------
-- Server version	10.0.25-MariaDB-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(4) NOT NULL DEFAULT '0',
  `account` decimal(10,2) DEFAULT '0.00',
  `tarif` int(11) NOT NULL DEFAULT '1',
  `credit` int(11) NOT NULL DEFAULT '1000',
  `mc` tinyint(4) NOT NULL DEFAULT '0',
  `bill` decimal(10,2) NOT NULL DEFAULT '0.00',
  `no_check_bill` tinyint(4) NOT NULL DEFAULT '0',
  `date_u` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,-6490.04,1,1000,0,0.00,1,'2015-05-27 08:59:38');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amaflags`
--

DROP TABLE IF EXISTS `amaflags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amaflags` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `value` varchar(10) NOT NULL DEFAULT '',
  `descr` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amaflags`
--

LOCK TABLES `amaflags` WRITE;
/*!40000 ALTER TABLE `amaflags` DISABLE KEYS */;
INSERT INTO `amaflags` VALUES (1,'BILLING','record outgoing'),(2,'DEFAULT','no record');
/*!40000 ALTER TABLE `amaflags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_px`
--

DROP TABLE IF EXISTS `call_px`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_px` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `px` varchar(5) DEFAULT '',
  `px2` varchar(5) DEFAULT '',
  `level` tinyint(4) DEFAULT '1',
  `descr` varchar(24) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_px`
--

LOCK TABLES `call_px` WRITE;
/*!40000 ALTER TABLE `call_px` DISABLE KEYS */;
INSERT INTO `call_px` VALUES (1,'','7812',0,'Местные'),(2,'8','7',1,'ВЗ'),(3,'8','7',2,'МГ'),(4,'810','',3,'МН');
/*!40000 ALTER TABLE `call_px` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `callback`
--

DROP TABLE IF EXISTS `callback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callback` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `number` varchar(15) NOT NULL DEFAULT '',
  `queue` varchar(7) DEFAULT '',
  `status` tinyint(4) DEFAULT '0',
  `try` tinyint(4) DEFAULT '0',
  `agent_na` tinyint(4) DEFAULT '0',
  `client_na` tinyint(4) DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `callback`
--

LOCK TABLES `callback` WRITE;
/*!40000 ALTER TABLE `callback` DISABLE KEYS */;
/*!40000 ALTER TABLE `callback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `callback_h`
--

DROP TABLE IF EXISTS `callback_h`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callback_h` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `number` varchar(15) NOT NULL DEFAULT '',
  `queue` varchar(7) DEFAULT '',
  `status` tinyint(4) DEFAULT '0',
  `try` tinyint(4) DEFAULT '0',
  `agent_na` tinyint(4) DEFAULT '0',
  `client_na` tinyint(4) DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `callback_h`
--

LOCK TABLES `callback_h` WRITE;
/*!40000 ALTER TABLE `callback_h` DISABLE KEYS */;
/*!40000 ALTER TABLE `callback_h` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `callback_statuses`
--

DROP TABLE IF EXISTS `callback_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callback_statuses` (
  `id` int(4) NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `callback_statuses`
--

LOCK TABLES `callback_statuses` WRITE;
/*!40000 ALTER TABLE `callback_statuses` DISABLE KEYS */;
INSERT INTO `callback_statuses` VALUES (0,'active'),(1,'inuse'),(2,'answered'),(3,'timeout');
/*!40000 ALTER TABLE `callback_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr`
--

DROP TABLE IF EXISTS `cdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr` (
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `clid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `dst` varchar(80) NOT NULL DEFAULT '',
  `dcontext` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `lastapp` varchar(80) NOT NULL DEFAULT '',
  `lastdata` varchar(80) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT '0',
  `billsec` int(11) NOT NULL DEFAULT '0',
  `disposition` varchar(45) NOT NULL DEFAULT '',
  `amaflags` int(11) NOT NULL DEFAULT '0',
  `accountcode` varchar(20) NOT NULL DEFAULT '',
  `uniqueid` varchar(32) NOT NULL DEFAULT '',
  `userfield` varchar(255) NOT NULL DEFAULT '',
  `operid` varchar(20) NOT NULL DEFAULT '',
  KEY `IDX_UNIQUEID` (`uniqueid`),
  KEY `calldate` (`calldate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr`
--

LOCK TABLES `cdr` WRITE;
/*!40000 ALTER TABLE `cdr` DISABLE KEYS */;
INSERT INTO `cdr` VALUES ('2016-09-01 23:04:14','1','79111852312','501','','','','','',60,55,'ANSWERED',2,'0','111','audio:b.wav','1');
/*!40000 ALTER TABLE `cdr` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mama`@`%`*/ /*!50003 TRIGGER `set_accountcode` BEFORE INSERT ON `cdr`
FOR EACH ROW
BEGIN
   DECLARE OPERID varchar(8);
   DECLARE NEWCID varchar(20);
   DECLARE CN varchar(20);
   SET NEW.accountcode='0';
   select id, uid, cnumber from operators where cnumber=NEW.src limit 1 into OPERID, NEWCID, CN;
   IF  NEWCID>0 THEN
     SET NEW.accountcode=concat('o-',NEWCID);
     SET NEW.operid=OPERID;
   ELSE
     select id, uid, cnumber from operators where cnumber=NEW.dst limit 1 into OPERID, NEWCID, CN;
     IF  NEWCID>0 THEN
       SET NEW.accountcode=NEWCID;
       SET NEW.operid=OPERID;
     END IF;
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cdr_u`
--

DROP TABLE IF EXISTS `cdr_u`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr_u` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `calldate` datetime DEFAULT '0000-00-00 00:00:00',
  `accountcode` int(4) NOT NULL DEFAULT '0',
  `src` varchar(16) DEFAULT '',
  `dst` varchar(16) DEFAULT '',
  `disposition` varchar(16) DEFAULT '',
  `duration` int(4) NOT NULL DEFAULT '0',
  `billsec` int(4) NOT NULL DEFAULT '0',
  `channel` varchar(64) DEFAULT '',
  `dstchannel` varchar(64) DEFAULT '',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bill` decimal(10,2) NOT NULL DEFAULT '0.00',
  `prefix` varchar(16) DEFAULT '',
  `cost_id` int(11) DEFAULT '0',
  `zone` int(11) DEFAULT '0',
  `operid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr_u`
--

LOCK TABLES `cdr_u` WRITE;
/*!40000 ALTER TABLE `cdr_u` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdr_u` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contexts`
--

DROP TABLE IF EXISTS `contexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contexts` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `context` varchar(20) NOT NULL DEFAULT '',
  `descr` varchar(255) DEFAULT '',
  `other` text,
  `disable` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `context` (`context`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contexts`
--

LOCK TABLES `contexts` WRITE;
/*!40000 ALTER TABLE `contexts` DISABLE KEYS */;
INSERT INTO `contexts` VALUES (1,'home','local extensions only',';-------- Call to local lines --------;\n\nexten => 1,1,Goto(ivr_900,s,1)\n\nexten => 501,1,Macro(dialIn,${EXTEN},120,tThH,R)\nexten => 501,hint,SIP/501; - for generate extenstatus (ext 501) events ;\n\nexten => 502,1,Macro(dialIn,${EXTEN},120,tThH,R)\nexten => 502,hint,SIP/502\n\nexten => 503,1,Macro(dialIn,${EXTEN},120,tThH,)\nexten => 503,hint,SIP/503\n\nexten => 504,1,Macro(dialIn,${EXTEN},120,tThH)\nexten => 504,hint,SIP/504\n\nexten => 505,1,Macro(dialIn,${EXTEN},120,tThH,R)\nexten => 505,hint,SIP/505\n\n;--------------------------------------;\n\nexten => *77,1,Macro(systemrecording,dorecord,${CALLERID(num)})\nexten => *99,1,Macro(systemrecording,docheck,${CALLERID(num)})\n\nexten => h,1, Macro(hangupcall,)\n',0),(2,'in_calls','incoming calls','include => operators\n\nexten => _X.,1,Goto(home,502,1)\n::exten => _X.,1,Answer\nexten => _X.,n,Goto(ivr_900,s,1)\nexten => _X.,n,Hangup()\n\nexten => 503,1,Goto(home,503,1)\n\nexten => h,1, Macro(hangupcall,)',0),(3,'ivr_900','IVR 900','exten => s,1,WaitExten(1)\nexten => s,n,Answer\nexten => s,n,Background(custom/asteroid)\nexten => s,n,Wait(3)\nexten => s,n,Goto(ivr_900,900,1)\nexten => 900,1,Set(MONITOR_FILENAME=${MONITORDIR}/q${EXTEN}-${STRFTIME(${EPOCH},,%Y%m%d-%H%M%S)}-${UNIQUEID})\nexten => 900,n,Queue(${EXTEN},,,,600)\n\nexten => 111,1,Set( CALLERID(num)=${IF($[\"${CALLERID(num)}\"=\"4542222\"]?4540001:${CALLERID(num)})} ) \nexten => 111,n,Dial(SIP/gw/4542222,,TtHh)\n\nexten => 0,1,Macro(FaxTo,el_brujo@asteroid.spb.ru)\nexten => 0,n,Hangup()\nexten => 1,1,Goto(home,501,1)\nexten => 2,1,Goto(home,502,1)\nexten => 3,1,Goto(home,503,1)\nexten => 4,1,Goto(home,504,1)\nexten => 9,1,Macro(FaxTo,joe@asteroid.spb.ru)\nexten => 12,1,Macro(Redirect,89112222222,4542222,R)\nexten => h,1,Macro(hangupcall,)',0),(4,'out_calls','outgoing calls','include => operators\n\n;exten => _1XX,1,Set(CALLERID(num)=302)\n;exten => _1XX,2,Macro(dialOut,${EXTEN},120,hHtT,${gwNVCI})\n\nexten => _X.,1,Set(CALLERID(num)=4540007)\nexten => _X.,n,Macro(dialOut,${EXTEN},130,hHtT)\nexten => _X.,n,Hangup()\n\nexten => h,1, Macro(hangupcall,)',0),(5,'brujo','Brujo Custom','include => home\nexten => _+7.,1,Goto(out_calls,8${EXTEN:2},1)\nexten => _X.,1,Goto(allallowed,${EXTEN},1)\nexten => h,1, Macro(hangupcall,)\n\n;-----------Autodialing--------------------------;\nexten => _188.,1,Playback(ozhidajte-soedinenija)\nexten => _188.,n,System(/var/lib/asterisk/sc/autodial ${EXTEN:3} SIP/nvc ${CALLERID(num)} 111)\nexten => _188.,n,Hangup()\n\nexten => _ad.,1,Answer()\nexten => _ad.,n,Set(CDR(userfield)=a-${EXTEN:2})\nexten => _ad.,n,Dial(SIP/${CALLERID(num)},,HhtT)\nexten => _ad.,n,Hangup()\n;------------------------------------------------;\n\nexten => _555.,1,Set(MESSAGE(body)=SALAM)\nexten => _555.,n,Playback(ozhidajte-soedinenija)\nexten => _555.,n,MessageSend(sip:${EXTEN:3},${CALLERID(all)})\nexten => _555.,n,Hangup()\n',0);
/*!40000 ALTER TABLE `contexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `costs`
--

DROP TABLE IF EXISTS `costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `costs` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `tarif` int(4) NOT NULL DEFAULT '1',
  `country_code` varchar(3) DEFAULT '',
  `prefix` varchar(7) DEFAULT '',
  `descr` varchar(64) DEFAULT '',
  `cost` decimal(12,2) DEFAULT NULL,
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `gw` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `zone` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5047 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costs`
--

LOCK TABLES `costs` WRITE;
/*!40000 ALTER TABLE `costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daystat`
--

DROP TABLE IF EXISTS `daystat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daystat` (
  `qid` int(4) NOT NULL DEFAULT '0',
  `answered` int(10) unsigned DEFAULT '0',
  `lost` int(10) unsigned DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daystat`
--

LOCK TABLES `daystat` WRITE;
/*!40000 ALTER TABLE `daystat` DISABLE KEYS */;
INSERT INTO `daystat` VALUES (900,8,7);
/*!40000 ALTER TABLE `daystat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositions`
--

DROP TABLE IF EXISTS `dispositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispositions` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `disposition` varchar(24) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositions`
--

LOCK TABLES `dispositions` WRITE;
/*!40000 ALTER TABLE `dispositions` DISABLE KEYS */;
INSERT INTO `dispositions` VALUES (1,'enterqueue'),(2,'connect'),(3,'completeagent'),(4,'completecaller'),(5,'abandon'),(6,'exitwithtimeout'),(7,'canceled'),(8,'exitwithkey');
/*!40000 ALTER TABLE `dispositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `event` varchar(12) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'вход'),(2,'выход');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gws`
--

DROP TABLE IF EXISTS `gws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gws` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `re` varchar(128) DEFAULT '',
  `name` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gws`
--

LOCK TABLES `gws` WRITE;
/*!40000 ALTER TABLE `gws` DISABLE KEYS */;
INSERT INTO `gws` VALUES (1,'^SIP/nvc','NevaCom'),(2,'.','any');
/*!40000 ALTER TABLE `gws` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `event` tinyint(4) NOT NULL DEFAULT '1',
  `dat` int(10) unsigned DEFAULT '0',
  `interva` int(10) unsigned DEFAULT '0',
  `number` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,403,1,1376428551,0,NULL),(2,401,2,1385626941,0,NULL),(3,402,2,1385627376,0,NULL),(4,402,1,1385627394,18,'501'),(5,402,2,1385627460,66,NULL),(6,401,1,1385627460,519,'501'),(7,401,2,1385627630,170,NULL),(8,402,1,1385627630,170,'501'),(9,404,1,1414500540,0,NULL),(10,405,1,1414502047,0,'504'),(11,401,1,1437469728,51842098,'501'),(12,404,2,1437482925,22982385,NULL),(13,4031,1,1442499423,0,'503'),(14,401,2,1445598380,8128652,NULL),(15,401,1,1445598416,36,'504');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `numbers`
--

DROP TABLE IF EXISTS `numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `numbers` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `account` int(4) NOT NULL DEFAULT '0',
  `number` varchar(24) NOT NULL DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `descr` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `numbers`
--

LOCK TABLES `numbers` WRITE;
/*!40000 ALTER TABLE `numbers` DISABLE KEYS */;
INSERT INTO `numbers` VALUES (1,1,'2223322',1,'outnum'),(2,1,'501',1,'Az'),(3,1,'502',1,'Brujo'),(4,1,'503',1,'NG');
/*!40000 ALTER TABLE `numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators`
--

DROP TABLE IF EXISTS `operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operators` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `uid` int(4) NOT NULL DEFAULT '0',
  `name` varchar(24) DEFAULT '',
  `pass` varchar(24) DEFAULT '',
  `cnumber` varchar(12) DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `gr` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators`
--

LOCK TABLES `operators` WRITE;
/*!40000 ALTER TABLE `operators` DISABLE KEYS */;
INSERT INTO `operators` VALUES (1,401,'Az','179101','504',1,1),(2,402,'El Brujo','194500','502',1,1),(3,403,'NG','191700','503',1,1),(4,404,'Observer','194512','0',1,1);
/*!40000 ALTER TABLE `operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qhistory`
--

DROP TABLE IF EXISTS `qhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qhistory` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `stime` int(10) unsigned DEFAULT '0',
  `qid` int(4) NOT NULL DEFAULT '0',
  `callid` int(4) NOT NULL DEFAULT '0',
  `cid` varchar(24) DEFAULT '',
  `did` varchar(24) DEFAULT '',
  `disposition` tinyint(4) NOT NULL DEFAULT '0',
  `wait` int(10) unsigned DEFAULT '0',
  `billsec` int(10) unsigned DEFAULT '0',
  `qname` varchar(24) DEFAULT '',
  `info` varchar(64) DEFAULT NULL,
  `didname` varchar(32) DEFAULT '',
  `btime` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qhistory`
--

LOCK TABLES `qhistory` WRITE;
/*!40000 ALTER TABLE `qhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `qhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qonline`
--

DROP TABLE IF EXISTS `qonline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qonline` (
  `stime` int(10) unsigned DEFAULT '0',
  `qid` int(4) NOT NULL DEFAULT '0',
  `callid` int(4) NOT NULL DEFAULT '0',
  `cid` varchar(24) DEFAULT '',
  `did` varchar(24) DEFAULT '',
  `disposition` tinyint(4) NOT NULL DEFAULT '0',
  `wait` int(10) unsigned DEFAULT '0',
  `billsec` int(10) unsigned DEFAULT '0',
  `qname` varchar(24) DEFAULT '',
  `info` varchar(64) DEFAULT NULL,
  `didname` varchar(32) DEFAULT '',
  `btime` int(10) unsigned DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qonline`
--

LOCK TABLES `qonline` WRITE;
/*!40000 ALTER TABLE `qonline` DISABLE KEYS */;
/*!40000 ALTER TABLE `qonline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_mon_formates`
--

DROP TABLE IF EXISTS `queue_mon_formates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_mon_formates` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `format` varchar(16) NOT NULL DEFAULT '',
  `descr` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_mon_formates`
--

LOCK TABLES `queue_mon_formates` WRITE;
/*!40000 ALTER TABLE `queue_mon_formates` DISABLE KEYS */;
INSERT INTO `queue_mon_formates` VALUES (1,'','no record'),(2,'vaw','vaw'),(3,'vaw49','vaw49'),(4,'gsm','gsm');
/*!40000 ALTER TABLE `queue_mon_formates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_mon_types`
--

DROP TABLE IF EXISTS `queue_mon_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_mon_types` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) NOT NULL DEFAULT '',
  `descr` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_mon_types`
--

LOCK TABLES `queue_mon_types` WRITE;
/*!40000 ALTER TABLE `queue_mon_types` DISABLE KEYS */;
INSERT INTO `queue_mon_types` VALUES (1,'','default'),(2,'mixmonitor','mixmonitor');
/*!40000 ALTER TABLE `queue_mon_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_strategyes`
--

DROP TABLE IF EXISTS `queue_strategyes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_strategyes` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `strategy` varchar(16) NOT NULL DEFAULT '',
  `descr` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_strategyes`
--

LOCK TABLES `queue_strategyes` WRITE;
/*!40000 ALTER TABLE `queue_strategyes` DISABLE KEYS */;
INSERT INTO `queue_strategyes` VALUES (1,'ringall','звонят все'),(2,'leastrecent','вызывается тот, кто меньше всего вызывался из этой очереди'),(3,'fewestcalls','вызывается тот, кто обработал наименьшее количество вызовов из д'),(4,'random','random'),(5,'rrmemory','циклическое распределение с памятью');
/*!40000 ALTER TABLE `queue_strategyes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queues`
--

DROP TABLE IF EXISTS `queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queues` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `extension` varchar(30) NOT NULL DEFAULT '',
  `descr` varchar(128) NOT NULL DEFAULT '',
  `c_strategy` varchar(30) NOT NULL DEFAULT 'ringall',
  `c_musicclass` varchar(30) NOT NULL DEFAULT 'default',
  `c_announce` varchar(30) NOT NULL DEFAULT '',
  `c_announce_frequency` int(11) NOT NULL DEFAULT '0',
  `c_announce_holdtime` varchar(3) NOT NULL DEFAULT 'no',
  `c_announce_position` varchar(30) NOT NULL DEFAULT 'no',
  `c_autofill` varchar(3) NOT NULL DEFAULT 'no',
  `c_joinempty` varchar(5) NOT NULL DEFAULT 'yes',
  `c_leavewhenempty` varchar(5) NOT NULL DEFAULT 'no',
  `c_maxlen` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `c_monitor_type` varchar(15) NOT NULL DEFAULT 'mixmonitor',
  `c_monitor_format` varchar(5) NOT NULL DEFAULT 'wav',
  `c_periodic_announce_frequency` int(10) unsigned NOT NULL DEFAULT '0',
  `c_reportholdtime` varchar(3) NOT NULL DEFAULT 'no',
  `c_retry` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `c_ringinuse` varchar(3) NOT NULL DEFAULT 'yes',
  `c_servicelevel` tinyint(3) unsigned NOT NULL DEFAULT '60',
  `c_timeout` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `c_weight` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `c_wrapuptime` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `members` text,
  `other` text,
  `disable` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `context` (`extension`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues`
--

LOCK TABLES `queues` WRITE;
/*!40000 ALTER TABLE `queues` DISABLE KEYS */;
INSERT INTO `queues` VALUES (1,'900','main','ringall','default','',0,'yes','yes','no','yes','no',0,'mixmonitor','vaw',0,'no',0,'yes',60,0,0,0,'Local/401@operators/n,0','context=redial-me-901\nperiodic-announce=custom/press-9-for-callback\nperiodic-announce-frequency=60',0),(2,'901','callback','ringall','default','',0,'yes','yes','no','yes','no',0,'mixmonitor','vaw',0,'no',0,'yes',60,0,0,0,'Local/401@operators/n,0\nLocal/404@operators/n,0','membermacro=queue-answ',0);
/*!40000 ALTER TABLE `queues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queues_config`
--

DROP TABLE IF EXISTS `queues_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queues_config` (
  `extension` varchar(20) NOT NULL DEFAULT '',
  `descr` varchar(35) NOT NULL DEFAULT '',
  `grppre` varchar(100) NOT NULL DEFAULT '',
  `alertinfo` varchar(254) NOT NULL DEFAULT '',
  `ringing` tinyint(1) NOT NULL DEFAULT '0',
  `maxwait` varchar(8) NOT NULL DEFAULT '',
  `password` varchar(20) NOT NULL DEFAULT '',
  `ivr_id` varchar(8) NOT NULL DEFAULT '0',
  `dest` varchar(50) NOT NULL DEFAULT '',
  `cwignore` tinyint(1) NOT NULL DEFAULT '0',
  `qregex` varchar(255) DEFAULT NULL,
  `agentannounce_id` int(11) DEFAULT NULL,
  `joinannounce_id` int(11) DEFAULT NULL,
  `queuewait` tinyint(1) DEFAULT '0',
  `use_queue_context` tinyint(1) DEFAULT '0',
  `togglehint` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`extension`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues_config`
--

LOCK TABLES `queues_config` WRITE;
/*!40000 ALTER TABLE `queues_config` DISABLE KEYS */;
INSERT INTO `queues_config` VALUES ('900','main','','',1,'','','0','ext-queues,900,1',0,NULL,NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `queues_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifes`
--

DROP TABLE IF EXISTS `tarifes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarifes` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(24) DEFAULT '',
  `parent` int(11) NOT NULL DEFAULT '0',
  `mul` decimal(8,4) NOT NULL DEFAULT '1.0000',
  `additive` decimal(10,2) DEFAULT NULL,
  `free_thr` int(4) NOT NULL DEFAULT '5',
  `min_thr` decimal(10,2) NOT NULL DEFAULT '0.00',
  `rounding` int(4) NOT NULL DEFAULT '60',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifes`
--

LOCK TABLES `tarifes` WRITE;
/*!40000 ALTER TABLE `tarifes` DISABLE KEYS */;
INSERT INTO `tarifes` VALUES (1,'mortel',0,1.0000,0.00,6,0.00,60);
/*!40000 ALTER TABLE `tarifes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `extension` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `c_secret` varchar(20) DEFAULT NULL,
  `c_type` varchar(50) DEFAULT 'friend',
  `c_host` varchar(50) DEFAULT 'dynamic',
  `c_nat` varchar(3) DEFAULT NULL,
  `c_callerid` varchar(50) DEFAULT NULL,
  `c_context` varchar(50) DEFAULT 'allallowed',
  `c_deny` varchar(50) DEFAULT '0.0.0.0/0.0.0.0',
  `permit` varchar(255) DEFAULT '0.0.0.0/0.0.0.0',
  `c_canreinvite` varchar(50) DEFAULT 'no',
  `c_allowtransfer` varchar(255) DEFAULT 'yes',
  `c_callcounter` varchar(3) DEFAULT 'yes',
  `c_amaflags` varchar(10) DEFAULT 'DEFAULT',
  `c_dtmfmode` varchar(10) DEFAULT 'rfc2833',
  `c_qualify` varchar(3) DEFAULT 'yes',
  `other` text,
  `disable` tinyint(4) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `st` tinyint(4) NOT NULL DEFAULT '0',
  `outnum` varchar(50) DEFAULT NULL,
  `calltime` int(10) unsigned DEFAULT '0',
  `exten_st` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `extension` (`extension`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'501','Az','slYGhg67867d8ia','friend','dynamic','no','\"Az\"<501>','az','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','no','yes','BILLING','rfc2833','yes','',0,'Az',0,'',1469724376,4),(2,'502','El Brujo','slw7676r789mia23','friend','dynamic','yes','\"Brujo\" <502>','az','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','no','yes','BILLING','rfc2833','yes','',0,'El Brujo',0,'',1472039144,0),(3,'503','NG','38poyuYU76a1ev','friend','dynamic','yes','\"NG\" <503>','allallowed','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','yes','yes','DEFAULT','rfc2833','yes','',0,'NG',0,'',1469724376,4),(4,'504','Duro','Qu124iKyh562erd','friend','dynamic','no','\"Duro\" <504>','aza','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','no','yes','DEFAULT','rfc2833','yes','',0,'Test',0,'',1469776078,4),(6,'506','aza2','s2l0n3e224rop23','friend','dynamic','yes','\"aza2\"<506>','aza2','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','yes','yes','BILLING','rfc2833','yes','',0,'Az',0,'',1469724376,0),(5,'505','Test <505>','q2we2423wert','friend','dynamic','yes','\"Test\" <505>','az','0.0.0.0/0.0.0.0','0.0.0.0/0.0.0.0','no','no','yes','DEFAULT','rfc2833','yes','transport = tls\nencryption=yes',0,'Test',0,'',1472071918,0);
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

-- Dump completed on 2016-09-29 16:16:53
