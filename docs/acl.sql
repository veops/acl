-- ------------------------------------------------------
-- Server version	5.7.36-log

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
-- Table structure for table `acl_apps`
--

DROP TABLE IF EXISTS `acl_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_apps` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` text,
  `app_id` text,
  `secret_key` text,
  PRIMARY KEY (`id`),
  KEY `ix_acl_apps_name` (`name`),
  KEY `ix_acl_apps_deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_apps`
--

LOCK TABLES `acl_apps` WRITE;
/*!40000 ALTER TABLE `acl_apps` DISABLE KEYS */;
INSERT INTO `acl_apps` VALUES (NULL,0,NULL,NULL,1,'acl',NULL,NULL,NULL),(NULL,0,NULL,NULL,2,'backend',NULL,NULL,NULL);
/*!40000 ALTER TABLE `acl_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_audit_permission_logs`
--

DROP TABLE IF EXISTS `acl_audit_permission_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_audit_permission_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `rid` int(11) DEFAULT NULL COMMENT '角色id',
  `resource_type_id` int(11) DEFAULT NULL COMMENT '资源类型id',
  `resource_ids` json DEFAULT NULL COMMENT '资源',
  `group_ids` json DEFAULT NULL COMMENT '资源组',
  `permission_ids` json DEFAULT NULL COMMENT '权限',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_permission_logs_resource_type_id` (`resource_type_id`),
  KEY `ix_acl_audit_permission_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_permission_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_permission_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_permission_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_permission_logs_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_audit_permission_logs`
--

LOCK TABLES `acl_audit_permission_logs` WRITE;
/*!40000 ALTER TABLE `acl_audit_permission_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_audit_permission_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_audit_resource_logs`
--

DROP TABLE IF EXISTS `acl_audit_resource_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_audit_resource_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `scope` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '范围',
  `link_id` int(11) DEFAULT NULL COMMENT '资源名',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '权限名',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_resource_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_resource_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_resource_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_resource_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_resource_logs_link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_audit_resource_logs`
--

LOCK TABLES `acl_audit_resource_logs` WRITE;
/*!40000 ALTER TABLE `acl_audit_resource_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_audit_resource_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_audit_role_logs`
--

DROP TABLE IF EXISTS `acl_audit_role_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_audit_role_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `scope` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '范围',
  `link_id` int(11) DEFAULT NULL COMMENT '资源id',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '其他内容',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_role_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_role_logs_operate_uid` (`operate_uid`),
  KEY `ix_acl_audit_role_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_role_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_role_logs_link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_audit_role_logs`
--

LOCK TABLES `acl_audit_role_logs` WRITE;
/*!40000 ALTER TABLE `acl_audit_role_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_audit_role_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_audit_trigger_logs`
--

DROP TABLE IF EXISTS `acl_audit_trigger_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_audit_trigger_logs` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `trigger_id` int(11) DEFAULT NULL COMMENT 'trigger',
  `operate_uid` int(11) DEFAULT NULL COMMENT '操作人uid',
  `operate_type` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作类型',
  `origin` json DEFAULT NULL COMMENT '原始数据',
  `current` json DEFAULT NULL COMMENT '当前数据',
  `extra` json DEFAULT NULL COMMENT '权限名',
  `source` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源',
  PRIMARY KEY (`id`),
  KEY `ix_acl_audit_trigger_logs_deleted` (`deleted`),
  KEY `ix_acl_audit_trigger_logs_app_id` (`app_id`),
  KEY `ix_acl_audit_trigger_logs_trigger_id` (`trigger_id`),
  KEY `ix_acl_audit_trigger_logs_operate_type` (`operate_type`),
  KEY `ix_acl_audit_trigger_logs_operate_uid` (`operate_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_audit_trigger_logs`
--

LOCK TABLES `acl_audit_trigger_logs` WRITE;
/*!40000 ALTER TABLE `acl_audit_trigger_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_audit_trigger_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_operation_records`
--

DROP TABLE IF EXISTS `acl_operation_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_operation_records` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rolename` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `operate` enum('3','4','1','2','0') COLLATE utf8_unicode_ci NOT NULL,
  `obj` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_acl_operation_records_deleted` (`deleted`),
  KEY `ix_acl_operation_records_rolename` (`rolename`),
  KEY `ix_acl_operation_records_app` (`app`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_operation_records`
--

