-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 11, 2019 at 04:12 PM
-- Server version: 10.1.39-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `castle`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2019-05-17 07:08:30', '2019-05-17 07:08:30'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2019-05-17 07:08:30', '2019-05-17 07:08:30'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, '', '', 1, 0, NULL, '2019-05-17 07:08:30', '2019-05-17 07:08:30');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(5) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `title`, `description`) VALUES
(35, '', ''),
(34, '', ''),
(33, '', ''),
(32, '', ''),
(31, '', ''),
(30, '', ''),
(29, '', ''),
(28, '', ''),
(27, '', ''),
(26, '', ''),
(36, '', ''),
(37, '', ''),
(38, '', ''),
(39, '', ''),
(40, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2019-05-17 07:08:31', '2019-05-17 07:08:31');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 5, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 3, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 2, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 9, '2019-05-17 07:08:31', '2019-05-17 07:08:31', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 10, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 11, '2019-05-17 07:08:31', '2019-05-17 07:08:31', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 12, '2019-05-17 07:08:32', '2019-05-17 07:08:32', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 13, '2019-05-17 07:08:32', '2019-05-17 07:08:32', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 14, '2019-05-17 07:08:32', '2019-05-17 07:08:32', 'voyager.settings.index', NULL),
(11, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 13, '2019-05-17 07:08:35', '2019-05-17 07:08:35', 'voyager.hooks', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(6, '2016_06_01_000004_create_oauth_clients_table', 2),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
(8, '2016_01_01_000000_add_voyager_user_fields', 3),
(9, '2016_01_01_000000_create_data_types_table', 3),
(10, '2016_05_19_173453_create_menu_table', 3),
(11, '2016_10_21_190000_create_roles_table', 3),
(12, '2016_10_21_190000_create_settings_table', 3),
(13, '2016_11_30_135954_create_permission_table', 3),
(14, '2016_11_30_141208_create_permission_role_table', 3),
(15, '2016_12_26_201236_data_types__add__server_side', 3),
(16, '2017_01_13_000000_add_route_to_menu_items_table', 3),
(17, '2017_01_14_005015_create_translations_table', 3),
(18, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 3),
(19, '2017_03_06_000000_add_controller_to_data_types_table', 3),
(20, '2017_04_21_000000_add_order_to_data_rows_table', 3),
(21, '2017_07_05_210000_add_policyname_to_data_types_table', 3),
(22, '2017_08_05_000000_add_group_to_settings_table', 3),
(23, '2017_11_26_013050_add_user_role_relationship', 3),
(24, '2017_11_26_015000_create_user_roles_table', 3),
(25, '2018_03_11_000000_add_user_settings', 3),
(26, '2018_03_14_000000_add_details_to_data_types_table', 3),
(27, '2018_03_16_000000_make_settings_value_nullable', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('01a334ab704824dc755a935cdd870da7d18c50e089d096ad88e4029420d18b0ce56c37e88738b2c8', 5, 1, 'MyApp', '[]', 0, '2019-05-24 01:02:01', '2019-05-24 01:02:01', '2020-05-24 06:32:01'),
('02210348f85c41181d625305bcfd1cf9d232e7fde0557e980e4eb4bbaea4bbdc69abf64b0470520c', 2, 1, 'castle', '[]', 0, '2019-05-28 09:05:33', '2019-05-28 09:05:33', '2020-05-28 14:35:33'),
('065b735fba732ad55b961da859be9a489e44cbcdfbc505a794d27d125a8522473116447e4ce67535', 48, 1, 'MyApp', '[]', 0, '2019-06-06 05:13:34', '2019-06-06 05:13:34', '2020-06-06 10:43:34'),
('073a19bcc4b95d23b8f2bf84828fb6183235a0d8d1b36cb667a1e04374c3031a5fe4ee3b28cce8c3', 32, 1, 'MyApp', '[]', 0, '2019-06-04 03:50:33', '2019-06-04 03:50:33', '2020-06-04 09:20:33'),
('07bb6537bb9ca138661ac10574d67c5ecf64ddff122f10f8abfa01401ec75e3d96ecf8c01f0ef2e7', 33, 1, 'castle', '[]', 0, '2019-06-04 05:08:36', '2019-06-04 05:08:36', '2020-06-04 10:38:36'),
('08b869b162d5e8315c9fe0682824e3a701354396a90d3ea666fd684ae8d379dab37ea3f9a608b6da', 29, 1, 'castle', '[]', 0, '2019-05-31 07:33:15', '2019-05-31 07:33:15', '2020-05-31 13:03:15'),
('08c78017d88b5a25a9817069d50fd7766b70d3bb0f9fbe04867eb3176a9219415d892b3f5eb9c1bc', 7, 1, 'MyApp', '[]', 0, '2019-05-16 06:56:44', '2019-05-16 06:56:44', '2020-05-16 12:26:44'),
('099b166f504311e1308c98723bee3599370255f23801f006514ea764a9b54593e4239d1b56a2f52a', 16, 1, 'castle', '[]', 0, '2019-05-17 08:11:40', '2019-05-17 08:11:40', '2020-05-17 13:41:40'),
('0acc5a508114aa4fc0cac0adb2e9e2ce74becdae76bea7a83147c3ee2765cf7f2668f1e94a54cfcf', 1, 1, 'castle', '[]', 0, '2019-05-27 02:13:00', '2019-05-27 02:13:00', '2020-05-27 07:43:00'),
('0ef4728309f4d77d75820d9021ebb398e965966906ee685187a2a53e4fea6db5b00692a0dae23e5f', 80, 1, 'castle', '[]', 0, '2019-06-11 02:13:39', '2019-06-11 02:13:39', '2020-06-11 07:43:39'),
('0f0c50a8b7a0a6dfa22a430c3e30a75ad819a6130a5b410feef31121fe93f876ae527bc7029f3a30', 39, 1, 'MyApp', '[]', 0, '2019-05-17 09:57:49', '2019-05-17 09:57:49', '2020-05-17 15:27:49'),
('103959905e86ee165dce5c7ca6106262e3bd988d8dee835fd7d1e318b7335b1709d4e7e016553e25', 55, 1, 'castle', '[]', 0, '2019-05-22 00:28:06', '2019-05-22 00:28:06', '2020-05-22 05:58:06'),
('11dd23caf1a1b1b56397ce77df60be8f9849bde618d71f4bf92f003525cc00dfa2ed384b6c22a729', 3, 1, 'MyApp', '[]', 0, '2019-05-23 03:03:43', '2019-05-23 03:03:43', '2020-05-23 08:33:43'),
('1256a2aaefa110289bc1b10e8194dc6cc4ac45a820d4918fc60caa82cf0d379379a15114ebef9262', 10, 1, 'MyApp', '[]', 0, '2019-05-28 23:40:55', '2019-05-28 23:40:55', '2020-05-29 05:10:55'),
('12b4af55b4a0368e2250d785a510374e3939faedbd67d051ddb99a90c6e7a58c6faf999f02021771', 59, 1, 'MyApp', '[]', 0, '2019-06-07 02:34:45', '2019-06-07 02:34:45', '2020-06-07 08:04:45'),
('13ca533a99e523b1aafbdd5ef5d71b9f66d3a350b1343f7e1ce334253701b447a5b4f49da64a25f3', 58, 1, 'MyApp', '[]', 0, '2019-06-07 02:28:23', '2019-06-07 02:28:23', '2020-06-07 07:58:23'),
('14992d3285897a28786fe0fd9ba9b3ed3561e5d8c3c904265b03dacd0eca3273d0dfb85e8f822d7b', 48, 1, 'castle', '[]', 0, '2019-06-06 05:21:29', '2019-06-06 05:21:29', '2020-06-06 10:51:29'),
('164132a14a0e23ba4c5360407b8be39e4122b9ea6fd57a51e418bd31144bfce9051ec26e579803e1', 9, 1, 'MyApp', '[]', 0, '2019-05-16 07:18:14', '2019-05-16 07:18:14', '2020-05-16 12:48:14'),
('16b5e3e7f3f41acb6c9be650dbb04dfef7fa99959a057674b5241065906edff34b418fb1fd53e8f1', 27, 1, 'MyApp', '[]', 0, '2019-05-31 06:33:01', '2019-05-31 06:33:01', '2020-05-31 12:03:01'),
('191aab6062e6f9753c031e5713c1987a114c8e86bb368c3ee237de3b10d31987f102dd93d90b2b94', 1, 1, 'castle', '[]', 0, '2019-05-27 23:33:35', '2019-05-27 23:33:35', '2020-05-28 05:03:35'),
('1a1ff4fabefc35115a41a9bf000728ee8cd67cb0704b8da7580946db912b1cf67dfdd985fa8b6e45', 16, 1, 'castle', '[]', 0, '2019-05-17 06:23:02', '2019-05-17 06:23:02', '2020-05-17 11:53:02'),
('1afc91fbaf0f343641027a696fd52adcb2d38186e9901ae81bf8b3609f72c5ccace0c3b41aa2d7a8', 3, 1, 'castle', '[]', 0, '2019-05-28 09:39:36', '2019-05-28 09:39:36', '2020-05-28 15:09:36'),
('1afe2015d48bfe1e06b17423ce508b54a9b40ae4bd51f70af1b998a2590ffe33a1416e98de7e265a', 1, 1, 'castle', '[]', 0, '2019-05-30 00:58:59', '2019-05-30 00:58:59', '2020-05-30 06:28:59'),
('1c984d15ae1db2edf3662bf4ee16224e508035e29842ae6fd7baa893cdae9a55c6ee51790e6dd03d', 49, 1, 'castle', '[]', 0, '2019-06-07 02:37:12', '2019-06-07 02:37:12', '2020-06-07 08:07:12'),
('1d781db9fd2121fab62bcfeb3c659476728e2a555dfdfb76b538e0ffda22e853ffb71328c913c5a7', 69, 1, 'MyApp', '[]', 0, '2019-06-07 04:26:42', '2019-06-07 04:26:42', '2020-06-07 09:56:42'),
('1dda9d8330a2952edcbcaf16c6c6bcee8b66616ed6ca36d9f1d4c9f4e2ece4806c5c915017b5f5a4', 25, 1, 'MyApp', '[]', 0, '2019-05-31 02:28:04', '2019-05-31 02:28:04', '2020-05-31 07:58:04'),
('1e1390fc078107fe35a632d10e80c166d69c548005077c3e5a9e2736edcb832cb439166696c5ae62', 20, 1, 'MyApp', '[]', 0, '2019-05-17 09:21:54', '2019-05-17 09:21:54', '2020-05-17 14:51:54'),
('1e3e2d3994013f1ea70230cd23bf4f5a0e77ce01b378a17a487a0dec77650a9413afcaed314d3941', 26, 1, 'castle', '[]', 0, '2019-05-31 09:08:13', '2019-05-31 09:08:13', '2020-05-31 14:38:13'),
('1e5a56cfec17ae36e2662543eefae2d9fc70a592aafe022d675c2857fbd78f2e77a08984798890a8', 35, 1, 'MyApp', '[]', 0, '2019-05-17 09:51:34', '2019-05-17 09:51:34', '2020-05-17 15:21:34'),
('1ee5da93378e19f2ada99ca5c90df82b5fa326b24b95403b55d84fa518ce9a240f942bc657c35e0c', 1, 1, 'castle', '[]', 0, '2019-05-28 05:35:19', '2019-05-28 05:35:19', '2020-05-28 11:05:19'),
('1f282758824e2f5facae9972aae30a5a6ffcc277abc85cc23dbf5f4cd5f632d794cedb9200c87b42', 23, 1, 'MyApp', '[]', 0, '2019-05-31 01:54:47', '2019-05-31 01:54:47', '2020-05-31 07:24:47'),
('1f7814e8fe379567e6484e4e6e2bdb73714a877d869e893b670b003bbcbfc9a8510eeb205f3561cb', 12, 1, 'castle', '[]', 0, '2019-05-30 06:28:52', '2019-05-30 06:28:52', '2020-05-30 11:58:52'),
('206024b151086c6c32f8aa8472192b3a5114923d8e2af716d82ee23e343853f95d98b5ff81191280', 5, 1, 'castle', '[]', 0, '2019-05-24 01:02:23', '2019-05-24 01:02:23', '2020-05-24 06:32:23'),
('214d4d5b310683ac4d380aca4c1fbcd3ddbae232cad08c6a78173410caa05ea7c97a80cac2474833', 34, 1, 'castle', '[]', 0, '2019-06-04 05:19:20', '2019-06-04 05:19:20', '2020-06-04 10:49:20'),
('21dfef32f7cf83512264480cfb8c8368d776e21cb5b65b1397d3fe777fddd5ef95547475b835c8a9', 19, 1, 'MyApp', '[]', 0, '2019-05-17 09:09:53', '2019-05-17 09:09:53', '2020-05-17 14:39:53'),
('22c55c972fef89d1af090cfc64f443b5c39fabcf5aebd9cbf43697d1bea2c2a920f9f36f18912fab', 29, 1, 'castle', '[]', 0, '2019-05-31 07:16:16', '2019-05-31 07:16:16', '2020-05-31 12:46:16'),
('239a045633b76653ce1a95a9f7dafc660e229d573ef8bd2d3ab742451360e9fee750200ced13e1d1', 61, 1, 'MyApp', '[]', 0, '2019-06-07 02:51:01', '2019-06-07 02:51:01', '2020-06-07 08:21:01'),
('26dad33892b121c2e84e00f721b1c04feb649833b74291c1bd49a69dd77e851474cf920da0c6d41b', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:46', '2019-05-22 00:27:46', '2020-05-22 05:57:46'),
('27010351817ccefc1bf8fd6b0c3e5d704f67d760aeaee2136f1a090bff48398144c22cc880213fe5', 50, 1, 'castle', '[]', 0, '2019-06-07 09:27:36', '2019-06-07 09:27:36', '2020-06-07 14:57:36'),
('2a7f7feb972619e825146b86cba5ee6f698bc2da135b107a4f8fc85ffa12396e25bba3130dadc529', 27, 1, 'MyApp', '[]', 0, '2019-05-17 09:37:53', '2019-05-17 09:37:53', '2020-05-17 15:07:53'),
('2b840a3ccdd7e54b748dc51657b7206501ce1ebee7de149574f3a9c9d65923f94a8ce7d2284f2925', 1, 1, 'castle', '[]', 0, '2019-05-28 06:25:28', '2019-05-28 06:25:28', '2020-05-28 11:55:28'),
('2bf0fd1c5c45366b19bd9cdd4da9da7e7a816110b41130f2740078fa096dbee8fbd7286f0a2a1499', 76, 1, 'MyApp', '[]', 0, '2019-06-07 04:36:34', '2019-06-07 04:36:34', '2020-06-07 10:06:34'),
('2eaf6410a9922b49b2e8ad209d3febcff9736aae79a86863aac400f0a1ce55314ea9179f7c6298fc', 21, 1, 'MyApp', '[]', 0, '2019-05-31 01:51:49', '2019-05-31 01:51:49', '2020-05-31 07:21:49'),
('304562d7e550f0ef4d97449ce6881d809e4320e123b44afd689e8892cf4b7412b6054b648619bb03', 19, 1, 'castle', '[]', 0, '2019-05-31 01:51:09', '2019-05-31 01:51:09', '2020-05-31 07:21:09'),
('31af45960c6eaa998bbe3838edffed8687d9b31d6ee0f0188183f91922777ec9f5a52f52aee9d8b1', 79, 1, 'castle', '[]', 0, '2019-06-10 03:01:11', '2019-06-10 03:01:11', '2020-06-10 08:31:11'),
('31c4ebc0c09ca8c6a23c15b99153ea36eceb60da2ee858e254cf0757045d976c8cfaa0d76a0b230b', 19, 1, 'MyApp', '[]', 0, '2019-05-31 01:43:39', '2019-05-31 01:43:39', '2020-05-31 07:13:39'),
('331449b2c4cf1749e4e7a3a8f1f1cdb4801142a04fd014d53f2fe1755dfffdad9abb976b1b7cb5cd', 37, 1, 'castle', '[]', 0, '2019-06-06 01:40:26', '2019-06-06 01:40:26', '2020-06-06 07:10:26'),
('331d2ca1808ba46ff85a552eb15760401a26883e5ee74e48f643f21e4ce663bc1dcb5ec7f21da8f5', 47, 1, 'castle', '[]', 0, '2019-06-06 05:20:30', '2019-06-06 05:20:30', '2020-06-06 10:50:30'),
('352c63830e449d98bc69470febe07c29ee1418c8db2e444d15f3bae170a1985b60c5eccb01f259d6', 28, 1, 'castle', '[]', 0, '2019-06-04 04:01:06', '2019-06-04 04:01:06', '2020-06-04 09:31:06'),
('3555ae9ca5364c955c6a2501d1cfcb131062af2682b05380a2b04fd46ededc7200f643de57f0696a', 28, 1, 'castle', '[]', 0, '2019-06-04 00:44:38', '2019-06-04 00:44:38', '2020-06-04 06:14:38'),
('36ac7d239da0d155a0f65609e3f281cbe9e2ba1d33c9896842a7f17848ad36c73b8b8742bc7358af', 46, 1, 'castle', '[]', 0, '2019-05-22 04:32:33', '2019-05-22 04:32:33', '2020-05-22 10:02:33'),
('36b80c72893d5fd2d964a6ca37bdfecac12835d508de6c5790e29900859a68fce5d546280ee87548', 54, 1, 'MyApp', '[]', 0, '2019-06-06 23:13:52', '2019-06-06 23:13:52', '2020-06-07 04:43:52'),
('36e021b6e28e34c8654b970bc46cacd526aa7468cf9ab13bbaab6083dd515c23b63c8e856e733151', 50, 1, 'MyApp', '[]', 0, '2019-06-06 08:24:24', '2019-06-06 08:24:24', '2020-06-06 13:54:24'),
('3706c2932bfe63d535c0a90a7396345f107a6ea0980a8c61cd30314e9eb82a7a64e2065bf8653530', 31, 1, 'castle', '[]', 0, '2019-06-06 02:08:36', '2019-06-06 02:08:36', '2020-06-06 07:38:36'),
('3780a3ed9986883e920077aaeaddd028a5362460c5d409f4d9c12e0768eff81c0cb424ba81da7f45', 26, 1, 'castle', '[]', 0, '2019-06-05 01:55:20', '2019-06-05 01:55:20', '2020-06-05 07:25:20'),
('3860f22fcfa505caf4cad7a62d0bea00662017adf8a3df5d348673d58c6eb0115cad5ca04dd2edd0', 57, 1, 'MyApp', '[]', 0, '2019-06-07 02:28:08', '2019-06-07 02:28:08', '2020-06-07 07:58:08'),
('3a1c704c916075835436db3947b6e8979cf557f53f68c88e6f457ffb9becffbba457932fc9f92771', 80, 1, 'castle', '[]', 0, '2019-06-11 07:43:36', '2019-06-11 07:43:36', '2020-06-11 13:13:36'),
('3aec1bfa62d058e70651a40122f2dc92421eba97ba109950fe710d1f8476880790b1e9e70514220d', 45, 1, 'MyApp', '[]', 0, '2019-05-20 01:01:35', '2019-05-20 01:01:35', '2020-05-20 06:31:35'),
('3bd307305e7bc19d9d06f51869e6dd0d316182c3e661a60b26893103e8920a3ae61241e1513af4b4', 47, 1, 'castle', '[]', 0, '2019-06-06 05:19:48', '2019-06-06 05:19:48', '2020-06-06 10:49:48'),
('3c315944ef88a2459d35c80ab3501d56160abfd4fa25424f4b7ec79c7ac591e3ae5344aeaed9c58d', 12, 1, 'MyApp', '[]', 0, '2019-05-17 02:50:27', '2019-05-17 02:50:27', '2020-05-17 08:20:27'),
('3cbfe395709c6dbe2059c3ac23458f0b2ca91331d3229833af24c61dcd591425e6cbecd1da10ea0b', 1, 1, 'castle', '[]', 0, '2019-05-28 09:59:29', '2019-05-28 09:59:29', '2020-05-28 15:29:29'),
('3d11f360dee1e09820d01f0e3118ea2e891cec8e45ec2459f6ea6659f72c1eb63e3cfa528fe644d8', 28, 1, 'MyApp', '[]', 0, '2019-05-31 06:49:25', '2019-05-31 06:49:25', '2020-05-31 12:19:25'),
('4080b22e2274e8400b4f6621108b85931a71507e7c56b82d363601c90c36acfaba801b871aa2cc3a', 65, 1, 'MyApp', '[]', 0, '2019-06-07 02:58:40', '2019-06-07 02:58:40', '2020-06-07 08:28:40'),
('4187ddb332c3691e46ed074d687dc6da9f81ab0fc95dc14ce0336d2c2818e27663bab913d688b31c', 37, 1, 'castle', '[]', 0, '2019-06-06 01:44:20', '2019-06-06 01:44:20', '2020-06-06 07:14:20'),
('41944d4beae5b8fd8ac95bb9d3ec4380aa3f1c1baf3c54e7ae57decab255750c8897950c5ee2e9d8', 55, 1, 'castle', '[]', 0, '2019-05-22 00:24:23', '2019-05-22 00:24:23', '2020-05-22 05:54:23'),
('41aea25fd781567265cc5c0b2d7c29defe92a028d810bbebeb26648b8b70870472fe56c95752dd65', 49, 1, 'castle', '[]', 0, '2019-06-06 23:35:55', '2019-06-06 23:35:55', '2020-06-07 05:05:55'),
('41c5a188043c313c249d0d3555929f14aace9844df559f67ab242fe90b9af84cebc62cd084145a14', 13, 1, 'MyApp', '[]', 0, '2019-05-17 05:14:12', '2019-05-17 05:14:12', '2020-05-17 10:44:12'),
('44311696f6b0a72e55136e0ba6575598dd36184b299d55ea8e1a443ba95cca7c860a0988f54d098e', 80, 1, 'castle', '[]', 0, '2019-06-11 06:19:41', '2019-06-11 06:19:41', '2020-06-11 11:49:41'),
('459c98e7f94ea3a1a5735b6f463b069bb04062b54beafa1dfd350573b012a2f12d049d2bddb1ac1f', 56, 1, 'castle', '[]', 0, '2019-06-07 00:29:30', '2019-06-07 00:29:30', '2020-06-07 05:59:30'),
('483bce5a298980ecb74fa7a46a87e8877ac974d9a4b8fc437623ee9d0a8a9693876ee4994f1531ab', 31, 1, 'castle', '[]', 0, '2019-06-04 02:39:57', '2019-06-04 02:39:57', '2020-06-04 08:09:57'),
('487b1ad0f240695cb1ad2f2f669b88e58478612fd48399321cd63de146a07eda4f4c228e0fba0cd5', 55, 1, 'MyApp', '[]', 0, '2019-06-06 23:57:53', '2019-06-06 23:57:53', '2020-06-07 05:27:53'),
('488da7ba4fac8fd9aef7209a071e7a846c3a9e65d8628ee64c69caaa14c0572494ac8727176e8221', 1, 1, 'castle', '[]', 0, '2019-05-29 00:47:12', '2019-05-29 00:47:12', '2020-05-29 06:17:12'),
('48a3c4b7ff4928b26d86375f1105e19cf021df55670e91c4907bfd7f72b6148bded035bf50581459', 14, 1, 'MyApp', '[]', 0, '2019-05-17 05:39:19', '2019-05-17 05:39:19', '2020-05-17 11:09:19'),
('48d6adc5286f347b0e88c2a57f95f71e35ab2a519df30e14fbc613686bd222df42e7450c2ac3e3da', 10, 1, 'MyApp', '[]', 0, '2019-05-16 07:20:15', '2019-05-16 07:20:15', '2020-05-16 12:50:15'),
('48f4b6955de04a1ae435fba11cb38757733729d22c0ee2b298234e81f00d28f7d76b4a58936d9dec', 1, 1, 'castle', '[]', 0, '2019-05-27 06:28:51', '2019-05-27 06:28:51', '2020-05-27 11:58:51'),
('498985393b6a8a44e81ce462379fb983c2a19fe2df4ca9a50f39628fac577b3e8e582c625cbfd701', 80, 1, 'castle', '[]', 0, '2019-06-11 06:07:06', '2019-06-11 06:07:06', '2020-06-11 11:37:06'),
('4b70be92a5a3a47fbdb3af3728180e871138d67bc98bc152c089f47e911f96193d066617a3b36326', 63, 1, 'MyApp', '[]', 0, '2019-06-07 02:53:29', '2019-06-07 02:53:29', '2020-06-07 08:23:29'),
('4d4aa2f67f0112ab74e56f1438d0fb5412838f5209bad4d21062c6e751016ed05f245eea2d94e735', 1, 1, 'castle', '[]', 0, '2019-05-29 02:21:29', '2019-05-29 02:21:29', '2020-05-29 07:51:29'),
('4d879495477be4a6b6526fcc4a500d988096f503557789b5638f03f5b2a7c70a81d3da40638be4aa', 30, 1, 'castle', '[]', 0, '2019-05-31 07:48:37', '2019-05-31 07:48:37', '2020-05-31 13:18:37'),
('4e81e73d5438e0918f6a5298e0f0f8025890ce8a6de7367c9892c858bfbe2a640060451e1ecdb62f', 18, 1, 'castle', '[]', 0, '2019-05-17 10:10:35', '2019-05-17 10:10:35', '2020-05-17 15:40:35'),
('4fd26fea7adc9a07bf9f427766f217e728865ebf44da1e839d5df163b12909cfe64d1a88c3b45fe0', 16, 1, 'MyApp', '[]', 0, '2019-05-17 06:22:13', '2019-05-17 06:22:13', '2020-05-17 11:52:13'),
('4fedaab3a2a7fb9d2b919cb381c61ad62f71dcb2ebfccdc594279d366c2919e7125c6425d760a8b0', 12, 1, 'MyApp', '[]', 0, '2019-05-30 05:32:09', '2019-05-30 05:32:09', '2020-05-30 11:02:09'),
('5035886aa077d3f9d4b26f4e5becb66127de07dbd42bb890bb2e41d2ca7c95d5df658a65b66e1d34', 33, 1, 'MyApp', '[]', 0, '2019-06-04 04:22:42', '2019-06-04 04:22:42', '2020-06-04 09:52:42'),
('5367c524678496b7d2a5c293eaf6d937d6ca5a6b4f106a3337ed89bcea30476f5ddda90087448be3', 55, 1, 'castle', '[]', 0, '2019-05-22 00:24:25', '2019-05-22 00:24:25', '2020-05-22 05:54:25'),
('55a7ba5adc956f75162d884733f0edf5c3c172125536ddfc68b56cc0b9e63548d2b38ea822b686db', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:42', '2019-05-22 00:23:42', '2020-05-22 05:53:42'),
('55cdcb4ccab89749f6f809a78ad19cddbbaadfef37aaf13a436c6a032644cb46f9dc08eae08ccdec', 47, 1, 'castle', '[]', 0, '2019-06-06 05:21:37', '2019-06-06 05:21:37', '2020-06-06 10:51:37'),
('568d851f1afa0d2772ea9cedbf0173726856ea6e050b932850ac0159c8c0cfc62affaabad519f828', 1, 1, 'castle', '[]', 0, '2019-05-23 03:01:04', '2019-05-23 03:01:04', '2020-05-23 08:31:04'),
('59e3c793190c939d45946387f3e78556605b34b9b38f77319a3e45834ef8c510c6c055775793ff67', 1, 1, 'castle', '[]', 0, '2019-05-29 04:37:37', '2019-05-29 04:37:37', '2020-05-29 10:07:37'),
('5a141eab9c56db358b2e30772d51becbae8a697efd8fcbbf727fd7e4c068257004003598868fbcb2', 49, 1, 'castle', '[]', 0, '2019-06-06 23:59:12', '2019-06-06 23:59:12', '2020-06-07 05:29:12'),
('5a85874f80f82074f6bfa5d43d6814aa1c769400ecef8b14160d3a988e0c7c55fa69d14f670ef8ab', 29, 1, 'castle', '[]', 0, '2019-05-31 07:19:43', '2019-05-31 07:19:43', '2020-05-31 12:49:43'),
('5b159704e73e973a8c4e8b789f13b9dea0841b1aa64ab7017932374032ff2629594c1fdaf5966cc3', 28, 1, 'castle', '[]', 0, '2019-06-06 00:17:29', '2019-06-06 00:17:29', '2020-06-06 05:47:29'),
('5b228ddac8e3b951ebb96a51b4333a4c3186c1a82d0d5170e75f660a34b447688853eec63f199fbc', 50, 1, 'castle', '[]', 0, '2019-06-07 05:34:07', '2019-06-07 05:34:07', '2020-06-07 11:04:07'),
('5b69ee6a2fef973b23409a3c971632ea759daddef159cb4c2b51d9795d6005018516d0576bbbedd0', 8, 1, 'MyApp', '[]', 0, '2019-05-28 09:41:13', '2019-05-28 09:41:13', '2020-05-28 15:11:13'),
('5c654eddf02c21996cdeee4ebb6e91fbd4d4cb72e7dc10f5c700fee3d5de11d1419f46119f48e18d', 26, 1, 'castle', '[]', 0, '2019-06-05 05:15:09', '2019-06-05 05:15:09', '2020-06-05 10:45:09'),
('5d42f1b2db181b78f64ff043e007e2f8ef46d366d17ffba6f94eac8cc984733e24f5498ef616de37', 26, 1, 'castle', '[]', 0, '2019-05-31 09:04:43', '2019-05-31 09:04:43', '2020-05-31 14:34:43'),
('5f8a8057cd5e3e2b121a542f0c93e789de1ba8447ab54d358067ae492634c21512e6bfe31ceaa2a7', 33, 1, 'castle', '[]', 0, '2019-06-04 06:29:45', '2019-06-04 06:29:45', '2020-06-04 11:59:45'),
('6043d3cd239d05867e8bce72e1a1c2d23628f3e1729876e7571a39c0c20e6234cd59cdd2a6b6a699', 29, 1, 'castle', '[]', 0, '2019-06-04 05:21:06', '2019-06-04 05:21:06', '2020-06-04 10:51:06'),
('61bfc2677d61ec468c9e9ac59bb049ccec8f3a9edd217c78570d097ab268793f1fd62e142313a278', 1, 1, 'castle', '[]', 0, '2019-05-28 06:29:10', '2019-05-28 06:29:10', '2020-05-28 11:59:10'),
('6216d4a38c9d5cf1dd650928887c785664f732124b0a7cd76d87058fddd27363a3df3d38988a5f20', 34, 1, 'MyApp', '[]', 0, '2019-06-04 05:05:00', '2019-06-04 05:05:00', '2020-06-04 10:35:00'),
('622b0ea04964c949f9c4a7be766d81be7651fee0761cf0d499bc1a3358b0dc931ee4f02009274ceb', 60, 1, 'MyApp', '[]', 0, '2019-05-23 02:52:33', '2019-05-23 02:52:33', '2020-05-23 08:22:33'),
('62b5aea4ec285bc0fa9bea4fd14ac2fa731e719817ec7f0d58c94fe1b155cf2107883681c52f3d1b', 80, 1, 'castle', '[]', 0, '2019-06-11 06:01:28', '2019-06-11 06:01:28', '2020-06-11 11:31:28'),
('63fd384b0c610c176c29c0eb105f44f1613a338fc46ba763adafd00273bb8f505e79cdec082eb317', 2, 1, 'castle', '[]', 0, '2019-05-28 07:25:42', '2019-05-28 07:25:42', '2020-05-28 12:55:42'),
('64bf582639511d71999d1c0785239f66832bf58cd24dd411f26de1ec500d942f6cb3d5f0cd72a1a1', 47, 1, 'castle', '[]', 0, '2019-06-07 02:03:52', '2019-06-07 02:03:52', '2020-06-07 07:33:52'),
('6540ac22b709d15562194c86b158c6fa410d541e59d851a04b6b465be421e1fe9cb0400076069cf3', 28, 1, 'castle', '[]', 0, '2019-06-03 06:17:01', '2019-06-03 06:17:01', '2020-06-03 11:47:00'),
('65bd6610da57fbb0cb10c0a4fcd677dca65f5a46c72a6533b0968bf940643b932829176f3ef43682', 28, 1, 'castle', '[]', 0, '2019-06-04 05:42:22', '2019-06-04 05:42:22', '2020-06-04 11:12:22'),
('65bf776934f1af709ecc7db844b41b5ec5cd1653b607b375d3e1bcead0eb029612d8e440f3dfc63d', 49, 1, 'castle', '[]', 0, '2019-06-06 08:18:01', '2019-06-06 08:18:01', '2020-06-06 13:48:01'),
('668b243eb0957fa89b266b4853ac4edba23cd5e380c6c89fd8f77c1cae3754bf146e70711889b42b', 7, 1, 'castle', '[]', 0, '2019-05-30 05:33:37', '2019-05-30 05:33:37', '2020-05-30 11:03:37'),
('687253ce88d29dd1c7f2edfa4758a0faf95ad2c0578df29dc6adbf04c39db23af29282c53898810e', 50, 1, 'castle', '[]', 0, '2019-06-09 23:02:55', '2019-06-09 23:02:55', '2020-06-10 04:32:55'),
('687b9dd27be9178435e7895f573e2189f496903c82332d613280522930849d0fc547fe5689d7c7e5', 47, 1, 'MyApp', '[]', 0, '2019-06-06 04:50:18', '2019-06-06 04:50:18', '2020-06-06 10:20:18'),
('694614b678fe4c09cdf81b9127b5127c39f857a91dd7ae7025361ff72ca30545c36d1fe7bbbc5084', 33, 1, 'castle', '[]', 0, '2019-06-04 06:29:09', '2019-06-04 06:29:09', '2020-06-04 11:59:09'),
('69c599f2a156b0c781a404a44067fbfd8b5129a32a6f7677e2b7b741367f32969a75a5f23faa9b41', 35, 1, 'MyApp', '[]', 0, '2019-06-04 06:39:30', '2019-06-04 06:39:30', '2020-06-04 12:09:30'),
('69fac726337eeea8717f094b93139c87cc1d6c012f0e7632702fd7f2d9008df6d7a71c0416953848', 1, 1, 'castle', '[]', 0, '2019-05-28 06:21:19', '2019-05-28 06:21:19', '2020-05-28 11:51:19'),
('6a35915f6b762f5089de642feb8d7e1517d214dff3494735f627edab07669e33e4616a48bf9b0b29', 59, 1, 'MyApp', '[]', 0, '2019-05-23 02:47:32', '2019-05-23 02:47:32', '2020-05-23 08:17:32'),
('6bbfbc2d469d350c18020a4f50424fea011e9c7a1ab4f4dff1fb34ff7d638422e30e6201d6b9765d', 77, 1, 'MyApp', '[]', 0, '2019-06-07 04:36:41', '2019-06-07 04:36:41', '2020-06-07 10:06:41'),
('6d14b76d4ca49718eccfdf914ab170b21e82c26c3f31d434eae7baa29a77911bf520d41b9f551cfb', 26, 1, 'MyApp', '[]', 0, '2019-05-31 02:33:02', '2019-05-31 02:33:02', '2020-05-31 08:03:02'),
('6ddc06c4b978972b4bcea11579a756a6db098b5049d54e5d98d901562f2d76a65f2ef0dec90710e3', 44, 1, 'MyApp', '[]', 0, '2019-05-17 10:11:13', '2019-05-17 10:11:13', '2020-05-17 15:41:13'),
('6e5ab234aeb3f0407b924b857dc926ff750ddd94d6808fe5a246a10c9834ef2f5c8f1008b808325e', 66, 1, 'MyApp', '[]', 0, '2019-06-07 03:51:20', '2019-06-07 03:51:20', '2020-06-07 09:21:20'),
('6f11d8f7fd3fc694098f905e35ba77cc1fa5e77735d3da31353dc78d629865f493bdbc99dd347dac', 56, 1, 'MyApp', '[]', 0, '2019-06-07 00:29:00', '2019-06-07 00:29:00', '2020-06-07 05:59:00'),
('6f3e4819457d49e3e2c43cbfb517110c5c48766620a898c613a1eba19ac203246c7f260bd2eab307', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:49', '2019-05-22 00:27:49', '2020-05-22 05:57:49'),
('706388a335c2b4605bd7917e204eb14899db130107930f97520bae77dc5c1455071408202a2b7f23', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:49', '2019-05-22 00:20:49', '2020-05-22 05:50:49'),
('70728ae6509a519188261abd2303db214b0bafea21f23630b365db12ff425c396dde4e8b7e785a21', 29, 1, 'MyApp', '[]', 0, '2019-05-31 07:13:38', '2019-05-31 07:13:38', '2020-05-31 12:43:38'),
('72d7baba8527245575a1c4e5a86955adab1b1385fbd8abd48e8916b2b319a394d97f502b5168848e', 1, 1, 'castle', '[]', 0, '2019-05-29 01:11:36', '2019-05-29 01:11:36', '2020-05-29 06:41:36'),
('730b838a83b9fe5bedf26b726781b90980d3568b6a498096c0bbe9f0f9e2bd48cbdd4b02c1da0d4e', 14, 1, 'castle', '[]', 0, '2019-05-17 05:40:36', '2019-05-17 05:40:36', '2020-05-17 11:10:36'),
('732de897a9bc42e7225ca12f1885860258203fb71ab8d691b73f746fa0e554057f6d54a9e900025d', 1, 1, 'castle', '[]', 0, '2019-05-28 06:30:16', '2019-05-28 06:30:16', '2020-05-28 12:00:16'),
('7355889d4fca3c049aaed7a06ff1db276e716706b45f8a7bab6077e3b39052bc0fb80201d235e854', 67, 1, 'MyApp', '[]', 0, '2019-06-07 04:18:07', '2019-06-07 04:18:07', '2020-06-07 09:48:07'),
('73c30f583f6ad035b06995a5953ebd063816c7296809332d6fe3ee5fe0d7ffaf030f6999867911d0', 53, 1, 'MyApp', '[]', 0, '2019-05-22 00:17:09', '2019-05-22 00:17:09', '2020-05-22 05:47:09'),
('73f9749c216caf504a1321dd33f243874d66b7f69a0f038d2f0b6c500ed6eed501db07dc401f9797', 62, 1, 'MyApp', '[]', 0, '2019-06-07 02:52:28', '2019-06-07 02:52:28', '2020-06-07 08:22:28'),
('744708a9f580c7852c3bc6fbfb34e9175577e78a1caf3e83d897f215d8368c2788f72e20b8afc823', 49, 1, 'castle', '[]', 0, '2019-06-06 08:39:22', '2019-06-06 08:39:22', '2020-06-06 14:09:22'),
('758d993923b1395dfe9d0ff672402e2a234aa7245ffad3ef2794252c2e287ede759c322f82bd9b79', 55, 1, 'castle', '[]', 0, '2019-06-07 00:43:07', '2019-06-07 00:43:07', '2020-06-07 06:13:07'),
('7629704cedfa78511a4d16bec231674850dd249b13874692bb404bf74af2f9f4d5a838968d39a920', 7, 1, 'MyApp', '[]', 0, '2019-05-28 05:39:33', '2019-05-28 05:39:33', '2020-05-28 11:09:33'),
('779d6b83bdb8a69ebb7a209a2befe0036a0e1f6d278f86a6fb85a527f7df5323f38b33aeef21722e', 48, 1, 'MyApp', '[]', 0, '2019-05-22 00:14:25', '2019-05-22 00:14:25', '2020-05-22 05:44:25'),
('77d09d7cf69f7f599757ab75b86c7d38cc68e0f457bace09116387206105a553ddbc726d0a57b24f', 29, 1, 'MyApp', '[]', 0, '2019-05-17 09:41:31', '2019-05-17 09:41:31', '2020-05-17 15:11:31'),
('77dc16f018ab77860ce38573fffe3cbf021e64766c1fb89a10f6249da15b1576e1b294f3bec86dbc', 80, 1, 'castle', '[]', 0, '2019-06-11 07:30:02', '2019-06-11 07:30:02', '2020-06-11 13:00:02'),
('78b7939a1fcd039775fddf7dd07d5e528592c7dcd97d433cb9e85ad99a3a932f8ce0c20243c57259', 30, 1, 'MyApp', '[]', 0, '2019-05-31 07:21:21', '2019-05-31 07:21:21', '2020-05-31 12:51:21'),
('78c6cfc18cd8bf81ed99cb04812ed48b3aac2a7b3faf9458ca3f50f028816a59f962fcba295985ab', 9, 1, 'MyApp', '[]', 0, '2019-05-28 09:42:46', '2019-05-28 09:42:46', '2020-05-28 15:12:46'),
('798259ee164bc352db28d4b52202eda7c9a148d6cb5e046090ced31db6ed408b77247b22f8305977', 34, 1, 'MyApp', '[]', 0, '2019-05-17 09:51:27', '2019-05-17 09:51:27', '2020-05-17 15:21:27'),
('7998a5492e7ff786dc07f3f235518d9b3ff83ffc5560403ed1c08485c145417715b6b06fd37fd83c', 9, 1, 'castle', '[]', 0, '2019-05-28 09:43:23', '2019-05-28 09:43:23', '2020-05-28 15:13:23'),
('7a15c4714560ad15ccf824ac09320cb421cd514c614b3f13c4c3edbb4861f832dc78fb230ce50faf', 4, 1, 'castle', '[]', 0, '2019-05-24 01:23:01', '2019-05-24 01:23:01', '2020-05-24 06:53:01'),
('7a707e7478d961951f5723ce2d2a8317f9cf25b041e4f9d8abe6f94b6872a754f413f9e93284c9b6', 79, 1, 'castle', '[]', 0, '2019-06-10 01:41:48', '2019-06-10 01:41:48', '2020-06-10 07:11:48'),
('7b55958e3158f1901b34cb11d25e76941ddbd9b8690e778d4b2c979d985fc82270ff01209ee49929', 23, 1, 'MyApp', '[]', 0, '2019-05-17 09:32:29', '2019-05-17 09:32:29', '2020-05-17 15:02:29'),
('7b6593aea05ad0b22c1a2e4d1e5708a77e3f9794261a98395a8e471bc88e0ca69a1ac17e79ea9561', 28, 1, 'castle', '[]', 0, '2019-06-03 06:50:20', '2019-06-03 06:50:20', '2020-06-03 12:20:20'),
('7b6bba3428852f91284a208c2c8a034ddb2204ea8c0e7bc3eb6e28b025ada4c160d752428e61c759', 24, 1, 'MyApp', '[]', 0, '2019-05-31 02:21:45', '2019-05-31 02:21:45', '2020-05-31 07:51:45'),
('7bfa99813e0e0bc89b45f725191d4e7eb6d7fc20ee07139a76deb31ce55b92fcb1c27b2da53e1efc', 15, 1, 'MyApp', '[]', 0, '2019-05-17 05:39:27', '2019-05-17 05:39:27', '2020-05-17 11:09:27'),
('7daf9d7dee3e2a8f68a38a076cc18edcbad616f0f6646a1375ffcaab355de7b5b2d0e17c1488ca23', 1, 1, 'castle', '[]', 0, '2019-05-27 02:14:18', '2019-05-27 02:14:18', '2020-05-27 07:44:18'),
('7e2e40df2f09df49d023a450600231cf68cf4063cdc40e71c0b8f81baccffc1f436219f061ee09b9', 36, 1, 'castle', '[]', 0, '2019-06-05 05:16:42', '2019-06-05 05:16:42', '2020-06-05 10:46:42'),
('7e4b528c622914ac781a38094927ccb0003150720fdfd7d35f69b8af4007ba76f3121186dc9499b6', 16, 1, 'castle', '[]', 0, '2019-05-30 07:12:54', '2019-05-30 07:12:54', '2020-05-30 12:42:54'),
('7f2eba8bab958b79f8e674c984c158375dbdeabc9dd0ad43689d82f2c2b56f9e039b1ec114e02d44', 26, 1, 'castle', '[]', 0, '2019-05-31 02:37:31', '2019-05-31 02:37:31', '2020-05-31 08:07:31'),
('802de2e87c4a16ff571066b970add9ce65f873c6e63d31e7265694e1c3c46f954b0d72bac53e8bd2', 12, 1, 'castle', '[]', 0, '2019-05-30 06:45:16', '2019-05-30 06:45:16', '2020-05-30 12:15:16'),
('80d7c860303bffda05826d7b00f24e099a40433eabde67bb2ecceab9ddb3f15f1406ab9272fce987', 2, 1, 'castle', '[]', 0, '2019-05-17 05:30:02', '2019-05-17 05:30:02', '2020-05-17 11:00:02'),
('8281c2037a7b3d8ef9b1f80a5121a1289570caa27f27d45f9061dd53db3f3b254ab6cc57d068800c', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:07', '2019-05-22 00:23:07', '2020-05-22 05:53:07'),
('83f9d99445e709c198e2435de166340603a89e188e618fd9d32626af9f9020f886625d96cbc0c497', 26, 1, 'MyApp', '[]', 0, '2019-05-17 09:35:17', '2019-05-17 09:35:17', '2020-05-17 15:05:17'),
('84498257e40a7629808c6230116b173c1e72dd75e276f4b347c4e76a39056fa27549eecfeb5b17e7', 8, 1, 'MyApp', '[]', 0, '2019-05-16 06:57:17', '2019-05-16 06:57:17', '2020-05-16 12:27:17'),
('84db6d9f0dc9a71a72a670e853aa7e57757d1db73b807492781bfa308256bd8fee36d586e61f3bbc', 33, 1, 'castle', '[]', 0, '2019-06-04 05:09:07', '2019-06-04 05:09:07', '2020-06-04 10:39:07'),
('852911de345a910af8871072bebe98fdca7d85626218384fd1b1430a7049621d6cbc95d043f9a29b', 36, 1, 'castle', '[]', 0, '2019-06-05 08:01:36', '2019-06-05 08:01:36', '2020-06-05 13:31:36'),
('859620aeefef41893c124143033e7d9b01508c3c8b1ce48ac295f1af77523af94b847140b4b2d79b', 13, 1, 'MyApp', '[]', 0, '2019-05-30 05:44:57', '2019-05-30 05:44:57', '2020-05-30 11:14:57'),
('87c8d9b0dedbbf512085a32edae43ba5c6152461a7e561f799ac3c262f0cef20e7fcd3d0407feed9', 16, 1, 'MyApp', '[]', 0, '2019-05-30 07:06:21', '2019-05-30 07:06:21', '2020-05-30 12:36:21'),
('8880b36eee873e86c25d0d104efd379631e12cbde197b2efe182f0c52d6402c327bfffe3c652d3b8', 55, 1, 'castle', '[]', 0, '2019-05-22 00:19:22', '2019-05-22 00:19:22', '2020-05-22 05:49:22'),
('89ec3ea7ec71cc97afbf87cf3ecde84b848268beaab8a75bc538f51a5b82e4573dd4723b7ab55fc1', 33, 1, 'castle', '[]', 0, '2019-06-04 05:17:26', '2019-06-04 05:17:26', '2020-06-04 10:47:26'),
('8a11ba7bb0be3152aba39d48ccf1fac87cb12eb675db020ce49cd30d85ab5923e6cb7ac951582494', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:56', '2019-05-22 00:27:56', '2020-05-22 05:57:56'),
('8a1dc0c59f9ac30971ab1cbec5fffa74a6ac55a182837f07f32c02232d65a40f44dcaa35a72b3cf9', 28, 1, 'castle', '[]', 0, '2019-06-03 07:52:01', '2019-06-03 07:52:01', '2020-06-03 13:22:01'),
('8ab86a6dae37aad09af445365f70784bdce2fde0ffc8bc0332c5a3c3842f2d56b6d116f5c4eba99f', 2, 1, 'castle', '[]', 0, '2019-05-17 04:55:06', '2019-05-17 04:55:06', '2020-05-17 10:25:06'),
('8bcf039bc18f5ac0a77704efe7a990342477212a56b795d64af99c7d6a4d12e1d654226f0e529688', 55, 1, 'MyApp', '[]', 0, '2019-05-22 00:18:49', '2019-05-22 00:18:49', '2020-05-22 05:48:49'),
('8c41de82f7b28d217a78a61ae1b14283b9bb608762019d4626b167707fe5cd9e5e6d0bd5c8a0e4b0', 64, 1, 'MyApp', '[]', 0, '2019-06-07 02:56:20', '2019-06-07 02:56:20', '2020-06-07 08:26:20'),
('8c66a40e8bc01f187d77c842f1b259e531498a81c68067574c96d4d4ee625e071d2c7786be353ba6', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:08', '2019-05-22 00:20:08', '2020-05-22 05:50:08'),
('8c9e61e10875528abc3ea65c16e3a01c60cea7fe604e0d65ac182c82bf2baddfcaea9becbd51ae59', 31, 1, 'MyApp', '[]', 0, '2019-05-31 09:06:15', '2019-05-31 09:06:15', '2020-05-31 14:36:15'),
('8f9214a2ed32dd4fb2e568853bccdfb50b64327ac7769a6c7b88534b9f4e7fcd40ffcce935d4753a', 79, 1, 'MyApp', '[]', 0, '2019-06-10 00:16:50', '2019-06-10 00:16:50', '2020-06-10 05:46:50'),
('91866c0682951a42e28f9c0582bba7eae264e7054ccd94ffce5307dc11d5c25c5198d05a4f578bb6', 38, 1, 'MyApp', '[]', 0, '2019-05-17 09:56:21', '2019-05-17 09:56:21', '2020-05-17 15:26:21'),
('9255cefe656791f5e62927965be903a64081810afa9a1b8c6ec9867c46fe069aa5dc67e4965118d3', 79, 1, 'castle', '[]', 0, '2019-06-10 09:23:47', '2019-06-10 09:23:47', '2020-06-10 14:53:47'),
('930c40ff8b8d62166014322de3b0db093f451d42320082cdc7df0c1ba740dae6ea0814ef20567ea5', 46, 1, 'castle', '[]', 0, '2019-06-06 04:01:29', '2019-06-06 04:01:29', '2020-06-06 09:31:29'),
('941515de14131e0bf2c5e9d1c01c4621fed4368cfa0b542e1119bb6933d02bbc44584864d5650cb5', 28, 1, 'castle', '[]', 0, '2019-06-02 23:31:08', '2019-06-02 23:31:08', '2020-06-03 05:01:08'),
('94a342ce3f64a7be0a093279a67823fbacd38d5d9b73837abe941b3f3edf5b5bfd4363e4155679d3', 25, 1, 'castle', '[]', 0, '2019-05-31 02:28:07', '2019-05-31 02:28:07', '2020-05-31 07:58:07'),
('958e1c34e460a4a574292538cfeac710b3a4b68faae2dbd1f9ff5051ee9f06be22878116a10a6062', 15, 1, 'castle', '[]', 0, '2019-05-17 05:40:46', '2019-05-17 05:40:46', '2020-05-17 11:10:46'),
('95dbb50e5487119939a0b01f050bf06bef4adde5cd01ba0a7f498f332773d791bc2f0765b42e7139', 1, 1, 'castle', '[]', 0, '2019-05-28 09:58:26', '2019-05-28 09:58:26', '2020-05-28 15:28:26'),
('96f1b2f335840dd3463a83eb22beb1e31ee1e53a7bacff002727bfea00092f445cef2862152e691f', 54, 1, 'MyApp', '[]', 0, '2019-05-22 00:17:49', '2019-05-22 00:17:49', '2020-05-22 05:47:49'),
('98b820f67220f2518ebe6051271c3cc423e3a8bd8a2a2a7a89c6747d8336cc284c1a17d0a1b922d8', 2, 1, 'castle', '[]', 0, '2019-05-17 05:13:42', '2019-05-17 05:13:42', '2020-05-17 10:43:42'),
('9936bbd641d3dd6779a47b712deced0656e25c49959406307c7b4563794bb1a0fb7e6ed50a1cc7cd', 36, 1, 'castle', '[]', 0, '2019-06-05 05:11:10', '2019-06-05 05:11:10', '2020-06-05 10:41:10'),
('994dc4ed358e2c1304744cafa8c49dd6521bb3fd186fb0f39a5818837c05f7354a0d32bbb8054f5c', 15, 1, 'MyApp', '[]', 0, '2019-05-30 07:03:27', '2019-05-30 07:03:27', '2020-05-30 12:33:27'),
('9a4703b74243c4d6e17e6525719f3ee23b57df0e55267a1d58e74ab2120bdf5a82bbb6fac86b7d86', 22, 1, 'MyApp', '[]', 0, '2019-05-17 09:23:07', '2019-05-17 09:23:07', '2020-05-17 14:53:07'),
('9b2e8984bedba3d1969ed9ef68bfdbfa7a8bdc07ab7eb54d8b09499bb601564eb2ee83bd25ea84f7', 16, 1, 'castle', '[]', 0, '2019-05-30 07:10:02', '2019-05-30 07:10:02', '2020-05-30 12:40:02'),
('9c93abc3174299dbd3129c8ace71a5fdfe7d46f455a3b04e697b27354a22e1813989586e1b2c1c2a', 49, 1, 'castle', '[]', 0, '2019-06-06 08:51:13', '2019-06-06 08:51:13', '2020-06-06 14:21:13'),
('9de916f22a8844c564e495b08000cd8d26bb877e9b8ef226cd164eb5fbe7ab704a50c121e27a9b1d', 52, 1, 'MyApp', '[]', 0, '2019-05-22 00:16:42', '2019-05-22 00:16:42', '2020-05-22 05:46:42'),
('a04fb6900c657a800c8381769938719901a02ca4b75d19b29ee1f6b66974044616abe9239c83af68', 80, 1, 'castle', '[]', 0, '2019-06-11 06:21:38', '2019-06-11 06:21:38', '2020-06-11 11:51:38'),
('a131960b8efd438b2447324cc18a4d487eb85942780fc0ee6bf7a744d86700526232b76f2f31d449', 28, 1, 'castle', '[]', 0, '2019-06-04 05:02:41', '2019-06-04 05:02:41', '2020-06-04 10:32:41'),
('a17c1a37d78cfca2bb0fc9498b36b79fbb33fa383bf9975e3ccf991ec27dc6e149081b4d859323f5', 55, 1, 'castle', '[]', 0, '2019-06-07 00:34:39', '2019-06-07 00:34:39', '2020-06-07 06:04:39'),
('a3eaa9c9c1bdd2a6a84782bd1d82c386a0ea16c82dcbb3938d1bb4ca19f1c0172a8cce763bad4f8e', 33, 1, 'castle', '[]', 0, '2019-06-04 05:09:57', '2019-06-04 05:09:57', '2020-06-04 10:39:57'),
('a5336c9d3b699602f307cbb4f9d9db9b190aa7d11e0247686b759fd425d147d648ef906e3c9071b2', 33, 1, 'MyApp', '[]', 0, '2019-05-17 09:47:40', '2019-05-17 09:47:40', '2020-05-17 15:17:40'),
('a5a76966aa3b0bd507298695fa4e98d58030cafb39899038be8744a5d1701257760840e57970d9c8', 49, 1, 'castle', '[]', 0, '2019-06-06 23:35:37', '2019-06-06 23:35:37', '2020-06-07 05:05:37'),
('a6b72b9a036f3226024537afef8de215890c290ff7a1c847882e5ada251127cf21d3de3f54b0fac6', 43, 1, 'MyApp', '[]', 0, '2019-05-17 10:08:15', '2019-05-17 10:08:15', '2020-05-17 15:38:15'),
('a7e61b2299191e3cf07890584c61b1632fafc65d0d65f0ad8a99366437b2bd131a4de557a7be9a9b', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:49', '2019-05-22 00:20:49', '2020-05-22 05:50:49'),
('a8e6362414cce05c290153709e80782c2a9adf1671956bc07aec5a8ac403cbde030f2971b369dcef', 58, 1, 'MyApp', '[]', 0, '2019-05-23 02:43:36', '2019-05-23 02:43:36', '2020-05-23 08:13:36'),
('a915e6c9dbc529c8b019f166cfd05c940b2fcaf4ba3f71b32639e490c036a66ce008318afce746ee', 47, 1, 'MyApp', '[]', 0, '2019-05-22 00:13:51', '2019-05-22 00:13:51', '2020-05-22 05:43:51'),
('a950d9c193ba116861caf3ac75945d4be06592c04da2344849633c303711e942d3619e3c10184b91', 80, 1, 'castle', '[]', 0, '2019-06-11 06:29:06', '2019-06-11 06:29:06', '2020-06-11 11:59:06'),
('a964d2a81cd248eaa8cc742aae676d12439bb946c4f3a5d1feae21bd2f45e172b2aff13425032735', 28, 1, 'castle', '[]', 0, '2019-06-05 04:07:22', '2019-06-05 04:07:22', '2020-06-05 09:37:22'),
('aac07be5e0bed5926c32c3437b00b7b18c82de22c4c94463e1b26d68e8f18ae0424f13fce2e996e3', 28, 1, 'castle', '[]', 0, '2019-06-04 06:10:51', '2019-06-04 06:10:51', '2020-06-04 11:40:51'),
('aafaee09180bad9fd937f6077554a9c1cdf6484b993774e61f059ff6b8bacafd8bdea6b6725d6167', 53, 1, 'MyApp', '[]', 0, '2019-06-06 23:09:18', '2019-06-06 23:09:18', '2020-06-07 04:39:18'),
('ab192d46627efc8d8074351a8778f1e5e14e882fd4eaef3137effb7f1266dfc86eb4708119e019f6', 28, 1, 'MyApp', '[]', 0, '2019-05-17 09:40:11', '2019-05-17 09:40:11', '2020-05-17 15:10:11'),
('ade3551050da35d887cb2a92dc21b1c6ab84623ee7dcdda1e0b108d39b25dead6b20a123a6420445', 28, 1, 'castle', '[]', 0, '2019-06-04 00:05:35', '2019-06-04 00:05:35', '2020-06-04 05:35:35'),
('adeaa7f3963446b7a6524f196ed53475e5359b47642010fc5ef453f1098ff0c27fceac765bb84282', 68, 1, 'MyApp', '[]', 0, '2019-06-07 04:25:09', '2019-06-07 04:25:09', '2020-06-07 09:55:09'),
('ae3aabf5701923ef37bb6fe82afbb5c330708e59125c9a444f8c03e5bd4eaedb6cd842a25826f00e', 31, 1, 'castle', '[]', 0, '2019-06-06 02:09:06', '2019-06-06 02:09:06', '2020-06-06 07:39:06'),
('ae54f3ac377ee2bf5f7f848239159befb1d5a6225a10c9cb5b416b6ad3388d13893659c171ed3506', 1, 1, 'castle', '[]', 0, '2019-05-28 10:13:01', '2019-05-28 10:13:01', '2020-05-28 15:43:01'),
('af120fe54ad3d803230252dbb6f1ed37d4fb9313f763676a7eff0cf340ecae2db9d558a5e46dbbeb', 72, 1, 'MyApp', '[]', 0, '2019-06-07 04:31:40', '2019-06-07 04:31:40', '2020-06-07 10:01:40'),
('af6442d7aaddec99fe43d4dfca755e2983f5037eb9b91e1aae726a4071948125e2302ee40f62a6ce', 36, 1, 'MyApp', '[]', 0, '2019-05-17 09:52:20', '2019-05-17 09:52:20', '2020-05-17 15:22:20'),
('b0b136787e34e42d1a96ade894f84a650c23cb0c5dc667a948694d5c90f1aa79ec7d65207f6e984f', 80, 1, 'MyApp', '[]', 0, '2019-06-10 23:28:55', '2019-06-10 23:28:55', '2020-06-11 04:58:55'),
('b0dc156ec823113ed7e3d1b18f5f21fa81ec7598d1e3cefbc75e3b1ec8522de86ae85e85b80f1149', 30, 1, 'MyApp', '[]', 0, '2019-05-17 09:43:55', '2019-05-17 09:43:55', '2020-05-17 15:13:55'),
('b1e1efa7f03b328f8e7f24179f0eea9ec3437351c01798b24a3ec72cbdf9e193a6d14abe449371e9', 1, 1, 'castle', '[]', 0, '2019-05-28 06:32:50', '2019-05-28 06:32:50', '2020-05-28 12:02:50'),
('b2262295a552eeebc36f5500d16c299c14754a3f377a61aa4b7789af9a02c96512e55930c0f9e924', 30, 1, 'castle', '[]', 0, '2019-05-31 07:48:48', '2019-05-31 07:48:48', '2020-05-31 13:18:48'),
('b22e7ab15bfc74cd06f11a996ad146eb2197632dafa62b32db23693b2f55fbe208aa1e25754aa243', 80, 1, 'castle', '[]', 0, '2019-06-11 07:30:45', '2019-06-11 07:30:45', '2020-06-11 13:00:45'),
('b375bb2efde6f03f44092826918f2ffc213eed4dd5c096d3c8832f2319ecc35962195cb3164a6115', 73, 1, 'MyApp', '[]', 0, '2019-06-07 04:33:17', '2019-06-07 04:33:17', '2020-06-07 10:03:17'),
('b5b7c17064c3e15bd78630b59ffae7eff0c7326ef16ba43025a06175c132a38754a56653d116e2ea', 47, 1, 'castle', '[]', 0, '2019-06-06 05:24:58', '2019-06-06 05:24:58', '2020-06-06 10:54:58'),
('b5f45436bcb6761fe63a753e33bc5ddc0cfd9dc093471e659485424bc0dcd8025033c4d3019290b1', 1, 1, 'castle', '[]', 0, '2019-05-27 02:25:59', '2019-05-27 02:25:59', '2020-05-27 07:55:59'),
('b682465b5e91a0b987740c67fbe8d9cbdec093f6cab44e01ccfeb8e6423a8940a819ca022571481b', 21, 1, 'MyApp', '[]', 0, '2019-05-17 09:22:43', '2019-05-17 09:22:43', '2020-05-17 14:52:43'),
('b68f41e6d7813ea2f97b2697b4c9ba0a97f7efcd31edb199cb61c85ae317a4d3f84cd7219b859942', 24, 1, 'MyApp', '[]', 0, '2019-05-17 09:33:57', '2019-05-17 09:33:57', '2020-05-17 15:03:57'),
('b6ab146d06b48ec15df4042e7304b737acde1d3dfc9f31980a88acac6d1d80df7ff599102973d89a', 36, 1, 'castle', '[]', 0, '2019-06-05 05:11:25', '2019-06-05 05:11:25', '2020-06-05 10:41:25'),
('b6e1e196f028dbe01246bed59abe2f85be18b72fea6e99c842cd9af761bb1d054a6b2840b59eee41', 60, 1, 'MyApp', '[]', 0, '2019-06-07 02:49:39', '2019-06-07 02:49:39', '2020-06-07 08:19:39'),
('b7450dcd24221ac9efb44c07ddeb8c76e5c4e7d90a766cce34364b1899717ddeb210140e5ce22d2e', 1, 1, 'MyApp', '[]', 0, '2019-05-23 02:58:04', '2019-05-23 02:58:04', '2020-05-23 08:28:04'),
('ba0bf44b156e404d38e6cb0316f9cadc3e81634471602a9410f1c36b6878b391129765a33e4a09e2', 28, 1, 'castle', '[]', 0, '2019-06-05 01:23:33', '2019-06-05 01:23:33', '2020-06-05 06:53:33'),
('ba65c7481a1a64bb24f0d10a1ae377df10d74267695d2d2866393c39e974edc62de424072a44d6d9', 51, 1, 'MyApp', '[]', 0, '2019-05-22 00:16:14', '2019-05-22 00:16:14', '2020-05-22 05:46:14'),
('ba91aabbad49db38d7c980243aaacc5bb761c02000545d4a46c07dccb0b58031b1eaa2fa60c1b666', 52, 1, 'MyApp', '[]', 0, '2019-06-06 08:58:01', '2019-06-06 08:58:01', '2020-06-06 14:28:01'),
('bbb749566230531fcf0a29b5104805e4e6edcb2bd19d51dcf4dd7eb41da9f179f8f8949039616ddc', 48, 1, 'castle', '[]', 0, '2019-06-06 05:21:24', '2019-06-06 05:21:24', '2020-06-06 10:51:24'),
('bc1ba8c945ae6729b5028ec3475ff31017f08e28e4722f150680cbb8612fd740da69a66c4f88148b', 44, 1, 'castle', '[]', 0, '2019-05-17 10:11:42', '2019-05-17 10:11:42', '2020-05-17 15:41:42'),
('bc6a632efec75521e7cdf79e01dbe5206ba0b14710bf63994faa6374d73d4872625fd2a60bd0ea4e', 28, 1, 'castle', '[]', 0, '2019-06-04 05:52:10', '2019-06-04 05:52:10', '2020-06-04 11:22:10'),
('bde68a1767b99888335c0eb4e86255b7285db7786739c05f0880ea11aec596db83a3a5bb5e1fa89e', 74, 1, 'MyApp', '[]', 0, '2019-06-07 04:34:14', '2019-06-07 04:34:14', '2020-06-07 10:04:14'),
('beb16b0c803b2de0bc0638a69ff48ce7cd379757b93e14a13fe75448846c1584de85b567bfa6416e', 75, 1, 'MyApp', '[]', 0, '2019-06-07 04:35:03', '2019-06-07 04:35:03', '2020-06-07 10:05:03'),
('c121c7576315e6131ccf73e870b1a2d452c5edff49693ce7612134a7a6c826fe7cea3558df4c754e', 57, 1, 'MyApp', '[]', 0, '2019-05-23 02:36:17', '2019-05-23 02:36:17', '2020-05-23 08:06:17'),
('c1299f6c74b6ea90b2e5d018564134bba7571e4bf03184bdb6b1f74cd3531d9ddecb468c2275cb16', 25, 1, 'MyApp', '[]', 0, '2019-05-17 09:34:25', '2019-05-17 09:34:25', '2020-05-17 15:04:25'),
('c3aa0caab511b8d5dc06974ff64967b77f1740fcc85904d55f44f5aad31d7adfae449e5bc6c69396', 79, 1, 'castle', '[]', 0, '2019-06-10 03:02:19', '2019-06-10 03:02:19', '2020-06-10 08:32:19'),
('c457294dc8335b06e5c996fa1b9836a426ada837604f7a372b63d89c3f8ad83033925ab027276335', 4, 1, 'castle', '[]', 0, '2019-05-24 05:37:06', '2019-05-24 05:37:06', '2020-05-24 11:07:06'),
('c4797cdf11b78f21196417ef26b6600f577d0657e67f780962d9b9b7ce939fe4da941755840398c5', 55, 1, 'castle', '[]', 0, '2019-06-06 23:58:14', '2019-06-06 23:58:14', '2020-06-07 05:28:14'),
('c53d7796f50cbc3775ff032ebae28cc7292b4d6d6acbbef889022a95408d723d46e95c782c977c8e', 55, 1, 'castle', '[]', 0, '2019-06-07 00:10:06', '2019-06-07 00:10:06', '2020-06-07 05:40:06'),
('c59c7f69b59b116e36145561d4d853011b38393eea85ce7f1e85c7230be3fc45fb93d9b638ae3155', 41, 1, 'MyApp', '[]', 0, '2019-05-17 10:03:15', '2019-05-17 10:03:15', '2020-05-17 15:33:15'),
('c6ebbef3a582d55a0f697aeb001016e920c9ef4eee97f303412cfeeb32ccee394d77e1ed16a233ae', 17, 1, 'MyApp', '[]', 0, '2019-05-17 08:59:35', '2019-05-17 08:59:35', '2020-05-17 14:29:35'),
('c8b33572f8ca44913621d322a04113fad339c45374325f6cecb2b5e4b5c81ac3edead49859a563cc', 2, 1, 'castle', '[]', 0, '2019-05-31 00:29:57', '2019-05-31 00:29:57', '2020-05-31 05:59:57'),
('c8e2eda7e1ac586ea2bca57f89f61874964fa5bdf9c0cbec7fd21d4dfe56b115516288d45b8ab538', 30, 1, 'castle', '[]', 0, '2019-05-31 08:22:22', '2019-05-31 08:22:22', '2020-05-31 13:52:22'),
('c8efe03c485ba2354e1e194b40e6972bf1f61a8bc8a1244a763c24fa6f4aa309163b3ef762bcbb45', 33, 1, 'castle', '[]', 0, '2019-06-04 06:45:44', '2019-06-04 06:45:44', '2020-06-04 12:15:44'),
('ca6c794efd9987f63ca8d11ada273353d549cb1d2cbff56f6019637493e5d5b17324834fcf3f3b46', 49, 1, 'MyApp', '[]', 0, '2019-05-22 00:14:38', '2019-05-22 00:14:38', '2020-05-22 05:44:38'),
('cb34b8e8fdd12e0d29714da8b9a285a0b1d11d3053b47a402adfaaea39df37a6546f57b75daa8995', 4, 1, 'castle', '[]', 0, '2019-05-27 05:16:37', '2019-05-27 05:16:37', '2020-05-27 10:46:37'),
('cb9f3db57cc330c3fe1bcce63f868aa2188cdcd36ff485dacaa6cf7a89a63e448eabe9ae92897338', 37, 1, 'MyApp', '[]', 0, '2019-06-06 01:28:55', '2019-06-06 01:28:55', '2020-06-06 06:58:55'),
('cc71a21753d5643d3b9953c4333d7f71960f51bb83b3889e8ba2c7b0652cad11d41d24059fba9983', 50, 1, 'castle', '[]', 0, '2019-06-09 23:34:31', '2019-06-09 23:34:31', '2020-06-10 05:04:31'),
('cc9b698cd0e7d75738da5c9019e690c58fa859c029689db2d57ac31358068a21d1c6c2685d4f0a4f', 3, 1, 'castle', '[]', 0, '2019-05-28 07:42:56', '2019-05-28 07:42:56', '2020-05-28 13:12:56'),
('cf84854197ed3803d4c7ec664afe0fbac6aa5a2c104f054bcaa8e16052c590a2128167a6ab04e0a0', 31, 1, 'MyApp', '[]', 0, '2019-05-17 09:44:55', '2019-05-17 09:44:55', '2020-05-17 15:14:55'),
('cfa8bb65f49a0cb11041bf7c9ae8cfaaa83584830d090fbed88c360ace2a677c3d7e4fdfdda176b0', 14, 1, 'MyApp', '[]', 0, '2019-05-30 06:47:30', '2019-05-30 06:47:30', '2020-05-30 12:17:30'),
('cfd4eaa644b1497b549feaf3e71184b60b74d07ef3581ed307dc4b6b127df1b793ae0015d8e012ad', 18, 1, 'MyApp', '[]', 0, '2019-05-31 01:33:48', '2019-05-31 01:33:48', '2020-05-31 07:03:48'),
('d0f060c8ebfc18d648940b529924b1f07cd7de910f2719b7c59cd10f559fe85b33b28c4495c3b71a', 45, 1, 'MyApp', '[]', 0, '2019-06-06 02:49:43', '2019-06-06 02:49:43', '2020-06-06 08:19:43'),
('d2632c9696171239b3615a0f4ade3717eaf678be6c480f8148d7a1c318a81054a6691c6c7720f725', 51, 1, 'MyApp', '[]', 0, '2019-06-06 08:24:43', '2019-06-06 08:24:43', '2020-06-06 13:54:43'),
('d2ae001f681ae853cd1372ce2eb76e1b0fc0e03d22cbed40cdba1fd85b5673e00647e1f42fe98b98', 17, 1, 'MyApp', '[]', 0, '2019-05-31 01:31:27', '2019-05-31 01:31:27', '2020-05-31 07:01:27'),
('d32294e807ec728db687b39d97653a12cc7f09a1cd7c02d39a883f00533e0713def8f21d006dc143', 47, 1, 'castle', '[]', 0, '2019-06-06 05:58:20', '2019-06-06 05:58:20', '2020-06-06 11:28:20'),
('d404cfb25e3553344173b0b0905bfacd308a116ecca140c4dc606919ee30eedcb881c518257a0fe2', 46, 1, 'castle', '[]', 0, '2019-05-22 04:33:38', '2019-05-22 04:33:38', '2020-05-22 10:03:38'),
('d4c26e783672696e68c6527b82b5a2781ccd409f9c68c942373d1bd9e3c635fd34c8f34de558e448', 42, 1, 'MyApp', '[]', 0, '2019-05-17 10:03:27', '2019-05-17 10:03:27', '2020-05-17 15:33:27'),
('d8e1208e568d1ebae637c90ca6bc2f09527bfa9a3c965352524b85e40617a8654b1a37c754aab081', 50, 1, 'castle', '[]', 0, '2019-06-07 07:47:44', '2019-06-07 07:47:44', '2020-06-07 13:17:44'),
('d99ab4ef0fef481041900da043973767bc2cfebe436ad3830d827ded52d9b7859b7d9d755eafb40e', 50, 1, 'MyApp', '[]', 0, '2019-05-22 00:15:22', '2019-05-22 00:15:22', '2020-05-22 05:45:22'),
('db30d7c5f8a3cdc647cc5f693b8e29a9139ed01e9bb0c2dc2e79d9a6df134165a28e5049e97c9642', 32, 1, 'MyApp', '[]', 0, '2019-05-17 09:47:25', '2019-05-17 09:47:25', '2020-05-17 15:17:25'),
('dbb17b6c67ed1b53a597f3856432dadf192ac0de30da7ef1432095e7732b4fe67c8a98a7912df167', 30, 1, 'castle', '[]', 0, '2019-05-31 08:07:40', '2019-05-31 08:07:40', '2020-05-31 13:37:40'),
('dc1bb6793f1c941572505b8dcca8540fc87a2106b812556299a8d6fb4c0b6c124c16c2499c1817a0', 33, 1, 'castle', '[]', 0, '2019-06-04 06:52:59', '2019-06-04 06:52:59', '2020-06-04 12:22:59'),
('dc504b45ea315c18c706e743d90f74fdde6673e11776f2d71fba6dbd67046478561db5ca44defdad', 38, 1, 'MyApp', '[]', 0, '2019-06-06 02:02:03', '2019-06-06 02:02:03', '2020-06-06 07:32:03'),
('dd0b3d3772636a67f90c302fc65b58985592e4ff6ccf775c6c43c5e1348f28d5faa9542c90aa07e4', 3, 1, 'castle', '[]', 0, '2019-05-28 06:57:19', '2019-05-28 06:57:19', '2020-05-28 12:27:19'),
('dd918cbc808da87debc80156ea6b6c703be5b2796c187bd3b022bdc0d868172ccb85270e527cfc1e', 46, 1, 'MyApp', '[]', 0, '2019-06-06 03:53:40', '2019-06-06 03:53:40', '2020-06-06 09:23:40'),
('de2160bc2cee766cf686b2da1ad2a78b53057f334727e6168a3f01f7b23fdee79b52bee014438626', 81, 1, 'MyApp', '[]', 0, '2019-06-11 06:43:23', '2019-06-11 06:43:23', '2020-06-11 12:13:23'),
('dfcb06422a244aa5296bca4f9521c4e14bb7ae7eac71d48788061637b07b86b85b17e72b3ed3c2dc', 1, 1, 'castle', '[]', 0, '2019-05-28 06:32:15', '2019-05-28 06:32:15', '2020-05-28 12:02:15'),
('e01501b090c3c02fbad2eb880679c0a29acb697fb3b2d11dfbde55ada6c92c7549461c625f32f974', 28, 1, 'castle', '[]', 0, '2019-06-04 02:33:45', '2019-06-04 02:33:45', '2020-06-04 08:03:45'),
('e425d2f8472c01bd7bd2086ff348035c0e9595f2a68a8b80b252e681974056f07fea3c70ece4914a', 18, 1, 'MyApp', '[]', 0, '2019-05-17 08:59:45', '2019-05-17 08:59:45', '2020-05-17 14:29:45'),
('e4a142716e05a14bd91cd7fab11c13728cabee40d2a17e32b7efe055432dc4dc117f407389b77c83', 3, 1, 'castle', '[]', 0, '2019-05-28 07:41:45', '2019-05-28 07:41:45', '2020-05-28 13:11:45'),
('e55be85f2546d0533ae072a13d48f624bfaa5e10f4e59683ab280023b772a71d91f838bf40fa405a', 71, 1, 'MyApp', '[]', 0, '2019-06-07 04:31:06', '2019-06-07 04:31:06', '2020-06-07 10:01:06'),
('e61e23c481a6ff5981814e2bc0818c673c4c5997ffa8852a2c4f18519ec4e849f42c2214deffa319', 26, 1, 'castle', '[]', 0, '2019-05-31 04:47:15', '2019-05-31 04:47:15', '2020-05-31 10:17:15'),
('e68e5a53ad376acfd11f7e25fce38336185253e956b6f081c5ca723e3d2a19dd46f6406088804314', 50, 1, 'castle', '[]', 0, '2019-06-08 08:58:08', '2019-06-08 08:58:08', '2020-06-08 14:28:08'),
('e7af7701511df4f1acebb9e491c26100df00e57f29ee55822427461303801090777b06fe033ac508', 50, 1, 'castle', '[]', 0, '2019-06-08 09:17:49', '2019-06-08 09:17:49', '2020-06-08 14:47:49'),
('e81b8e8eebe5a7468bca0cfe8a2a4934b907ac4e7074f43656b2546c934dbda8f2e45a0c0e4fe54f', 1, 1, 'castle', '[]', 0, '2019-05-27 01:23:59', '2019-05-27 01:23:59', '2020-05-27 06:53:59'),
('e902384f78083952243ff9781b6ff3c26c0acd59821dcc2e6e383bff7e1400c27be85bec492af389', 40, 1, 'MyApp', '[]', 0, '2019-05-17 09:58:07', '2019-05-17 09:58:07', '2020-05-17 15:28:07'),
('ead0940d147da546440b46ae6904a842385044a0157698fb43c21ce4df2b9fb8f5611bcb45a18637', 61, 1, 'MyApp', '[]', 0, '2019-05-23 02:54:56', '2019-05-23 02:54:56', '2020-05-23 08:24:56'),
('eba97202ab86b995ece0794e284652fabb0fcf497216a1f4cb7d7f35cad99856af437008fee903d2', 79, 1, 'castle', '[]', 0, '2019-06-10 08:45:30', '2019-06-10 08:45:30', '2020-06-10 14:15:30'),
('ef9998fb71def2d5af4652e391358e6c1c366cfaaa33646f256656fa0e284111330c29863190ead5', 80, 1, 'castle', '[]', 0, '2019-06-10 23:56:19', '2019-06-10 23:56:19', '2020-06-11 05:26:19'),
('f09c5f33a25a1385ef6d993c330770fd5c1ac5b2e98258df949f51f906a30e2888e9055cae612d80', 2, 1, 'MyApp', '[]', 0, '2019-05-23 03:01:20', '2019-05-23 03:01:20', '2020-05-23 08:31:20'),
('f287bbf54e49a9f9e0275c9a49bcb132eb59b6aa3266bff97e2997af10c97c59f9f6833212081401', 79, 1, 'castle', '[]', 0, '2019-06-10 02:37:29', '2019-06-10 02:37:29', '2020-06-10 08:07:29'),
('f2e1173e55907817c300ff85acde7a8caed4f718e9134eb9210c2df8df340ec649fde5979fd85685', 30, 1, 'castle', '[]', 0, '2019-05-31 08:20:19', '2019-05-31 08:20:19', '2020-05-31 13:50:19'),
('f32f9e6709fe300d7430d3146b01d3306e10083e160aaf6e08629bd434a8d7661260a7c5f4cf00f6', 1, 1, 'castle', '[]', 0, '2019-05-27 02:13:05', '2019-05-27 02:13:05', '2020-05-27 07:43:05'),
('f33c311bea137160e63aba9dcd3b3d85c88e2bf0d612900997c7ae4d1ef17a71f8b842192aee0cc4', 50, 1, 'castle', '[]', 0, '2019-06-08 01:17:33', '2019-06-08 01:17:33', '2020-06-08 06:47:33'),
('f38e8a8046911e0a662a480b0629df5522bd8221f64f82db3bd3ea2431729654b415da8cd3f9051a', 3, 1, 'castle', '[]', 0, '2019-05-28 06:44:58', '2019-05-28 06:44:58', '2020-05-28 12:14:58'),
('f4e91f2877774643761633912eaaf89f1795e8946862af4bea063d440614e90a6110d6ccd1fc9548', 50, 1, 'castle', '[]', 0, '2019-06-07 23:48:51', '2019-06-07 23:48:51', '2020-06-08 05:18:51'),
('f55e10e87e2acf4a5ac1d905ecb83d86e225e8cc1613ac779199670e113d1309f8013102eb773086', 49, 1, 'MyApp', '[]', 0, '2019-06-06 05:26:57', '2019-06-06 05:26:57', '2020-06-06 10:56:57'),
('f5b8363e538f256d3704b911226b85aed24001b2cae513a8002db5aacd5b3adbd8d25e4835343e77', 70, 1, 'MyApp', '[]', 0, '2019-06-07 04:28:22', '2019-06-07 04:28:22', '2020-06-07 09:58:22');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('f7c4af89e6c51c5226e3ca0ac380c5108b9c10118fbd4cee1fdc96af26314d7cecb66671d609fb8d', 11, 1, 'MyApp', '[]', 0, '2019-05-28 23:43:18', '2019-05-28 23:43:18', '2020-05-29 05:13:18'),
('f929999b58144b08100e0ad79171a28fdce7df8d267adec183e2c6e4afeb1979d7a6fc1b4b099564', 56, 1, 'MyApp', '[]', 0, '2019-05-23 02:14:46', '2019-05-23 02:14:46', '2020-05-23 07:44:46'),
('fa17a15e74e0b687c1c038f6ec7f6571c84ba159d5cfe9996ee1dca9e02a91627ef5b4ccc21eb188', 46, 1, 'castle', '[]', 0, '2019-05-21 04:05:14', '2019-05-21 04:05:14', '2020-05-21 09:35:14'),
('fa42ee74e90311968e5fbd902e723c0fbf628bd5ca42fc0a9e4ac7aac8ad59cfed9d03103f3a4ecb', 1, 1, 'castle', '[]', 0, '2019-05-28 06:27:19', '2019-05-28 06:27:19', '2020-05-28 11:57:19'),
('fa54d57d0ddba12c669baf7f19a34e6cf829d97b211ff9bee9f085238ff92e4c01ed9f354cfed1d7', 3, 1, 'castle', '[]', 0, '2019-05-28 06:34:59', '2019-05-28 06:34:59', '2020-05-28 12:04:59'),
('fa88e554cc8e7af3b2198a7d7f12e0cb6ac616efeafc85b12ca74680b06e4313403b737034e28331', 1, 1, 'castle', '[]', 0, '2019-05-27 02:24:03', '2019-05-27 02:24:03', '2020-05-27 07:54:03'),
('fb04063b5c59553b6c0c06772767bae32395889a49e33ef3191736cfce5317ec88bf2a8c230de184', 50, 1, 'castle', '[]', 0, '2019-06-08 03:27:19', '2019-06-08 03:27:19', '2020-06-08 08:57:19'),
('fb371f11c4acbe567030cb92f7bb924e5aaff099bccb076d446e788d00af3f503940dfa11be34dfd', 6, 1, 'MyApp', '[]', 0, '2019-05-27 01:57:36', '2019-05-27 01:57:36', '2020-05-27 07:27:36'),
('fb4e6f04392e694b32f7e61a57975a6198366bef77348fb7faf425c66f284909dfa1a1363ebfb62f', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:02', '2019-05-22 00:23:02', '2020-05-22 05:53:02'),
('fc30a9d9f4c6c3e046a5b4cd2f432286f79f384b1798a0c65db1551cc93db57263b50490ff72663a', 46, 1, 'MyApp', '[]', 0, '2019-05-21 04:03:00', '2019-05-21 04:03:00', '2020-05-21 09:33:00'),
('fd2d191793e061a4dd58ce4e61609140068d8b37c7e26e3f1ee93e20c8073fb7b4f003458973294c', 26, 1, 'castle', '[]', 0, '2019-05-31 04:37:31', '2019-05-31 04:37:31', '2020-05-31 10:07:31'),
('fd404e53b8d5879b916670bed2159bb612d7b4e05b1a4c54fcf14f03da100c29694435c0866a5e1b', 2, 1, 'castle', '[]', 0, '2019-05-28 07:28:06', '2019-05-28 07:28:06', '2020-05-28 12:58:06'),
('fd40de64c397f41e024f959239d417ea6842ee3e0395def97c8682cdd2cdee1e67110e231ebaa616', 51, 1, 'castle', '[]', 0, '2019-06-06 08:25:10', '2019-06-06 08:25:10', '2020-06-06 13:55:10'),
('fd882b22953a5b7f8da1b0d5a2273d37d9f7116bffbf3251429a4a8e6d73d72a43816a94341efefc', 16, 1, 'castle', '[]', 0, '2019-05-30 07:15:50', '2019-05-30 07:15:50', '2020-05-30 12:45:50'),
('fdfe253c70f9d1c3f2fde21b7fb83deff34e8e1d456caa60fb31a22e7edae09e2e68cfd0b656fe07', 12, 1, 'castle', '[]', 0, '2019-05-30 06:34:07', '2019-05-30 06:34:07', '2020-05-30 12:04:07'),
('fe2ae5814ad0630d4efada40f7dd0ccf5cd944293bfaa5a9fdde53ab8660e5f5bdc0b4eced837051', 22, 1, 'MyApp', '[]', 0, '2019-05-31 01:54:03', '2019-05-31 01:54:03', '2020-05-31 07:24:03'),
('fe5c865f7c72777842837ab2d6c41a82d80f8a7bc4e5b2a53f398155a83680c36a945497d32d21fe', 36, 1, 'castle', '[]', 0, '2019-06-05 08:04:55', '2019-06-05 08:04:55', '2020-06-05 13:34:55'),
('ff30fe31c2159d58db63305c028e0a29502430f059a4084d0805ce715f5db19ea1139c6f9f79a25b', 37, 1, 'MyApp', '[]', 0, '2019-05-17 09:55:44', '2019-05-17 09:55:44', '2020-05-17 15:25:44'),
('ff663b326d54579515df3117f0b9620bca241776b993fe44d50c674ff476fbe2dd0a7e88a0f62848', 4, 1, 'castle', '[]', 0, '2019-05-26 23:03:58', '2019-05-26 23:03:58', '2020-05-27 04:33:58'),
('ffda75feb552bbe145bd7ab809d0502ec9a44b795e1ff267816e63af96882706e66649fabf23dead', 50, 1, 'castle', '[]', 0, '2019-06-09 23:02:55', '2019-06-09 23:02:55', '2020-06-10 04:32:55'),
('fff8fd35eab055fb1a0c8ddc6b946ad41c34bf39da4ca39b2aba0bde09380fa2b2813383efcc7048', 80, 1, 'castle', '[]', 0, '2019-06-11 06:05:23', '2019-06-11 06:05:23', '2020-06-11 11:35:23');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'H7twWecU9H5dLURPtZrEQ2AFDbmjPErzOtJKIVaV', 'http://localhost', 1, 0, 0, '2019-05-15 07:08:23', '2019-05-15 07:08:23'),
(2, NULL, 'Laravel Password Grant Client', 'JxbCCJwaWddy5q2yVetZaG9d3uqPkpaaYFM7vYY6', 'http://localhost', 0, 1, 0, '2019-05-15 07:08:23', '2019-05-15 07:08:23');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-05-15 07:08:23', '2019-05-15 07:08:23');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`, `updated_at`) VALUES
('mohit@gmail.com', 'ubmhLMDFmH', '2019-06-11 08:29:16', '2019-06-11 08:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(2, 'browse_bread', NULL, '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(3, 'browse_database', NULL, '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(4, 'browse_media', NULL, '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(5, 'browse_compass', NULL, '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(6, 'browse_menus', 'menus', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(7, 'read_menus', 'menus', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(8, 'edit_menus', 'menus', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(9, 'add_menus', 'menus', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(10, 'delete_menus', 'menus', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(11, 'browse_roles', 'roles', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(12, 'read_roles', 'roles', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(13, 'edit_roles', 'roles', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(14, 'add_roles', 'roles', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(15, 'delete_roles', 'roles', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(16, 'browse_users', 'users', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(17, 'read_users', 'users', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(18, 'edit_users', 'users', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(19, 'add_users', 'users', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(20, 'delete_users', 'users', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(21, 'browse_settings', 'settings', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(22, 'read_settings', 'settings', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(23, 'edit_settings', 'settings', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(24, 'add_settings', 'settings', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(25, 'delete_settings', 'settings', '2019-05-17 07:08:33', '2019-05-17 07:08:33'),
(26, 'browse_hooks', NULL, '2019-05-17 07:08:36', '2019-05-17 07:08:36');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `feed_product_type` text,
  `item_sku` text,
  `brand_name` text,
  `item_name` text,
  `external_product_id` text,
  `external_product_id_type` text,
  `manufacturer` text,
  `item_type` varchar(255) DEFAULT NULL,
  `unit_count` int(11) DEFAULT NULL,
  `unit_count_type` varchar(100) DEFAULT NULL,
  `standard_price` decimal(10,0) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `update_delete` varchar(100) DEFAULT NULL,
  `main_image_url` varchar(255) DEFAULT NULL,
  `other_image_url1` varchar(255) DEFAULT NULL,
  `other_image_url2` varchar(255) DEFAULT NULL,
  `other_image_url3` varchar(255) DEFAULT NULL,
  `product_description` text,
  `bullet_point1` varchar(255) DEFAULT NULL,
  `bullet_point2` varchar(255) DEFAULT NULL,
  `bullet_point3` varchar(255) DEFAULT NULL,
  `bullet_point4` varchar(255) DEFAULT NULL,
  `bullet_point5` varchar(255) DEFAULT NULL,
  `color_name` text,
  `is_adult_product` varchar(20) DEFAULT NULL,
  `product_for` varchar(100) DEFAULT NULL,
  `exclusive` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `feed_product_type`, `item_sku`, `brand_name`, `item_name`, `external_product_id`, `external_product_id_type`, `manufacturer`, `item_type`, `unit_count`, `unit_count_type`, `standard_price`, `quantity`, `update_delete`, `main_image_url`, `other_image_url1`, `other_image_url2`, `other_image_url3`, `product_description`, `bullet_point1`, `bullet_point2`, `bullet_point3`, `bullet_point4`, `bullet_point5`, `color_name`, `is_adult_product`, `product_for`, `exclusive`, `created_at`, `updated_at`) VALUES
(99, 'healthmisc', 'END8INBLK', 'Enduro', 'Enduro 8Inch Dildo - Realistic Head And Veins, Waterproof, Easy To Clean (Black)', '707676016815', 'UPC', 'Enduro', 'dildos', 1, 'Count', '40', 636, 'Update', 'https://www.castlemegastore.com/amz/707676016815.jpg', NULL, NULL, NULL, 'Be astonished by the pleasure the Enduro 8in dildo will give you! Realistic head and veins will trick you into thinking that it is the real thing. The curve of the dildo will help hit that g-spot. All Enduro products are body-safe and phthalate-free. Will you endure the Enduro?', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Black', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(100, 'healthmisc', 'PASSSWIRBLU', 'Passions', 'Passions Swirl Vibe Blue', '707676044153', 'UPC', 'Passions', 'vibrators', 1, 'Count', '23', 636, 'Update', 'https://www.castlemegastore.com/amz/707676044368.jpg', NULL, NULL, NULL, 'If you’ve been looking for a slick, versatile vibe that’s up for anything you are, look no further than the Swirl from the celebrated Passions collection. A discreet but effective design takes the guesswork out of stimulating multiple erogenous zones to perfection. A powerful motor and multi-speed operation ensure orgasms are always on the menu for you and your partner.\n• Made of slick, seamless ABS that feels wonderful against your most intimate sweet spots.\n• At just 7 inches long, the Swirl is big enough to get the job done, but small enough to take on the go without a second thought.\n• A tapered tip and undulating shaft work to awaken every last nerve ending.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Blue', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(101, 'healthmisc', 'JPDONGBLU', 'Jelly Pleasures', 'Jelly Pleasures Dong - 7 Inch, Anti-Bacterial Formula, Stimulating Texture And Feel (Blue)', '707676044351', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 624, 'Update', 'https://www.castlemegastore.com/amz/707676044351.jpg', NULL, NULL, NULL, 'Jelly Pleasures has mastered the art of dongs. This 7.5\" dong is perfect for anyone\'s toy chest. \n\n- Body-safe material.\n\n- Anti-bacterial formula makes it safe and easy to clean.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Blue', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(102, 'healthmisc', 'JPDONGPNK', 'Jelly Pleasures', 'Jelly Pleasures Dong - Soft And Flexible, Body-Safe, Stimulating Texture (Pink)', '707676044320', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 622, 'Update', 'https://www.castlemegastore.com/amz/707676044320.jpg', NULL, NULL, NULL, 'Bring the excitement of the bedroom to all new levels with the Jelly Pleasures 7\" Dong. No toy chest is complete without a great dong.\n\n- Stimulating Texture and feel, for that realistic feel.\n\n- Soft and Flexible\n\n- Made from body-safe and Phthalate free PVC.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Pink', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(103, 'healthmisc', 'PRETTYPAPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Hypoallergenic Body-Safe, Waterproof, Easy To Clean', '707676016747', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 619, 'Update', 'https://www.castlemegastore.com/amz/707676016747.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Plum', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(104, 'healthmisc', 'FPPDUWHBULL', 'Fetish Pleasure Play', 'Dual Glow-In-The-Dark Bullet Vibe (White)', '707676044375', 'UPC', 'Fetish Pleasure Play', 'vibrators', 1, 'Count', '20', 616, 'Update', 'https://www.castlemegastore.com/amz/707676044375.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'White', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(105, 'healthmisc', 'FPPSIL3RINGENH', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone 3Ring Penis And Balls Enchancer', '707676049479', 'UPC', 'Fetish Pleasure Play', 'penis-rings', 1, 'Count', '10', 615, 'Update', 'https://www.castlemegastore.com/amz/707676049479.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(106, 'healthmisc', 'CONNEZRELRNG', 'Connecto', 'Connecto Easy Release Double Cock Ring Set (Black)', '707676036363', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '13', 612, 'Update', 'https://www.castlemegastore.com/amz/707676036363.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove double ring from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(107, 'healthmisc', 'JWBLUBOY3WAY', 'Junkwear', 'Junkwear Blue Boy 3Way Penis Ring For Enhanced Erections', '707676043996', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 605, 'Update', 'https://www.castlemegastore.com/amz/707676043996.jpg', NULL, NULL, NULL, 'The JunkWear 3-way ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(108, 'healthmisc', 'PPANPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Easy To Use Body-Safe Anal Sex Toy (Pink)', '707676016730', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 540, 'Update', 'https://www.castlemegastore.com/amz/707676016730.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', 'him', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(109, 'healthmisc', 'JWBLKB3WAYRING', 'Junkwear', 'Junkwear Black Beauty 3 Way Erection Enhancing Penis Ring', '707676043958', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 527, 'Update', 'https://www.castlemegastore.com/amz/707676043958.jpg', NULL, NULL, NULL, 'The JunkWear Black Beauty 3 Way ring design is stretchy and comfortable TPR erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-way ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(110, 'healthmisc', 'VELRATTBLK', 'Velskin', 'Velskin Rattler Vibrator - Perfect Waterproof Silicone Made Vibrating Sex Toy (Black)', '707676018482', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '50', 515, 'Update', 'https://www.castlemegastore.com/amz/707676018482.jpg', NULL, NULL, NULL, 'All Velskin products are made from our superior proprietary blend of 100% Vel-Ultra premium silicone. Experience the amazing touch, feel and quality of Velskin. All Velskin products are phthalate free, body safe, hypoallergenic and environmentally friendly.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Black', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(111, 'healthmisc', 'MRABBDACER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Daisy  - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060351', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060351.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Daisy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(112, 'healthmisc', 'MWMAPRBALL', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits April Ballet Slipper - Waterproof Platinum Cured Silicone Massager (Purple)', '707676060368', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060368.jpg', NULL, NULL, NULL, 'April comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(113, 'healthmisc', 'MWMMRLUCYCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Lucy - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060375', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '85', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060375.jpg', NULL, NULL, NULL, 'Lucy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(114, 'healthmisc', 'MWMMRMOLCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Molly - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060382', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060382.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Molly comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(115, 'healthmisc', 'MWMMRMAECER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Mae - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676065226', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676065226.jpg', NULL, NULL, NULL, 'Mighty Rabbits pack power into a fun bunny shape! Fully rechargeable and easy to use. \n\nMae\'s dual clit stimulator is soft and flexible to hit all your hot spots? Mae also features fast gyrating technology for extra intense orgasms!\n\nThis rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(116, 'healthmisc', 'HPMEDPLUG', 'Hot Pinks', 'Hot Pinks Medium Butt Plug - Easy To Clean, Perfect For Anal Sex Beginners (Pink)', '707676016709', 'UPC', 'Hot Pinks', 'butt-plugs', 1, 'Count', '20', 496, 'Update', 'https://www.castlemegastore.com/amz/707676016709.jpg', NULL, NULL, NULL, 'A tapered, rounded tip slides in easily, while the 4\" graduated shaft gives a sensually filling experience. The narrow neck and oval base are comfortable to wear, and the flat base allows for hot solo play.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(117, 'healthmisc', 'JKICYHDUORING', 'Junkwear', 'Junkwear Icy Hot Duo Penis Ring - Ball Stretcher Made Of Body-Safe Material (Transparent)', '707676044016', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 489, 'Update', 'https://www.castlemegastore.com/amz/707676044016.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(118, 'healthmisc', 'BLUEANGSTRO', 'Blue Angel', 'Blue Angel Stroker - Body-Safe Pussy Masturbator (Blue)', '707676018888', 'UPC', 'Blue Angel', 'male-masturbators', 1, 'Count', '25', 487, 'Update', 'https://www.castlemegastore.com/amz/707676018888.jpg', NULL, NULL, NULL, 'A great choice for solo pleasure, the Blue Angel Masturbator gives you a feeling like some of the higher end toys out there, for a much more reasonable price. The soft, smooth and stretchy jelly rubber warms to the touch as you enjoy, and the small size makes it easy to hold in hand, where you can squeeze it until the 4 rows of silver rolling beads are gripping and massaging you as tight as you like.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Blue', 'her', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(119, 'healthmisc', 'CWPLEASPEARLR', 'Cware', 'Cware Pleasure Pearl Penis Ring - Durable, Versatile, Adjustable, Made Of Silicone', '707676044023', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '15', 472, 'Update', 'https://www.castlemegastore.com/amz/707676044023.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Green', 'couples', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(120, 'healthmisc', 'CONNEZRELCAG', 'Connecto', 'Connecto Easy Release Cock Cage - Customizable, Easy To Clean And Release (Black)', '707676036349', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '15', 470, 'Update', 'https://www.castlemegastore.com/amz/707676036349.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove cage from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'couples', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(121, 'healthmisc', 'FPPNEONVIBEPNK', 'Passions', 'Passions Neon Classic Mini Vibe - Body-Safe, Multi-Speed, Waterproof Pink', '707676044078', 'UPC', 'Passions', 'vibrators', 1, 'Count', '15', 457, 'Update', 'https://www.castlemegastore.com/amz/707676044078.jpg', NULL, NULL, NULL, 'Passions Neon Classic Mini Vibe', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Waterproof', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Pink', 'couples', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(122, 'healthmisc', 'VELSPECOBROWN', 'Velskin', 'Velskin Pecos Dildo - Body-Safe Silicone, Harness Compatible, Lifetime Warranty (Brown)', '707676018390', 'UPC', 'Velskin', 'dildos', 1, 'Count', '100', 456, 'Update', 'https://www.castlemegastore.com/amz/707676018390.jpg', NULL, NULL, NULL, 'This Velskin Pecos Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-ultra silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Brown', 'couples', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(123, 'healthmisc', 'BLACKFURLEGCUFF', 'Fetish Pleasure Play', 'Fetish Pleasure Play Furry Ankle Cuffs - Metal And Faux Fur Black', '707676001378', 'UPC', 'Fetish Pleasure Play', 'restraints', 1, 'Count', '29', 434, 'Update', 'https://www.castlemegastore.com/amz/707676001378.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'One size fits most', 'Keys included', 'fetish sex toys, restraints, handcuffs, fetish play toys', 'Black', 'couples', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(124, '', '', 'Bangkok Ballbuster', 'Bangkok Ballbuster Vagina Masturbator For Men (Pink)', '707676018925', 'UPC', 'Bangkok Ballbuster', 'male-masturbators', 1, 'Count', '15', 431, 'Update', 'https://www.castlemegastore.com/amz/707676018925.jpg', NULL, NULL, NULL, 'Soft, tight, and stretchy masturbator. Textured pleasure chamber with closed end for enhanced suction. Maintenance free TPR.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Pink', 'fetish', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(125, 'healthmisc', 'VELSLONGRIDBLK', 'Velskin', 'Velskin Long Rider Penis Extender - Silicone, Lifetime Warranty, Hypoallergenic (Black)', '707676018352', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '120', 428, 'Update', 'https://www.castlemegastore.com/amz/707676018352.jpg', NULL, NULL, NULL, 'It\'s the little things that make a big difference. Velskin brings this long rider penis extension to enhance your natural penis size. Apply a little water-based lube to your penis and the toy\'s canal, slide your penis inside and stretch the base of the toy over your balls, for a secure fit.\n\nSometimes it’s fine to enjoy yourself exactly the way Mother Nature made you, but every so often it’s fun to spice things up a little in the size department. The Long Rider penis extender from Velskin makes it easy to experience what a difference a little size boost can really make.\n•Made of Velskin’s own ultra-soft, lifelike silicone. Warms to the touch and perfectly mimics the feeling of real skin.\n•Makes you noticeably thicker and longer. Also desensitizes you just enough to help you go the distance.\n•Try it with a little of your favorite water-based lube for an even better experience!', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', 'fetish', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(126, 'healthmisc', '', 'Junkwear', 'Junkwear Stretch Flex Clear Penis Ring And Ball Stretcher', '707676044047', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '7', 426, 'Update', 'https://www.castlemegastore.com/amz/707676044047.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Transparent', 'fetish', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(127, 'healthmisc', 'PASSREDTICKL', '', 'Passions Kiss Lover Mini Vibrator - Body-Safe, Seamless Design, G-Spot Stimulation (Red)', '707676044108', 'UPC', 'Passions', 'vibrators', 1, 'Count', '20', 423, 'Update', 'https://www.castlemegastore.com/amz/707676044108.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'G-spot stimulation', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Red', 'fetish', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(128, 'healthmisc', 'PEARLESMEDPLUGPNK', 'Pearlescent', 'Pearlescent Medium Butt Plug - Perfect Anal Sex Toy (Pink)', '707676016693', 'UPC', 'Pearlescent', 'butt-plugs', 1, 'Count', '20', 420, 'Update', 'https://www.castlemegastore.com/amz/707676016693pearlescent-medium-bp.jpg', NULL, NULL, NULL, 'A little shine to stimulate your behind! Pearlescent\'s Butt Plug is smooth with a tapered shape ideal for first-time insertion. This plug is a small slim size for comfortable anal stimulation. The plug is firm but very flexible. Introduce a partner to the joys of mild anal stimulation. It is made from phthalate-free body safe material.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', 'fetish', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(129, 'healthmisc', 'NWBELLNIPPCLAMPS', 'Nipple Wear', 'Nipple Wear Bell Nipple Clamps - Adjustable, Rubber Tips, Made Of Metal (Black)', '707676018963', 'UPC', 'Nipple Wear', 'ball-stretchers', 1, 'Count', '13', 412, 'Update', 'https://www.castlemegastore.com/amz/707676018963.jpg', NULL, NULL, NULL, 'Who says a pair of nipple clamps can’t be beautiful, appealing, and effective? This strong, sexy pair is positively mesmerizing in its simplicity. Tough, stainless steel alligator clamps support a pair of black, twinkling bells to add visual and auditory appeal to your next play session.\n• Classic alligator clamps are fully adjustable to make achieving the ideal degree of pressure easy.\n• Medical grade stainless steel and tough, body-safe rubber tips make these clamps as safe, strong, and practical as they are fun to use.\n• Pretty, black bells lend a sexy, sassy touch to any fetish look or bedroom ensemble.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Waterproof', 'male sex toys, ball stretchers, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(130, 'healthmisc', 'VELSBENDALEXFLSH', 'Velskin', 'Velskin Bendable Alexandria Dildo - Harness Compatible, Bendable Spine, Lifetime Warranty', '707676046027', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 407, 'Update', 'https://www.castlemegastore.com/amz/707676046027.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nFind out what a difference a little flexibility really makes when you make this bendable Velskin dildo a part of your collection. Ample proportions, premium dual-density silicone, and a bevy of stimulating details add even more pleasure to your experience.\n• With an insertable length of 9 inches and a girth of 4.75 inches, this toy really fills you up to capacity.\n• Dual-density silicone design almost perfectly mimics the real thing – hard on the inside and soft on the outside.\n• Bendable and flexible. Customize each play experience according to mood, position, activity, and more.\n• Full harness compatibility makes engaging in satisfying partnered play easy.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(131, 'healthmisc', 'CWTRISUPPRNG', 'Cware', 'Cware Tri-Support Penis Ring Set - Body-Safe Silicone, Versatile, Durable (White)', '707676043927', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 395, 'Update', 'https://www.castlemegastore.com/amz/707676043927.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The C & B ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(132, 'healthmisc', 'VELSCLINTIVOR', 'Velskin', 'Velskin Clint Ivory Dildo - Vel-Ultra Silicone, Harness Compatible, G-Spot And P-Spot Stimulation', '707676018673', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 390, 'Update', 'https://www.castlemegastore.com/amz/707676018673.jpg', NULL, NULL, NULL, 'Velskin\'s Ivory Clint Dildo is ultra realistic and great for first time fun! With it\'s lifelike head for a natural feel, it has a curved shaft for precise G-Spot or P-spot stimulation! Made of 100% Vel-Ultra silicone and is harness compatible.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Ivory', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(133, 'healthmisc', 'VELSAUSTFLESH', 'Velskin', 'Velskin Austin Flesh Dildo - Vel-Ultra Silicone, Harness Compatible, Lifetime Warranty', '707676018710', 'UPC', 'Velskin', 'dildos', 1, 'Count', '45', 388, 'Update', 'https://www.castlemegastore.com/amz/707676018710.jpg', NULL, NULL, NULL, 'This Velskin Austin Flesh Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-Ultra Silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(134, 'healthmisc', 'VELSSTALLBLK', 'Velskin', 'Velskin Stallion Penis Extender - Body-Safe Silicone, Hypoallergenic, Easy To Clean (Black)', '707676018260', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '130', 381, 'Update', 'https://www.castlemegastore.com/amz/707676018260.jpg', NULL, NULL, NULL, 'Enjoy longer lovemaking in every way as this black stallion extender from Velskin desensitizes you for prolonged session. It stays comfortably in place throughout lovemaking and offers you extra control to help tame your beast.\n\nWith the incredible Velskin Stallion in your corner, there’s no limit to your ability to curl your partner’s toes in bed. Add inches to your natural physique, regain total control over your orgasm, and treat your partner to additional stimulation to boot.\n• Made of premium sculpted silicone – body-safe, hypoallergenic, and phthalate-free.\n• Desensitizes you just enough to help you last as long as you like. Perfect for controlling premature ejaculation!\n• Noticeably increases your length and girth. Sculpted, lifelike design brings even more stimulation to the table for your partner. \n• Protected by a lifetime warranty.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(135, 'healthmisc', 'VELSBENDJULIETFLS', 'Velskin', 'Velskin Bendable Juliette Flesh Dildo - Body-Safe Silicone, Easy To Clean, Hypoallergenic', '707676046010', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 373, 'Update', 'https://www.castlemegastore.com/amz/707676046010.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\n- Made from 100% body-safe silicone, which makes it easier to clean and hypoallergenic.\n\n- Constructed out of dual density silicone, which makes for a firm inner core and a soft, realistic feeling outer coat.\n\n- With a bendable spine, makes this dildo able to bend to your pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(136, 'healthmisc', 'CWARGNDDUORNG', 'Cware', 'Cware Premium Silicone Penis Rings (White)', '707676043903', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 366, 'Update', 'https://www.castlemegastore.com/amz/707676043903.jpg', NULL, NULL, NULL, 'The CWARE duo ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', 'lingerie', 1, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(137, 'healthmisc', 'MWMINIBLU', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Silicone Head, Body-Safe, Batteries Included (Blue)', '707676019557', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 362, 'Update', 'https://www.castlemegastore.com/amz/707676019557-mw-mini-blue.jpg', NULL, NULL, NULL, 'If you love the power and performance of the original Mighty Wand, you\'ll definitely want to get up close and personal with the Mighty Wand Mini as well. Enjoy the same toe-curling sensation and versatility you\'ve come to love in a compact, streamlined package that\'s easy to take along absolutely anywhere.\n• Measures in at 4.25\" with a 4\" head circumference making it easy to include in a suitcase, purse or overnight bag.\n• Made from ABS plastic and features a smooth, inviting silicone head -- body-safe, easy to care for, and capable of providing phenomenal sensation.\n• Pretty blue color and jeweled accents make this vibe as lovely to look at as it is fun to use.\n• Batteries already included!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Blue', 'lingerie', 1, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(138, 'healthmisc', 'HOOKNALTPNKPLUG', 'Hook N\' Up', 'Hooknup Beaded Silicone Anal Plug (Pink)', '707676044207', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 361, 'Update', 'https://www.castlemegastore.com/amz/hook n up_707676044207_4.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_1.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_2.jpg', 'https://www.castlemegastore.com/amz/hooknup_707676044207_3.jpg', 'Tired of the normal style of butt plugs? Well then try the Hook \'N\' Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% silicone, which makes it easy to clean and is hypoallergenic.\n\n- Revolutionary beaded design helps bring your anal play to a new level', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', 'lingerie', 1, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(139, 'healthmisc', 'VELSSADDPURPL', 'Velskin', 'Velskin Saddlehorn Wand Attachment (Purple)', '707676018529', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '60', 358, 'Update', 'https://www.castlemegastore.com/amz/707676018529.jpg', NULL, NULL, NULL, 'Velskin\'s Saddlehorn wand attachment will bring you into bliss. This all silicone attachment is smooth and has an amazing tip to reach that g-spot.\n\nIf you love the sheer oomph a wand massager brings to the table, but occasionally find yourself in the mood for more targeted stimulation, this saddlehorn-style Velskin attachment was made with you in mind. It fits right over the head of your favorite wand massager, instantly converting it into a pinpoint-accurate G-spot or P-spot stimulator.\n• Made of Velskin’s own ultra-smooth, body-safe silicone for an experience that treats your body right on every level.\n• Fits a variety of popular wand massagers including Bodywand, Magic Wand, and Mighty Wand.\n• Perfect for taking solo play to the next level, but ideal for treating a partner to a “happy ending” massage as well.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Premium Silicone', 'Magic Wand Rechargeable', 'sex toy accessories, magic wand accessories, magic wand attachments, silicone sex toys', 'Purple', 'lingerie', 1, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(140, 'healthmisc', 'CWAREEASTRINGPURP', 'Cware', 'Cware Elastomer Penis Ring - Ultra Flex, Stretchy, Latex Free (Purple)', '707676016297', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 356, 'Update', 'https://www.castlemegastore.com/amz/707676016297.jpg', NULL, NULL, NULL, 'Cock rings work by restricting blood flow out of your cock. Placing this stretchy ring at the base of your cock and balls will help make your erection even bigger and veinier. It\'s a simple stretchy cock ring that gets the job done.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(141, 'healthmisc', 'ANALISANBEADVIBE', 'Analiscious', 'Analiscious Anal Beaded Vibrator - Body-Safe, Waterproof, Multi-Speed (Purple)', '707676016631', 'UPC', 'Analiscious', 'anal-beads', 1, 'Count', '23', 353, 'Update', 'https://www.castlemegastore.com/amz/707676016631.jpg', NULL, NULL, NULL, 'For ultimate anal enjoyment, Analiscious Beaded Anal Vibrator will hit the spot every time. This sturdy strand of waterproof beads has a straight, precise design with vibration that resonates throughout for even stimulation and perfect pleasure. The slightly flexible beaded body has 4 beads that graduate in size, staring small and ending larger, with smooth, thinner areas in between for lots of sensation when inserting and removing. Multi-speed vibration is controlled with a simple twist dial at the base, which also has a wrist cord to keep the Beads close as you play. Takes 2 AAA batteries, sold separately.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'Multi-speed', 'anal sex toys, anal beads, anal vibrators, anal vibrating toys, vibrating anal beads', 'Pink', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(142, 'healthmisc', 'FPPSILTHINSPANK', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone Thin Spank Slapper (Black)', '707676054077', 'UPC', 'Fetish Pleasure Play', 'paddles', 1, 'Count', '33', 353, 'Update', 'https://www.castlemegastore.com/amz/707676054077-01.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Hypoallergenic body-safe', 'Premium silicone', 'fetish sex toys, silicone sex toys, paddles, fetish play toys', 'Black', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(143, 'healthmisc', 'VELSBENDAMALFLSH', 'Velskin', 'Velskin Bendable Amal Flesh Dildo - Made Of Silicone, Harness Compatible, Bendable Spine', '707676046003', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 352, 'Update', 'https://www.castlemegastore.com/amz/707676046003.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nThis premium dual-density dildo from Velskin isn’t just second to none in the realism department. Thanks to a special bendable spine, you can adjust it to reflect any angle you like. Add creativity and variety to solo sessions and partnered play alike!\n• Dual-density silicone is velvety soft on the outside and deliciously hard on the inside.\n• Adjust the angle of your toy to better stimulate your sweet spots, explore new positions, and more.\n• Harness compatibility makes it easy to play with a partner exactly the way you want to.\n• Ample but realistic proportions and thoughtful texturing add realism to your experience.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(144, 'healthmisc', 'HOOKNALTSILBLU', 'Hook N\' Up', 'Hooknup Medical Grade Silicone Plug (Blue)', '707676045358', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 349, 'Update', 'https://www.castlemegastore.com/amz/hnu-707676045358-01.jpg', NULL, NULL, NULL, 'Tired of the normal style of butt plugs? Well then try the Hook \'N Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% medical grade silicone, which makes it easy to clean, take care of, and is hypoallergenic.\n\n- Revolutionary alternating beaded design helps bring your anal play to a new level.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Blue', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(145, 'healthmisc', 'CWTRIMETALRNG', 'Cware', 'Cware Tri Metal Ring Set', '707676016440', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '8', 348, 'Update', 'https://www.castlemegastore.com/amz/707676016440.jpg', NULL, NULL, NULL, 'A triple set of ultra sturdy, sleek and shiny metal cock rings from Spartacus, this advanced set is a step up from stretchy varieties, offering a more secure, unyielding feel for ultra impressive results and a fantastic look.', 'Discreet packaging', 'Easy to clean', 'Metal', 'Waterproof', 'Hypoallergenic body-safe', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(146, 'healthmisc', 'MWMMINIPURPL', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Portable, Travel-Friendly, Made Of Silicone (Purple)', '707676019564', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 346, 'Update', 'https://www.castlemegastore.com/amz/707676019564-mw-mini-purple.jpg', NULL, NULL, NULL, 'You already love wand vibrators like the Mighty Wand for the sheer versatility they bring to the table. Now you can take your creative pleasure sessions to even greater heights with the fabulous Mighty Wand Mini - all the power and oomph of the original, but in a convenient compact package.\n\n- Portable, travel-friendly size - 4.25\" in length with a 4\" head circumference.\n\n- Made of smooth, silky silicone and ABS plastic for an experience that not only feels great, but is completely body-safe as well.\n\n- Easy to clean and care for.\n\n- Looks fantastic as it functions with a flirty purple color scheme and jeweled accents.\n\n- Perfect for both solo sessions and partner play.\n\n- Batteries included.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Purple', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(147, 'healthmisc', 'CHAMP6INDILDMED', 'Champions', 'Champions 6 Inch Silicone Dildo Medalist - Harness Compatible, Suction Cup Base', '707676033942', 'UPC', 'Champions', 'dildos', 1, 'Count', '100', 335, 'Update', 'https://www.castlemegastore.com/amz/707676033942.jpg', NULL, NULL, NULL, 'Champions dildos are ultra premium pleasure silicone cocks that are handcrafted with amazing detail and feel. Experience Champions dual density silcione, the perfect combination of rigidity and softness. \"The Real Ride\" the perfection of pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(148, 'healthmisc', 'CWTRISUPPRINGSET', 'Cware', 'Cware Tri-Support Ring Set Black', '707676043910', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 334, 'Update', 'https://www.castlemegastore.com/amz/707676043910.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', 'lingerie', 0, '2019-06-10 10:20:41', '2019-06-10 10:20:41'),
(298, 'healthmisc', 'END8INBLK', 'Enduro', 'Enduro 8Inch Dildo - Realistic Head And Veins, Waterproof, Easy To Clean (Black)', '707676016815', 'UPC', 'Enduro', 'dildos', 1, 'Count', '40', 636, 'Update', 'https://www.castlemegastore.com/amz/707676016815.jpg', NULL, NULL, NULL, 'Be astonished by the pleasure the Enduro 8in dildo will give you! Realistic head and veins will trick you into thinking that it is the real thing. The curve of the dildo will help hit that g-spot. All Enduro products are body-safe and phthalate-free. Will you endure the Enduro?', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(299, 'healthmisc', 'PASSSWIRBLU', 'Passions', 'Passions Swirl Vibe Blue', '707676044153', 'UPC', 'Passions', 'vibrators', 1, 'Count', '23', 636, 'Update', 'https://www.castlemegastore.com/amz/707676044368.jpg', NULL, NULL, NULL, 'If you’ve been looking for a slick, versatile vibe that’s up for anything you are, look no further than the Swirl from the celebrated Passions collection. A discreet but effective design takes the guesswork out of stimulating multiple erogenous zones to perfection. A powerful motor and multi-speed operation ensure orgasms are always on the menu for you and your partner.\n• Made of slick, seamless ABS that feels wonderful against your most intimate sweet spots.\n• At just 7 inches long, the Swirl is big enough to get the job done, but small enough to take on the go without a second thought.\n• A tapered tip and undulating shaft work to awaken every last nerve ending.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Blue', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(300, 'healthmisc', 'JPDONGBLU', 'Jelly Pleasures', 'Jelly Pleasures Dong - 7 Inch, Anti-Bacterial Formula, Stimulating Texture And Feel (Blue)', '707676044351', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 624, 'Update', 'https://www.castlemegastore.com/amz/707676044351.jpg', NULL, NULL, NULL, 'Jelly Pleasures has mastered the art of dongs. This 7.5\" dong is perfect for anyone\'s toy chest. \n\n- Body-safe material.\n\n- Anti-bacterial formula makes it safe and easy to clean.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Blue', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(301, 'healthmisc', 'JPDONGPNK', 'Jelly Pleasures', 'Jelly Pleasures Dong - Soft And Flexible, Body-Safe, Stimulating Texture (Pink)', '707676044320', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 622, 'Update', 'https://www.castlemegastore.com/amz/707676044320.jpg', NULL, NULL, NULL, 'Bring the excitement of the bedroom to all new levels with the Jelly Pleasures 7\" Dong. No toy chest is complete without a great dong.\n\n- Stimulating Texture and feel, for that realistic feel.\n\n- Soft and Flexible\n\n- Made from body-safe and Phthalate free PVC.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12');
INSERT INTO `products` (`id`, `feed_product_type`, `item_sku`, `brand_name`, `item_name`, `external_product_id`, `external_product_id_type`, `manufacturer`, `item_type`, `unit_count`, `unit_count_type`, `standard_price`, `quantity`, `update_delete`, `main_image_url`, `other_image_url1`, `other_image_url2`, `other_image_url3`, `product_description`, `bullet_point1`, `bullet_point2`, `bullet_point3`, `bullet_point4`, `bullet_point5`, `color_name`, `is_adult_product`, `product_for`, `exclusive`, `created_at`, `updated_at`) VALUES
(302, 'healthmisc', 'PRETTYPAPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Hypoallergenic Body-Safe, Waterproof, Easy To Clean', '707676016747', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 619, 'Update', 'https://www.castlemegastore.com/amz/707676016747.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Plum', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(303, 'healthmisc', 'FPPDUWHBULL', 'Fetish Pleasure Play', 'Dual Glow-In-The-Dark Bullet Vibe (White)', '707676044375', 'UPC', 'Fetish Pleasure Play', 'vibrators', 1, 'Count', '20', 616, 'Update', 'https://www.castlemegastore.com/amz/707676044375.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'White', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(304, 'healthmisc', 'FPPSIL3RINGENH', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone 3Ring Penis And Balls Enchancer', '707676049479', 'UPC', 'Fetish Pleasure Play', 'penis-rings', 1, 'Count', '10', 615, 'Update', 'https://www.castlemegastore.com/amz/707676049479.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(305, 'healthmisc', 'CONNEZRELRNG', 'Connecto', 'Connecto Easy Release Double Cock Ring Set (Black)', '707676036363', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '13', 612, 'Update', 'https://www.castlemegastore.com/amz/707676036363.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove double ring from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(306, 'healthmisc', 'JWBLUBOY3WAY', 'Junkwear', 'Junkwear Blue Boy 3Way Penis Ring For Enhanced Erections', '707676043996', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 605, 'Update', 'https://www.castlemegastore.com/amz/707676043996.jpg', NULL, NULL, NULL, 'The JunkWear 3-way ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(307, 'healthmisc', 'PPANPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Easy To Use Body-Safe Anal Sex Toy (Pink)', '707676016730', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 540, 'Update', 'https://www.castlemegastore.com/amz/707676016730.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(308, 'healthmisc', 'JWBLKB3WAYRING', 'Junkwear', 'Junkwear Black Beauty 3 Way Erection Enhancing Penis Ring', '707676043958', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 527, 'Update', 'https://www.castlemegastore.com/amz/707676043958.jpg', NULL, NULL, NULL, 'The JunkWear Black Beauty 3 Way ring design is stretchy and comfortable TPR erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-way ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(309, 'healthmisc', 'VELRATTBLK', 'Velskin', 'Velskin Rattler Vibrator - Perfect Waterproof Silicone Made Vibrating Sex Toy (Black)', '707676018482', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '50', 515, 'Update', 'https://www.castlemegastore.com/amz/707676018482.jpg', NULL, NULL, NULL, 'All Velskin products are made from our superior proprietary blend of 100% Vel-Ultra premium silicone. Experience the amazing touch, feel and quality of Velskin. All Velskin products are phthalate free, body safe, hypoallergenic and environmentally friendly.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(310, 'healthmisc', 'MRABBDACER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Daisy  - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060351', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060351.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Daisy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(311, 'healthmisc', 'MWMAPRBALL', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits April Ballet Slipper - Waterproof Platinum Cured Silicone Massager (Purple)', '707676060368', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060368.jpg', NULL, NULL, NULL, 'April comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(312, 'healthmisc', 'MWMMRLUCYCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Lucy - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060375', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '85', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060375.jpg', NULL, NULL, NULL, 'Lucy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(313, 'healthmisc', 'MWMMRMOLCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Molly - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060382', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060382.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Molly comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(314, 'healthmisc', 'MWMMRMAECER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Mae - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676065226', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676065226.jpg', NULL, NULL, NULL, 'Mighty Rabbits pack power into a fun bunny shape! Fully rechargeable and easy to use. \n\nMae\'s dual clit stimulator is soft and flexible to hit all your hot spots? Mae also features fast gyrating technology for extra intense orgasms!\n\nThis rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(315, 'healthmisc', 'HPMEDPLUG', 'Hot Pinks', 'Hot Pinks Medium Butt Plug - Easy To Clean, Perfect For Anal Sex Beginners (Pink)', '707676016709', 'UPC', 'Hot Pinks', 'butt-plugs', 1, 'Count', '20', 496, 'Update', 'https://www.castlemegastore.com/amz/707676016709.jpg', NULL, NULL, NULL, 'A tapered, rounded tip slides in easily, while the 4\" graduated shaft gives a sensually filling experience. The narrow neck and oval base are comfortable to wear, and the flat base allows for hot solo play.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(316, 'healthmisc', 'JKICYHDUORING', 'Junkwear', 'Junkwear Icy Hot Duo Penis Ring - Ball Stretcher Made Of Body-Safe Material (Transparent)', '707676044016', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 489, 'Update', 'https://www.castlemegastore.com/amz/707676044016.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(317, 'healthmisc', 'BLUEANGSTRO', 'Blue Angel', 'Blue Angel Stroker - Body-Safe Pussy Masturbator (Blue)', '707676018888', 'UPC', 'Blue Angel', 'male-masturbators', 1, 'Count', '25', 487, 'Update', 'https://www.castlemegastore.com/amz/707676018888.jpg', NULL, NULL, NULL, 'A great choice for solo pleasure, the Blue Angel Masturbator gives you a feeling like some of the higher end toys out there, for a much more reasonable price. The soft, smooth and stretchy jelly rubber warms to the touch as you enjoy, and the small size makes it easy to hold in hand, where you can squeeze it until the 4 rows of silver rolling beads are gripping and massaging you as tight as you like.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Blue', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(318, 'healthmisc', 'CWPLEASPEARLR', 'Cware', 'Cware Pleasure Pearl Penis Ring - Durable, Versatile, Adjustable, Made Of Silicone', '707676044023', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '15', 472, 'Update', 'https://www.castlemegastore.com/amz/707676044023.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Green', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(319, 'healthmisc', 'CONNEZRELCAG', 'Connecto', 'Connecto Easy Release Cock Cage - Customizable, Easy To Clean And Release (Black)', '707676036349', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '15', 470, 'Update', 'https://www.castlemegastore.com/amz/707676036349.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove cage from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(320, 'healthmisc', 'FPPNEONVIBEPNK', 'Passions', 'Passions Neon Classic Mini Vibe - Body-Safe, Multi-Speed, Waterproof Pink', '707676044078', 'UPC', 'Passions', 'vibrators', 1, 'Count', '15', 457, 'Update', 'https://www.castlemegastore.com/amz/707676044078.jpg', NULL, NULL, NULL, 'Passions Neon Classic Mini Vibe', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Waterproof', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(321, 'healthmisc', 'VELSPECOBROWN', 'Velskin', 'Velskin Pecos Dildo - Body-Safe Silicone, Harness Compatible, Lifetime Warranty (Brown)', '707676018390', 'UPC', 'Velskin', 'dildos', 1, 'Count', '100', 456, 'Update', 'https://www.castlemegastore.com/amz/707676018390.jpg', NULL, NULL, NULL, 'This Velskin Pecos Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-ultra silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Brown', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(322, 'healthmisc', 'BLACKFURLEGCUFF', 'Fetish Pleasure Play', 'Fetish Pleasure Play Furry Ankle Cuffs - Metal And Faux Fur Black', '707676001378', 'UPC', 'Fetish Pleasure Play', 'restraints', 1, 'Count', '29', 434, 'Update', 'https://www.castlemegastore.com/amz/707676001378.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'One size fits most', 'Keys included', 'fetish sex toys, restraints, handcuffs, fetish play toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(323, 'healthmisc', 'BANGKBALLBUS', 'Bangkok Ballbuster', 'Bangkok Ballbuster Vagina Masturbator For Men (Pink)', '707676018925', 'UPC', 'Bangkok Ballbuster', 'male-masturbators', 1, 'Count', '15', 431, 'Update', 'https://www.castlemegastore.com/amz/707676018925.jpg', NULL, NULL, NULL, 'Soft, tight, and stretchy masturbator. Textured pleasure chamber with closed end for enhanced suction. Maintenance free TPR.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(324, 'healthmisc', 'VELSLONGRIDBLK', 'Velskin', 'Velskin Long Rider Penis Extender - Silicone, Lifetime Warranty, Hypoallergenic (Black)', '707676018352', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '120', 428, 'Update', 'https://www.castlemegastore.com/amz/707676018352.jpg', NULL, NULL, NULL, 'It\'s the little things that make a big difference. Velskin brings this long rider penis extension to enhance your natural penis size. Apply a little water-based lube to your penis and the toy\'s canal, slide your penis inside and stretch the base of the toy over your balls, for a secure fit.\n\nSometimes it’s fine to enjoy yourself exactly the way Mother Nature made you, but every so often it’s fun to spice things up a little in the size department. The Long Rider penis extender from Velskin makes it easy to experience what a difference a little size boost can really make.\n•Made of Velskin’s own ultra-soft, lifelike silicone. Warms to the touch and perfectly mimics the feeling of real skin.\n•Makes you noticeably thicker and longer. Also desensitizes you just enough to help you go the distance.\n•Try it with a little of your favorite water-based lube for an even better experience!', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(325, 'healthmisc', 'JWSTRETCHFLEXRNG', 'Junkwear', 'Junkwear Stretch Flex Clear Penis Ring And Ball Stretcher', '707676044047', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '7', 426, 'Update', 'https://www.castlemegastore.com/amz/707676044047.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Transparent', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(326, 'healthmisc', 'PASSREDTICKL', 'Passions', 'Passions Kiss Lover Mini Vibrator - Body-Safe, Seamless Design, G-Spot Stimulation (Red)', '707676044108', 'UPC', 'Passions', 'vibrators', 1, 'Count', '20', 423, 'Update', 'https://www.castlemegastore.com/amz/707676044108.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'G-spot stimulation', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Red', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(327, 'healthmisc', 'PEARLESMEDPLUGPNK', 'Pearlescent', 'Pearlescent Medium Butt Plug - Perfect Anal Sex Toy (Pink)', '707676016693', 'UPC', 'Pearlescent', 'butt-plugs', 1, 'Count', '20', 420, 'Update', 'https://www.castlemegastore.com/amz/707676016693pearlescent-medium-bp.jpg', NULL, NULL, NULL, 'A little shine to stimulate your behind! Pearlescent\'s Butt Plug is smooth with a tapered shape ideal for first-time insertion. This plug is a small slim size for comfortable anal stimulation. The plug is firm but very flexible. Introduce a partner to the joys of mild anal stimulation. It is made from phthalate-free body safe material.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(328, 'healthmisc', 'NWBELLNIPPCLAMPS', 'Nipple Wear', 'Nipple Wear Bell Nipple Clamps - Adjustable, Rubber Tips, Made Of Metal (Black)', '707676018963', 'UPC', 'Nipple Wear', 'ball-stretchers', 1, 'Count', '13', 412, 'Update', 'https://www.castlemegastore.com/amz/707676018963.jpg', NULL, NULL, NULL, 'Who says a pair of nipple clamps can’t be beautiful, appealing, and effective? This strong, sexy pair is positively mesmerizing in its simplicity. Tough, stainless steel alligator clamps support a pair of black, twinkling bells to add visual and auditory appeal to your next play session.\n• Classic alligator clamps are fully adjustable to make achieving the ideal degree of pressure easy.\n• Medical grade stainless steel and tough, body-safe rubber tips make these clamps as safe, strong, and practical as they are fun to use.\n• Pretty, black bells lend a sexy, sassy touch to any fetish look or bedroom ensemble.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Waterproof', 'male sex toys, ball stretchers, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(329, 'healthmisc', 'VELSBENDALEXFLSH', 'Velskin', 'Velskin Bendable Alexandria Dildo - Harness Compatible, Bendable Spine, Lifetime Warranty', '707676046027', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 407, 'Update', 'https://www.castlemegastore.com/amz/707676046027.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nFind out what a difference a little flexibility really makes when you make this bendable Velskin dildo a part of your collection. Ample proportions, premium dual-density silicone, and a bevy of stimulating details add even more pleasure to your experience.\n• With an insertable length of 9 inches and a girth of 4.75 inches, this toy really fills you up to capacity.\n• Dual-density silicone design almost perfectly mimics the real thing – hard on the inside and soft on the outside.\n• Bendable and flexible. Customize each play experience according to mood, position, activity, and more.\n• Full harness compatibility makes engaging in satisfying partnered play easy.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(330, 'healthmisc', 'CWTRISUPPRNG', 'Cware', 'Cware Tri-Support Penis Ring Set - Body-Safe Silicone, Versatile, Durable (White)', '707676043927', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 395, 'Update', 'https://www.castlemegastore.com/amz/707676043927.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The C & B ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(331, 'healthmisc', 'VELSCLINTIVOR', 'Velskin', 'Velskin Clint Ivory Dildo - Vel-Ultra Silicone, Harness Compatible, G-Spot And P-Spot Stimulation', '707676018673', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 390, 'Update', 'https://www.castlemegastore.com/amz/707676018673.jpg', NULL, NULL, NULL, 'Velskin\'s Ivory Clint Dildo is ultra realistic and great for first time fun! With it\'s lifelike head for a natural feel, it has a curved shaft for precise G-Spot or P-spot stimulation! Made of 100% Vel-Ultra silicone and is harness compatible.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Ivory', NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(332, 'healthmisc', 'VELSAUSTFLESH', 'Velskin', 'Velskin Austin Flesh Dildo - Vel-Ultra Silicone, Harness Compatible, Lifetime Warranty', '707676018710', 'UPC', 'Velskin', 'dildos', 1, 'Count', '45', 388, 'Update', 'https://www.castlemegastore.com/amz/707676018710.jpg', NULL, NULL, NULL, 'This Velskin Austin Flesh Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-Ultra Silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 10:49:12', '2019-06-10 10:49:12'),
(333, 'healthmisc', 'VELSSTALLBLK', 'Velskin', 'Velskin Stallion Penis Extender - Body-Safe Silicone, Hypoallergenic, Easy To Clean (Black)', '707676018260', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '130', 381, 'Update', 'https://www.castlemegastore.com/amz/707676018260.jpg', NULL, NULL, NULL, 'Enjoy longer lovemaking in every way as this black stallion extender from Velskin desensitizes you for prolonged session. It stays comfortably in place throughout lovemaking and offers you extra control to help tame your beast.\n\nWith the incredible Velskin Stallion in your corner, there’s no limit to your ability to curl your partner’s toes in bed. Add inches to your natural physique, regain total control over your orgasm, and treat your partner to additional stimulation to boot.\n• Made of premium sculpted silicone – body-safe, hypoallergenic, and phthalate-free.\n• Desensitizes you just enough to help you last as long as you like. Perfect for controlling premature ejaculation!\n• Noticeably increases your length and girth. Sculpted, lifelike design brings even more stimulation to the table for your partner. \n• Protected by a lifetime warranty.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(334, 'healthmisc', 'VELSBENDJULIETFLS', 'Velskin', 'Velskin Bendable Juliette Flesh Dildo - Body-Safe Silicone, Easy To Clean, Hypoallergenic', '707676046010', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 373, 'Update', 'https://www.castlemegastore.com/amz/707676046010.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\n- Made from 100% body-safe silicone, which makes it easier to clean and hypoallergenic.\n\n- Constructed out of dual density silicone, which makes for a firm inner core and a soft, realistic feeling outer coat.\n\n- With a bendable spine, makes this dildo able to bend to your pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(335, 'healthmisc', 'CWARGNDDUORNG', 'Cware', 'Cware Premium Silicone Penis Rings (White)', '707676043903', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 366, 'Update', 'https://www.castlemegastore.com/amz/707676043903.jpg', NULL, NULL, NULL, 'The CWARE duo ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(336, 'healthmisc', 'MWMINIBLU', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Silicone Head, Body-Safe, Batteries Included (Blue)', '707676019557', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 362, 'Update', 'https://www.castlemegastore.com/amz/707676019557-mw-mini-blue.jpg', NULL, NULL, NULL, 'If you love the power and performance of the original Mighty Wand, you\'ll definitely want to get up close and personal with the Mighty Wand Mini as well. Enjoy the same toe-curling sensation and versatility you\'ve come to love in a compact, streamlined package that\'s easy to take along absolutely anywhere.\n• Measures in at 4.25\" with a 4\" head circumference making it easy to include in a suitcase, purse or overnight bag.\n• Made from ABS plastic and features a smooth, inviting silicone head -- body-safe, easy to care for, and capable of providing phenomenal sensation.\n• Pretty blue color and jeweled accents make this vibe as lovely to look at as it is fun to use.\n• Batteries already included!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Blue', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(337, 'healthmisc', 'HOOKNALTPNKPLUG', 'Hook N\' Up', 'Hooknup Beaded Silicone Anal Plug (Pink)', '707676044207', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 361, 'Update', 'https://www.castlemegastore.com/amz/hook n up_707676044207_4.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_1.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_2.jpg', 'https://www.castlemegastore.com/amz/hooknup_707676044207_3.jpg', 'Tired of the normal style of butt plugs? Well then try the Hook \'N\' Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% silicone, which makes it easy to clean and is hypoallergenic.\n\n- Revolutionary beaded design helps bring your anal play to a new level', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(338, 'healthmisc', 'VELSSADDPURPL', 'Velskin', 'Velskin Saddlehorn Wand Attachment (Purple)', '707676018529', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '60', 358, 'Update', 'https://www.castlemegastore.com/amz/707676018529.jpg', NULL, NULL, NULL, 'Velskin\'s Saddlehorn wand attachment will bring you into bliss. This all silicone attachment is smooth and has an amazing tip to reach that g-spot.\n\nIf you love the sheer oomph a wand massager brings to the table, but occasionally find yourself in the mood for more targeted stimulation, this saddlehorn-style Velskin attachment was made with you in mind. It fits right over the head of your favorite wand massager, instantly converting it into a pinpoint-accurate G-spot or P-spot stimulator.\n• Made of Velskin’s own ultra-smooth, body-safe silicone for an experience that treats your body right on every level.\n• Fits a variety of popular wand massagers including Bodywand, Magic Wand, and Mighty Wand.\n• Perfect for taking solo play to the next level, but ideal for treating a partner to a “happy ending” massage as well.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Premium Silicone', 'Magic Wand Rechargeable', 'sex toy accessories, magic wand accessories, magic wand attachments, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(339, 'healthmisc', 'CWAREEASTRINGPURP', 'Cware', 'Cware Elastomer Penis Ring - Ultra Flex, Stretchy, Latex Free (Purple)', '707676016297', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 356, 'Update', 'https://www.castlemegastore.com/amz/707676016297.jpg', NULL, NULL, NULL, 'Cock rings work by restricting blood flow out of your cock. Placing this stretchy ring at the base of your cock and balls will help make your erection even bigger and veinier. It\'s a simple stretchy cock ring that gets the job done.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(340, 'healthmisc', 'ANALISANBEADVIBE', 'Analiscious', 'Analiscious Anal Beaded Vibrator - Body-Safe, Waterproof, Multi-Speed (Purple)', '707676016631', 'UPC', 'Analiscious', 'anal-beads', 1, 'Count', '23', 353, 'Update', 'https://www.castlemegastore.com/amz/707676016631.jpg', NULL, NULL, NULL, 'For ultimate anal enjoyment, Analiscious Beaded Anal Vibrator will hit the spot every time. This sturdy strand of waterproof beads has a straight, precise design with vibration that resonates throughout for even stimulation and perfect pleasure. The slightly flexible beaded body has 4 beads that graduate in size, staring small and ending larger, with smooth, thinner areas in between for lots of sensation when inserting and removing. Multi-speed vibration is controlled with a simple twist dial at the base, which also has a wrist cord to keep the Beads close as you play. Takes 2 AAA batteries, sold separately.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'Multi-speed', 'anal sex toys, anal beads, anal vibrators, anal vibrating toys, vibrating anal beads', 'Pink', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(341, 'healthmisc', 'FPPSILTHINSPANK', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone Thin Spank Slapper (Black)', '707676054077', 'UPC', 'Fetish Pleasure Play', 'paddles', 1, 'Count', '33', 353, 'Update', 'https://www.castlemegastore.com/amz/707676054077-01.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Hypoallergenic body-safe', 'Premium silicone', 'fetish sex toys, silicone sex toys, paddles, fetish play toys', 'Black', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(342, 'healthmisc', 'VELSBENDAMALFLSH', 'Velskin', 'Velskin Bendable Amal Flesh Dildo - Made Of Silicone, Harness Compatible, Bendable Spine', '707676046003', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 352, 'Update', 'https://www.castlemegastore.com/amz/707676046003.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nThis premium dual-density dildo from Velskin isn’t just second to none in the realism department. Thanks to a special bendable spine, you can adjust it to reflect any angle you like. Add creativity and variety to solo sessions and partnered play alike!\n• Dual-density silicone is velvety soft on the outside and deliciously hard on the inside.\n• Adjust the angle of your toy to better stimulate your sweet spots, explore new positions, and more.\n• Harness compatibility makes it easy to play with a partner exactly the way you want to.\n• Ample but realistic proportions and thoughtful texturing add realism to your experience.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(343, 'healthmisc', 'HOOKNALTSILBLU', 'Hook N\' Up', 'Hooknup Medical Grade Silicone Plug (Blue)', '707676045358', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 349, 'Update', 'https://www.castlemegastore.com/amz/hnu-707676045358-01.jpg', NULL, NULL, NULL, 'Tired of the normal style of butt plugs? Well then try the Hook \'N Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% medical grade silicone, which makes it easy to clean, take care of, and is hypoallergenic.\n\n- Revolutionary alternating beaded design helps bring your anal play to a new level.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Blue', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(344, 'healthmisc', 'CWTRIMETALRNG', 'Cware', 'Cware Tri Metal Ring Set', '707676016440', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '8', 348, 'Update', 'https://www.castlemegastore.com/amz/707676016440.jpg', NULL, NULL, NULL, 'A triple set of ultra sturdy, sleek and shiny metal cock rings from Spartacus, this advanced set is a step up from stretchy varieties, offering a more secure, unyielding feel for ultra impressive results and a fantastic look.', 'Discreet packaging', 'Easy to clean', 'Metal', 'Waterproof', 'Hypoallergenic body-safe', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', NULL, NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(345, 'healthmisc', 'MWMMINIPURPL', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Portable, Travel-Friendly, Made Of Silicone (Purple)', '707676019564', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 346, 'Update', 'https://www.castlemegastore.com/amz/707676019564-mw-mini-purple.jpg', NULL, NULL, NULL, 'You already love wand vibrators like the Mighty Wand for the sheer versatility they bring to the table. Now you can take your creative pleasure sessions to even greater heights with the fabulous Mighty Wand Mini - all the power and oomph of the original, but in a convenient compact package.\n\n- Portable, travel-friendly size - 4.25\" in length with a 4\" head circumference.\n\n- Made of smooth, silky silicone and ABS plastic for an experience that not only feels great, but is completely body-safe as well.\n\n- Easy to clean and care for.\n\n- Looks fantastic as it functions with a flirty purple color scheme and jeweled accents.\n\n- Perfect for both solo sessions and partner play.\n\n- Batteries included.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Purple', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(346, 'healthmisc', 'CHAMP6INDILDMED', 'Champions', 'Champions 6 Inch Silicone Dildo Medalist - Harness Compatible, Suction Cup Base', '707676033942', 'UPC', 'Champions', 'dildos', 1, 'Count', '100', 335, 'Update', 'https://www.castlemegastore.com/amz/707676033942.jpg', NULL, NULL, NULL, 'Champions dildos are ultra premium pleasure silicone cocks that are handcrafted with amazing detail and feel. Experience Champions dual density silcione, the perfect combination of rigidity and softness. \"The Real Ride\" the perfection of pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(347, 'healthmisc', 'CWTRISUPPRINGSET', 'Cware', 'Cware Tri-Support Ring Set Black', '707676043910', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 334, 'Update', 'https://www.castlemegastore.com/amz/707676043910.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 10:49:13', '2019-06-10 10:49:13'),
(591, 'sdfsdf', 'sdfdsfsdf', NULL, NULL, '707676016815', 'UPC', 'Enduro', 'dildos', 1, 'Count', '40', 636, 'Update', 'https://www.castlemegastore.com/amz/707676016815.jpg', NULL, NULL, NULL, 'Be astonished by the pleasure the Enduro 8in dildo will give you! Realistic head and veins will trick you into thinking that it is the real thing. The curve of the dildo will help hit that g-spot. All Enduro products are body-safe and phthalate-free. Will you endure the Enduro?', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(592, NULL, NULL, NULL, 'Passions Swirl Vibe Blue', '707676044153', 'UPC', 'Passions', 'vibrators', 1, 'Count', '23', 636, 'Update', 'https://www.castlemegastore.com/amz/707676044368.jpg', NULL, NULL, NULL, 'If you’ve been looking for a slick, versatile vibe that’s up for anything you are, look no further than the Swirl from the celebrated Passions collection. A discreet but effective design takes the guesswork out of stimulating multiple erogenous zones to perfection. A powerful motor and multi-speed operation ensure orgasms are always on the menu for you and your partner.\n• Made of slick, seamless ABS that feels wonderful against your most intimate sweet spots.\n• At just 7 inches long, the Swirl is big enough to get the job done, but small enough to take on the go without a second thought.\n• A tapered tip and undulating shaft work to awaken every last nerve ending.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Blue', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(593, NULL, NULL, 'Jelly Pleasures', 'Jelly Pleasures Dong - 7 Inch, Anti-Bacterial Formula, Stimulating Texture And Feel (Blue)', '707676044351', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 624, 'Update', 'https://www.castlemegastore.com/amz/707676044351.jpg', NULL, NULL, NULL, 'Jelly Pleasures has mastered the art of dongs. This 7.5\" dong is perfect for anyone\'s toy chest. \n\n- Body-safe material.\n\n- Anti-bacterial formula makes it safe and easy to clean.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Blue', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(594, NULL, NULL, 'Jelly Pleasures', 'Jelly Pleasures Dong - Soft And Flexible, Body-Safe, Stimulating Texture (Pink)', '707676044320', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 622, 'Update', 'https://www.castlemegastore.com/amz/707676044320.jpg', NULL, NULL, NULL, 'Bring the excitement of the bedroom to all new levels with the Jelly Pleasures 7\" Dong. No toy chest is complete without a great dong.\n\n- Stimulating Texture and feel, for that realistic feel.\n\n- Soft and Flexible\n\n- Made from body-safe and Phthalate free PVC.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(595, 'dfgdffdgdfg', 'PRETTYPAPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Hypoallergenic Body-Safe, Waterproof, Easy To Clean', '707676016747', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 619, 'Update', 'https://www.castlemegastore.com/amz/707676016747.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Plum', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(596, 'healthmisc', 'FPPDUWHBULL', NULL, 'Dual Glow-In-The-Dark Bullet Vibe (White)', '707676044375', 'UPC', 'Fetish Pleasure Play', 'vibrators', 1, 'Count', '20', 616, 'Update', 'https://www.castlemegastore.com/amz/707676044375.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'White', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(597, 'healthmisc', 'FPPSIL3RINGENH', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone 3Ring Penis And Balls Enchancer', '707676049479', 'UPC', 'Fetish Pleasure Play', 'penis-rings', 1, 'Count', '10', 615, 'Update', 'https://www.castlemegastore.com/amz/707676049479.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(598, 'healthmisc', 'CONNEZRELRNG', 'Connecto', 'Connecto Easy Release Double Cock Ring Set (Black)', '707676036363', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '13', 612, 'Update', 'https://www.castlemegastore.com/amz/707676036363.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove double ring from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(599, 'healthmisc', 'JWBLUBOY3WAY', 'Junkwear', 'Junkwear Blue Boy 3Way Penis Ring For Enhanced Erections', '707676043996', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 605, 'Update', 'https://www.castlemegastore.com/amz/707676043996.jpg', NULL, NULL, NULL, 'The JunkWear 3-way ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11');
INSERT INTO `products` (`id`, `feed_product_type`, `item_sku`, `brand_name`, `item_name`, `external_product_id`, `external_product_id_type`, `manufacturer`, `item_type`, `unit_count`, `unit_count_type`, `standard_price`, `quantity`, `update_delete`, `main_image_url`, `other_image_url1`, `other_image_url2`, `other_image_url3`, `product_description`, `bullet_point1`, `bullet_point2`, `bullet_point3`, `bullet_point4`, `bullet_point5`, `color_name`, `is_adult_product`, `product_for`, `exclusive`, `created_at`, `updated_at`) VALUES
(600, 'healthmisc', 'PPANPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Easy To Use Body-Safe Anal Sex Toy (Pink)', '707676016730', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 540, 'Update', 'https://www.castlemegastore.com/amz/707676016730.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(601, 'healthmisc', 'JWBLKB3WAYRING', 'Junkwear', 'Junkwear Black Beauty 3 Way Erection Enhancing Penis Ring', '707676043958', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 527, 'Update', 'https://www.castlemegastore.com/amz/707676043958.jpg', NULL, NULL, NULL, 'The JunkWear Black Beauty 3 Way ring design is stretchy and comfortable TPR erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-way ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(602, 'healthmisc', 'VELRATTBLK', 'Velskin', 'Velskin Rattler Vibrator - Perfect Waterproof Silicone Made Vibrating Sex Toy (Black)', '707676018482', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '50', 515, 'Update', 'https://www.castlemegastore.com/amz/707676018482.jpg', NULL, NULL, NULL, 'All Velskin products are made from our superior proprietary blend of 100% Vel-Ultra premium silicone. Experience the amazing touch, feel and quality of Velskin. All Velskin products are phthalate free, body safe, hypoallergenic and environmentally friendly.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(603, 'healthmisc', 'MRABBDACER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Daisy  - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060351', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060351.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Daisy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(604, 'healthmisc', 'MWMAPRBALL', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits April Ballet Slipper - Waterproof Platinum Cured Silicone Massager (Purple)', '707676060368', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060368.jpg', NULL, NULL, NULL, 'April comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(605, 'healthmisc', 'MWMMRLUCYCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Lucy - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060375', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '85', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060375.jpg', NULL, NULL, NULL, 'Lucy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(606, 'healthmisc', 'MWMMRMOLCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Molly - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060382', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060382.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Molly comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(607, 'healthmisc', 'MWMMRMAECER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Mae - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676065226', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676065226.jpg', NULL, NULL, NULL, 'Mighty Rabbits pack power into a fun bunny shape! Fully rechargeable and easy to use. \n\nMae\'s dual clit stimulator is soft and flexible to hit all your hot spots? Mae also features fast gyrating technology for extra intense orgasms!\n\nThis rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(608, 'healthmisc', 'HPMEDPLUG', 'Hot Pinks', 'Hot Pinks Medium Butt Plug - Easy To Clean, Perfect For Anal Sex Beginners (Pink)', '707676016709', 'UPC', 'Hot Pinks', 'butt-plugs', 1, 'Count', '20', 496, 'Update', 'https://www.castlemegastore.com/amz/707676016709.jpg', NULL, NULL, NULL, 'A tapered, rounded tip slides in easily, while the 4\" graduated shaft gives a sensually filling experience. The narrow neck and oval base are comfortable to wear, and the flat base allows for hot solo play.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(609, 'healthmisc', 'JKICYHDUORING', 'Junkwear', 'Junkwear Icy Hot Duo Penis Ring - Ball Stretcher Made Of Body-Safe Material (Transparent)', '707676044016', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 489, 'Update', 'https://www.castlemegastore.com/amz/707676044016.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(610, 'healthmisc', 'BLUEANGSTRO', 'Blue Angel', 'Blue Angel Stroker - Body-Safe Pussy Masturbator (Blue)', '707676018888', 'UPC', 'Blue Angel', 'male-masturbators', 1, 'Count', '25', 487, 'Update', 'https://www.castlemegastore.com/amz/707676018888.jpg', NULL, NULL, NULL, 'A great choice for solo pleasure, the Blue Angel Masturbator gives you a feeling like some of the higher end toys out there, for a much more reasonable price. The soft, smooth and stretchy jelly rubber warms to the touch as you enjoy, and the small size makes it easy to hold in hand, where you can squeeze it until the 4 rows of silver rolling beads are gripping and massaging you as tight as you like.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Blue', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(611, 'healthmisc', 'CWPLEASPEARLR', 'Cware', 'Cware Pleasure Pearl Penis Ring - Durable, Versatile, Adjustable, Made Of Silicone', '707676044023', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '15', 472, 'Update', 'https://www.castlemegastore.com/amz/707676044023.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Green', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(612, 'healthmisc', 'CONNEZRELCAG', 'Connecto', 'Connecto Easy Release Cock Cage - Customizable, Easy To Clean And Release (Black)', '707676036349', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '15', 470, 'Update', 'https://www.castlemegastore.com/amz/707676036349.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove cage from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(613, 'healthmisc', 'FPPNEONVIBEPNK', 'Passions', 'Passions Neon Classic Mini Vibe - Body-Safe, Multi-Speed, Waterproof Pink', '707676044078', 'UPC', 'Passions', 'vibrators', 1, 'Count', '15', 457, 'Update', 'https://www.castlemegastore.com/amz/707676044078.jpg', NULL, NULL, NULL, 'Passions Neon Classic Mini Vibe', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Waterproof', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(614, 'healthmisc', 'VELSPECOBROWN', 'Velskin', 'Velskin Pecos Dildo - Body-Safe Silicone, Harness Compatible, Lifetime Warranty (Brown)', '707676018390', 'UPC', 'Velskin', 'dildos', 1, 'Count', '100', 456, 'Update', 'https://www.castlemegastore.com/amz/707676018390.jpg', NULL, NULL, NULL, 'This Velskin Pecos Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-ultra silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Brown', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(615, 'healthmisc', 'BLACKFURLEGCUFF', 'Fetish Pleasure Play', 'Fetish Pleasure Play Furry Ankle Cuffs - Metal And Faux Fur Black', '707676001378', 'UPC', 'Fetish Pleasure Play', 'restraints', 1, 'Count', '29', 434, 'Update', 'https://www.castlemegastore.com/amz/707676001378.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'One size fits most', 'Keys included', 'fetish sex toys, restraints, handcuffs, fetish play toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(616, 'healthmisc', 'BANGKBALLBUS', 'Bangkok Ballbuster', 'Bangkok Ballbuster Vagina Masturbator For Men (Pink)', '707676018925', 'UPC', 'Bangkok Ballbuster', 'male-masturbators', 1, 'Count', '15', 431, 'Update', 'https://www.castlemegastore.com/amz/707676018925.jpg', NULL, NULL, NULL, 'Soft, tight, and stretchy masturbator. Textured pleasure chamber with closed end for enhanced suction. Maintenance free TPR.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(617, 'healthmisc', 'VELSLONGRIDBLK', 'Velskin', 'Velskin Long Rider Penis Extender - Silicone, Lifetime Warranty, Hypoallergenic (Black)', '707676018352', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '120', 428, 'Update', 'https://www.castlemegastore.com/amz/707676018352.jpg', NULL, NULL, NULL, 'It\'s the little things that make a big difference. Velskin brings this long rider penis extension to enhance your natural penis size. Apply a little water-based lube to your penis and the toy\'s canal, slide your penis inside and stretch the base of the toy over your balls, for a secure fit.\n\nSometimes it’s fine to enjoy yourself exactly the way Mother Nature made you, but every so often it’s fun to spice things up a little in the size department. The Long Rider penis extender from Velskin makes it easy to experience what a difference a little size boost can really make.\n•Made of Velskin’s own ultra-soft, lifelike silicone. Warms to the touch and perfectly mimics the feeling of real skin.\n•Makes you noticeably thicker and longer. Also desensitizes you just enough to help you go the distance.\n•Try it with a little of your favorite water-based lube for an even better experience!', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(618, 'healthmisc', 'JWSTRETCHFLEXRNG', 'Junkwear', 'Junkwear Stretch Flex Clear Penis Ring And Ball Stretcher', '707676044047', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '7', 426, 'Update', 'https://www.castlemegastore.com/amz/707676044047.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Transparent', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(619, 'healthmisc', 'PASSREDTICKL', 'Passions', 'Passions Kiss Lover Mini Vibrator - Body-Safe, Seamless Design, G-Spot Stimulation (Red)', '707676044108', 'UPC', 'Passions', 'vibrators', 1, 'Count', '20', 423, 'Update', 'https://www.castlemegastore.com/amz/707676044108.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'G-spot stimulation', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Red', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(620, 'healthmisc', 'PEARLESMEDPLUGPNK', 'Pearlescent', 'Pearlescent Medium Butt Plug - Perfect Anal Sex Toy (Pink)', '707676016693', 'UPC', 'Pearlescent', 'butt-plugs', 1, 'Count', '20', 420, 'Update', 'https://www.castlemegastore.com/amz/707676016693pearlescent-medium-bp.jpg', NULL, NULL, NULL, 'A little shine to stimulate your behind! Pearlescent\'s Butt Plug is smooth with a tapered shape ideal for first-time insertion. This plug is a small slim size for comfortable anal stimulation. The plug is firm but very flexible. Introduce a partner to the joys of mild anal stimulation. It is made from phthalate-free body safe material.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(621, 'healthmisc', 'NWBELLNIPPCLAMPS', 'Nipple Wear', 'Nipple Wear Bell Nipple Clamps - Adjustable, Rubber Tips, Made Of Metal (Black)', '707676018963', 'UPC', 'Nipple Wear', 'ball-stretchers', 1, 'Count', '13', 412, 'Update', 'https://www.castlemegastore.com/amz/707676018963.jpg', NULL, NULL, NULL, 'Who says a pair of nipple clamps can’t be beautiful, appealing, and effective? This strong, sexy pair is positively mesmerizing in its simplicity. Tough, stainless steel alligator clamps support a pair of black, twinkling bells to add visual and auditory appeal to your next play session.\n• Classic alligator clamps are fully adjustable to make achieving the ideal degree of pressure easy.\n• Medical grade stainless steel and tough, body-safe rubber tips make these clamps as safe, strong, and practical as they are fun to use.\n• Pretty, black bells lend a sexy, sassy touch to any fetish look or bedroom ensemble.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Waterproof', 'male sex toys, ball stretchers, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(622, 'healthmisc', 'VELSBENDALEXFLSH', 'Velskin', 'Velskin Bendable Alexandria Dildo - Harness Compatible, Bendable Spine, Lifetime Warranty', '707676046027', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 407, 'Update', 'https://www.castlemegastore.com/amz/707676046027.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nFind out what a difference a little flexibility really makes when you make this bendable Velskin dildo a part of your collection. Ample proportions, premium dual-density silicone, and a bevy of stimulating details add even more pleasure to your experience.\n• With an insertable length of 9 inches and a girth of 4.75 inches, this toy really fills you up to capacity.\n• Dual-density silicone design almost perfectly mimics the real thing – hard on the inside and soft on the outside.\n• Bendable and flexible. Customize each play experience according to mood, position, activity, and more.\n• Full harness compatibility makes engaging in satisfying partnered play easy.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(623, 'healthmisc', 'CWTRISUPPRNG', 'Cware', 'Cware Tri-Support Penis Ring Set - Body-Safe Silicone, Versatile, Durable (White)', '707676043927', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 395, 'Update', 'https://www.castlemegastore.com/amz/707676043927.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The C & B ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(624, 'healthmisc', 'VELSCLINTIVOR', 'Velskin', 'Velskin Clint Ivory Dildo - Vel-Ultra Silicone, Harness Compatible, G-Spot And P-Spot Stimulation', '707676018673', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 390, 'Update', 'https://www.castlemegastore.com/amz/707676018673.jpg', NULL, NULL, NULL, 'Velskin\'s Ivory Clint Dildo is ultra realistic and great for first time fun! With it\'s lifelike head for a natural feel, it has a curved shaft for precise G-Spot or P-spot stimulation! Made of 100% Vel-Ultra silicone and is harness compatible.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Ivory', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(625, 'healthmisc', 'VELSAUSTFLESH', 'Velskin', 'Velskin Austin Flesh Dildo - Vel-Ultra Silicone, Harness Compatible, Lifetime Warranty', '707676018710', 'UPC', 'Velskin', 'dildos', 1, 'Count', '45', 388, 'Update', 'https://www.castlemegastore.com/amz/707676018710.jpg', NULL, NULL, NULL, 'This Velskin Austin Flesh Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-Ultra Silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(626, 'healthmisc', 'VELSSTALLBLK', 'Velskin', 'Velskin Stallion Penis Extender - Body-Safe Silicone, Hypoallergenic, Easy To Clean (Black)', '707676018260', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '130', 381, 'Update', 'https://www.castlemegastore.com/amz/707676018260.jpg', NULL, NULL, NULL, 'Enjoy longer lovemaking in every way as this black stallion extender from Velskin desensitizes you for prolonged session. It stays comfortably in place throughout lovemaking and offers you extra control to help tame your beast.\n\nWith the incredible Velskin Stallion in your corner, there’s no limit to your ability to curl your partner’s toes in bed. Add inches to your natural physique, regain total control over your orgasm, and treat your partner to additional stimulation to boot.\n• Made of premium sculpted silicone – body-safe, hypoallergenic, and phthalate-free.\n• Desensitizes you just enough to help you last as long as you like. Perfect for controlling premature ejaculation!\n• Noticeably increases your length and girth. Sculpted, lifelike design brings even more stimulation to the table for your partner. \n• Protected by a lifetime warranty.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(627, 'healthmisc', 'VELSBENDJULIETFLS', 'Velskin', 'Velskin Bendable Juliette Flesh Dildo - Body-Safe Silicone, Easy To Clean, Hypoallergenic', '707676046010', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 373, 'Update', 'https://www.castlemegastore.com/amz/707676046010.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\n- Made from 100% body-safe silicone, which makes it easier to clean and hypoallergenic.\n\n- Constructed out of dual density silicone, which makes for a firm inner core and a soft, realistic feeling outer coat.\n\n- With a bendable spine, makes this dildo able to bend to your pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(628, 'healthmisc', 'CWARGNDDUORNG', 'Cware', 'Cware Premium Silicone Penis Rings (White)', '707676043903', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 366, 'Update', 'https://www.castlemegastore.com/amz/707676043903.jpg', NULL, NULL, NULL, 'The CWARE duo ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(629, 'healthmisc', 'MWMINIBLU', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Silicone Head, Body-Safe, Batteries Included (Blue)', '707676019557', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 362, 'Update', 'https://www.castlemegastore.com/amz/707676019557-mw-mini-blue.jpg', NULL, NULL, NULL, 'If you love the power and performance of the original Mighty Wand, you\'ll definitely want to get up close and personal with the Mighty Wand Mini as well. Enjoy the same toe-curling sensation and versatility you\'ve come to love in a compact, streamlined package that\'s easy to take along absolutely anywhere.\n• Measures in at 4.25\" with a 4\" head circumference making it easy to include in a suitcase, purse or overnight bag.\n• Made from ABS plastic and features a smooth, inviting silicone head -- body-safe, easy to care for, and capable of providing phenomenal sensation.\n• Pretty blue color and jeweled accents make this vibe as lovely to look at as it is fun to use.\n• Batteries already included!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Blue', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(630, 'healthmisc', 'HOOKNALTPNKPLUG', 'Hook N\' Up', 'Hooknup Beaded Silicone Anal Plug (Pink)', '707676044207', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 361, 'Update', 'https://www.castlemegastore.com/amz/hook n up_707676044207_4.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_1.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_2.jpg', 'https://www.castlemegastore.com/amz/hooknup_707676044207_3.jpg', 'Tired of the normal style of butt plugs? Well then try the Hook \'N\' Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% silicone, which makes it easy to clean and is hypoallergenic.\n\n- Revolutionary beaded design helps bring your anal play to a new level', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(631, 'healthmisc', 'VELSSADDPURPL', 'Velskin', 'Velskin Saddlehorn Wand Attachment (Purple)', '707676018529', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '60', 358, 'Update', 'https://www.castlemegastore.com/amz/707676018529.jpg', NULL, NULL, NULL, 'Velskin\'s Saddlehorn wand attachment will bring you into bliss. This all silicone attachment is smooth and has an amazing tip to reach that g-spot.\n\nIf you love the sheer oomph a wand massager brings to the table, but occasionally find yourself in the mood for more targeted stimulation, this saddlehorn-style Velskin attachment was made with you in mind. It fits right over the head of your favorite wand massager, instantly converting it into a pinpoint-accurate G-spot or P-spot stimulator.\n• Made of Velskin’s own ultra-smooth, body-safe silicone for an experience that treats your body right on every level.\n• Fits a variety of popular wand massagers including Bodywand, Magic Wand, and Mighty Wand.\n• Perfect for taking solo play to the next level, but ideal for treating a partner to a “happy ending” massage as well.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Premium Silicone', 'Magic Wand Rechargeable', 'sex toy accessories, magic wand accessories, magic wand attachments, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(632, 'healthmisc', 'CWAREEASTRINGPURP', 'Cware', 'Cware Elastomer Penis Ring - Ultra Flex, Stretchy, Latex Free (Purple)', '707676016297', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 356, 'Update', 'https://www.castlemegastore.com/amz/707676016297.jpg', NULL, NULL, NULL, 'Cock rings work by restricting blood flow out of your cock. Placing this stretchy ring at the base of your cock and balls will help make your erection even bigger and veinier. It\'s a simple stretchy cock ring that gets the job done.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(633, 'healthmisc', 'ANALISANBEADVIBE', 'Analiscious', 'Analiscious Anal Beaded Vibrator - Body-Safe, Waterproof, Multi-Speed (Purple)', '707676016631', 'UPC', 'Analiscious', 'anal-beads', 1, 'Count', '23', 353, 'Update', 'https://www.castlemegastore.com/amz/707676016631.jpg', NULL, NULL, NULL, 'For ultimate anal enjoyment, Analiscious Beaded Anal Vibrator will hit the spot every time. This sturdy strand of waterproof beads has a straight, precise design with vibration that resonates throughout for even stimulation and perfect pleasure. The slightly flexible beaded body has 4 beads that graduate in size, staring small and ending larger, with smooth, thinner areas in between for lots of sensation when inserting and removing. Multi-speed vibration is controlled with a simple twist dial at the base, which also has a wrist cord to keep the Beads close as you play. Takes 2 AAA batteries, sold separately.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'Multi-speed', 'anal sex toys, anal beads, anal vibrators, anal vibrating toys, vibrating anal beads', 'Pink', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(634, 'healthmisc', 'FPPSILTHINSPANK', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone Thin Spank Slapper (Black)', '707676054077', 'UPC', 'Fetish Pleasure Play', 'paddles', 1, 'Count', '33', 353, 'Update', 'https://www.castlemegastore.com/amz/707676054077-01.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Hypoallergenic body-safe', 'Premium silicone', 'fetish sex toys, silicone sex toys, paddles, fetish play toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(635, 'healthmisc', 'VELSBENDAMALFLSH', 'Velskin', 'Velskin Bendable Amal Flesh Dildo - Made Of Silicone, Harness Compatible, Bendable Spine', '707676046003', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 352, 'Update', 'https://www.castlemegastore.com/amz/707676046003.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nThis premium dual-density dildo from Velskin isn’t just second to none in the realism department. Thanks to a special bendable spine, you can adjust it to reflect any angle you like. Add creativity and variety to solo sessions and partnered play alike!\n• Dual-density silicone is velvety soft on the outside and deliciously hard on the inside.\n• Adjust the angle of your toy to better stimulate your sweet spots, explore new positions, and more.\n• Harness compatibility makes it easy to play with a partner exactly the way you want to.\n• Ample but realistic proportions and thoughtful texturing add realism to your experience.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(636, 'healthmisc', 'HOOKNALTSILBLU', 'Hook N\' Up', 'Hooknup Medical Grade Silicone Plug (Blue)', '707676045358', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 349, 'Update', 'https://www.castlemegastore.com/amz/hnu-707676045358-01.jpg', NULL, NULL, NULL, 'Tired of the normal style of butt plugs? Well then try the Hook \'N Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% medical grade silicone, which makes it easy to clean, take care of, and is hypoallergenic.\n\n- Revolutionary alternating beaded design helps bring your anal play to a new level.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Blue', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(637, 'healthmisc', 'CWTRIMETALRNG', 'Cware', 'Cware Tri Metal Ring Set', '707676016440', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '8', 348, 'Update', 'https://www.castlemegastore.com/amz/707676016440.jpg', NULL, NULL, NULL, 'A triple set of ultra sturdy, sleek and shiny metal cock rings from Spartacus, this advanced set is a step up from stretchy varieties, offering a more secure, unyielding feel for ultra impressive results and a fantastic look.', 'Discreet packaging', 'Easy to clean', 'Metal', 'Waterproof', 'Hypoallergenic body-safe', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(638, 'healthmisc', 'MWMMINIPURPL', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Portable, Travel-Friendly, Made Of Silicone (Purple)', '707676019564', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 346, 'Update', 'https://www.castlemegastore.com/amz/707676019564-mw-mini-purple.jpg', NULL, NULL, NULL, 'You already love wand vibrators like the Mighty Wand for the sheer versatility they bring to the table. Now you can take your creative pleasure sessions to even greater heights with the fabulous Mighty Wand Mini - all the power and oomph of the original, but in a convenient compact package.\n\n- Portable, travel-friendly size - 4.25\" in length with a 4\" head circumference.\n\n- Made of smooth, silky silicone and ABS plastic for an experience that not only feels great, but is completely body-safe as well.\n\n- Easy to clean and care for.\n\n- Looks fantastic as it functions with a flirty purple color scheme and jeweled accents.\n\n- Perfect for both solo sessions and partner play.\n\n- Batteries included.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Purple', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(639, 'healthmisc', 'CHAMP6INDILDMED', 'Champions', 'Champions 6 Inch Silicone Dildo Medalist - Harness Compatible, Suction Cup Base', '707676033942', 'UPC', 'Champions', 'dildos', 1, 'Count', '100', 335, 'Update', 'https://www.castlemegastore.com/amz/707676033942.jpg', NULL, NULL, NULL, 'Champions dildos are ultra premium pleasure silicone cocks that are handcrafted with amazing detail and feel. Experience Champions dual density silcione, the perfect combination of rigidity and softness. \"The Real Ride\" the perfection of pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(640, 'healthmisc', 'CWTRISUPPRINGSET', 'Cware', 'Cware Tri-Support Ring Set Black', '707676043910', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 334, 'Update', 'https://www.castlemegastore.com/amz/707676043910.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-10 13:35:11', '2019-06-10 13:35:11'),
(641, NULL, NULL, NULL, NULL, '707676016815', 'UPC', 'Enduro', 'dildos', 1, 'Count', '40', 636, 'Update', 'https://www.castlemegastore.com/amz/707676016815.jpg', NULL, NULL, NULL, 'Be astonished by the pleasure the Enduro 8in dildo will give you! Realistic head and veins will trick you into thinking that it is the real thing. The curve of the dildo will help hit that g-spot. All Enduro products are body-safe and phthalate-free. Will you endure the Enduro?', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(642, NULL, NULL, NULL, 'Passions Swirl Vibe Blue', '707676044153', 'UPC', 'Passions', 'vibrators', 1, 'Count', '23', 636, 'Update', 'https://www.castlemegastore.com/amz/707676044368.jpg', NULL, NULL, NULL, 'If you’ve been looking for a slick, versatile vibe that’s up for anything you are, look no further than the Swirl from the celebrated Passions collection. A discreet but effective design takes the guesswork out of stimulating multiple erogenous zones to perfection. A powerful motor and multi-speed operation ensure orgasms are always on the menu for you and your partner.\n• Made of slick, seamless ABS that feels wonderful against your most intimate sweet spots.\n• At just 7 inches long, the Swirl is big enough to get the job done, but small enough to take on the go without a second thought.\n• A tapered tip and undulating shaft work to awaken every last nerve ending.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Blue', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(643, NULL, NULL, 'Jelly Pleasures', 'Jelly Pleasures Dong - 7 Inch, Anti-Bacterial Formula, Stimulating Texture And Feel (Blue)', '707676044351', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 624, 'Update', 'https://www.castlemegastore.com/amz/707676044351.jpg', NULL, NULL, NULL, 'Jelly Pleasures has mastered the art of dongs. This 7.5\" dong is perfect for anyone\'s toy chest. \n\n- Body-safe material.\n\n- Anti-bacterial formula makes it safe and easy to clean.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Blue', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(644, NULL, NULL, 'Jelly Pleasures', 'Jelly Pleasures Dong - Soft And Flexible, Body-Safe, Stimulating Texture (Pink)', '707676044320', 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', '20', 622, 'Update', 'https://www.castlemegastore.com/amz/707676044320.jpg', NULL, NULL, NULL, 'Bring the excitement of the bedroom to all new levels with the Jelly Pleasures 7\" Dong. No toy chest is complete without a great dong.\n\n- Stimulating Texture and feel, for that realistic feel.\n\n- Soft and Flexible\n\n- Made from body-safe and Phthalate free PVC.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(645, 'dfgdffdgdfg', 'PRETTYPAPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Hypoallergenic Body-Safe, Waterproof, Easy To Clean', '707676016747', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 619, 'Update', 'https://www.castlemegastore.com/amz/707676016747.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Plum', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(646, 'healthmisc', 'FPPDUWHBULL', NULL, 'Dual Glow-In-The-Dark Bullet Vibe (White)', '707676044375', 'UPC', 'Fetish Pleasure Play', 'vibrators', 1, 'Count', '20', 616, 'Update', 'https://www.castlemegastore.com/amz/707676044375.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'White', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(647, 'healthmisc', 'FPPSIL3RINGENH', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone 3Ring Penis And Balls Enchancer', '707676049479', 'UPC', 'Fetish Pleasure Play', 'penis-rings', 1, 'Count', '10', 615, 'Update', 'https://www.castlemegastore.com/amz/707676049479.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(648, 'healthmisc', 'CONNEZRELRNG', 'Connecto', 'Connecto Easy Release Double Cock Ring Set (Black)', '707676036363', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '13', 612, 'Update', 'https://www.castlemegastore.com/amz/707676036363.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove double ring from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(649, 'healthmisc', 'JWBLUBOY3WAY', 'Junkwear', 'Junkwear Blue Boy 3Way Penis Ring For Enhanced Erections', '707676043996', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 605, 'Update', 'https://www.castlemegastore.com/amz/707676043996.jpg', NULL, NULL, NULL, 'The JunkWear 3-way ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(650, 'healthmisc', 'PPANPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Easy To Use Body-Safe Anal Sex Toy (Pink)', '707676016730', 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', '15', 540, 'Update', 'https://www.castlemegastore.com/amz/707676016730.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(651, 'healthmisc', 'JWBLKB3WAYRING', 'Junkwear', 'Junkwear Black Beauty 3 Way Erection Enhancing Penis Ring', '707676043958', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 527, 'Update', 'https://www.castlemegastore.com/amz/707676043958.jpg', NULL, NULL, NULL, 'The JunkWear Black Beauty 3 Way ring design is stretchy and comfortable TPR erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-way ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(652, 'healthmisc', 'VELRATTBLK', 'Velskin', 'Velskin Rattler Vibrator - Perfect Waterproof Silicone Made Vibrating Sex Toy (Black)', '707676018482', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '50', 515, 'Update', 'https://www.castlemegastore.com/amz/707676018482.jpg', NULL, NULL, NULL, 'All Velskin products are made from our superior proprietary blend of 100% Vel-Ultra premium silicone. Experience the amazing touch, feel and quality of Velskin. All Velskin products are phthalate free, body safe, hypoallergenic and environmentally friendly.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(653, 'healthmisc', 'MRABBDACER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Daisy  - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060351', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060351.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Daisy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(654, 'healthmisc', 'MWMAPRBALL', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits April Ballet Slipper - Waterproof Platinum Cured Silicone Massager (Purple)', '707676060368', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '80', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060368.jpg', NULL, NULL, NULL, 'April comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24');
INSERT INTO `products` (`id`, `feed_product_type`, `item_sku`, `brand_name`, `item_name`, `external_product_id`, `external_product_id_type`, `manufacturer`, `item_type`, `unit_count`, `unit_count_type`, `standard_price`, `quantity`, `update_delete`, `main_image_url`, `other_image_url1`, `other_image_url2`, `other_image_url3`, `product_description`, `bullet_point1`, `bullet_point2`, `bullet_point3`, `bullet_point4`, `bullet_point5`, `color_name`, `is_adult_product`, `product_for`, `exclusive`, `created_at`, `updated_at`) VALUES
(655, 'healthmisc', 'MWMMRLUCYCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Lucy - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060375', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '85', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060375.jpg', NULL, NULL, NULL, 'Lucy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(656, 'healthmisc', 'MWMMRMOLCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Molly - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676060382', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676060382.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Molly comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(657, 'healthmisc', 'MWMMRMAECER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Mae - Waterproof Platinum Cured Silicone Massager (Cerise)', '707676065226', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '90', 500, 'Update', 'https://www.castlemegastore.com/amz/707676065226.jpg', NULL, NULL, NULL, 'Mighty Rabbits pack power into a fun bunny shape! Fully rechargeable and easy to use. \n\nMae\'s dual clit stimulator is soft and flexible to hit all your hot spots? Mae also features fast gyrating technology for extra intense orgasms!\n\nThis rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(658, 'healthmisc', 'HPMEDPLUG', 'Hot Pinks', 'Hot Pinks Medium Butt Plug - Easy To Clean, Perfect For Anal Sex Beginners (Pink)', '707676016709', 'UPC', 'Hot Pinks', 'butt-plugs', 1, 'Count', '20', 496, 'Update', 'https://www.castlemegastore.com/amz/707676016709.jpg', NULL, NULL, NULL, 'A tapered, rounded tip slides in easily, while the 4\" graduated shaft gives a sensually filling experience. The narrow neck and oval base are comfortable to wear, and the flat base allows for hot solo play.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(659, 'healthmisc', 'JKICYHDUORING', 'Junkwear', 'Junkwear Icy Hot Duo Penis Ring - Ball Stretcher Made Of Body-Safe Material (Transparent)', '707676044016', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '20', 489, 'Update', 'https://www.castlemegastore.com/amz/707676044016.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(660, 'healthmisc', 'BLUEANGSTRO', 'Blue Angel', 'Blue Angel Stroker - Body-Safe Pussy Masturbator (Blue)', '707676018888', 'UPC', 'Blue Angel', 'male-masturbators', 1, 'Count', '25', 487, 'Update', 'https://www.castlemegastore.com/amz/707676018888.jpg', NULL, NULL, NULL, 'A great choice for solo pleasure, the Blue Angel Masturbator gives you a feeling like some of the higher end toys out there, for a much more reasonable price. The soft, smooth and stretchy jelly rubber warms to the touch as you enjoy, and the small size makes it easy to hold in hand, where you can squeeze it until the 4 rows of silver rolling beads are gripping and massaging you as tight as you like.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Blue', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(661, 'healthmisc', 'CWPLEASPEARLR', 'Cware', 'Cware Pleasure Pearl Penis Ring - Durable, Versatile, Adjustable, Made Of Silicone', '707676044023', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '15', 472, 'Update', 'https://www.castlemegastore.com/amz/707676044023.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Green', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(662, 'healthmisc', 'CONNEZRELCAG', 'Connecto', 'Connecto Easy Release Cock Cage - Customizable, Easy To Clean And Release (Black)', '707676036349', 'UPC', 'Connecto', 'penis-rings', 1, 'Count', '15', 470, 'Update', 'https://www.castlemegastore.com/amz/707676036349.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove cage from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(663, 'healthmisc', 'FPPNEONVIBEPNK', 'Passions', 'Passions Neon Classic Mini Vibe - Body-Safe, Multi-Speed, Waterproof Pink', '707676044078', 'UPC', 'Passions', 'vibrators', 1, 'Count', '15', 457, 'Update', 'https://www.castlemegastore.com/amz/707676044078.jpg', NULL, NULL, NULL, 'Passions Neon Classic Mini Vibe', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Waterproof', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(664, 'healthmisc', 'VELSPECOBROWN', 'Velskin', 'Velskin Pecos Dildo - Body-Safe Silicone, Harness Compatible, Lifetime Warranty (Brown)', '707676018390', 'UPC', 'Velskin', 'dildos', 1, 'Count', '100', 456, 'Update', 'https://www.castlemegastore.com/amz/707676018390.jpg', NULL, NULL, NULL, 'This Velskin Pecos Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-ultra silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Brown', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(665, 'healthmisc', 'BLACKFURLEGCUFF', 'Fetish Pleasure Play', 'Fetish Pleasure Play Furry Ankle Cuffs - Metal And Faux Fur Black', '707676001378', 'UPC', 'Fetish Pleasure Play', 'restraints', 1, 'Count', '29', 434, 'Update', 'https://www.castlemegastore.com/amz/707676001378.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'One size fits most', 'Keys included', 'fetish sex toys, restraints, handcuffs, fetish play toys', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(666, 'healthmisc', 'BANGKBALLBUS', 'Bangkok Ballbuster', 'Bangkok Ballbuster Vagina Masturbator For Men (Pink)', '707676018925', 'UPC', 'Bangkok Ballbuster', 'male-masturbators', 1, 'Count', '15', 431, 'Update', 'https://www.castlemegastore.com/amz/707676018925.jpg', NULL, NULL, NULL, 'Soft, tight, and stretchy masturbator. Textured pleasure chamber with closed end for enhanced suction. Maintenance free TPR.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Pink', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(667, 'healthmisc', 'VELSLONGRIDBLK', 'Velskin', 'Velskin Long Rider Penis Extender - Silicone, Lifetime Warranty, Hypoallergenic (Black)', '707676018352', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '120', 428, 'Update', 'https://www.castlemegastore.com/amz/707676018352.jpg', NULL, NULL, NULL, 'It\'s the little things that make a big difference. Velskin brings this long rider penis extension to enhance your natural penis size. Apply a little water-based lube to your penis and the toy\'s canal, slide your penis inside and stretch the base of the toy over your balls, for a secure fit.\n\nSometimes it’s fine to enjoy yourself exactly the way Mother Nature made you, but every so often it’s fun to spice things up a little in the size department. The Long Rider penis extender from Velskin makes it easy to experience what a difference a little size boost can really make.\n•Made of Velskin’s own ultra-soft, lifelike silicone. Warms to the touch and perfectly mimics the feeling of real skin.\n•Makes you noticeably thicker and longer. Also desensitizes you just enough to help you go the distance.\n•Try it with a little of your favorite water-based lube for an even better experience!', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(668, 'healthmisc', 'JWSTRETCHFLEXRNG', 'Junkwear', 'Junkwear Stretch Flex Clear Penis Ring And Ball Stretcher', '707676044047', 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', '7', 426, 'Update', 'https://www.castlemegastore.com/amz/707676044047.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Transparent', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(669, 'healthmisc', 'PASSREDTICKL', 'Passions', 'Passions Kiss Lover Mini Vibrator - Body-Safe, Seamless Design, G-Spot Stimulation (Red)', '707676044108', 'UPC', 'Passions', 'vibrators', 1, 'Count', '20', 423, 'Update', 'https://www.castlemegastore.com/amz/707676044108.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'G-spot stimulation', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Red', NULL, 0, '2019-06-11 07:56:24', '2019-06-11 07:56:24'),
(670, 'healthmisc', 'PEARLESMEDPLUGPNK', 'Pearlescent', 'Pearlescent Medium Butt Plug - Perfect Anal Sex Toy (Pink)', '707676016693', 'UPC', 'Pearlescent', 'butt-plugs', 1, 'Count', '20', 420, 'Update', 'https://www.castlemegastore.com/amz/707676016693pearlescent-medium-bp.jpg', NULL, NULL, NULL, 'A little shine to stimulate your behind! Pearlescent\'s Butt Plug is smooth with a tapered shape ideal for first-time insertion. This plug is a small slim size for comfortable anal stimulation. The plug is firm but very flexible. Introduce a partner to the joys of mild anal stimulation. It is made from phthalate-free body safe material.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(671, 'healthmisc', 'NWBELLNIPPCLAMPS', 'Nipple Wear', 'Nipple Wear Bell Nipple Clamps - Adjustable, Rubber Tips, Made Of Metal (Black)', '707676018963', 'UPC', 'Nipple Wear', 'ball-stretchers', 1, 'Count', '13', 412, 'Update', 'https://www.castlemegastore.com/amz/707676018963.jpg', NULL, NULL, NULL, 'Who says a pair of nipple clamps can’t be beautiful, appealing, and effective? This strong, sexy pair is positively mesmerizing in its simplicity. Tough, stainless steel alligator clamps support a pair of black, twinkling bells to add visual and auditory appeal to your next play session.\n• Classic alligator clamps are fully adjustable to make achieving the ideal degree of pressure easy.\n• Medical grade stainless steel and tough, body-safe rubber tips make these clamps as safe, strong, and practical as they are fun to use.\n• Pretty, black bells lend a sexy, sassy touch to any fetish look or bedroom ensemble.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Waterproof', 'male sex toys, ball stretchers, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(672, 'healthmisc', 'VELSBENDALEXFLSH', 'Velskin', 'Velskin Bendable Alexandria Dildo - Harness Compatible, Bendable Spine, Lifetime Warranty', '707676046027', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 407, 'Update', 'https://www.castlemegastore.com/amz/707676046027.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nFind out what a difference a little flexibility really makes when you make this bendable Velskin dildo a part of your collection. Ample proportions, premium dual-density silicone, and a bevy of stimulating details add even more pleasure to your experience.\n• With an insertable length of 9 inches and a girth of 4.75 inches, this toy really fills you up to capacity.\n• Dual-density silicone design almost perfectly mimics the real thing – hard on the inside and soft on the outside.\n• Bendable and flexible. Customize each play experience according to mood, position, activity, and more.\n• Full harness compatibility makes engaging in satisfying partnered play easy.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(673, 'healthmisc', 'CWTRISUPPRNG', 'Cware', 'Cware Tri-Support Penis Ring Set - Body-Safe Silicone, Versatile, Durable (White)', '707676043927', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 395, 'Update', 'https://www.castlemegastore.com/amz/707676043927.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The C & B ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(674, 'healthmisc', 'VELSCLINTIVOR', 'Velskin', 'Velskin Clint Ivory Dildo - Vel-Ultra Silicone, Harness Compatible, G-Spot And P-Spot Stimulation', '707676018673', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 390, 'Update', 'https://www.castlemegastore.com/amz/707676018673.jpg', NULL, NULL, NULL, 'Velskin\'s Ivory Clint Dildo is ultra realistic and great for first time fun! With it\'s lifelike head for a natural feel, it has a curved shaft for precise G-Spot or P-spot stimulation! Made of 100% Vel-Ultra silicone and is harness compatible.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Ivory', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(675, 'healthmisc', 'VELSAUSTFLESH', 'Velskin', 'Velskin Austin Flesh Dildo - Vel-Ultra Silicone, Harness Compatible, Lifetime Warranty', '707676018710', 'UPC', 'Velskin', 'dildos', 1, 'Count', '45', 388, 'Update', 'https://www.castlemegastore.com/amz/707676018710.jpg', NULL, NULL, NULL, 'This Velskin Austin Flesh Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-Ultra Silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(676, 'healthmisc', 'VELSSTALLBLK', 'Velskin', 'Velskin Stallion Penis Extender - Body-Safe Silicone, Hypoallergenic, Easy To Clean (Black)', '707676018260', 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', '130', 381, 'Update', 'https://www.castlemegastore.com/amz/707676018260.jpg', NULL, NULL, NULL, 'Enjoy longer lovemaking in every way as this black stallion extender from Velskin desensitizes you for prolonged session. It stays comfortably in place throughout lovemaking and offers you extra control to help tame your beast.\n\nWith the incredible Velskin Stallion in your corner, there’s no limit to your ability to curl your partner’s toes in bed. Add inches to your natural physique, regain total control over your orgasm, and treat your partner to additional stimulation to boot.\n• Made of premium sculpted silicone – body-safe, hypoallergenic, and phthalate-free.\n• Desensitizes you just enough to help you last as long as you like. Perfect for controlling premature ejaculation!\n• Noticeably increases your length and girth. Sculpted, lifelike design brings even more stimulation to the table for your partner. \n• Protected by a lifetime warranty.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(677, 'healthmisc', 'VELSBENDJULIETFLS', 'Velskin', 'Velskin Bendable Juliette Flesh Dildo - Body-Safe Silicone, Easy To Clean, Hypoallergenic', '707676046010', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 373, 'Update', 'https://www.castlemegastore.com/amz/707676046010.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\n- Made from 100% body-safe silicone, which makes it easier to clean and hypoallergenic.\n\n- Constructed out of dual density silicone, which makes for a firm inner core and a soft, realistic feeling outer coat.\n\n- With a bendable spine, makes this dildo able to bend to your pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(678, 'healthmisc', 'CWARGNDDUORNG', 'Cware', 'Cware Premium Silicone Penis Rings (White)', '707676043903', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 366, 'Update', 'https://www.castlemegastore.com/amz/707676043903.jpg', NULL, NULL, NULL, 'The CWARE duo ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(679, 'healthmisc', 'MWMINIBLU', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Silicone Head, Body-Safe, Batteries Included (Blue)', '707676019557', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 362, 'Update', 'https://www.castlemegastore.com/amz/707676019557-mw-mini-blue.jpg', NULL, NULL, NULL, 'If you love the power and performance of the original Mighty Wand, you\'ll definitely want to get up close and personal with the Mighty Wand Mini as well. Enjoy the same toe-curling sensation and versatility you\'ve come to love in a compact, streamlined package that\'s easy to take along absolutely anywhere.\n• Measures in at 4.25\" with a 4\" head circumference making it easy to include in a suitcase, purse or overnight bag.\n• Made from ABS plastic and features a smooth, inviting silicone head -- body-safe, easy to care for, and capable of providing phenomenal sensation.\n• Pretty blue color and jeweled accents make this vibe as lovely to look at as it is fun to use.\n• Batteries already included!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Blue', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(680, 'healthmisc', 'HOOKNALTPNKPLUG', 'Hook N\' Up', 'Hooknup Beaded Silicone Anal Plug (Pink)', '707676044207', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 361, 'Update', 'https://www.castlemegastore.com/amz/hook n up_707676044207_4.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_1.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_2.jpg', 'https://www.castlemegastore.com/amz/hooknup_707676044207_3.jpg', 'Tired of the normal style of butt plugs? Well then try the Hook \'N\' Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% silicone, which makes it easy to clean and is hypoallergenic.\n\n- Revolutionary beaded design helps bring your anal play to a new level', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(681, 'healthmisc', 'VELSSADDPURPL', 'Velskin', 'Velskin Saddlehorn Wand Attachment (Purple)', '707676018529', 'UPC', 'Velskin', 'vibrators', 1, 'Count', '60', 358, 'Update', 'https://www.castlemegastore.com/amz/707676018529.jpg', NULL, NULL, NULL, 'Velskin\'s Saddlehorn wand attachment will bring you into bliss. This all silicone attachment is smooth and has an amazing tip to reach that g-spot.\n\nIf you love the sheer oomph a wand massager brings to the table, but occasionally find yourself in the mood for more targeted stimulation, this saddlehorn-style Velskin attachment was made with you in mind. It fits right over the head of your favorite wand massager, instantly converting it into a pinpoint-accurate G-spot or P-spot stimulator.\n• Made of Velskin’s own ultra-smooth, body-safe silicone for an experience that treats your body right on every level.\n• Fits a variety of popular wand massagers including Bodywand, Magic Wand, and Mighty Wand.\n• Perfect for taking solo play to the next level, but ideal for treating a partner to a “happy ending” massage as well.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Premium Silicone', 'Magic Wand Rechargeable', 'sex toy accessories, magic wand accessories, magic wand attachments, silicone sex toys', 'Purple', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(682, 'healthmisc', 'CWAREEASTRINGPURP', 'Cware', 'Cware Elastomer Penis Ring - Ultra Flex, Stretchy, Latex Free (Purple)', '707676016297', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '13', 356, 'Update', 'https://www.castlemegastore.com/amz/707676016297.jpg', NULL, NULL, NULL, 'Cock rings work by restricting blood flow out of your cock. Placing this stretchy ring at the base of your cock and balls will help make your erection even bigger and veinier. It\'s a simple stretchy cock ring that gets the job done.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(683, 'healthmisc', 'ANALISANBEADVIBE', 'Analiscious', 'Analiscious Anal Beaded Vibrator - Body-Safe, Waterproof, Multi-Speed (Purple)', '707676016631', 'UPC', 'Analiscious', 'anal-beads', 1, 'Count', '23', 353, 'Update', 'https://www.castlemegastore.com/amz/707676016631.jpg', NULL, NULL, NULL, 'For ultimate anal enjoyment, Analiscious Beaded Anal Vibrator will hit the spot every time. This sturdy strand of waterproof beads has a straight, precise design with vibration that resonates throughout for even stimulation and perfect pleasure. The slightly flexible beaded body has 4 beads that graduate in size, staring small and ending larger, with smooth, thinner areas in between for lots of sensation when inserting and removing. Multi-speed vibration is controlled with a simple twist dial at the base, which also has a wrist cord to keep the Beads close as you play. Takes 2 AAA batteries, sold separately.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'Multi-speed', 'anal sex toys, anal beads, anal vibrators, anal vibrating toys, vibrating anal beads', 'Pink', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(684, 'healthmisc', 'FPPSILTHINSPANK', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone Thin Spank Slapper (Black)', '707676054077', 'UPC', 'Fetish Pleasure Play', 'paddles', 1, 'Count', '33', 353, 'Update', 'https://www.castlemegastore.com/amz/707676054077-01.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Hypoallergenic body-safe', 'Premium silicone', 'fetish sex toys, silicone sex toys, paddles, fetish play toys', 'Black', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(685, 'healthmisc', 'VELSBENDAMALFLSH', 'Velskin', 'Velskin Bendable Amal Flesh Dildo - Made Of Silicone, Harness Compatible, Bendable Spine', '707676046003', 'UPC', 'Velskin', 'dildos', 1, 'Count', '110', 352, 'Update', 'https://www.castlemegastore.com/amz/707676046003.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nThis premium dual-density dildo from Velskin isn’t just second to none in the realism department. Thanks to a special bendable spine, you can adjust it to reflect any angle you like. Add creativity and variety to solo sessions and partnered play alike!\n• Dual-density silicone is velvety soft on the outside and deliciously hard on the inside.\n• Adjust the angle of your toy to better stimulate your sweet spots, explore new positions, and more.\n• Harness compatibility makes it easy to play with a partner exactly the way you want to.\n• Ample but realistic proportions and thoughtful texturing add realism to your experience.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(686, 'healthmisc', 'HOOKNALTSILBLU', 'Hook N\' Up', 'Hooknup Medical Grade Silicone Plug (Blue)', '707676045358', 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', '25', 349, 'Update', 'https://www.castlemegastore.com/amz/hnu-707676045358-01.jpg', NULL, NULL, NULL, 'Tired of the normal style of butt plugs? Well then try the Hook \'N Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% medical grade silicone, which makes it easy to clean, take care of, and is hypoallergenic.\n\n- Revolutionary alternating beaded design helps bring your anal play to a new level.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Blue', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(687, 'healthmisc', 'CWTRIMETALRNG', 'Cware', 'Cware Tri Metal Ring Set', '707676016440', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '8', 348, 'Update', 'https://www.castlemegastore.com/amz/707676016440.jpg', NULL, NULL, NULL, 'A triple set of ultra sturdy, sleek and shiny metal cock rings from Spartacus, this advanced set is a step up from stretchy varieties, offering a more secure, unyielding feel for ultra impressive results and a fantastic look.', 'Discreet packaging', 'Easy to clean', 'Metal', 'Waterproof', 'Hypoallergenic body-safe', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(688, 'healthmisc', 'MWMMINIPURPL', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Portable, Travel-Friendly, Made Of Silicone (Purple)', '707676019564', 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', '20', 346, 'Update', 'https://www.castlemegastore.com/amz/707676019564-mw-mini-purple.jpg', NULL, NULL, NULL, 'You already love wand vibrators like the Mighty Wand for the sheer versatility they bring to the table. Now you can take your creative pleasure sessions to even greater heights with the fabulous Mighty Wand Mini - all the power and oomph of the original, but in a convenient compact package.\n\n- Portable, travel-friendly size - 4.25\" in length with a 4\" head circumference.\n\n- Made of smooth, silky silicone and ABS plastic for an experience that not only feels great, but is completely body-safe as well.\n\n- Easy to clean and care for.\n\n- Looks fantastic as it functions with a flirty purple color scheme and jeweled accents.\n\n- Perfect for both solo sessions and partner play.\n\n- Batteries included.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Purple', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(689, 'healthmisc', 'CHAMP6INDILDMED', 'Champions', 'Champions 6 Inch Silicone Dildo Medalist - Harness Compatible, Suction Cup Base', '707676033942', 'UPC', 'Champions', 'dildos', 1, 'Count', '100', 335, 'Update', 'https://www.castlemegastore.com/amz/707676033942.jpg', NULL, NULL, NULL, 'Champions dildos are ultra premium pleasure silicone cocks that are handcrafted with amazing detail and feel. Experience Champions dual density silcione, the perfect combination of rigidity and softness. \"The Real Ride\" the perfection of pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25'),
(690, 'healthmisc', 'CWTRISUPPRINGSET', 'Cware', 'Cware Tri-Support Ring Set Black', '707676043910', 'UPC', 'Cware', 'penis-rings', 1, 'Count', '12', 334, 'Update', 'https://www.castlemegastore.com/amz/707676043910.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', NULL, 0, '2019-06-11 07:56:25', '2019-06-11 07:56:25');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2019-05-17 07:08:32', '2019-05-17 07:08:32'),
(2, 'user', 'Normal User', '2019-05-17 07:08:32', '2019-05-17 07:08:32');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `Sheet1`
--

CREATE TABLE `Sheet1` (
  `A` varchar(24) DEFAULT NULL,
  `B` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Sheet1`
--

INSERT INTO `Sheet1` (`A`, `B`) VALUES
('title', 'description'),
('itsolutionstuff.com', 'Larave Tuto..'),
('Demo.itsolutionstuff.com', 'Demo fo Larave Tuto..');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `page` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `page`, `title`, `image`, `sort_order`, `created_at`, `updated_at`) VALUES
(7, NULL, 'Slide1', '1558525085.jpeg', NULL, '2019-05-22 06:08:05', '2019-05-22 06:08:05'),
(8, NULL, 'Title4', '1558525139.jpeg', NULL, '2019-05-22 06:08:59', '2019-05-22 06:08:59'),
(9, NULL, 'asdasdasd', '1558525502.jpeg', NULL, '2019-05-22 06:15:02', '2019-05-22 06:15:02'),
(10, NULL, 'EEEEE', '1558525579.jpeg', NULL, '2019-05-22 06:16:19', '2019-05-22 06:16:19'),
(11, NULL, 'sdfsdf', '1558525593.jpeg', NULL, '2019-05-22 06:16:33', '2019-05-22 06:16:33'),
(12, NULL, 'Title7', '1558526701.jpeg', NULL, '2019-05-22 06:35:01', '2019-05-22 06:35:01'),
(14, 'home', 'gfhdgfh', '1560149606.png', NULL, '2019-06-10 01:23:26', '2019-06-10 01:23:26'),
(15, 'home', 'asdasdas', '1560149800.jpeg', NULL, '2019-06-10 01:26:40', '2019-06-10 01:26:40'),
(16, 'home', 'demo', '1560225584.png', NULL, '2019-06-10 22:29:44', '2019-06-10 22:29:44');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_info`
--

CREATE TABLE `tbl_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `facebook_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gmail_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` timestamp NULL DEFAULT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` int(12) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '2',
  `gender` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `first_name`, `last_name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `facebook_id`, `gmail_id`, `access_token`, `timezone`, `device_id`, `address`, `city`, `country`, `state`, `zip`, `type`, `gender`, `created_at`, `updated_at`, `deleted_at`) VALUES
(78, 1, 'Castle', 'mohit', 'Sharma', 'castle@gmail.com', 'users/default.png', NULL, '$2y$10$LFtRSHhfu.bBI6/Dae.d9OFJRr6Aj4hQp4TCkcJ3e5j3Q36CE/ijO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mohali', NULL, 'punjab', 160055, 1, 'male', '2019-06-10 00:16:34', '2019-06-10 22:23:07', NULL),
(80, 1, NULL, 'mohit', 'sharma', 'mohit@gmail.com', 'avatar_80.png', NULL, '$2y$10$jlJD8NexlFwGvumSVhNrG.3veO9hlVWR8ArD/f0x340DqZmrUwUFq', NULL, NULL, '', '', NULL, '2019-06-10 23:28:55', NULL, 'ABC', 'mohali', 'india', 'punjab', NULL, 2, 'male', '2019-06-10 23:28:55', '2019-06-11 08:23:35', NULL),
(81, NULL, NULL, NULL, NULL, 'nitinsharma.sharma6@gmail.com', 'users/default.png', NULL, '$2y$10$FJBwaV6aRJllaXJyPpEEmeogaf.WJmgCnF8FwsEylznotzq6S3mwm', NULL, NULL, '', '101102363664672642027', NULL, '2019-06-11 06:43:23', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '2019-06-11 06:43:23', '2019-06-11 06:43:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(2, 79, 136, '2019-06-10 06:46:38', '2019-06-10 06:46:38'),
(8, 80, 138, '2019-06-11 00:18:44', '2019-06-11 00:18:44'),
(10, 80, 137, '2019-06-11 06:13:31', '2019-06-11 06:13:31'),
(11, 80, 136, '2019-06-11 06:26:22', '2019-06-11 06:26:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_info`
--
ALTER TABLE `tbl_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=831;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
