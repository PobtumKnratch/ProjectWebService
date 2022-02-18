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
-- Table structure for table `fileupload3`
--

CREATE TABLE `fileupload3` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fileupload3`
--

INSERT INTO `fileupload3` (`id`, `name`, `image`, `date`) VALUES
(5, 'board1', '202109271817520097.jpg', '2021-09-27 09:02:33'),
(6, 'board2', '20210927874219126.jpg', '2021-09-27 09:03:12'),
(7, 'board3', '202109271544553339.jpg', '2021-09-27 09:03:33'),
(8, 'board4', '20210927999053219.jpg', '2021-09-27 09:03:50'),
(9, 'board5', '202109271918937520.jpg', '2021-09-27 09:04:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fileupload3`
--
ALTER TABLE `fileupload3`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fileupload3`
--
ALTER TABLE `fileupload3`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
