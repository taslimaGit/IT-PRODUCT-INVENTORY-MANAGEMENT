-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2022 at 07:00 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product_managment`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brandName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `brandName`, `created_at`, `updated_at`) VALUES
(6, 'logitech', '2021-11-17 05:33:23', '2021-11-17 05:33:23'),
(7, 'HP', '2021-11-17 05:33:29', '2021-11-17 05:33:29'),
(8, 'Dell', '2021-11-17 05:33:37', '2021-11-17 05:33:37'),
(9, 'Asus', '2021-11-17 05:33:42', '2021-11-17 05:33:42'),
(10, 'TP-Link', '2021-11-17 05:33:55', '2021-11-17 05:33:55'),
(11, 'D-Link', '2021-11-17 05:34:05', '2021-11-17 05:34:05'),
(12, 'Transcend', '2021-11-17 05:34:35', '2021-11-17 05:34:35'),
(13, 'Adata', '2021-11-17 05:34:43', '2021-11-17 05:34:43'),
(14, 'Gigabyte', '2021-11-29 01:08:25', '2021-11-29 01:08:25'),
(15, 'Intel', '2021-11-29 01:31:53', '2021-11-29 01:31:53'),
(16, 'Sewoo', '2021-11-29 01:41:57', '2021-11-29 01:41:57'),
(17, 'Lenovo', '2021-11-29 07:09:58', '2021-11-29 07:09:58'),
(18, 'TOSHIBA', '2021-11-29 21:28:58', '2021-11-29 21:28:58'),
(19, 'Cisco', '2021-12-01 00:22:20', '2021-12-01 00:22:20'),
(20, 'Netis', '2021-12-01 00:22:37', '2021-12-01 00:22:37'),
(21, 'A4 Tech', '2022-01-05 05:15:10', '2022-01-05 05:15:24'),
(22, 'POWER GUARD', '2022-01-05 05:44:30', '2022-01-05 05:44:30'),
(23, 'APACER', '2022-01-05 05:55:14', '2022-01-05 05:55:14'),
(24, 'SILICON POWER JEWEL', '2022-01-05 05:56:28', '2022-01-05 05:56:28'),
(25, 'CANON', '2022-01-05 06:14:27', '2022-01-05 06:14:27');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(5) UNSIGNED NOT NULL,
  `client_id` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clientName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` int(5) NOT NULL,
  `designation_id` int(5) NOT NULL,
  `phoneNo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `activeStatus` tinyint(1) NOT NULL DEFAULT 1,
  `deletionStatus` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `client_id`, `clientName`, `department_id`, `designation_id`, `phoneNo`, `activeStatus`, `deletionStatus`, `created_at`, `updated_at`) VALUES
(4, 'Txf10004', 'Md Abdur Rahman', 5, 15, '01914356252', 1, 0, '2021-11-29 07:23:23', '2021-11-29 21:25:26'),
(5, 'Txf10005', 'SAJIM', 11, 11, '01670973622', 1, 0, '2022-01-05 06:17:23', '2022-01-05 06:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `client_products`
--

CREATE TABLE `client_products` (
  `id` int(15) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `startDate` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endDate` text COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `activeStatus` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_products`
--

INSERT INTO `client_products` (`id`, `client_id`, `product_id`, `startDate`, `endDate`, `activeStatus`, `created_at`, `updated_at`) VALUES
(14, 4, 7, '29/11/2021 07:24 pm', '1', 1, NULL, NULL),
(15, 4, 5, '29/11/2021 07:24 pm', '1', 1, NULL, NULL),
(16, 4, 4, '29/11/2021 07:24 pm', '1', 1, NULL, NULL),
(17, 4, 3, '29/11/2021 07:24 pm', '1', 1, NULL, NULL),
(18, 4, 8, '30/11/2021 09:30 am', '1', 1, NULL, NULL),
(19, 5, 13, '05/01/2022 06:18 pm', '1', 1, NULL, NULL),
(20, 5, 14, '05/01/2022 06:18 pm', '1', 1, NULL, NULL),
(21, 5, 16, '05/01/2022 06:18 pm', '1', 1, NULL, NULL),
(22, 5, 15, '05/01/2022 06:18 pm', '1', 1, NULL, NULL),
(23, 5, 12, '05/01/2022 06:18 pm', '1', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(5) UNSIGNED NOT NULL,
  `departmentName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `departmentName`, `created_at`, `updated_at`) VALUES
