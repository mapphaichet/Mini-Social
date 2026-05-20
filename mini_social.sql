-- MySQL/MariaDB compatible dump converted from Django SQLite db.sqlite3
-- Database name: mini_social
CREATE DATABASE IF NOT EXISTS `mini_social` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mini_social`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `django_admin_log`;
DROP TABLE IF EXISTS `auth_user_user_permissions`;
DROP TABLE IF EXISTS `auth_user_groups`;
DROP TABLE IF EXISTS `auth_group_permissions`;
DROP TABLE IF EXISTS `social_reaction`;
DROP TABLE IF EXISTS `social_postmedia`;
DROP TABLE IF EXISTS `social_comment`;
DROP TABLE IF EXISTS `social_profile`;
DROP TABLE IF EXISTS `social_post`;
DROP TABLE IF EXISTS `django_session`;
DROP TABLE IF EXISTS `auth_user`;
DROP TABLE IF EXISTS `auth_group`;
DROP TABLE IF EXISTS `auth_permission`;
DROP TABLE IF EXISTS `django_content_type`;
DROP TABLE IF EXISTS `django_migrations`;

SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `django_migrations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `applied` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1, 'contenttypes', '0001_initial', '2026-05-19 06:31:32.859214');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (2, 'auth', '0001_initial', '2026-05-19 06:31:32.869798');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (3, 'admin', '0001_initial', '2026-05-19 06:31:32.877640');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2026-05-19 06:31:32.884958');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-19 06:31:32.890528');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2026-05-19 06:31:32.900126');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2026-05-19 06:31:32.909930');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (8, 'auth', '0003_alter_user_email_max_length', '2026-05-19 06:31:32.916797');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (9, 'auth', '0004_alter_user_username_opts', '2026-05-19 06:31:32.921461');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (10, 'auth', '0005_alter_user_last_login_null', '2026-05-19 06:31:32.928511');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (11, 'auth', '0006_require_contenttypes_0002', '2026-05-19 06:31:32.930661');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2026-05-19 06:31:32.935674');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (13, 'auth', '0008_alter_user_username_max_length', '2026-05-19 06:31:32.942150');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2026-05-19 06:31:32.948240');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (15, 'auth', '0010_alter_group_name_max_length', '2026-05-19 06:31:32.955664');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (16, 'auth', '0011_update_proxy_permissions', '2026-05-19 06:31:32.960153');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2026-05-19 06:31:32.967271');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (18, 'sessions', '0001_initial', '2026-05-19 06:31:32.971765');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (19, 'social', '0001_initial', '2026-05-19 06:31:32.996191');

