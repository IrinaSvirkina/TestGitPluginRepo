SET NAMES 'koi8r';

CREATE DATABASE IF NOT EXISTS octsrv CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE octsrv;

DROP TABLE IF EXISTS `octsrv`.`bannedctn`;
DROP TABLE IF EXISTS `octsrv`.`globalsetting`;
DROP TABLE IF EXISTS `octsrv`.`draftuser`;
DROP TABLE IF EXISTS `octsrv`.`user`;

DROP TABLE IF EXISTS `octsrv`.`targetgroup`;
DROP TABLE IF EXISTS `octsrv`.`attribute`;
DROP TABLE IF EXISTS `octsrv`.`regionphonemapping`;
DROP TABLE IF EXISTS `octsrv`.`region`;

DROP TABLE IF EXISTS `octsrv`.`actionstatistic`;
DROP TABLE IF EXISTS `octsrv`.`draftstatistics`;
DROP TABLE IF EXISTS `octsrv`.`summarystatistic`;
DROP TABLE IF EXISTS `octsrv`.`banner`;
DROP TABLE IF EXISTS `octsrv`.`campaignaccount`;
DROP TABLE IF EXISTS `octsrv`.`campaign`;
DROP TABLE IF EXISTS `octsrv`.`pricerates`;
DROP TABLE IF EXISTS `octsrv`.`client`;

CREATE TABLE `octsrv`.`attribute` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `octsrv`.`region` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `octsrv`.`regionphonemapping` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`region_id` BIGINT(20) NOT NULL,
	`phone_from` BIGINT(10) NOT NULL,
	`phone_to` BIGINT(10) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_regionphonemapping_region` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`client` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `activationId` VARCHAR(64) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
  `company` VARCHAR(40) NOT NULL COLLATE 'utf8_unicode_ci',
  `email` VARCHAR(36) NOT NULL COLLATE 'utf8_unicode_ci',
  `enabled` BIT(1) NOT NULL,
  `firstName` VARCHAR(20) NOT NULL COLLATE 'utf8_unicode_ci',
  `lastName` VARCHAR(20) NOT NULL COLLATE 'utf8_unicode_ci',
  `login` VARCHAR(20) NOT NULL COLLATE 'utf8_unicode_ci',
  `password` VARCHAR(32) NOT NULL COLLATE 'utf8_unicode_ci',
  `phone` VARCHAR(52) NOT NULL COLLATE 'utf8_unicode_ci',
  `registrationDate` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login` (`login`),
  INDEX `FK7877DFEBA11219B8` (`region_id`),
  CONSTRAINT `FK7877DFEBA11219B8` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)

#  `id` bigint(20) NOT NULL AUTO_INCREMENT,
#  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `firstName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `lastName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#  `registrationDate` datetime NOT NULL,
#  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `age_mask` smallint(6) NOT NULL,
  `category` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datetime_end` datetime NOT NULL,
  `datetime_start` datetime NOT NULL,
  `gender_mask` smallint(6) NOT NULL,
  `max_display_count` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `modification_date` datetime NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` bit(1) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFB83653081C4B9A1` (`client_id`),
  CONSTRAINT `FKFB83653081C4B9A1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`campaignaccount` (
  `campaign_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account` double(11,2) NOT NULL,
  'version' BIGINT(20) NOT NULL,
  PRIMARY KEY (`campaign_id`),
  UNIQUE KEY `campaign_id` (`campaign_id`),
  KEY `fk_campaignaccount_campaign` (`campaign_id`),
  CONSTRAINT `fk_campaignaccount_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`pricerates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aZ` double(11,2) NOT NULL,
  `aY` double(11,2) NOT NULL,
  `aX` double(11,2) NOT NULL,
  `uZ` double(11,2) NOT NULL,
  `uY` double(11,2) NOT NULL,
  `uX` double(11,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `octsrv`.`targetgroup` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`campaign_id` BIGINT(20) NOT NULL,
	`attribute_id` BIGINT(20) NOT NULL,
	`value` BIGINT(20) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_targetgroup_campaign` (`campaign_id`),
	INDEX `FK_targetgroup_attribute` (`attribute_id`),
	CONSTRAINT `FK_targetgroup_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`),
	CONSTRAINT `FK_targetgroup_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_phone` varchar(52) COLLATE utf8_unicode_ci NOT NULL,
  `action_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL,
  `format` int(11) NOT NULL,
  `max_display_count_for_user` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` longtext COLLATE utf8_unicode_ci NOT NULL,
  `campaign_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK762A6B4CA32FF91C` (`campaign_id`),
  CONSTRAINT `FK762A6B4CA32FF91C` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`summarystatistic` (
  `calls_count` int(11) NOT NULL,
  `gotourls_count` int(11) NOT NULL,
  `views_count` int(11) NOT NULL,
  `banner_id` bigint(20) NOT NULL,
  `money_value` double(11,2) NOT NULL,
  PRIMARY KEY (`banner_id`),
  UNIQUE KEY `banner_id` (`banner_id`),
  KEY `FK970D706AC19E0780` (`banner_id`),
  CONSTRAINT `FK970D706AC19E0780` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`actionstatistic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `banner_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE6D36F9AC19E0780` (`banner_id`),
  CONSTRAINT `FKE6D36F9AC19E0780` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`draftstatistic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `creation_date` datetime NOT NULL,
  `banner_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCC48E984C19E0780` (`banner_id`),
  CONSTRAINT `FKCC48E984C19E0780` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`),
  CONSTRAINT `FKCC48E984DA89105D` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`draftuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `age_mask` int(11) NOT NULL,
  `gender_mask` int(11) NOT NULL,
  `ucid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `imei` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `phone_model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ucid` (`ucid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`globalsetting` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE  `octsrv`.`user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `region_id` BIGINT(20) NOT NULL,
  'os' varchar(10) NOT NULL,
  `age_mask` int(11) NOT NULL,
  `gender_mask` int(11) NOT NULL,
  `ucid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `imei` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `phone_model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(52) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ucid` (`ucid`),
#  UNIQUE KEY `imei` (`imei`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `octsrv`.`bannedctn` (
	`phone_number` varchar(52) COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