(4, 'Accessories', '2021-11-29 06:56:48', '2021-11-29 06:56:48'),
(5, 'Accounts', '2021-11-29 06:57:04', '2021-11-29 21:24:57'),
(6, 'admin', '2021-11-29 06:57:13', '2021-11-29 06:57:13'),
(7, 'IE', '2021-11-29 06:57:24', '2021-11-29 06:57:24'),
(8, 'Cutting', '2021-11-29 06:57:42', '2021-11-29 06:57:42'),
(9, 'Planning', '2021-11-29 06:58:37', '2021-11-29 06:58:37'),
(10, 'IT', '2021-11-29 06:58:48', '2021-11-29 06:58:48'),
(11, 'Merchandising+MKT', '2021-11-29 06:59:18', '2021-11-29 07:00:14'),
(12, 'Commercial', '2021-11-29 06:59:38', '2021-11-29 06:59:38');

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` int(20) UNSIGNED NOT NULL,
  `designationName` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `designationName`, `created_at`, `updated_at`) VALUES
(4, 'SR. Manager', '2021-11-29 07:00:34', '2021-11-29 07:00:34'),
(5, 'Manager', '2021-11-29 07:00:42', '2021-11-29 07:00:42'),
(6, 'GM', '2021-11-29 07:00:55', '2021-11-29 07:00:55'),
(7, 'AGM', '2021-11-29 07:01:01', '2021-11-29 07:01:01'),
(8, 'DGM', '2021-11-29 07:01:07', '2021-11-29 07:01:07'),
(9, 'Asst. marchander', '2021-11-29 07:01:30', '2021-11-29 07:01:30'),
(10, 'Sr. Merchander', '2021-11-29 07:02:16', '2021-11-29 07:02:16'),
(11, 'Merchander', '2021-11-29 07:02:23', '2021-11-29 07:02:23'),
(12, 'Trinee', '2021-11-29 07:03:09', '2021-11-29 07:03:09'),
(13, 'Sr.Executive', '2021-11-29 07:04:36', '2021-11-29 07:04:36'),
(14, 'Executive', '2021-11-29 07:04:40', '2021-11-29 07:04:40'),
(15, 'Accounts Officer', '2021-11-29 07:05:14', '2021-11-29 07:05:14'),
(16, 'Designer', '2021-11-29 07:05:34', '2021-11-29 07:05:34'),
(17, 'Reporter', '2021-11-29 07:05:54', '2021-11-29 07:05:54'),
(18, 'Cad Officer', '2021-11-29 07:06:12', '2021-11-29 07:06:12'),
(19, 'Sr. GM', '2021-11-29 07:06:26', '2021-11-29 07:06:26');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(9) UNSIGNED NOT NULL,
  `itemName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `itemName`, `created_at`, `updated_at`) VALUES