CREATE TABLE `django_content_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app_label` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_uniq` (`app_label`, `model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1, 'social', 'comment');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (2, 'social', 'post');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (3, 'social', 'postmedia');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (4, 'social', 'profile');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (5, 'social', 'reaction');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6, 'admin', 'logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (7, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (8, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (9, 'auth', 'user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (10, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (11, 'sessions', 'session');

CREATE TABLE `auth_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content_type_id` INT NOT NULL,
  `codename` VARCHAR(100) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_uniq` (`content_type_id`, `codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`),
  CONSTRAINT `fk_auth_permission_content_type` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (1, 2, 'add_post', 'Can add post');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (2, 2, 'change_post', 'Can change post');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (3, 2, 'delete_post', 'Can delete post');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (4, 2, 'view_post', 'Can view post');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (5, 1, 'add_comment', 'Can add comment');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (6, 1, 'change_comment', 'Can change comment');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (7, 1, 'delete_comment', 'Can delete comment');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (8, 1, 'view_comment', 'Can view comment');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (9, 3, 'add_postmedia', 'Can add post media');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (10, 3, 'change_postmedia', 'Can change post media');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (11, 3, 'delete_postmedia', 'Can delete post media');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (12, 3, 'view_postmedia', 'Can view post media');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (13, 4, 'add_profile', 'Can add profile');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (14, 4, 'change_profile', 'Can change profile');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (15, 4, 'delete_profile', 'Can delete profile');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (16, 4, 'view_profile', 'Can view profile');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (17, 5, 'add_reaction', 'Can add reaction');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (18, 5, 'change_reaction', 'Can change reaction');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (19, 5, 'delete_reaction', 'Can delete reaction');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (20, 5, 'view_reaction', 'Can view reaction');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (21, 6, 'add_logentry', 'Can add log entry');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (22, 6, 'change_logentry', 'Can change log entry');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (23, 6, 'delete_logentry', 'Can delete log entry');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (24, 6, 'view_logentry', 'Can view log entry');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (25, 8, 'add_permission', 'Can add permission');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (26, 8, 'change_permission', 'Can change permission');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (27, 8, 'delete_permission', 'Can delete permission');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (28, 8, 'view_permission', 'Can view permission');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (29, 7, 'add_group', 'Can add group');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (30, 7, 'change_group', 'Can change group');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (31, 7, 'delete_group', 'Can delete group');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (32, 7, 'view_group', 'Can view group');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (33, 9, 'add_user', 'Can add user');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (34, 9, 'change_user', 'Can change user');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (35, 9, 'delete_user', 'Can delete user');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (36, 9, 'view_user', 'Can view user');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (37, 10, 'add_contenttype', 'Can add content type');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (38, 10, 'change_contenttype', 'Can change content type');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (39, 10, 'delete_contenttype', 'Can delete content type');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (40, 10, 'view_contenttype', 'Can view content type');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (41, 11, 'add_session', 'Can add session');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (42, 11, 'change_session', 'Can change session');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (43, 11, 'delete_session', 'Can delete session');
INSERT INTO `auth_permission` (`id`, `content_type_id`, `codename`, `name`) VALUES (44, 11, 'view_session', 'Can view session');

CREATE TABLE `auth_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_name_uniq` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `auth_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME NULL,
  `is_superuser` TINYINT(1) NOT NULL,
  `username` VARCHAR(150) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `is_staff` TINYINT(1) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `date_joined` DATETIME NOT NULL,
  `first_name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_username_uniq` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `first_name`) VALUES (1, 'pbkdf2_sha256$1200000$O2jds3eVeGZoQlbsScGRjm$rtwsgLNdJbCRJNFXA3PTp60ecZz+ZCgmxYXXW12df1o=', '2026-05-20 01:07:49.113602', 1, 'admin', '', 'admin123@gmail.com', 1, 1, '2026-05-19 06:38:03.168784', '');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `first_name`) VALUES (2, 'pbkdf2_sha256$1200000$vJpJ5ZyVYq5aV3MeHg2J0u$Bq1WBCREwqV0WD9pyHGjhOjqa2sMdEND0UadiKk2atc=', '2026-05-19 06:42:04.082007', 0, 'customer2', '', 'customer2@gmail.com', 0, 1, '2026-05-19 06:42:03.489255', '');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `first_name`) VALUES (3, 'pbkdf2_sha256$1200000$1BpxfFu8Hb1jASev6l5trd$90s7ckqQFmVGhl8qmmFBNtaxkWwo3eM2FNr+Lte3b/o=', '2026-05-19 06:47:25.422608', 0, 'customer1', '', 'customer1@gmail.com', 0, 1, '2026-05-19 06:42:57.359678', '');

CREATE TABLE `auth_group_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_uniq` (`group_id`, `permission_id`),
  KEY `auth_group_permissions_group_id` (`group_id`),
  KEY `auth_group_permissions_permission_id` (`permission_id`),
  CONSTRAINT `fk_auth_group_permissions_group` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_auth_group_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `auth_user_groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_uniq` (`user_id`, `group_id`),
  KEY `auth_user_groups_user_id` (`user_id`),
  KEY `auth_user_groups_group_id` (`group_id`),
  CONSTRAINT `fk_auth_user_groups_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `fk_auth_user_groups_group` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `auth_user_user_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_uniq` (`user_id`, `permission_id`),
  KEY `auth_user_user_permissions_user_id` (`user_id`),
  KEY `auth_user_user_permissions_permission_id` (`permission_id`),
  CONSTRAINT `fk_auth_user_user_permissions_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `fk_auth_user_user_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `django_session` (
  `session_key` VARCHAR(40) NOT NULL,
  `session_data` TEXT NOT NULL,
  `expire_date` DATETIME NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('b0kz1u0upwrayyhnxxdbj72x1175tgw3', '.eJxVjMsOwiAQAP9lz4YUtrx69O43kGUBWzWQlPZk_HfTpAe9zkzmDYH2bQ57z2tYEkwg4fLLIvEz10OkB9V7E9zqti5RHIk4bRe3lvLrerZ_g5n6DBN41qyTVIpGXxgRndWELhoiz8QyFR6cU4ykWaO3o8klcWGrRjNIQvh8Ae1rOC0:1wPVPZ:4I3hsZ4GoRuwEYLUdEX58PpBSK00LGSiFx6KBsxEcMM', '2026-06-03 01:07:49.116815');

CREATE TABLE `social_post` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_post_author_id` (`author_id`),
  CONSTRAINT `fk_social_post_author` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `social_post` (`id`, `content`, `created_at`, `updated_at`, `author_id`) VALUES (1, 'dvnisdbhfiuybcvkjzbcjkdfbs', '2026-05-19 06:42:24.581597', '2026-05-19 06:42:24.581629', 2);
