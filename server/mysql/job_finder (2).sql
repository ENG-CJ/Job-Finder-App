-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 10, 2023 at 06:49 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `createJob` (IN `_id` VARCHAR(100), IN `_title` VARCHAR(100), IN `_category` VARCHAR(100), IN `_type` VARCHAR(100), IN `_descr` TEXT, IN `_qualify` VARCHAR(200), IN `_active` VARCHAR(100), IN `_applicants` INT, IN `_owner` INT, IN `_deadline` DATE)   BEGIN
INSERT INTO `jobs`(`id`, `jobTitle`, `category`,`jobType`, `descripton`, `qualifications`, `active`, `applicants`, `owner`, `deadLine`) VALUES (_id,_title,_category,_type,_descr,_qualify,_active,_applicants,_owner,_deadline);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `displayJobsOnUserScreen` ()   BEGIN

SELECT jobs.id, jobs.jobTitle,jobs.jobType,jobs.descripton,jobs.qualifications,
jobs.applicants,jobs.deadLine,jobs.updated,jobs.applicants,
users.id as 'owner',users.username as company,users.profile_pic as profile
FROM jobs
INNER JOIN users
ON jobs.owner=users.id
ORDER BY updated DESC;
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
  `category` varchar(100) NOT NULL,
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

INSERT INTO `jobs` (`id`, `jobTitle`, `category`, `jobType`, `descripton`, `qualifications`, `active`, `applicants`, `owner`, `deadLine`, `updated`) VALUES
('1828b55b-f15e-432f-ba56-d5fa307e1046', 'Digital Marketer', 'Marketing', 'FullTime', 'this is a description for this job apply before deadline comeup', 'Social Poster Up', 'true', 0, 65, '2023-09-27', '2023-09-09 16:14:59'),
('58fffe98-b241-4346-9dd0-1dadfb75a263', 'Regula Marketing Officr', 'Marketing', 'FullTime', 'no description speified for ths job click load and here sjhjs sbalala', 'social media poster', 'true', 0, 65, '2023-09-23', '2023-09-09 16:16:16');

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
  `mobile` int(20) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `verified` varchar(100) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `profile_pic` varchar(300) NOT NULL,
  `country` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `type`, `mobile`, `address`, `verified`, `description`, `profile_pic`, `country`) VALUES
(63, 'ENG-CJ', 'abdul@gmail.com', '1234', 'User', 615178163, NULL, 'false', 'Hello I am software developer from somalia, Building and solving current problems is my passionate, this my local profile your can pick me whether you want to solve any problem. ', 'd0fdeb70-d472-4694-874c-c7e0bf874490.jpg', 'Mogadishu'),
(64, 'Kavi Dudu', 'dudu123@gmail.com', '123', 'User', 617588945, NULL, 'false', 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsu', '80260523-9980-43d0-b9b1-0e14d2383411.jpg', 'Mogadishu, Somalia'),
(65, 'Jamhuuriya University', 'just@edu.so', '@just', 'Company', 3005005, 'Digfeer, rd', 'false', 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is availabl', '007347f2-7369-4c11-b8a7-96882a6f51a5.jpg', 'Mogadishu'),
(66, 'Tabark,ICT', 'tabarak@ict', '@tabarak', 'Company', 9898781, 'Yaqshid, Road 13', 'false', 'This is tabarak ict for developing app and web apps', 'no_profile', 'Mogadishu'),
(67, 'get', '6', '666', 'Company', 66, '66', 'false', '6', 'no_profile', '6'),
(68, 'Afro Tech', 'afro@tech', '@afro', 'Company', 617989567, 'Hodan, Buulo xuubet', 'false', 'This is our profile data hi, can contact use now to provide bala balab\n\n', 'no_profile', 'Mogadishu');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
