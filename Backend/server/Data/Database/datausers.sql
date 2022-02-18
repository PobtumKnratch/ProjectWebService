-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2022 at 10:03 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nectecpro`
--

-- --------------------------------------------------------

--
-- Table structure for table `datausers`
--

CREATE TABLE `datausers` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `firstname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_thai_520_w2 NOT NULL,
  `lastname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_thai_520_w2 NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_thai_520_w2 NOT NULL,
  `current_login` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `previous_login` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `user_status` varchar(2) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `datausers`
--

INSERT INTO `datausers` (`user_id`, `username`, `password`, `topic_id`, `firstname`, `lastname`, `email`, `current_login`, `previous_login`, `user_status`) VALUES
(1, 'user1', '$2y$10$ZCHM8Ik3xxL815dDA6n1M.QfcrKxZTxH6HNK0akaVFsDmULtviam2', 1, 'pobtum', 'kunratch', 'user1@mail.com', '1642409804', '1642409804', 'US'),
(2, 'user2', '$2y$10$ZCHM8Ik3xxL815dDA6n1M.QfcrKxZTxH6HNK0akaVFsDmULtviam2', 2, 'pobtum', 'kunratch', 'user2@mail.com', '1640518115', '1640518108', 'US'),
(3, 'user3', '$2y$10$ZCHM8Ik3xxL815dDA6n1M.QfcrKxZTxH6HNK0akaVFsDmULtviam2', 3, 'pobtum', 'kunratch', 'user3@mail.com', '1637255568', '1637255544', 'US'),
(4, 'user4', '$2y$10$JJlL2aG50R53HyYNhHZdAukGx7NvOGCE1tth2lgXIo0PzmCci6jBC', 4, 'pobtum', 'kunratch', 'user4@mail.com', '2021-11-16 16:38:02', '2021-11-16 16:38:02', 'US'),
(5, 'admin1', '123456789', 1, 'admin1', 'admin1', 'admin@mail.com', '2021-11-16 16:38:02', '2021-11-16 16:38:02', 'AD'),
(6, 'superadmin', '$2y$10$SHliQKf.UJe3iNN4o6rajuOut4.DVNtRpTJ0aL/SyDPlfEnGDeZOe', 5, 'superadmin', 'superadmin', 'superadmin@mail.com', '2021-11-16 16:38:02', '2021-11-16 16:38:02', 'AD'),
(7, 'editor1', '$2y$10$JJlL2aG50R53HyYNhHZdAukGx7NvOGCE1tth2lgXIo0PzmCci6jBC', 1, 'edit1', 'edit', 'edit@mail.com', '0', '0', 'ED'),
(8, 'annotation', '$2y$10$JJlL2aG50R53HyYNhHZdAukGx7NvOGCE1tth2lgXIo0PzmCci6jBC', 1, 'annotation', 'tool', 'annotation@mail.com', '0', '0', 'AN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `datausers`
--
ALTER TABLE `datausers`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `datausers`
--
ALTER TABLE `datausers`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
