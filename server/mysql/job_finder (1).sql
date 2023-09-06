-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2023 at 02:08 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `job_finder`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createJob` (IN `_id` VARCHAR(100), IN `_title` VARCHAR(100), IN `_type` VARCHAR(100), IN `_descr` TEXT, IN `_deadline` DATE, IN `_active` VARCHAR(100), IN `_applicants` INT, IN `_owner` INT, IN `_qualify` VARCHAR(200))   BEGIN
INSERT INTO `jobs`(`id`, `jobTitle`, `jobType`, `descripton`, `qualifications`, `active`, `applicants`, `owner`, `deadLine`) VALUES (_id,_title,_type,_descr,_qualify,_active,_applicants,_owner,_deadline);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchJob` (IN `_id` INT)   BEGIN
SELECT jobs.id,jobs.jobTitle,jobs.jobType,
jobs.descripton,jobs.qualifications,jobs.active,
jobs.applicants,jobs.owner,jobs.deadLine,
jobs.updated FROM jobs
INNER JOIN users
ON jobs.owner=users.id
WHERE jobs.owner=_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` varchar(100) NOT NULL,
  `jobTitle` varchar(100) NOT NULL,
  `jobType` varchar(100) NOT NULL,
  `descripton` text NOT NULL,
  `qualifications` varchar(200) NOT NULL,
  `active` varchar(100) NOT NULL,
  `applicants` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `deadLine` date NOT NULL,
  `updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `jobTitle`, `jobType`, `descripton`, `qualifications`, `active`, `applicants`, `owner`, `deadLine`, `updated`) VALUES
('d7943ce2-da22-47e5-81de-d73ddd64b438', 'Database Admin', 'FullTime', 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is availabl', 'SQL,MySQL,Oracle,PostgrSQL', 'true', 0, 65, '2023-09-28', '2023-09-06 09:42:43'),
('a3d9d762-9ded-4f6c-911f-c703bfd07979', 'Mobile App Developer', 'PartTime', 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is availabl', 'Flutter, Kotlin, ReactNative', 'true', 0, 66, '2023-09-06', '2023-09-06 09:46:32'),
('5ad4e852-409b-444d-bc61-fad7e228d2c2', 'Grpahic Design', 'PartTime', 'this is descriptin about this job where is and when it is', 'Figma,Adobe InDesign,Photoshop', 'true', 0, 66, '2023-09-06', '2023-09-06 11:28:45'),
('a86841d1-4841-4316-8759-bc63beed9152', 'Database Creator', 'PartTime', 'No description about this job only apply it and we will accept as soon as possible', 'SQL SERVER', 'true', 0, 66, '2023-09-18', '2023-09-06 11:32:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `verified` varchar(100) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `profile_pic` longblob DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `type`, `mobile`, `address`, `verified`, `description`, `profile_pic`, `country`) VALUES
(63, 'Abdulrahman Haaji', 'abdul@gmail.com', '1234', 'User', '615178163', NULL, 'false', 'Hello I am software developer from somalia, Building and solving current problems is my passionate, this my local profile your can pick me whether you want to solve any problem. ', NULL, 'Mogadishu'),
(64, 'ENG-Kavi', 'kavi@gmail.com', '123', 'User', '619666666', NULL, 'false', 'This is my Profile.', NULL, 'Mogadishu'),
(65, 'Jamhuuriya Univ', 'just@edu.so', '@just', 'Company', '3005005', 'Digfeer, rd', 'false', 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is availabl', NULL, 'Mogadishu'),
(66, 'Tabark,ICT', 'tabarak@ict', '@tabarak', 'Company', '9898781', 'Yaqshid, Road 13', 'false', 'This is tabarak ict for developing app and web apps', NULL, 'Mogadishu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `mobile_UNIQUE` (`mobile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