INSERT INTO `social_post` (`id`, `content`, `created_at`, `updated_at`, `author_id`) VALUES (2, 'vnx hdfbjckxc
xcdfdnxdkfxdjk
dfxdmfxdjnfjvxvxvsdxg', '2026-05-19 06:43:24.937946', '2026-05-19 06:43:24.937974', 3);
INSERT INTO `social_post` (`id`, `content`, `created_at`, `updated_at`, `author_id`) VALUES (3, 'fuck you noob', '2026-05-19 06:47:38.483260', '2026-05-19 06:47:38.483273', 3);
INSERT INTO `social_post` (`id`, `content`, `created_at`, `updated_at`, `author_id`) VALUES (4, 'bfgskjsjdkkckndf', '2026-05-20 01:08:27.092597', '2026-05-20 01:08:27.092631', 1);

CREATE TABLE `social_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `avatar` VARCHAR(100) NULL,
  `bio` TEXT NOT NULL,
  `can_post` TINYINT(1) NOT NULL,
  `violation_count` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_profile_user_id_uniq` (`user_id`),
  CONSTRAINT `fk_social_profile_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `social_profile` (`id`, `avatar`, `bio`, `can_post`, `violation_count`, `created_at`, `updated_at`, `user_id`) VALUES (1, 'avatars/677782775_122188523906779766_2440040631734420953_n.jpg', '', 1, 0, '2026-05-19 06:38:03.521221', '2026-05-20 01:08:05.355838', 1);
INSERT INTO `social_profile` (`id`, `avatar`, `bio`, `can_post`, `violation_count`, `created_at`, `updated_at`, `user_id`) VALUES (2, '', '', 1, 0, '2026-05-19 06:42:04.075320', '2026-05-19 06:42:04.075343', 2);
INSERT INTO `social_profile` (`id`, `avatar`, `bio`, `can_post`, `violation_count`, `created_at`, `updated_at`, `user_id`) VALUES (3, 'avatars/675525231_122188524062779766_1160243545439818128_n.jpg', '', 1, 0, '2026-05-19 06:42:57.949008', '2026-05-19 06:45:47.770544', 3);

CREATE TABLE `social_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `is_approved` TINYINT(1) NOT NULL,
  `flagged_reason` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `author_id` INT NOT NULL,
  `post_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_comment_post_id` (`post_id`),
  KEY `social_comment_author_id` (`author_id`),
  CONSTRAINT `fk_social_comment_post` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`),
  CONSTRAINT `fk_social_comment_author` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `social_postmedia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `file` VARCHAR(100) NOT NULL,
  `uploaded_at` DATETIME NOT NULL,
  `post_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_postmedia_post_id` (`post_id`),
  CONSTRAINT `fk_social_postmedia_post` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `social_postmedia` (`id`, `file`, `uploaded_at`, `post_id`) VALUES (1, 'posts/515103598_17915227827134992_8203255846613461599_n.webp', '2026-05-19 06:42:24.587011', 1);
INSERT INTO `social_postmedia` (`id`, `file`, `uploaded_at`, `post_id`) VALUES (2, 'posts/516289201_17915227797134992_7571386976811353025_n.webp', '2026-05-19 06:43:24.942264', 2);
INSERT INTO `social_postmedia` (`id`, `file`, `uploaded_at`, `post_id`) VALUES (3, 'posts/514598743_17915227839134992_8854693668319294019_n.webp', '2026-05-19 06:47:38.488096', 3);
INSERT INTO `social_postmedia` (`id`, `file`, `uploaded_at`, `post_id`) VALUES (4, 'posts/677782775_122188523906779766_2440040631734420953_n.jpg', '2026-05-20 01:08:27.097882', 4);

CREATE TABLE `social_reaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `post_id` BIGINT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_reaction_post_id` (`post_id`),
  KEY `social_reaction_user_id` (`user_id`),
  CONSTRAINT `fk_social_reaction_post` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`id`),
  CONSTRAINT `fk_social_reaction_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `social_reaction` (`id`, `created_at`, `post_id`, `user_id`) VALUES (2, '2026-05-19 06:42:32.179842', 1, 2);
INSERT INTO `social_reaction` (`id`, `created_at`, `post_id`, `user_id`) VALUES (3, '2026-05-19 06:42:59.690281', 1, 3);
INSERT INTO `social_reaction` (`id`, `created_at`, `post_id`, `user_id`) VALUES (4, '2026-05-20 01:08:56.521804', 4, 1);

CREATE TABLE `django_admin_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_id` TEXT NULL,
  `object_repr` VARCHAR(200) NOT NULL,
  `action_flag` SMALLINT UNSIGNED NOT NULL,
  `change_message` TEXT NOT NULL,
  `content_type_id` INT NULL,
  `user_id` INT NOT NULL,
  `action_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id` (`user_id`),
  CONSTRAINT `fk_django_admin_log_content_type` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `fk_django_admin_log_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;