LOCK TABLES `acl_operation_records` WRITE;
/*!40000 ALTER TABLE `acl_operation_records` DISABLE KEYS */;
INSERT INTO `acl_operation_records` VALUES (NULL,0,'2023-07-18 15:47:48',NULL,1,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:48:10',NULL,2,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:48:23',NULL,3,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:48:39',NULL,4,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:52:24',NULL,5,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:55:34',NULL,6,NULL,'admin','0','[\"ACL\"]'),(NULL,0,'2023-07-18 15:55:34',NULL,7,'backend','admin','1','[\"resources\"]'),(NULL,0,'2023-07-18 15:55:34',NULL,8,'backend','admin','1','[\"resources\"]'),(NULL,0,'2023-07-18 15:55:43',NULL,9,'backend','admin','1','[\"resources\"]'),(NULL,0,'2023-07-18 15:56:15',NULL,10,'backend','admin','1','[\"resources\"]'),(NULL,0,'2023-07-18 15:56:25',NULL,11,'backend','admin','1','[\"resources\"]');
/*!40000 ALTER TABLE `acl_operation_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_permissions`
--

DROP TABLE IF EXISTS `acl_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_permissions` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_permissions_deleted` (`deleted`),
  CONSTRAINT `acl_permissions_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_permissions_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_permissions`
--

LOCK TABLES `acl_permissions` WRITE;
/*!40000 ALTER TABLE `acl_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_resource_group_items`
--

DROP TABLE IF EXISTS `acl_resource_group_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_resource_group_items` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `resource_id` (`resource_id`),
  KEY `ix_acl_resource_group_items_deleted` (`deleted`),
  CONSTRAINT `acl_resource_group_items_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `acl_resource_groups` (`id`),
  CONSTRAINT `acl_resource_group_items_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `acl_resources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_resource_group_items`
--

LOCK TABLES `acl_resource_group_items` WRITE;
/*!40000 ALTER TABLE `acl_resource_group_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_resource_group_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_resource_groups`
--

DROP TABLE IF EXISTS `acl_resource_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_resource_groups` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resource_groups_name` (`name`),
  KEY `ix_acl_resource_groups_uid` (`uid`),
  KEY `ix_acl_resource_groups_deleted` (`deleted`),
  CONSTRAINT `acl_resource_groups_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_resource_groups_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_resource_groups`
--

LOCK TABLES `acl_resource_groups` WRITE;
/*!40000 ALTER TABLE `acl_resource_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_resource_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_resource_types`
--

DROP TABLE IF EXISTS `acl_resource_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_resource_types` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resource_types_deleted` (`deleted`),
  KEY `ix_acl_resource_types_name` (`name`),
  CONSTRAINT `acl_resource_types_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_resource_types`
--

LOCK TABLES `acl_resource_types` WRITE;
/*!40000 ALTER TABLE `acl_resource_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_resource_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_resources`
--

DROP TABLE IF EXISTS `acl_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_resources` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_resources_deleted` (`deleted`),
  KEY `ix_acl_resources_uid` (`uid`),
  CONSTRAINT `acl_resources_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_resources_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_resources`
--

LOCK TABLES `acl_resources` WRITE;
/*!40000 ALTER TABLE `acl_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_role_permissions`
--

DROP TABLE IF EXISTS `acl_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_permissions` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `perm_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `resource_id` (`resource_id`),
  KEY `group_id` (`group_id`),
  KEY `perm_id` (`perm_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_role_permissions_deleted` (`deleted`),
  CONSTRAINT `acl_role_permissions_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `acl_resources` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `acl_resource_groups` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_4` FOREIGN KEY (`perm_id`) REFERENCES `acl_permissions` (`id`),
  CONSTRAINT `acl_role_permissions_ibfk_5` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role_permissions`
--

LOCK TABLES `acl_role_permissions` WRITE;
/*!40000 ALTER TABLE `acl_role_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_role_relations`
--

DROP TABLE IF EXISTS `acl_role_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_relations` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `child_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_role_relations_deleted` (`deleted`),
  CONSTRAINT `acl_role_relations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_relations_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `acl_roles` (`id`),
  CONSTRAINT `acl_role_relations_ibfk_3` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role_relations`
--

LOCK TABLES `acl_role_relations` WRITE;
/*!40000 ALTER TABLE `acl_role_relations` DISABLE KEYS */;
INSERT INTO `acl_role_relations` VALUES (NULL,0,NULL,NULL,1,1,2,NULL);
/*!40000 ALTER TABLE `acl_role_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_roles`
--

DROP TABLE IF EXISTS `acl_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_roles` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `is_app_admin` tinyint(1) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `password` varchar(80) DEFAULT NULL,
  `key` varchar(32) DEFAULT NULL,
  `secret` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_roles_name` (`name`),
  KEY `ix_acl_roles_deleted` (`deleted`),
  CONSTRAINT `acl_roles_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_roles`
--

LOCK TABLES `acl_roles` WRITE;
/*!40000 ALTER TABLE `acl_roles` DISABLE KEYS */;
INSERT INTO `acl_roles` VALUES (NULL,0,NULL,NULL,1,'acl_admin',1,1,NULL,NULL,NULL,NULL),(NULL,0,NULL,NULL,2,'admin',NULL,NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `acl_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_triggers`
--

DROP TABLE IF EXISTS `acl_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_triggers` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wildcard` text COLLATE utf8_unicode_ci,
  `uid` text COLLATE utf8_unicode_ci,
  `resource_type_id` int(11) DEFAULT NULL,
  `roles` text COLLATE utf8_unicode_ci,
  `permissions` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_type_id` (`resource_type_id`),
  KEY `app_id` (`app_id`),
  KEY `ix_acl_triggers_deleted` (`deleted`),
  CONSTRAINT `acl_triggers_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `acl_resource_types` (`id`),
  CONSTRAINT `acl_triggers_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `acl_apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_triggers`
--

LOCK TABLES `acl_triggers` WRITE;
/*!40000 ALTER TABLE `acl_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_company_info_json`
--

DROP TABLE IF EXISTS `common_company_info_json`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_company_info_json` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_common_company_info_json_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_company_info_json`
--

LOCK TABLES `common_company_info_json` WRITE;
/*!40000 ALTER TABLE `common_company_info_json` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_company_info_json` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_department`
--

DROP TABLE IF EXISTS `common_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_department` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '部门名称',
  `department_director_id` int(11) DEFAULT NULL COMMENT '部门负责人ID',
  `department_parent_id` int(11) DEFAULT NULL COMMENT '上级部门ID',
  `sort_value` int(11) DEFAULT NULL COMMENT '排序值',
  `acl_rid` int(11) DEFAULT NULL COMMENT 'ACL中rid',
  PRIMARY KEY (`department_id`),
  KEY `ix_common_department_deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_department`
--

LOCK TABLES `common_department` WRITE;
/*!40000 ALTER TABLE `common_department` DISABLE KEYS */;
INSERT INTO `common_department` VALUES (NULL,0,'2023-07-18 15:56:12','2023-07-18 15:56:12',0,'全公司',0,-1,0,0);
/*!40000 ALTER TABLE `common_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_employee`
--

DROP TABLE IF EXISTS `common_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_employee` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(64) DEFAULT NULL COMMENT '性别',
  `position_name` varchar(255) DEFAULT NULL COMMENT '职位名称',
  `mobile` varchar(255) DEFAULT NULL COMMENT '电话号码',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `direct_supervisor_id` int(11) DEFAULT NULL COMMENT '直接上级ID',
  `department_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `acl_uid` int(11) DEFAULT NULL COMMENT 'ACL中uid',
  `acl_rid` int(11) DEFAULT NULL COMMENT 'ACL中rid',
  `acl_virtual_rid` int(11) DEFAULT NULL COMMENT 'ACL中虚拟角色rid',
  `last_login` timestamp NULL DEFAULT NULL COMMENT '上次登录时间',
  `block` int(11) DEFAULT NULL COMMENT '锁定状态',
  PRIMARY KEY (`employee_id`),
  KEY `department_id` (`department_id`),
  KEY `ix_common_employee_deleted` (`deleted`),
  CONSTRAINT `common_employee_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `common_department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_employee`
--

LOCK TABLES `common_employee` WRITE;
/*!40000 ALTER TABLE `common_employee` DISABLE KEYS */;
INSERT INTO `common_employee` VALUES (NULL,0,'2023-07-18 14:50:35',NULL,133,'admin@veops.cn','admin','admin','','','','',0,0,1,0,0,'2023-07-18 06:50:35',0);
/*!40000 ALTER TABLE `common_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_employee_info`
--

DROP TABLE IF EXISTS `common_employee_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_employee_info` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` json DEFAULT NULL COMMENT '员工信息',
  `employee_id` int(11) DEFAULT NULL COMMENT '员工ID',
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `ix_common_employee_info_deleted` (`deleted`),
  CONSTRAINT `common_employee_info_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `common_employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_employee_info`
--

LOCK TABLES `common_employee_info` WRITE;
/*!40000 ALTER TABLE `common_employee_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_employee_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_internal_message`
--

DROP TABLE IF EXISTS `common_internal_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_internal_message` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '跳转路径',
  `is_read` tinyint(1) DEFAULT NULL COMMENT '是否已读',
  `app_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '应用名称',
  `category` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '分类',
  `message_data` json DEFAULT NULL COMMENT '数据',
  `employee_id` int(11) DEFAULT NULL COMMENT 'ID',
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `ix_common_internal_message_deleted` (`deleted`),
  CONSTRAINT `common_internal_message_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `common_employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_internal_message`
--

LOCK TABLES `common_internal_message` WRITE;
/*!40000 ALTER TABLE `common_internal_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_internal_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `department` varchar(20) DEFAULT NULL,
  `catalog` varchar(64) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(14) DEFAULT NULL,
  `password` varchar(80) DEFAULT NULL,
  `key` varchar(32) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `date_joined` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `block` tinyint(1) DEFAULT NULL,
  `has_logined` tinyint(1) DEFAULT NULL,
  `wx_id` varchar(32) DEFAULT NULL,
  `employee_id` varchar(16) DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `ix_users_deleted` (`deleted`),
  KEY `ix_users_employee_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (NULL,0,1,'admin','admin',NULL,NULL,'admin@veops.cn',NULL,'e10adc3949ba59abbe56e057f20f883e','e304a43a600b4304bb5ce9845b67ea47','90z2Ld4$hvKc~SPRuwsl#E5!GtB8k%TD',NULL,'2023-07-18 15:55:21',0,1,NULL,'0000',NULL);
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

