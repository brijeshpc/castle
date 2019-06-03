-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 24, 2019 at 03:38 PM
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
('08c78017d88b5a25a9817069d50fd7766b70d3bb0f9fbe04867eb3176a9219415d892b3f5eb9c1bc', 7, 1, 'MyApp', '[]', 0, '2019-05-16 06:56:44', '2019-05-16 06:56:44', '2020-05-16 12:26:44'),
('099b166f504311e1308c98723bee3599370255f23801f006514ea764a9b54593e4239d1b56a2f52a', 16, 1, 'castle', '[]', 0, '2019-05-17 08:11:40', '2019-05-17 08:11:40', '2020-05-17 13:41:40'),
('0f0c50a8b7a0a6dfa22a430c3e30a75ad819a6130a5b410feef31121fe93f876ae527bc7029f3a30', 39, 1, 'MyApp', '[]', 0, '2019-05-17 09:57:49', '2019-05-17 09:57:49', '2020-05-17 15:27:49'),
('103959905e86ee165dce5c7ca6106262e3bd988d8dee835fd7d1e318b7335b1709d4e7e016553e25', 55, 1, 'castle', '[]', 0, '2019-05-22 00:28:06', '2019-05-22 00:28:06', '2020-05-22 05:58:06'),
('11dd23caf1a1b1b56397ce77df60be8f9849bde618d71f4bf92f003525cc00dfa2ed384b6c22a729', 3, 1, 'MyApp', '[]', 0, '2019-05-23 03:03:43', '2019-05-23 03:03:43', '2020-05-23 08:33:43'),
('164132a14a0e23ba4c5360407b8be39e4122b9ea6fd57a51e418bd31144bfce9051ec26e579803e1', 9, 1, 'MyApp', '[]', 0, '2019-05-16 07:18:14', '2019-05-16 07:18:14', '2020-05-16 12:48:14'),
('1a1ff4fabefc35115a41a9bf000728ee8cd67cb0704b8da7580946db912b1cf67dfdd985fa8b6e45', 16, 1, 'castle', '[]', 0, '2019-05-17 06:23:02', '2019-05-17 06:23:02', '2020-05-17 11:53:02'),
('1e1390fc078107fe35a632d10e80c166d69c548005077c3e5a9e2736edcb832cb439166696c5ae62', 20, 1, 'MyApp', '[]', 0, '2019-05-17 09:21:54', '2019-05-17 09:21:54', '2020-05-17 14:51:54'),
('1e5a56cfec17ae36e2662543eefae2d9fc70a592aafe022d675c2857fbd78f2e77a08984798890a8', 35, 1, 'MyApp', '[]', 0, '2019-05-17 09:51:34', '2019-05-17 09:51:34', '2020-05-17 15:21:34'),
('206024b151086c6c32f8aa8472192b3a5114923d8e2af716d82ee23e343853f95d98b5ff81191280', 5, 1, 'castle', '[]', 0, '2019-05-24 01:02:23', '2019-05-24 01:02:23', '2020-05-24 06:32:23'),
('21dfef32f7cf83512264480cfb8c8368d776e21cb5b65b1397d3fe777fddd5ef95547475b835c8a9', 19, 1, 'MyApp', '[]', 0, '2019-05-17 09:09:53', '2019-05-17 09:09:53', '2020-05-17 14:39:53'),
('26dad33892b121c2e84e00f721b1c04feb649833b74291c1bd49a69dd77e851474cf920da0c6d41b', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:46', '2019-05-22 00:27:46', '2020-05-22 05:57:46'),
('2a7f7feb972619e825146b86cba5ee6f698bc2da135b107a4f8fc85ffa12396e25bba3130dadc529', 27, 1, 'MyApp', '[]', 0, '2019-05-17 09:37:53', '2019-05-17 09:37:53', '2020-05-17 15:07:53'),
('36ac7d239da0d155a0f65609e3f281cbe9e2ba1d33c9896842a7f17848ad36c73b8b8742bc7358af', 46, 1, 'castle', '[]', 0, '2019-05-22 04:32:33', '2019-05-22 04:32:33', '2020-05-22 10:02:33'),
('3aec1bfa62d058e70651a40122f2dc92421eba97ba109950fe710d1f8476880790b1e9e70514220d', 45, 1, 'MyApp', '[]', 0, '2019-05-20 01:01:35', '2019-05-20 01:01:35', '2020-05-20 06:31:35'),
('3c315944ef88a2459d35c80ab3501d56160abfd4fa25424f4b7ec79c7ac591e3ae5344aeaed9c58d', 12, 1, 'MyApp', '[]', 0, '2019-05-17 02:50:27', '2019-05-17 02:50:27', '2020-05-17 08:20:27'),
('41944d4beae5b8fd8ac95bb9d3ec4380aa3f1c1baf3c54e7ae57decab255750c8897950c5ee2e9d8', 55, 1, 'castle', '[]', 0, '2019-05-22 00:24:23', '2019-05-22 00:24:23', '2020-05-22 05:54:23'),
('41c5a188043c313c249d0d3555929f14aace9844df559f67ab242fe90b9af84cebc62cd084145a14', 13, 1, 'MyApp', '[]', 0, '2019-05-17 05:14:12', '2019-05-17 05:14:12', '2020-05-17 10:44:12'),
('48a3c4b7ff4928b26d86375f1105e19cf021df55670e91c4907bfd7f72b6148bded035bf50581459', 14, 1, 'MyApp', '[]', 0, '2019-05-17 05:39:19', '2019-05-17 05:39:19', '2020-05-17 11:09:19'),
('48d6adc5286f347b0e88c2a57f95f71e35ab2a519df30e14fbc613686bd222df42e7450c2ac3e3da', 10, 1, 'MyApp', '[]', 0, '2019-05-16 07:20:15', '2019-05-16 07:20:15', '2020-05-16 12:50:15'),
('4e81e73d5438e0918f6a5298e0f0f8025890ce8a6de7367c9892c858bfbe2a640060451e1ecdb62f', 18, 1, 'castle', '[]', 0, '2019-05-17 10:10:35', '2019-05-17 10:10:35', '2020-05-17 15:40:35'),
('4fd26fea7adc9a07bf9f427766f217e728865ebf44da1e839d5df163b12909cfe64d1a88c3b45fe0', 16, 1, 'MyApp', '[]', 0, '2019-05-17 06:22:13', '2019-05-17 06:22:13', '2020-05-17 11:52:13'),
('5367c524678496b7d2a5c293eaf6d937d6ca5a6b4f106a3337ed89bcea30476f5ddda90087448be3', 55, 1, 'castle', '[]', 0, '2019-05-22 00:24:25', '2019-05-22 00:24:25', '2020-05-22 05:54:25'),
('55a7ba5adc956f75162d884733f0edf5c3c172125536ddfc68b56cc0b9e63548d2b38ea822b686db', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:42', '2019-05-22 00:23:42', '2020-05-22 05:53:42'),
('568d851f1afa0d2772ea9cedbf0173726856ea6e050b932850ac0159c8c0cfc62affaabad519f828', 1, 1, 'castle', '[]', 0, '2019-05-23 03:01:04', '2019-05-23 03:01:04', '2020-05-23 08:31:04'),
('622b0ea04964c949f9c4a7be766d81be7651fee0761cf0d499bc1a3358b0dc931ee4f02009274ceb', 60, 1, 'MyApp', '[]', 0, '2019-05-23 02:52:33', '2019-05-23 02:52:33', '2020-05-23 08:22:33'),
('6a35915f6b762f5089de642feb8d7e1517d214dff3494735f627edab07669e33e4616a48bf9b0b29', 59, 1, 'MyApp', '[]', 0, '2019-05-23 02:47:32', '2019-05-23 02:47:32', '2020-05-23 08:17:32'),
('6ddc06c4b978972b4bcea11579a756a6db098b5049d54e5d98d901562f2d76a65f2ef0dec90710e3', 44, 1, 'MyApp', '[]', 0, '2019-05-17 10:11:13', '2019-05-17 10:11:13', '2020-05-17 15:41:13'),
('6f3e4819457d49e3e2c43cbfb517110c5c48766620a898c613a1eba19ac203246c7f260bd2eab307', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:49', '2019-05-22 00:27:49', '2020-05-22 05:57:49'),
('706388a335c2b4605bd7917e204eb14899db130107930f97520bae77dc5c1455071408202a2b7f23', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:49', '2019-05-22 00:20:49', '2020-05-22 05:50:49'),
('730b838a83b9fe5bedf26b726781b90980d3568b6a498096c0bbe9f0f9e2bd48cbdd4b02c1da0d4e', 14, 1, 'castle', '[]', 0, '2019-05-17 05:40:36', '2019-05-17 05:40:36', '2020-05-17 11:10:36'),
('73c30f583f6ad035b06995a5953ebd063816c7296809332d6fe3ee5fe0d7ffaf030f6999867911d0', 53, 1, 'MyApp', '[]', 0, '2019-05-22 00:17:09', '2019-05-22 00:17:09', '2020-05-22 05:47:09'),
('779d6b83bdb8a69ebb7a209a2befe0036a0e1f6d278f86a6fb85a527f7df5323f38b33aeef21722e', 48, 1, 'MyApp', '[]', 0, '2019-05-22 00:14:25', '2019-05-22 00:14:25', '2020-05-22 05:44:25'),
('77d09d7cf69f7f599757ab75b86c7d38cc68e0f457bace09116387206105a553ddbc726d0a57b24f', 29, 1, 'MyApp', '[]', 0, '2019-05-17 09:41:31', '2019-05-17 09:41:31', '2020-05-17 15:11:31'),
('798259ee164bc352db28d4b52202eda7c9a148d6cb5e046090ced31db6ed408b77247b22f8305977', 34, 1, 'MyApp', '[]', 0, '2019-05-17 09:51:27', '2019-05-17 09:51:27', '2020-05-17 15:21:27'),
('7a15c4714560ad15ccf824ac09320cb421cd514c614b3f13c4c3edbb4861f832dc78fb230ce50faf', 4, 1, 'castle', '[]', 0, '2019-05-24 01:23:01', '2019-05-24 01:23:01', '2020-05-24 06:53:01'),
('7b55958e3158f1901b34cb11d25e76941ddbd9b8690e778d4b2c979d985fc82270ff01209ee49929', 23, 1, 'MyApp', '[]', 0, '2019-05-17 09:32:29', '2019-05-17 09:32:29', '2020-05-17 15:02:29'),
('7bfa99813e0e0bc89b45f725191d4e7eb6d7fc20ee07139a76deb31ce55b92fcb1c27b2da53e1efc', 15, 1, 'MyApp', '[]', 0, '2019-05-17 05:39:27', '2019-05-17 05:39:27', '2020-05-17 11:09:27'),
('80d7c860303bffda05826d7b00f24e099a40433eabde67bb2ecceab9ddb3f15f1406ab9272fce987', 2, 1, 'castle', '[]', 0, '2019-05-17 05:30:02', '2019-05-17 05:30:02', '2020-05-17 11:00:02'),
('8281c2037a7b3d8ef9b1f80a5121a1289570caa27f27d45f9061dd53db3f3b254ab6cc57d068800c', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:07', '2019-05-22 00:23:07', '2020-05-22 05:53:07'),
('83f9d99445e709c198e2435de166340603a89e188e618fd9d32626af9f9020f886625d96cbc0c497', 26, 1, 'MyApp', '[]', 0, '2019-05-17 09:35:17', '2019-05-17 09:35:17', '2020-05-17 15:05:17'),
('84498257e40a7629808c6230116b173c1e72dd75e276f4b347c4e76a39056fa27549eecfeb5b17e7', 8, 1, 'MyApp', '[]', 0, '2019-05-16 06:57:17', '2019-05-16 06:57:17', '2020-05-16 12:27:17'),
('8880b36eee873e86c25d0d104efd379631e12cbde197b2efe182f0c52d6402c327bfffe3c652d3b8', 55, 1, 'castle', '[]', 0, '2019-05-22 00:19:22', '2019-05-22 00:19:22', '2020-05-22 05:49:22'),
('8a11ba7bb0be3152aba39d48ccf1fac87cb12eb675db020ce49cd30d85ab5923e6cb7ac951582494', 55, 1, 'castle', '[]', 0, '2019-05-22 00:27:56', '2019-05-22 00:27:56', '2020-05-22 05:57:56'),
('8ab86a6dae37aad09af445365f70784bdce2fde0ffc8bc0332c5a3c3842f2d56b6d116f5c4eba99f', 2, 1, 'castle', '[]', 0, '2019-05-17 04:55:06', '2019-05-17 04:55:06', '2020-05-17 10:25:06'),
('8bcf039bc18f5ac0a77704efe7a990342477212a56b795d64af99c7d6a4d12e1d654226f0e529688', 55, 1, 'MyApp', '[]', 0, '2019-05-22 00:18:49', '2019-05-22 00:18:49', '2020-05-22 05:48:49'),
('8c66a40e8bc01f187d77c842f1b259e531498a81c68067574c96d4d4ee625e071d2c7786be353ba6', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:08', '2019-05-22 00:20:08', '2020-05-22 05:50:08'),
('91866c0682951a42e28f9c0582bba7eae264e7054ccd94ffce5307dc11d5c25c5198d05a4f578bb6', 38, 1, 'MyApp', '[]', 0, '2019-05-17 09:56:21', '2019-05-17 09:56:21', '2020-05-17 15:26:21'),
('958e1c34e460a4a574292538cfeac710b3a4b68faae2dbd1f9ff5051ee9f06be22878116a10a6062', 15, 1, 'castle', '[]', 0, '2019-05-17 05:40:46', '2019-05-17 05:40:46', '2020-05-17 11:10:46'),
('96f1b2f335840dd3463a83eb22beb1e31ee1e53a7bacff002727bfea00092f445cef2862152e691f', 54, 1, 'MyApp', '[]', 0, '2019-05-22 00:17:49', '2019-05-22 00:17:49', '2020-05-22 05:47:49'),
('98b820f67220f2518ebe6051271c3cc423e3a8bd8a2a2a7a89c6747d8336cc284c1a17d0a1b922d8', 2, 1, 'castle', '[]', 0, '2019-05-17 05:13:42', '2019-05-17 05:13:42', '2020-05-17 10:43:42'),
('9a4703b74243c4d6e17e6525719f3ee23b57df0e55267a1d58e74ab2120bdf5a82bbb6fac86b7d86', 22, 1, 'MyApp', '[]', 0, '2019-05-17 09:23:07', '2019-05-17 09:23:07', '2020-05-17 14:53:07'),
('9de916f22a8844c564e495b08000cd8d26bb877e9b8ef226cd164eb5fbe7ab704a50c121e27a9b1d', 52, 1, 'MyApp', '[]', 0, '2019-05-22 00:16:42', '2019-05-22 00:16:42', '2020-05-22 05:46:42'),
('a5336c9d3b699602f307cbb4f9d9db9b190aa7d11e0247686b759fd425d147d648ef906e3c9071b2', 33, 1, 'MyApp', '[]', 0, '2019-05-17 09:47:40', '2019-05-17 09:47:40', '2020-05-17 15:17:40'),
('a6b72b9a036f3226024537afef8de215890c290ff7a1c847882e5ada251127cf21d3de3f54b0fac6', 43, 1, 'MyApp', '[]', 0, '2019-05-17 10:08:15', '2019-05-17 10:08:15', '2020-05-17 15:38:15'),
('a7e61b2299191e3cf07890584c61b1632fafc65d0d65f0ad8a99366437b2bd131a4de557a7be9a9b', 55, 1, 'castle', '[]', 0, '2019-05-22 00:20:49', '2019-05-22 00:20:49', '2020-05-22 05:50:49'),
('a8e6362414cce05c290153709e80782c2a9adf1671956bc07aec5a8ac403cbde030f2971b369dcef', 58, 1, 'MyApp', '[]', 0, '2019-05-23 02:43:36', '2019-05-23 02:43:36', '2020-05-23 08:13:36'),
('a915e6c9dbc529c8b019f166cfd05c940b2fcaf4ba3f71b32639e490c036a66ce008318afce746ee', 47, 1, 'MyApp', '[]', 0, '2019-05-22 00:13:51', '2019-05-22 00:13:51', '2020-05-22 05:43:51'),
('ab192d46627efc8d8074351a8778f1e5e14e882fd4eaef3137effb7f1266dfc86eb4708119e019f6', 28, 1, 'MyApp', '[]', 0, '2019-05-17 09:40:11', '2019-05-17 09:40:11', '2020-05-17 15:10:11'),
('af6442d7aaddec99fe43d4dfca755e2983f5037eb9b91e1aae726a4071948125e2302ee40f62a6ce', 36, 1, 'MyApp', '[]', 0, '2019-05-17 09:52:20', '2019-05-17 09:52:20', '2020-05-17 15:22:20'),
('b0dc156ec823113ed7e3d1b18f5f21fa81ec7598d1e3cefbc75e3b1ec8522de86ae85e85b80f1149', 30, 1, 'MyApp', '[]', 0, '2019-05-17 09:43:55', '2019-05-17 09:43:55', '2020-05-17 15:13:55'),
('b682465b5e91a0b987740c67fbe8d9cbdec093f6cab44e01ccfeb8e6423a8940a819ca022571481b', 21, 1, 'MyApp', '[]', 0, '2019-05-17 09:22:43', '2019-05-17 09:22:43', '2020-05-17 14:52:43'),
('b68f41e6d7813ea2f97b2697b4c9ba0a97f7efcd31edb199cb61c85ae317a4d3f84cd7219b859942', 24, 1, 'MyApp', '[]', 0, '2019-05-17 09:33:57', '2019-05-17 09:33:57', '2020-05-17 15:03:57'),
('b7450dcd24221ac9efb44c07ddeb8c76e5c4e7d90a766cce34364b1899717ddeb210140e5ce22d2e', 1, 1, 'MyApp', '[]', 0, '2019-05-23 02:58:04', '2019-05-23 02:58:04', '2020-05-23 08:28:04'),
('ba65c7481a1a64bb24f0d10a1ae377df10d74267695d2d2866393c39e974edc62de424072a44d6d9', 51, 1, 'MyApp', '[]', 0, '2019-05-22 00:16:14', '2019-05-22 00:16:14', '2020-05-22 05:46:14'),
('bc1ba8c945ae6729b5028ec3475ff31017f08e28e4722f150680cbb8612fd740da69a66c4f88148b', 44, 1, 'castle', '[]', 0, '2019-05-17 10:11:42', '2019-05-17 10:11:42', '2020-05-17 15:41:42'),
('c121c7576315e6131ccf73e870b1a2d452c5edff49693ce7612134a7a6c826fe7cea3558df4c754e', 57, 1, 'MyApp', '[]', 0, '2019-05-23 02:36:17', '2019-05-23 02:36:17', '2020-05-23 08:06:17'),
('c1299f6c74b6ea90b2e5d018564134bba7571e4bf03184bdb6b1f74cd3531d9ddecb468c2275cb16', 25, 1, 'MyApp', '[]', 0, '2019-05-17 09:34:25', '2019-05-17 09:34:25', '2020-05-17 15:04:25'),
('c457294dc8335b06e5c996fa1b9836a426ada837604f7a372b63d89c3f8ad83033925ab027276335', 4, 1, 'castle', '[]', 0, '2019-05-24 05:37:06', '2019-05-24 05:37:06', '2020-05-24 11:07:06'),
('c59c7f69b59b116e36145561d4d853011b38393eea85ce7f1e85c7230be3fc45fb93d9b638ae3155', 41, 1, 'MyApp', '[]', 0, '2019-05-17 10:03:15', '2019-05-17 10:03:15', '2020-05-17 15:33:15'),
('c6ebbef3a582d55a0f697aeb001016e920c9ef4eee97f303412cfeeb32ccee394d77e1ed16a233ae', 17, 1, 'MyApp', '[]', 0, '2019-05-17 08:59:35', '2019-05-17 08:59:35', '2020-05-17 14:29:35'),
('ca6c794efd9987f63ca8d11ada273353d549cb1d2cbff56f6019637493e5d5b17324834fcf3f3b46', 49, 1, 'MyApp', '[]', 0, '2019-05-22 00:14:38', '2019-05-22 00:14:38', '2020-05-22 05:44:38'),
('cf84854197ed3803d4c7ec664afe0fbac6aa5a2c104f054bcaa8e16052c590a2128167a6ab04e0a0', 31, 1, 'MyApp', '[]', 0, '2019-05-17 09:44:55', '2019-05-17 09:44:55', '2020-05-17 15:14:55'),
('d404cfb25e3553344173b0b0905bfacd308a116ecca140c4dc606919ee30eedcb881c518257a0fe2', 46, 1, 'castle', '[]', 0, '2019-05-22 04:33:38', '2019-05-22 04:33:38', '2020-05-22 10:03:38'),
('d4c26e783672696e68c6527b82b5a2781ccd409f9c68c942373d1bd9e3c635fd34c8f34de558e448', 42, 1, 'MyApp', '[]', 0, '2019-05-17 10:03:27', '2019-05-17 10:03:27', '2020-05-17 15:33:27'),
('d99ab4ef0fef481041900da043973767bc2cfebe436ad3830d827ded52d9b7859b7d9d755eafb40e', 50, 1, 'MyApp', '[]', 0, '2019-05-22 00:15:22', '2019-05-22 00:15:22', '2020-05-22 05:45:22'),
('db30d7c5f8a3cdc647cc5f693b8e29a9139ed01e9bb0c2dc2e79d9a6df134165a28e5049e97c9642', 32, 1, 'MyApp', '[]', 0, '2019-05-17 09:47:25', '2019-05-17 09:47:25', '2020-05-17 15:17:25'),
('e425d2f8472c01bd7bd2086ff348035c0e9595f2a68a8b80b252e681974056f07fea3c70ece4914a', 18, 1, 'MyApp', '[]', 0, '2019-05-17 08:59:45', '2019-05-17 08:59:45', '2020-05-17 14:29:45'),
('e902384f78083952243ff9781b6ff3c26c0acd59821dcc2e6e383bff7e1400c27be85bec492af389', 40, 1, 'MyApp', '[]', 0, '2019-05-17 09:58:07', '2019-05-17 09:58:07', '2020-05-17 15:28:07'),
('ead0940d147da546440b46ae6904a842385044a0157698fb43c21ce4df2b9fb8f5611bcb45a18637', 61, 1, 'MyApp', '[]', 0, '2019-05-23 02:54:56', '2019-05-23 02:54:56', '2020-05-23 08:24:56'),
('f09c5f33a25a1385ef6d993c330770fd5c1ac5b2e98258df949f51f906a30e2888e9055cae612d80', 2, 1, 'MyApp', '[]', 0, '2019-05-23 03:01:20', '2019-05-23 03:01:20', '2020-05-23 08:31:20'),
('f929999b58144b08100e0ad79171a28fdce7df8d267adec183e2c6e4afeb1979d7a6fc1b4b099564', 56, 1, 'MyApp', '[]', 0, '2019-05-23 02:14:46', '2019-05-23 02:14:46', '2020-05-23 07:44:46'),
('fa17a15e74e0b687c1c038f6ec7f6571c84ba159d5cfe9996ee1dca9e02a91627ef5b4ccc21eb188', 46, 1, 'castle', '[]', 0, '2019-05-21 04:05:14', '2019-05-21 04:05:14', '2020-05-21 09:35:14'),
('fb4e6f04392e694b32f7e61a57975a6198366bef77348fb7faf425c66f284909dfa1a1363ebfb62f', 55, 1, 'castle', '[]', 0, '2019-05-22 00:23:02', '2019-05-22 00:23:02', '2020-05-22 05:53:02'),
('fc30a9d9f4c6c3e046a5b4cd2f432286f79f384b1798a0c65db1551cc93db57263b50490ff72663a', 46, 1, 'MyApp', '[]', 0, '2019-05-21 04:03:00', '2019-05-21 04:03:00', '2020-05-21 09:33:00'),
('ff30fe31c2159d58db63305c028e0a29502430f059a4084d0805ce715f5db19ea1139c6f9f79a25b', 37, 1, 'MyApp', '[]', 0, '2019-05-17 09:55:44', '2019-05-17 09:55:44', '2020-05-17 15:25:44');

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
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `external_product_id` bigint(20) DEFAULT NULL,
  `external_product_id_type` text,
  `manufacturer` text,
  `item_type` varchar(255) DEFAULT NULL,
  `unit_count` bigint(20) DEFAULT NULL,
  `unit_count_type` varchar(100) DEFAULT NULL,
  `standard_price` float DEFAULT NULL,
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
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `feed_product_type`, `item_sku`, `brand_name`, `item_name`, `external_product_id`, `external_product_id_type`, `manufacturer`, `item_type`, `unit_count`, `unit_count_type`, `standard_price`, `quantity`, `update_delete`, `main_image_url`, `other_image_url1`, `other_image_url2`, `other_image_url3`, `product_description`, `bullet_point1`, `bullet_point2`, `bullet_point3`, `bullet_point4`, `bullet_point5`, `color_name`, `is_adult_product`, `created_at`, `updated_at`) VALUES
(1, 'healthmisc', 'END8INBLK', 'Enduro', 'Enduro 8Inch Dildo - Realistic Head And Veins, Waterproof, Easy To Clean (Black)', 707676016815, 'UPC', 'Enduro', 'dildos', 1, 'Count', 39.99, 636, 'Update', 'https://www.castlemegastore.com/amz/707676016815.jpg', NULL, NULL, NULL, 'Be astonished by the pleasure the Enduro 8in dildo will give you! Realistic head and veins will trick you into thinking that it is the real thing. The curve of the dildo will help hit that g-spot. All Enduro products are body-safe and phthalate-free. Will you endure the Enduro?', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(2, 'healthmisc', 'PASSSWIRBLU', 'Passions', 'Passions Swirl Vibe Blue', 707676044153, 'UPC', 'Passions', 'vibrators', 1, 'Count', 22.99, 636, 'Update', 'https://www.castlemegastore.com/amz/707676044368.jpg', NULL, NULL, NULL, 'If you’ve been looking for a slick, versatile vibe that’s up for anything you are, look no further than the Swirl from the celebrated Passions collection. A discreet but effective design takes the guesswork out of stimulating multiple erogenous zones to perfection. A powerful motor and multi-speed operation ensure orgasms are always on the menu for you and your partner.\n• Made of slick, seamless ABS that feels wonderful against your most intimate sweet spots.\n• At just 7 inches long, the Swirl is big enough to get the job done, but small enough to take on the go without a second thought.\n• A tapered tip and undulating shaft work to awaken every last nerve ending.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Blue', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(3, 'healthmisc', 'JPDONGBLU', 'Jelly Pleasures', 'Jelly Pleasures Dong - 7 Inch, Anti-Bacterial Formula, Stimulating Texture And Feel (Blue)', 707676044351, 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', 19.99, 624, 'Update', 'https://www.castlemegastore.com/amz/707676044351.jpg', NULL, NULL, NULL, 'Jelly Pleasures has mastered the art of dongs. This 7.5\" dong is perfect for anyone\'s toy chest. \n\n- Body-safe material.\n\n- Anti-bacterial formula makes it safe and easy to clean.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Blue', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(4, 'healthmisc', 'JPDONGPNK', 'Jelly Pleasures', 'Jelly Pleasures Dong - Soft And Flexible, Body-Safe, Stimulating Texture (Pink)', 707676044320, 'UPC', 'Jelly Pleasures', 'dildos', 1, 'Count', 19.99, 622, 'Update', 'https://www.castlemegastore.com/amz/707676044320.jpg', NULL, NULL, NULL, 'Bring the excitement of the bedroom to all new levels with the Jelly Pleasures 7\" Dong. No toy chest is complete without a great dong.\n\n- Stimulating Texture and feel, for that realistic feel.\n\n- Soft and Flexible\n\n- Made from body-safe and Phthalate free PVC.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(5, 'healthmisc', 'PRETTYPAPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Hypoallergenic Body-Safe, Waterproof, Easy To Clean', 707676016747, 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', 14.99, 619, 'Update', 'https://www.castlemegastore.com/amz/707676016747.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Plum', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(6, 'healthmisc', 'FPPDUWHBULL', 'Fetish Pleasure Play', 'Dual Glow-In-The-Dark Bullet Vibe (White)', 707676044375, 'UPC', 'Fetish Pleasure Play', 'vibrators', 1, 'Count', 19.99, 616, 'Update', 'https://www.castlemegastore.com/amz/707676044375.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'White', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(7, 'healthmisc', 'FPPSIL3RINGENH', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone 3Ring Penis And Balls Enchancer', 707676049479, 'UPC', 'Fetish Pleasure Play', 'penis-rings', 1, 'Count', 9.99, 615, 'Update', 'https://www.castlemegastore.com/amz/707676049479.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(8, 'healthmisc', 'CONNEZRELRNG', 'Connecto', 'Connecto Easy Release Double Cock Ring Set (Black)', 707676036363, 'UPC', 'Connecto', 'penis-rings', 1, 'Count', 12.99, 612, 'Update', 'https://www.castlemegastore.com/amz/707676036363.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove double ring from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(9, 'healthmisc', 'JWBLUBOY3WAY', 'Junkwear', 'Junkwear Blue Boy 3Way Penis Ring For Enhanced Erections', 707676043996, 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', 19.99, 605, 'Update', 'https://www.castlemegastore.com/amz/707676043996.jpg', NULL, NULL, NULL, 'The JunkWear 3-way ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(10, 'healthmisc', 'PPANPLU', 'Pretty Pleasures', 'Pretty Pleasures Anal Plug - Easy To Use Body-Safe Anal Sex Toy (Pink)', 707676016730, 'UPC', 'Pretty Pleasures', 'butt-plugs', 1, 'Count', 14.99, 540, 'Update', 'https://www.castlemegastore.com/amz/707676016730.jpg', NULL, NULL, NULL, 'If you\'ve already conquered \'teeny weeny\', the next logical step is \'small but super\', right? Take that next step with the Pretty Pleasures small butt plug.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(11, 'healthmisc', 'JWBLKB3WAYRING', 'Junkwear', 'Junkwear Black Beauty 3 Way Erection Enhancing Penis Ring', 707676043958, 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', 19.99, 527, 'Update', 'https://www.castlemegastore.com/amz/707676043958.jpg', NULL, NULL, NULL, 'The JunkWear Black Beauty 3 Way ring design is stretchy and comfortable TPR erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-way ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(12, 'healthmisc', 'VELRATTBLK', 'Velskin', 'Velskin Rattler Vibrator - Perfect Waterproof Silicone Made Vibrating Sex Toy (Black)', 707676018482, 'UPC', 'Velskin', 'vibrators', 1, 'Count', 49.99, 515, 'Update', 'https://www.castlemegastore.com/amz/707676018482.jpg', NULL, NULL, NULL, 'All Velskin products are made from our superior proprietary blend of 100% Vel-Ultra premium silicone. Experience the amazing touch, feel and quality of Velskin. All Velskin products are phthalate free, body safe, hypoallergenic and environmentally friendly.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Discreet design', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(13, 'healthmisc', 'MRABBDACER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Daisy  - Waterproof Platinum Cured Silicone Massager (Cerise)', 707676060351, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 79.99, 500, 'Update', 'https://www.castlemegastore.com/amz/707676060351.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Daisy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(14, 'healthmisc', 'MWMAPRBALL', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits April Ballet Slipper - Waterproof Platinum Cured Silicone Massager (Purple)', 707676060368, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 79.99, 500, 'Update', 'https://www.castlemegastore.com/amz/707676060368.jpg', NULL, NULL, NULL, 'April comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(15, 'healthmisc', 'MWMMRLUCYCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Lucy - Waterproof Platinum Cured Silicone Massager (Cerise)', 707676060375, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 84.99, 500, 'Update', 'https://www.castlemegastore.com/amz/707676060375.jpg', NULL, NULL, NULL, 'Lucy comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(16, 'healthmisc', 'MWMMRMOLCER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Molly - Waterproof Platinum Cured Silicone Massager (Cerise)', 707676060382, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 89.99, 500, 'Update', 'https://www.castlemegastore.com/amz/707676060382.jpg', NULL, NULL, NULL, 'Fully rechargeable and easy to use. Molly comes with 7 deep vibrating functions. This rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(17, 'healthmisc', 'MWMMRMAECER', 'Mighty Wand Massagers', 'Powerful Mighty Rabbits Mae - Waterproof Platinum Cured Silicone Massager (Cerise)', 707676065226, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 89.99, 500, 'Update', 'https://www.castlemegastore.com/amz/707676065226.jpg', NULL, NULL, NULL, 'Mighty Rabbits pack power into a fun bunny shape! Fully rechargeable and easy to use. \n\nMae\'s dual clit stimulator is soft and flexible to hit all your hot spots? Mae also features fast gyrating technology for extra intense orgasms!\n\nThis rabbit is sure to put a little hop in your step!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Cerise', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(18, 'healthmisc', 'HPMEDPLUG', 'Hot Pinks', 'Hot Pinks Medium Butt Plug - Easy To Clean, Perfect For Anal Sex Beginners (Pink)', 707676016709, 'UPC', 'Hot Pinks', 'butt-plugs', 1, 'Count', 19.99, 496, 'Update', 'https://www.castlemegastore.com/amz/707676016709.jpg', NULL, NULL, NULL, 'A tapered, rounded tip slides in easily, while the 4\" graduated shaft gives a sensually filling experience. The narrow neck and oval base are comfortable to wear, and the flat base allows for hot solo play.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(19, 'healthmisc', 'JKICYHDUORING', 'Junkwear', 'Junkwear Icy Hot Duo Penis Ring - Ball Stretcher Made Of Body-Safe Material (Transparent)', 707676044016, 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', 19.99, 489, 'Update', 'https://www.castlemegastore.com/amz/707676044016.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(20, 'healthmisc', 'BLUEANGSTRO', 'Blue Angel', 'Blue Angel Stroker - Body-Safe Pussy Masturbator (Blue)', 707676018888, 'UPC', 'Blue Angel', 'male-masturbators', 1, 'Count', 24.99, 487, 'Update', 'https://www.castlemegastore.com/amz/707676018888.jpg', NULL, NULL, NULL, 'A great choice for solo pleasure, the Blue Angel Masturbator gives you a feeling like some of the higher end toys out there, for a much more reasonable price. The soft, smooth and stretchy jelly rubber warms to the touch as you enjoy, and the small size makes it easy to hold in hand, where you can squeeze it until the 4 rows of silver rolling beads are gripping and massaging you as tight as you like.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Blue', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(21, 'healthmisc', 'CWPLEASPEARLR', 'Cware', 'Cware Pleasure Pearl Penis Ring - Durable, Versatile, Adjustable, Made Of Silicone', 707676044023, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 14.99, 472, 'Update', 'https://www.castlemegastore.com/amz/707676044023.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Green', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(22, 'healthmisc', 'CONNEZRELCAG', 'Connecto', 'Connecto Easy Release Cock Cage - Customizable, Easy To Clean And Release (Black)', 707676036349, 'UPC', 'Connecto', 'penis-rings', 1, 'Count', 14.99, 470, 'Update', 'https://www.castlemegastore.com/amz/707676036349.jpg', NULL, NULL, NULL, 'Maintain your erection and intensify your orgasms with our easy to use and remove fully customizable Erection Enhancement System. Remove cage from package and trim to the desired size. Snap together and you\'re ready for fun!', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(23, 'healthmisc', 'FPPNEONVIBEPNK', 'Passions', 'Passions Neon Classic Mini Vibe - Body-Safe, Multi-Speed, Waterproof Pink', 707676044078, 'UPC', 'Passions', 'vibrators', 1, 'Count', 14.99, 457, 'Update', 'https://www.castlemegastore.com/amz/707676044078.jpg', NULL, NULL, NULL, 'Passions Neon Classic Mini Vibe', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'Waterproof', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(24, 'healthmisc', 'VELSPECOBROWN', 'Velskin', 'Velskin Pecos Dildo - Body-Safe Silicone, Harness Compatible, Lifetime Warranty (Brown)', 707676018390, 'UPC', 'Velskin', 'dildos', 1, 'Count', 99.99, 456, 'Update', 'https://www.castlemegastore.com/amz/707676018390.jpg', NULL, NULL, NULL, 'This Velskin Pecos Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-ultra silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Brown', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(25, 'healthmisc', 'BLACKFURLEGCUFF', 'Fetish Pleasure Play', 'Fetish Pleasure Play Furry Ankle Cuffs - Metal And Faux Fur Black', 707676001378, 'UPC', 'Fetish Pleasure Play', 'restraints', 1, 'Count', 28.99, 434, 'Update', 'https://www.castlemegastore.com/amz/707676001378.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'One size fits most', 'Keys included', 'fetish sex toys, restraints, handcuffs, fetish play toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(26, 'healthmisc', 'BANGKBALLBUS', 'Bangkok Ballbuster', 'Bangkok Ballbuster Vagina Masturbator For Men (Pink)', 707676018925, 'UPC', 'Bangkok Ballbuster', 'male-masturbators', 1, 'Count', 14.99, 431, 'Update', 'https://www.castlemegastore.com/amz/707676018925.jpg', NULL, NULL, NULL, 'Soft, tight, and stretchy masturbator. Textured pleasure chamber with closed end for enhanced suction. Maintenance free TPR.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(27, 'healthmisc', 'VELSLONGRIDBLK', 'Velskin', 'Velskin Long Rider Penis Extender - Silicone, Lifetime Warranty, Hypoallergenic (Black)', 707676018352, 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', 119.99, 428, 'Update', 'https://www.castlemegastore.com/amz/707676018352.jpg', NULL, NULL, NULL, 'It\'s the little things that make a big difference. Velskin brings this long rider penis extension to enhance your natural penis size. Apply a little water-based lube to your penis and the toy\'s canal, slide your penis inside and stretch the base of the toy over your balls, for a secure fit.\n\nSometimes it’s fine to enjoy yourself exactly the way Mother Nature made you, but every so often it’s fun to spice things up a little in the size department. The Long Rider penis extender from Velskin makes it easy to experience what a difference a little size boost can really make.\n•Made of Velskin’s own ultra-soft, lifelike silicone. Warms to the touch and perfectly mimics the feeling of real skin.\n•Makes you noticeably thicker and longer. Also desensitizes you just enough to help you go the distance.\n•Try it with a little of your favorite water-based lube for an even better experience!', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(28, 'healthmisc', 'JWSTRETCHFLEXRNG', 'Junkwear', 'Junkwear Stretch Flex Clear Penis Ring And Ball Stretcher', 707676044047, 'UPC', 'Junkwear', 'penis-rings', 1, 'Count', 6.99, 426, 'Update', 'https://www.castlemegastore.com/amz/707676044047.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Transparent', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(29, 'healthmisc', 'PASSREDTICKL', 'Passions', 'Passions Kiss Lover Mini Vibrator - Body-Safe, Seamless Design, G-Spot Stimulation (Red)', 707676044108, 'UPC', 'Passions', 'vibrators', 1, 'Count', 19.99, 423, 'Update', 'https://www.castlemegastore.com/amz/707676044108.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'G-spot stimulation', 'vibrators, female sex toys, vibrating sex toys, discreet sex toys, discreet vibrators, discreet vibrating toys', 'Red', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(30, 'healthmisc', 'PEARLESMEDPLUGPNK', 'Pearlescent', 'Pearlescent Medium Butt Plug - Perfect Anal Sex Toy (Pink)', 707676016693, 'UPC', 'Pearlescent', 'butt-plugs', 1, 'Count', 19.99, 420, 'Update', 'https://www.castlemegastore.com/amz/707676016693pearlescent-medium-bp.jpg', NULL, NULL, NULL, 'A little shine to stimulate your behind! Pearlescent\'s Butt Plug is smooth with a tapered shape ideal for first-time insertion. This plug is a small slim size for comfortable anal stimulation. The plug is firm but very flexible. Introduce a partner to the joys of mild anal stimulation. It is made from phthalate-free body safe material.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(31, 'healthmisc', 'NWBELLNIPPCLAMPS', 'Nipple Wear', 'Nipple Wear Bell Nipple Clamps - Adjustable, Rubber Tips, Made Of Metal (Black)', 707676018963, 'UPC', 'Nipple Wear', 'ball-stretchers', 1, 'Count', 12.99, 412, 'Update', 'https://www.castlemegastore.com/amz/707676018963.jpg', NULL, NULL, NULL, 'Who says a pair of nipple clamps can’t be beautiful, appealing, and effective? This strong, sexy pair is positively mesmerizing in its simplicity. Tough, stainless steel alligator clamps support a pair of black, twinkling bells to add visual and auditory appeal to your next play session.\n• Classic alligator clamps are fully adjustable to make achieving the ideal degree of pressure easy.\n• Medical grade stainless steel and tough, body-safe rubber tips make these clamps as safe, strong, and practical as they are fun to use.\n• Pretty, black bells lend a sexy, sassy touch to any fetish look or bedroom ensemble.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Waterproof', 'male sex toys, ball stretchers, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(32, 'healthmisc', 'VELSBENDALEXFLSH', 'Velskin', 'Velskin Bendable Alexandria Dildo - Harness Compatible, Bendable Spine, Lifetime Warranty', 707676046027, 'UPC', 'Velskin', 'dildos', 1, 'Count', 109.99, 407, 'Update', 'https://www.castlemegastore.com/amz/707676046027.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nFind out what a difference a little flexibility really makes when you make this bendable Velskin dildo a part of your collection. Ample proportions, premium dual-density silicone, and a bevy of stimulating details add even more pleasure to your experience.\n• With an insertable length of 9 inches and a girth of 4.75 inches, this toy really fills you up to capacity.\n• Dual-density silicone design almost perfectly mimics the real thing – hard on the inside and soft on the outside.\n• Bendable and flexible. Customize each play experience according to mood, position, activity, and more.\n• Full harness compatibility makes engaging in satisfying partnered play easy.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(33, 'healthmisc', 'CWTRISUPPRNG', 'Cware', 'Cware Tri-Support Penis Ring Set - Body-Safe Silicone, Versatile, Durable (White)', 707676043927, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 11.99, 395, 'Update', 'https://www.castlemegastore.com/amz/707676043927.jpg', NULL, NULL, NULL, 'The CWARE ring is stretchy and comfortable Silicone erection enhancer. Soft and smooth, thick and durable. The C & B ring is fully adjustable with a supportive penis shaft design.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(34, 'healthmisc', 'VELSCLINTIVOR', 'Velskin', 'Velskin Clint Ivory Dildo - Vel-Ultra Silicone, Harness Compatible, G-Spot And P-Spot Stimulation', 707676018673, 'UPC', 'Velskin', 'dildos', 1, 'Count', 109.99, 390, 'Update', 'https://www.castlemegastore.com/amz/707676018673.jpg', NULL, NULL, NULL, 'Velskin\'s Ivory Clint Dildo is ultra realistic and great for first time fun! With it\'s lifelike head for a natural feel, it has a curved shaft for precise G-Spot or P-spot stimulation! Made of 100% Vel-Ultra silicone and is harness compatible.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', 'Ivory', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(35, 'healthmisc', 'VELSAUSTFLESH', 'Velskin', 'Velskin Austin Flesh Dildo - Vel-Ultra Silicone, Harness Compatible, Lifetime Warranty', 707676018710, 'UPC', 'Velskin', 'dildos', 1, 'Count', 44.99, 388, 'Update', 'https://www.castlemegastore.com/amz/707676018710.jpg', NULL, NULL, NULL, 'This Velskin Austin Flesh Dildo has a curved shaft for precise G-Spot or P-spot stimulation. Comes with a lifelike head and glans for a natural feel and is made of 100% Vel-Ultra Silicone.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(36, 'healthmisc', 'VELSSTALLBLK', 'Velskin', 'Velskin Stallion Penis Extender - Body-Safe Silicone, Hypoallergenic, Easy To Clean (Black)', 707676018260, 'UPC', 'Velskin', 'male-masturbators', 1, 'Count', 129.99, 381, 'Update', 'https://www.castlemegastore.com/amz/707676018260.jpg', NULL, NULL, NULL, 'Enjoy longer lovemaking in every way as this black stallion extender from Velskin desensitizes you for prolonged session. It stays comfortably in place throughout lovemaking and offers you extra control to help tame your beast.\n\nWith the incredible Velskin Stallion in your corner, there’s no limit to your ability to curl your partner’s toes in bed. Add inches to your natural physique, regain total control over your orgasm, and treat your partner to additional stimulation to boot.\n• Made of premium sculpted silicone – body-safe, hypoallergenic, and phthalate-free.\n• Desensitizes you just enough to help you last as long as you like. Perfect for controlling premature ejaculation!\n• Noticeably increases your length and girth. Sculpted, lifelike design brings even more stimulation to the table for your partner. \n• Protected by a lifetime warranty.', 'Discreet packaging', 'Easy to clean', 'Sensi-Skin Technology', 'Realistic look and feel', 'Ultra smooth surface', 'male sex toys, male masturbators, ass replicas, anal sex toys for men', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(37, 'healthmisc', 'VELSBENDJULIETFLS', 'Velskin', 'Velskin Bendable Juliette Flesh Dildo - Body-Safe Silicone, Easy To Clean, Hypoallergenic', 707676046010, 'UPC', 'Velskin', 'dildos', 1, 'Count', 109.99, 373, 'Update', 'https://www.castlemegastore.com/amz/707676046010.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\n- Made from 100% body-safe silicone, which makes it easier to clean and hypoallergenic.\n\n- Constructed out of dual density silicone, which makes for a firm inner core and a soft, realistic feeling outer coat.\n\n- With a bendable spine, makes this dildo able to bend to your pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(38, 'healthmisc', 'CWARGNDDUORNG', 'Cware', 'Cware Premium Silicone Penis Rings (White)', 707676043903, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 12.99, 366, 'Update', 'https://www.castlemegastore.com/amz/707676043903.jpg', NULL, NULL, NULL, 'The CWARE duo ring and ball stretcher draws attention to your penis and testicles by pushing them forward for a provocative look. The ring makes the testicles and penis swell up a little, making them bigger and more sensitive. The toy is made of soft and stretchy material for a perfect fit, which makes it comfortable to wear. Clean the ring and ball stretcher after use with water and toy cleaner for a good hygiene.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'White', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(39, 'healthmisc', 'MWMINIBLU', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Silicone Head, Body-Safe, Batteries Included (Blue)', 707676019557, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 19.99, 362, 'Update', 'https://www.castlemegastore.com/amz/707676019557-mw-mini-blue.jpg', NULL, NULL, NULL, 'If you love the power and performance of the original Mighty Wand, you\'ll definitely want to get up close and personal with the Mighty Wand Mini as well. Enjoy the same toe-curling sensation and versatility you\'ve come to love in a compact, streamlined package that\'s easy to take along absolutely anywhere.\n• Measures in at 4.25\" with a 4\" head circumference making it easy to include in a suitcase, purse or overnight bag.\n• Made from ABS plastic and features a smooth, inviting silicone head -- body-safe, easy to care for, and capable of providing phenomenal sensation.\n• Pretty blue color and jeweled accents make this vibe as lovely to look at as it is fun to use.\n• Batteries already included!', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Blue', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(40, 'healthmisc', 'HOOKNALTPNKPLUG', 'Hook N\' Up', 'Hooknup Beaded Silicone Anal Plug (Pink)', 707676044207, 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', 24.99, 361, 'Update', 'https://www.castlemegastore.com/amz/hook n up_707676044207_4.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_1.jpg', 'https://www.castlemegastore.com/amz/hookup_707676044207_2.jpg', 'https://www.castlemegastore.com/amz/hooknup_707676044207_3.jpg', 'Tired of the normal style of butt plugs? Well then try the Hook \'N\' Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% silicone, which makes it easy to clean and is hypoallergenic.\n\n- Revolutionary beaded design helps bring your anal play to a new level', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(41, 'healthmisc', 'VELSSADDPURPL', 'Velskin', 'Velskin Saddlehorn Wand Attachment (Purple)', 707676018529, 'UPC', 'Velskin', 'vibrators', 1, 'Count', 59.99, 358, 'Update', 'https://www.castlemegastore.com/amz/707676018529.jpg', NULL, NULL, NULL, 'Velskin\'s Saddlehorn wand attachment will bring you into bliss. This all silicone attachment is smooth and has an amazing tip to reach that g-spot.\n\nIf you love the sheer oomph a wand massager brings to the table, but occasionally find yourself in the mood for more targeted stimulation, this saddlehorn-style Velskin attachment was made with you in mind. It fits right over the head of your favorite wand massager, instantly converting it into a pinpoint-accurate G-spot or P-spot stimulator.\n• Made of Velskin’s own ultra-smooth, body-safe silicone for an experience that treats your body right on every level.\n• Fits a variety of popular wand massagers including Bodywand, Magic Wand, and Mighty Wand.\n• Perfect for taking solo play to the next level, but ideal for treating a partner to a “happy ending” massage as well.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Premium Silicone', 'Magic Wand Rechargeable', 'sex toy accessories, magic wand accessories, magic wand attachments, silicone sex toys', 'Purple', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(42, 'healthmisc', 'CWAREEASTRINGPURP', 'Cware', 'Cware Elastomer Penis Ring - Ultra Flex, Stretchy, Latex Free (Purple)', 707676016297, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 12.99, 356, 'Update', 'https://www.castlemegastore.com/amz/707676016297.jpg', NULL, NULL, NULL, 'Cock rings work by restricting blood flow out of your cock. Placing this stretchy ring at the base of your cock and balls will help make your erection even bigger and veinier. It\'s a simple stretchy cock ring that gets the job done.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Purple', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(43, 'healthmisc', 'ANALISANBEADVIBE', 'Analiscious', 'Analiscious Anal Beaded Vibrator - Body-Safe, Waterproof, Multi-Speed (Purple)', 707676016631, 'UPC', 'Analiscious', 'anal-beads', 1, 'Count', 22.99, 353, 'Update', 'https://www.castlemegastore.com/amz/707676016631.jpg', NULL, NULL, NULL, 'For ultimate anal enjoyment, Analiscious Beaded Anal Vibrator will hit the spot every time. This sturdy strand of waterproof beads has a straight, precise design with vibration that resonates throughout for even stimulation and perfect pleasure. The slightly flexible beaded body has 4 beads that graduate in size, staring small and ending larger, with smooth, thinner areas in between for lots of sensation when inserting and removing. Multi-speed vibration is controlled with a simple twist dial at the base, which also has a wrist cord to keep the Beads close as you play. Takes 2 AAA batteries, sold separately.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Phthalate Free', 'Multi-speed', 'anal sex toys, anal beads, anal vibrators, anal vibrating toys, vibrating anal beads', 'Pink', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(44, 'healthmisc', 'FPPSILTHINSPANK', 'Fetish Pleasure Play', 'Fetish Pleasure Play Silicone Thin Spank Slapper (Black)', 707676054077, 'UPC', 'Fetish Pleasure Play', 'paddles', 1, 'Count', 32.99, 353, 'Update', 'https://www.castlemegastore.com/amz/707676054077-01.jpg', NULL, NULL, NULL, NULL, 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Hypoallergenic body-safe', 'Premium silicone', 'fetish sex toys, silicone sex toys, paddles, fetish play toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(45, 'healthmisc', 'VELSBENDAMALFLSH', 'Velskin', 'Velskin Bendable Amal Flesh Dildo - Made Of Silicone, Harness Compatible, Bendable Spine', 707676046003, 'UPC', 'Velskin', 'dildos', 1, 'Count', 109.99, 352, 'Update', 'https://www.castlemegastore.com/amz/707676046003.jpg', NULL, NULL, NULL, 'Velskin introduces their bendable dildo line. If you are looking for something that is more realistic and can are able to bend it for different angles, then look no further. Velskin Bendable dildos are made of dual density silicone. It has a firm inner core but a softer outer silicone layer to give the most realistic look and feel.\n\nThis premium dual-density dildo from Velskin isn’t just second to none in the realism department. Thanks to a special bendable spine, you can adjust it to reflect any angle you like. Add creativity and variety to solo sessions and partnered play alike!\n• Dual-density silicone is velvety soft on the outside and deliciously hard on the inside.\n• Adjust the angle of your toy to better stimulate your sweet spots, explore new positions, and more.\n• Harness compatibility makes it easy to play with a partner exactly the way you want to.\n• Ample but realistic proportions and thoughtful texturing add realism to your experience.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(46, 'healthmisc', 'HOOKNALTSILBLU', 'Hook N\' Up', 'Hooknup Medical Grade Silicone Plug (Blue)', 707676045358, 'UPC', 'Hook N\' Up', 'butt-plugs', 1, 'Count', 24.99, 349, 'Update', 'https://www.castlemegastore.com/amz/hnu-707676045358-01.jpg', NULL, NULL, NULL, 'Tired of the normal style of butt plugs? Well then try the Hook \'N Up Beaded Anal Plug. With alternating sized beads will bring your anal play to a new level.\n\n- Made from 100% medical grade silicone, which makes it easy to clean, take care of, and is hypoallergenic.\n\n- Revolutionary alternating beaded design helps bring your anal play to a new level.', 'Discreet packaging', 'Easy to clean', 'Phthalate Free', 'Waterproof', 'Hypoallergenic body-safe', 'anal sex toys, female sex toys, male sex toys, anal plugs, ass plugs, anal masturbation toys', 'Blue', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(47, 'healthmisc', 'CWTRIMETALRNG', 'Cware', 'Cware Tri Metal Ring Set', 707676016440, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 7.99, 348, 'Update', 'https://www.castlemegastore.com/amz/707676016440.jpg', NULL, NULL, NULL, 'A triple set of ultra sturdy, sleek and shiny metal cock rings from Spartacus, this advanced set is a step up from stretchy varieties, offering a more secure, unyielding feel for ultra impressive results and a fantastic look.', 'Discreet packaging', 'Easy to clean', 'Metal', 'Waterproof', 'Hypoallergenic body-safe', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(48, 'healthmisc', 'MWMMINIPURPL', 'Mighty Wand Massagers', 'Mighty Wand Mini Massager - Portable, Travel-Friendly, Made Of Silicone (Purple)', 707676019564, 'UPC', 'Mighty Wand Massagers', 'vibrators', 1, 'Count', 19.99, 346, 'Update', 'https://www.castlemegastore.com/amz/707676019564-mw-mini-purple.jpg', NULL, NULL, NULL, 'You already love wand vibrators like the Mighty Wand for the sheer versatility they bring to the table. Now you can take your creative pleasure sessions to even greater heights with the fabulous Mighty Wand Mini - all the power and oomph of the original, but in a convenient compact package.\n\n- Portable, travel-friendly size - 4.25\" in length with a 4\" head circumference.\n\n- Made of smooth, silky silicone and ABS plastic for an experience that not only feels great, but is completely body-safe as well.\n\n- Easy to clean and care for.\n\n- Looks fantastic as it functions with a flirty purple color scheme and jeweled accents.\n\n- Perfect for both solo sessions and partner play.\n\n- Batteries included.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Multi-speed', 'USB Rechargeable', 'vibrators, female sex toys, premium sex toys, vibrating sex toys, discreet sex toys, rabbit vibrators, vibrating rabbits', 'Purple', '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(49, 'healthmisc', 'CHAMP6INDILDMED', 'Champions', 'Champions 6 Inch Silicone Dildo Medalist - Harness Compatible, Suction Cup Base', 707676033942, 'UPC', 'Champions', 'dildos', 1, 'Count', 99.99, 335, 'Update', 'https://www.castlemegastore.com/amz/707676033942.jpg', NULL, NULL, NULL, 'Champions dildos are ultra premium pleasure silicone cocks that are handcrafted with amazing detail and feel. Experience Champions dual density silcione, the perfect combination of rigidity and softness. \"The Real Ride\" the perfection of pleasure.', 'Discreet packaging', 'Easy to clean', 'Hypoallergenic body-safe', 'Waterproof', 'Realistic feel', 'female sex toys, waterproof sex toys, realistic feel sex toys, dongs, anti-bacterial sex toys', NULL, '2019-05-22 12:14:43', '2019-05-22 12:14:43'),
(50, 'healthmisc', 'CWTRISUPPRINGSET', 'Cware', 'Cware Tri-Support Ring Set Black', 707676043910, 'UPC', 'Cware', 'penis-rings', 1, 'Count', 11.99, 334, 'Update', 'https://www.castlemegastore.com/amz/707676043910.jpg', NULL, NULL, NULL, 'The Fetish Pleasure Play 3-ring design is stretchy and comfortable Silicone erection enhancer. It can gently separate the testicles while also providing the pleasurable effects of multiple rings. Soft and smooth, thick and durable. The 3-ring design is fully adjustable with a supportive design for pleasurable erection enhancement.', 'Discreet packaging', 'Easy to clean', 'Premium Silicone', 'Soft and stretchy', 'Satin finish', 'males sex toys, penis rings, cock rings, mens sex toys, mens sex accessories, male sex enhancers, silicone sex toys', 'Black', '2019-05-22 12:14:43', '2019-05-22 12:14:43');

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
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `title`, `image`, `sort_order`, `created_at`, `updated_at`) VALUES
(5, 'Title4', '1558439516.jpeg', NULL, '2019-05-21 06:21:56', '2019-05-21 06:21:56'),
(7, 'Slide1', '1558525085.jpeg', NULL, '2019-05-22 06:08:05', '2019-05-22 06:08:05'),
(8, 'Title4', '1558525139.jpeg', NULL, '2019-05-22 06:08:59', '2019-05-22 06:08:59'),
(9, 'asdasdasd', '1558525502.jpeg', NULL, '2019-05-22 06:15:02', '2019-05-22 06:15:02'),
(10, 'EEEEE', '1558525579.jpeg', NULL, '2019-05-22 06:16:19', '2019-05-22 06:16:19'),
(11, 'sdfsdf', '1558525593.jpeg', NULL, '2019-05-22 06:16:33', '2019-05-22 06:16:33'),
(12, 'Title7', '1558526701.jpeg', NULL, '2019-05-22 06:35:01', '2019-05-22 06:35:01');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `first_name`, `last_name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `facebook_id`, `gmail_id`, `access_token`, `timezone`, `device_id`, `address`, `city`, `country`, `state`, `zip`, `type`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, NULL, 'mohit@gmail.com', 'users/default.png', NULL, '$2y$10$8kuuRyVoem9ofimi4DdXKeGZynDJLcuZ6VnFPtutnCAtJ89ZVI8/y', NULL, NULL, '', '', NULL, '2019-05-23 02:58:04', NULL, NULL, NULL, NULL, NULL, NULL, 2, '2019-05-23 02:58:04', '2019-05-23 02:58:04'),
(2, NULL, NULL, NULL, NULL, 'iphonex9313@gmail.com', 'users/default.png', NULL, '', NULL, NULL, '', '109110582642133495874', NULL, '2019-05-23 03:01:20', NULL, NULL, NULL, NULL, NULL, NULL, 2, '2019-05-23 03:01:20', '2019-05-23 03:01:20'),
(3, NULL, NULL, NULL, NULL, 'democoder2223@gmail.com', 'users/default.png', NULL, '', NULL, NULL, '371056357088889', '', NULL, '2019-05-23 03:03:43', NULL, NULL, NULL, NULL, NULL, NULL, 2, '2019-05-23 03:03:43', '2019-05-23 03:03:43'),
(4, NULL, 'brijesh', NULL, NULL, 'castle@gmail.com', 'users/default.png', NULL, '$2y$10$luxKRCjcd2rHmq3Mrg53sO.4ti3.tonmkjRXMBpA2pZef7nK7.TDu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2019-05-24 00:13:07', '2019-05-24 00:13:07'),
(5, NULL, NULL, NULL, NULL, 'mdddsdfdsfsohitwill@gmail.com', 'users/default.png', NULL, '$2y$10$uhUwXuuraCAzAsWgWX62UOE84.Scl5J.H7K4VjmZdVpbN.MjFEzK.', NULL, NULL, '', '', NULL, '2019-05-24 01:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 2, '2019-05-24 01:02:00', '2019-05-24 01:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
