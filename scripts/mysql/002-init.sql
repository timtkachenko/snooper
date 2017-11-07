CREATE DATABASE IF NOT EXISTS `snooper` DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO "root"@"%" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* to "root"@"localhost" identified by "$MYSQL_ROOT_PASSWORD";
GRANT ALL PRIVILEGES ON *.* TO "$MYSQL_USER"@"%" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO "$MYSQL_USER"@"localhost" WITH GRANT OPTION;
FLUSH PRIVILEGES ;

########################
USE `snooper`;

CREATE TABLE `job` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `retry_count` int(10) unsigned NOT NULL DEFAULT '0',
  `last_retry_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `last_ping_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delayed_until` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `service` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