(13, 'Mouse', '2021-11-17 05:26:48', '2021-11-17 05:26:48'),
(14, 'Keyboard', '2021-11-17 05:27:04', '2021-11-17 05:27:04'),
(15, 'Laptop', '2021-11-17 05:27:24', '2021-11-17 05:27:24'),
(16, 'CPU fan', '2021-11-17 05:27:47', '2021-11-17 05:27:47'),
(17, 'UPS Battary', '2021-11-17 05:28:07', '2021-11-17 05:28:07'),
(18, 'Printer', '2021-11-17 05:28:28', '2021-11-17 05:28:28'),
(19, 'RAM', '2021-11-17 05:28:36', '2021-11-17 05:28:36'),
(20, 'M.2', '2021-11-17 05:28:48', '2021-11-17 05:28:48'),
(21, 'HDD', '2021-11-17 05:29:04', '2021-11-17 05:29:53'),
(22, 'SSD', '2021-11-17 05:30:01', '2021-11-17 05:30:01'),
(23, 'Processor', '2021-11-17 05:30:33', '2021-11-17 05:30:33'),
(24, 'Mother Board', '2021-11-17 05:30:55', '2021-11-17 05:30:55'),
(25, 'Power Supply', '2021-11-17 05:31:24', '2021-11-17 05:31:24'),
(26, 'Monitor', '2021-11-17 05:31:45', '2021-11-17 05:31:45'),
(27, 'UPS', '2021-11-17 05:32:04', '2021-11-17 05:32:04'),
(28, 'Brand PC', '2021-11-17 05:38:47', '2021-11-17 05:38:47'),
(29, 'Barcode Scanner', '2021-11-29 01:38:04', '2021-11-29 01:38:04'),
(32, 'Switch', '2021-12-01 00:21:48', '2021-12-01 06:06:09'),
(33, 'PEN DRIVE', '2022-01-05 05:55:46', '2022-01-05 05:55:46');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_02_28_065152_create_departments_table', 1),
(5, '2021_03_03_070912_create_designations_table', 2),
(6, '2021_03_03_113946_create_clients_table', 3),
(12, '2021_03_10_033122_create_items_table', 4),
(14, '2021_03_10_040220_create_product_attributes_table', 5),
(15, '2021_03_10_053753_create_brands_table', 6),
(16, '2021_03_17_110246_create_products_table', 7),
(17, '2021_03_21_042706_create_client_products_table', 8),
(18, '2021_03_24_073350_create_roles_table', 9),
(19, '2021_11_18_094800_create_sellers_table', 10),
(20, '2021_11_21_061614_create_warranties_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(9) UNSIGNED NOT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `productName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seller_id` int(4) NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(4) NOT NULL,
  `brand_id` int(3) DEFAULT NULL,
  `serialNumber` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(3) DEFAULT NULL,
  `purcessDate` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `warranty` tinyint(1) DEFAULT 0,
  `warranty_id` int(3) DEFAULT NULL,
  `productStatus` tinyint(1) NOT NULL DEFAULT 1,
  `assignStatus` tinyint(1) NOT NULL DEFAULT 0,
  `deletionStatus` int(1) NOT NULL DEFAULT 0,
  `created_by` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_by` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_id`, `productName`, `seller_id`, `location`, `item_id`, `brand_id`, `serialNumber`, `attribute`, `user_id`, `purcessDate`, `warranty`, `warranty_id`, `productStatus`, `assignStatus`, `deletionStatus`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(3, 'Txf1000003', 'GIGABYTE B560M GAMING HD', 10, 'Uttara', 24, 14, 'SN213850088183', '[]', NULL, '2021-11-29', 1, 5, 1, 1, 0, 'Lanzu', 'Lanzu', '2021-11-29 01:17:02', '2021-11-29 13:24:00'),
(4, 'Txf1000004', 'DD4 RAM 3200hz', 10, 'Uttara', 19, 12, 'JM3200HLH-4G', '[{\"attributeName\":\"Version\",\"attributeValue\":\"DDR 4\"}]', NULL, '2021-11-29', 1, 6, 1, 1, 0, 'Lanzu', 'Lanzu', '2021-11-29 01:21:28', '2021-11-29 13:24:00'),
(5, 'Txf1000005', 'Core i3', 10, 'Uttara', 23, 15, 'U1EP658202695', '[{\"attributeName\":\"Genaration\",\"attributeValue\":\"10th\"},{\"attributeName\":\"Core\",\"attributeValue\":\"i3\"}]', NULL, '2021-11-29', 1, 7, 1, 1, 0, 'Lanzu', 'Lanzu', '2021-11-29 01:36:03', '2021-11-29 13:24:00'),
(6, 'Txf1000006', '2D WIRELESS BARCODE SCANNER', 10, 'Uttara', 29, 16, 'N2185800535', '[{\"attributeName\":\"Version\",\"attributeValue\":\"Wireless\"}]', NULL, '2021-11-29', 1, 7, 1, 0, 0, 'Lanzu', 'Lanzu', '2021-11-29 01:40:37', '2021-11-29 01:42:09'),
(7, 'Txf1000007', 'transcend 110s  2280 m-key pciel', 10, 'uttara', 20, 12, 'ts128gmte110s', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"128GB\"}]', NULL, '2021-11-29', 1, 10, 1, 1, 0, 'Lanzu', 'Lanzu', '2021-11-29 07:21:31', '2021-11-29 13:24:00'),
(8, 'Txf1000008', 'TOSHIBA 1 TB  3.5 SATA HDD', 10, 'Uttara', 21, 18, '4116ERYFSEZG', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"1TB\"}]', NULL, '2021-11-28', 1, 8, 1, 1, 0, 'Lanzu', 'Lanzu', '2021-11-29 21:28:42', '2021-11-30 03:30:59'),
(9, 'Txf1000009', 'TP LINK  SWITCH 8 PORT', 10, 'UTTARA', 32, 10, '2215342001843', '[{\"attributeName\":\"Port\",\"attributeValue\":\"8\"},{\"attributeName\":\"Type\",\"attributeValue\":\"Etharnet\"}]', NULL, '2021-12-01', 1, 7, 1, 0, 0, 'Lanzu', 'Administrator', '2021-12-01 00:25:30', '2021-12-01 06:09:45'),
(10, 'Txf1000010', 'NETIS ETHERNET SWITCH', 10, 'UTTARA', 32, 20, '1100170153800194', '[{\"attributeName\":\"Port\",\"attributeValue\":\"8\"},{\"attributeName\":\"Type\",\"attributeValue\":\"Etharnet\"}]', NULL, '2021-12-01', 1, 7, 1, 0, 0, 'Lanzu', 'Administrator', '2021-12-01 00:28:36', '2021-12-01 06:09:30'),
(11, 'Txf1000011', 'CISCO SF95D', 10, 'UTTARA', 32, 19, 'PSZ25091DVN', '[{\"attributeName\":\"Port\",\"attributeValue\":\"8\"},{\"attributeName\":\"Type\",\"attributeValue\":\"Etharnet\"}]', NULL, '2021-12-01', 1, 7, 1, 0, 0, 'Lanzu', 'Administrator', '2021-12-01 00:32:51', '2021-12-01 06:09:14'),
(12, 'Txf1000012', 'INTEL 10TH GEN PROCESSOR', 10, 'UTTARA', 23, 15, 'U1MN536500474', '[{\"attributeName\":\"Genaration\",\"attributeValue\":\"10TH\"}]', NULL, '2022-01-04', 1, 5, 1, 1, 0, 'Lanzu', NULL, '2022-01-05 04:54:58', '2022-01-05 12:18:46'),
(13, 'Txf1000013', 'GIGABYTE H510M MOTHERBORD', 10, 'UTTARA', 24, 14, 'SN213950109186', '[{\"attributeName\":\"Genaration\",\"attributeValue\":\"10TH\\\\11TH\"}]', NULL, '2022-01-04', 1, 5, 1, 1, 0, 'Lanzu', NULL, '2022-01-05 04:58:13', '2022-01-05 12:18:46'),
(14, 'Txf1000014', 'DDR4 RAM 3200M', 10, 'UTTARA', 19, 12, 'G768020646', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"4GB\"}]', NULL, '2022-01-04', 1, 6, 1, 1, 0, 'Lanzu', 'Lanzu', '2022-01-05 05:04:51', '2022-01-05 12:18:46'),
(15, 'Txf1000015', 'TOSHIBA 3.5 SATA 7200RPM HDD', 10, 'UTTARA', 21, 18, '61IYSV5FSWK7', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"1TB\"}]', NULL, '2022-01-04', 1, 8, 1, 1, 0, 'Lanzu', NULL, '2022-01-05 05:08:05', '2022-01-05 12:18:46'),
(16, 'Txf1000016', 'M.2 2280 M-KEY SSD', 10, 'UTTARA', 22, 12, 'G872860536', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"128GB\"}]', NULL, '2022-01-04', 1, 10, 1, 1, 0, 'Lanzu', NULL, '2022-01-05 05:12:23', '2022-01-05 12:18:46'),
(17, 'Txf1000017', 'A4 TECH KEYBOARD 85 BLACK', 10, 'UTTARA', 14, 21, '30960', '[]', NULL, '2022-01-04', 1, 7, 1, 0, 0, 'Lanzu', NULL, '2022-01-05 05:29:28', '2022-01-05 05:29:28'),
(18, 'Txf1000018', 'A4 TECH OP 730D 2X  MAUSE', 10, 'UTTARA', 13, 21, 'RYTLT159151\\BG2104045114', '[]', NULL, '2022-01-04', 1, 7, 1, 0, 0, 'Lanzu', NULL, '2022-01-05 05:35:14', '2022-01-05 05:35:14'),
(19, 'Txf1000019', 'CANON PIXMA G1010 INK TANK PRINTER', 10, 'Uttara', 18, 25, 'KMYV72584', '[]', NULL, '2022-01-04', 1, 7, 1, 0, 0, 'Lanzu', 'Lanzu', '2022-01-05 05:41:18', '2022-01-05 06:15:08'),
(20, 'Txf1000020', 'HP P19B G4 MONITOR', 10, 'UTTARA', 26, 7, '3CQ13507S1', '[{\"attributeName\":\"Port\",\"attributeValue\":\"VGA,HDMI\"}]', NULL, '2022-01-04', 1, 5, 1, 0, 0, 'Lanzu', NULL, '2022-01-05 05:43:22', '2022-01-05 05:43:22'),
(21, 'Txf1000021', 'POWER GUARD 650VA UPS', 10, 'UTTARA', 27, 22, '211021014261', '[{\"attributeName\":\"BODY\",\"attributeValue\":\"PLASTIC\"}]', NULL, '2022-01-04', 1, 7, 1, 0, 0, 'Lanzu', NULL, '2022-01-05 05:50:09', '2022-01-05 05:50:09'),
(22, 'Txf1000022', 'APACER AH353', 10, 'UTTARA', 33, 23, 'RYTLT33461\\142127104324', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"32GB\"}]', NULL, '2022-01-04', 1, 6, 1, 0, 0, 'Lanzu', 'Lanzu', '2022-01-05 05:54:53', '2022-01-05 05:57:14'),
(23, 'Txf1000023', 'PENDRIVE J80 TITANIUM', 10, 'UTTARA', 33, 24, 'RYMG51322\\D33B29', '[{\"attributeName\":\"Memory\",\"attributeValue\":\"32GB\"}]', NULL, '2022-01-04', 1, 10, 1, 0, 0, 'Lanzu', NULL, '2022-01-05 06:00:43', '2022-01-05 06:00:43'),
(24, 'Txf1000024', 'CANON PIXMA G1010 INK TANK  PRINTER', 10, 'UTTARA', 18, 25, 'KMAW57439', '[]', NULL, '2022-01-04', 1, 7, 1, 0, 0, 'Lanzu', 'Lanzu', '2022-01-05 06:14:15', '2022-01-05 06:14:49');

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attributeName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `attributeName`, `created_at`, `updated_at`) VALUES
(11, 'Memory', '2021-11-17 21:59:29', '2021-11-17 21:59:29'),
(12, 'Version', '2021-11-18 01:30:15', '2021-11-18 01:30:15'),
(13, 'Genaration', '2021-11-18 01:33:00', '2021-11-18 01:33:00'),
(14, 'Core', '2021-11-29 01:31:16', '2021-11-29 01:31:16'),
(15, 'Port', '2021-12-01 00:24:35', '2021-12-01 00:24:35'),
(16, 'Type', '2021-12-01 06:09:01', '2021-12-01 06:09:01'),
(17, 'BODY', '2022-01-05 05:44:49', '2022-01-05 05:44:49');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(2) UNSIGNED NOT NULL,
  `roleName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `roleName`, `permission`, `created_at`, `updated_at`) VALUES
(10, 'Admin', NULL, '2021-03-24 02:41:33', '2021-03-24 02:43:15'),
(13, 'Editor', NULL, '2021-03-24 02:42:44', '2021-03-24 02:43:25'),
(15, 'Repoter', NULL, '2021-03-24 04:54:34', '2021-03-24 04:54:44'),
(16, 'Administrator', NULL, '2021-03-27 04:40:52', '2021-03-27 04:40:52');

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sellerName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `sellerName`, `created_at`, `updated_at`) VALUES
(2, 'Global Brand Ltd', '2021-11-20 00:22:03', '2021-11-20 04:27:39'),
(10, 'Ryans COMPUTER', '2021-11-22 03:12:32', '2022-01-05 05:35:37'),
(11, 'IT VISTA', '2021-11-22 03:12:46', '2021-11-22 03:12:46'),
(12, 'Floora', '2021-11-29 07:08:39', '2021-11-29 07:08:39'),
(13, 'Smart Technology', '2021-11-29 07:09:20', '2021-11-29 07:09:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fullName` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userImage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(2) DEFAULT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullName`, `userName`, `userImage`, `email_verified_at`, `password`, `role_id`, `isActive`, `remember_token`, `created_at`, `updated_at`) VALUES
(14, 'Administrator', 'administrator', NULL, NULL, '$2a$12$UHRgxJy97KgC28dYOrEDQO7eTiSclcI/LwMHOVTy2ru/XVZ4XcCvK', 16, 5, NULL, '2021-03-27 04:43:46', '2021-03-27 04:43:46'),
(16, 'Lanzu', 'l123', NULL, NULL, '$2y$10$qN96t6px.rRKodgNXJgWzewqCIVCxmZo4Dx8vDEHTc05Q85nMWz.S', 13, 0, NULL, '2021-03-28 23:07:42', '2021-11-20 03:42:46'),
(17, 'Lanzu', 'lanzu', NULL, NULL, '$2y$10$qowQXDVwwniFfA98p5HOzO.J11xqndfQJHHuliuKLVpXURq8XsIuC', 10, 1, NULL, '2021-11-20 03:43:21', '2021-11-20 03:43:21');

-- --------------------------------------------------------

--
-- Table structure for table `warranties`
--

CREATE TABLE `warranties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `periodTime` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warranties`
--

INSERT INTO `warranties` (`id`, `periodTime`, `created_at`, `updated_at`) VALUES
(1, '1 Month', '2021-11-21 00:31:42', '2021-11-21 00:31:42'),
(3, '3  Months', '2021-11-21 00:44:55', '2021-11-22 03:12:02'),
(4, '2 Months', '2021-11-22 03:11:53', '2021-11-22 03:11:53'),
(5, '3 Years', '2021-11-29 01:17:17', '2021-11-29 01:17:17'),
(6, 'Life Time', '2021-11-29 01:28:29', '2021-11-29 01:28:29'),
(7, '1 Year', '2021-11-29 01:36:16', '2021-11-29 01:36:16'),
(8, '2 Years', '2021-11-29 07:07:55', '2021-11-29 07:07:55'),
(9, '6 Months', '2021-11-29 07:08:19', '2021-11-29 07:08:19'),
(10, '5 Years', '2021-11-29 07:20:59', '2021-11-29 07:20:59'),
(11, '4 Years', '2021-11-29 07:27:45', '2021-11-29 07:27:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_products`
--
ALTER TABLE `client_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departmentName` (`departmentName`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `designationName` (`designationName`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_rolename_unique` (`roleName`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`userName`);

--
-- Indexes for table `warranties`
--
ALTER TABLE `warranties`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `client_products`
--
ALTER TABLE `client_products`
  MODIFY `id` int(15) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `warranties`
--
ALTER TABLE `warranties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
