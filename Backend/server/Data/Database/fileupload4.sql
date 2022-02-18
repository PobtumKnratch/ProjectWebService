-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2021 at 11:48 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

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
-- Table structure for table `fileupload`
--

CREATE TABLE `fileupload4` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(250) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fileupload`
--

INSERT INTO `fileupload4` (`id`, `name`, `image`, `date`) VALUES
(15, 'image1', 'alisa.supun_web_kg3fzii44_IMG20201003101808.jpg', '2021-07-22 14:42:02'),
(16, 'image2', 'alisa.supun_web_kg7vp7gd685_IMG20201007115857.jpg', '2021-07-22 14:42:02'),
(17, 'image3', 'alisa.supun_web_kg3fzihw996_IMG20201003101751.jpg', '2021-07-22 14:42:02'),
(18, 'image4', 'GGEZalisa.supun_web_kg3fhezh637_IMG20200926183950.jpg', '2021-07-22 14:42:02'),
(19, 'image6', 'fileupload/GGEZalisa.supun_web_kg3fhezv651_IMG20200926183955.jpg', '2021-07-22 14:42:02'),
(20, 'image2.1', 'GGEZalisa.supun_web_kg3h7x38772_IMG20201003103318.jpg', '2021-07-22 15:20:39'),
(21, 'image2.2', 'GGEZalisa.supun_web_kg3cnxa9441_IMG20200920094851.jpg', '2021-07-22 15:21:06'),
(22, 'image2.3', 'GGEZalisa.supun_web_kg7vp7g8680_IMG20201007110648.jpg', '2021-07-22 15:23:11'),
(23, 'kk', 'GGEZalisa.supun_web_kg7vp7gl693_IMG20201007140640.jpg', '2021-07-22 15:27:35'),
(24, '545', 'GGEZalisa.supun_web_kg3cnx9z431_IMG20200920094823.jpg', '2021-07-22 15:28:25'),
(25, 'Test1', 'GGEZalisa.supun_web_kg8xo3hj295_IMG20201008111716.jpg', '2021-07-22 15:30:12'),
(26, 'image500', 'fileupload/GGEZ.jpeg.jpeg', '2021-07-22 15:33:24'),
(27, 'image600', 'GGEZ.jpeg', '2021-07-22 15:35:04'),
(28, 'testrename1', 'testrename1.jpeg', '2021-07-22 15:37:28'),
(29, 'ojsdad', '202107261864752287.jpeg', '2021-07-26 08:47:49'),
(30, 'ko', '202107262099103487.jpeg', '2021-07-26 08:54:49'),
(31, '12345648967', '20210729229918470.jpg', '2021-07-29 09:29:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fileupload`
--
ALTER TABLE `fileupload4`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fileupload`
--
ALTER TABLE `fileupload4`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
