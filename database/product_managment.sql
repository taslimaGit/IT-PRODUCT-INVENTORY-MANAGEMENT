-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2021 at 07:10 AM
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
(1, 'Dell', '2021-03-31 02:13:59', '2021-03-31 02:13:59'),
(2, 'A4tech', '2021-03-31 02:14:21', '2021-03-31 02:14:21'),
(3, 'Lenevo', '2021-03-31 02:14:26', '2021-03-31 02:14:26'),
(4, 'Logitech', '2021-04-01 01:25:42', '2021-04-01 01:25:42'),
(5, 'HP', '2021-04-01 01:34:50', '2021-04-01 01:34:50');

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
(1, 'Txf10001', 'Sumon', 2, 1, '12345678901', 1, 0, '2021-03-31 02:15:47', '2021-03-31 02:29:29'),
(2, 'Txf10002', 'Pintu', 1, 2, '32145678965', 1, 0, '2021-03-31 02:16:03', '2021-03-31 02:16:03');

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
(1, 1, 1, '31/03/2021 02:21 pm', '31/03/2021 02:25 pm', 0, NULL, '2021-03-31 08:25:29'),
(2, 2, 1, '31/03/2021 02:29 pm', '31/03/2021 02:31 pm', 0, NULL, '2021-03-31 08:31:11'),
(3, 2, 2, '31/03/2021 02:29 pm', '01/04/2021 01:29 pm', 0, NULL, '2021-04-01 07:29:50'),
(4, 2, 3, '01/04/2021 01:30 pm', '01/04/2021 01:30 pm', 0, NULL, '2021-04-01 07:30:34'),
(5, 2, 1, '01/04/2021 01:30 pm', '01/04/2021 01:36 pm', 0, NULL, '2021-04-01 07:36:10'),
(6, 1, 3, '01/04/2021 01:30 pm', '1', 1, NULL, NULL),
(7, 1, 2, '01/04/2021 01:30 pm', '1', 1, NULL, NULL),
(8, 2, 4, '01/04/2021 01:35 pm', '1', 1, NULL, NULL),
(9, 1, 1, '01/04/2021 01:36 pm', '1', 1, NULL, NULL);

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
(1, 'Accounce', '2021-03-31 02:00:49', '2021-03-31 02:00:49'),
(2, 'IT', '2021-03-31 02:01:03', '2021-03-31 02:01:03');

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
(1, 'Manager', '2021-03-31 02:06:46', '2021-03-31 02:06:46'),
(2, 'Executive', '2021-03-31 02:06:52', '2021-03-31 02:06:52');

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
(8, 'Laptop', '2021-03-31 02:07:09', '2021-03-31 02:07:09'),
(9, 'PC', '2021-03-31 02:07:13', '2021-03-31 02:07:13'),
(10, 'Keyboard', '2021-03-31 02:07:31', '2021-03-31 02:07:31'),
(11, 'Mouse', '2021-04-01 01:25:29', '2021-04-01 01:25:29'),
(12, 'Printer', '2021-04-01 01:32:57', '2021-04-01 01:32:57');

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
(18, '2021_03_24_073350_create_roles_table', 9);

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
  `item_id` int(4) NOT NULL,
  `brand_id` int(3) DEFAULT NULL,
  `serialNumber` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(3) DEFAULT NULL,
  `purcessDate` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `warranty` tinyint(1) DEFAULT 0,
  `warrantyDetails` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `productStatus` tinyint(1) NOT NULL DEFAULT 1,
  `assignStatus` tinyint(1) NOT NULL DEFAULT 0,
  `deletionStatus` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_id`, `productName`, `item_id`, `brand_id`, `serialNumber`, `attribute`, `user_id`, `purcessDate`, `warranty`, `warrantyDetails`, `productStatus`, `assignStatus`, `deletionStatus`, `created_at`, `updated_at`) VALUES
(1, 'Txf1000001', 'Dell vostro 3650', 8, 1, 'jk2556452155654ssdffs', '[{\"attributeName\":\"HDD\",\"attributeValue\":\"1TB\"},{\"attributeName\":\"Ram\",\"attributeValue\":\"8GM\"},{\"attributeName\":\"Proccessor\",\"attributeValue\":\"Core i7\"}]', NULL, '2021-03-29', 1, '3 Years', 1, 1, 0, '2021-03-31 02:19:06', '2021-04-01 07:36:25'),
(2, 'Txf1000002', 'lenevo 555', 9, 3, 'ewrewrwerewrewdf43534', '[{\"attributeName\":\"HDD\",\"attributeValue\":\"500GB\"}]', NULL, '2021-03-25', 0, NULL, 1, 1, 0, '2021-03-31 02:21:10', '2021-04-01 07:30:45'),
(3, 'Txf1000003', 'Logitech M45', 11, 4, 'fd3433df354353', '[{\"attributeName\":\"Type\",\"attributeValue\":\"Wireless\"}]', NULL, '2021-03-31', 1, '6 Months', 1, 1, 0, '2021-04-01 01:27:25', '2021-04-01 07:30:45'),
(4, 'Txf1000004', 'HP M12 Laserjet', 12, 5, 'd33fsdf34343343', '[{\"attributeName\":\"Type\",\"attributeValue\":\"LaserJet\"}]', NULL, '2021-03-28', 0, NULL, 1, 1, 0, '2021-04-01 01:34:31', '2021-04-01 07:35:38');

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
(1, 'HDD', '2021-03-31 02:17:14', '2021-03-31 02:17:14'),
(2, 'Proccessor', '2021-03-31 02:17:20', '2021-03-31 02:17:20'),
(3, 'Ram', '2021-03-31 02:17:24', '2021-03-31 02:17:24'),
(4, 'Genaration', '2021-03-31 02:17:30', '2021-03-31 02:17:30'),
(5, 'Type', '2021-04-01 01:26:41', '2021-04-01 01:26:47');

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
(14, 'Administrator', 'administrator', NULL, NULL, '$2y$10$8N2XRfjQnGWEdHMBTBP1e.K8DeBTp3ArPPlCiuNx11msALaBFrnOi', 16, 5, NULL, '2021-03-27 04:43:46', '2021-03-27 04:43:46'),
(16, 'Lanzu', 'l123', NULL, NULL, '$2y$10$qN96t6px.rRKodgNXJgWzewqCIVCxmZo4Dx8vDEHTc05Q85nMWz.S', 13, 1, NULL, '2021-03-28 23:07:42', '2021-03-28 23:07:42');

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`userName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `client_products`
--
ALTER TABLE `client_products`
  MODIFY `id` int(15) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
