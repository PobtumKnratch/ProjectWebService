-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2021 at 11:18 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.23

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
-- Table structure for table `fileupload2`
--

CREATE TABLE `fileupload2` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fileupload2`
--

INSERT INTO `fileupload2` (`id`, `name`, `image`, `date`) VALUES
(15, 'temple1', '2021092732907037.jpeg', '2021-09-27 09:15:17'),
(16, 'temple2', '202109271681006253.jpeg', '2021-09-27 09:15:30'),
(17, 'temple3', '202109271522487266.jpeg', '2021-09-27 09:16:00'),
(18, 'temple4', '20210927637624757.jpeg', '2021-09-27 09:16:18'),
(19, 'temple5', '20210927719100839.jpeg', '2021-09-27 09:16:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fileupload2`
--
ALTER TABLE `fileupload2`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fileupload2`
--
ALTER TABLE `fileupload2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
