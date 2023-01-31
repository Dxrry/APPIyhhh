-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 14, 2022 at 03:26 AM
-- Server version: 10.9.4-MariaDB
-- PHP Version: 8.1.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `community_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` longtext NOT NULL,
  `password` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `email`, `password`) VALUES
(1, 'p', 'ppp@pp.d', 'p'),
(3, 's', 'swjlia98@gmail.com', 's'),
(4, 'cc', 'cc@cc.vs', 'cc'),
(5, 'k', 'k@k.k', 'k\\'),
(6, 'sdasd@c.c', 'sdasd@c.c', 'sdasd@c.c'),
(7, 'sc', 'sc@gmail.com', 'sc'),
(8, 'test', 'test@gmail.com', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `tb_datasoal`
--

CREATE TABLE `tb_datasoal` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `full_description` longtext NOT NULL,
  `table_data` longtext NOT NULL,
  `count_soal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_datasoal`
--

INSERT INTO `tb_datasoal` (`id`, `title`, `description`, `full_description`, `table_data`, `count_soal`) VALUES
(1, 'Logika & Algoritma', '-', '{\"Time\": 60, \"Soal\": 50}', 'tb_lna_soal', 3),
(2, 'Enterpreneurship', '-', '{\"Time\": 60, \"Soal\": 50}', 'tb_enterpreneur_soal', 3),
(3, 'PTIK', '-', '{\"Time\": 60, \"Soal\": 50}', 'tb_ptik_soal', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tb_enterpreneur_soal`
--

CREATE TABLE `tb_enterpreneur_soal` (
  `id` int(11) NOT NULL,
  `questions` longtext NOT NULL,
  `answer_a` longtext NOT NULL,
  `answer_b` longtext NOT NULL,
  `answer_c` longtext NOT NULL,
  `answer_d` longtext NOT NULL,
  `answer_r` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_enterpreneur_soal`
--

INSERT INTO `tb_enterpreneur_soal` (`id`, `questions`, `answer_a`, `answer_b`, `answer_c`, `answer_d`, `answer_r`) VALUES
(1, 'e', 'orang yang bekerja dalam instansi komputer dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perdagangan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_a'),
(2, 's', 'orang yang bekerja dalam instansi komputer dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perdagangan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_a'),
(3, 'a', 'orang yang bekerja dalam instansi komputer dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perdagangan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_a');

-- --------------------------------------------------------

--
-- Table structure for table `tb_enterpreneur_soal_users`
--

CREATE TABLE `tb_enterpreneur_soal_users` (
  `id` int(11) NOT NULL,
  `user_answered` longtext DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `answer` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_enterpreneur_soal_users`
--

INSERT INTO `tb_enterpreneur_soal_users` (`id`, `user_answered`, `user_id`, `answer`) VALUES
(19, '{\"1\": \"answer_c\", \"2\": \"answer_b\"}', 1, '{\"1\": 1, \"2\": 3, \"3\": 2}'),
(20, '{\"1\": \"answer_d\", \"2\": \"answer_c\", \"3\": \"answer_b\"}', 3, '{\"1\": 1, \"2\": 2, \"3\": 3}'),
(21, NULL, 4, '{\"1\": 1, \"2\": 3, \"3\": 2}');

-- --------------------------------------------------------

--
-- Table structure for table `tb_lna_soal`
--

CREATE TABLE `tb_lna_soal` (
  `id` int(11) NOT NULL,
  `questions` longtext NOT NULL,
  `answer_a` longtext NOT NULL,
  `answer_b` longtext NOT NULL,
  `answer_c` longtext NOT NULL,
  `answer_d` longtext NOT NULL,
  `answer_r` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_lna_soal`
--

INSERT INTO `tb_lna_soal` (`id`, `questions`, `answer_a`, `answer_b`, `answer_c`, `answer_d`, `answer_r`) VALUES
(1, 'Urutan langkah komputasi yang rangkaiannya sesuai dengan logika yang dimiliki manusia disebut dengan', 'Algoritma', 'Logika', 'Oprasi', 'Flowchart', 'answer_a'),
(2, 'Di bawah ini adalah bahasa bahasa pemrograman, kecuali', 'Basic', 'Powerpoint', 'Pascal', 'Python', 'answer_b'),
(3, 'Berikut ini yang merupakan bahasa pemrograman adalah', 'Jawa', 'Sunda', 'English', 'Python3', 'answer_d'),
(4, 'sgrdgtfhgjhgjhg', 'Jawa', 'Sunda', 'English', 'Python3', 'answer_a');

-- --------------------------------------------------------

--
-- Table structure for table `tb_lna_soal_users`
--

CREATE TABLE `tb_lna_soal_users` (
  `id` int(11) NOT NULL,
  `user_answered` longtext DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `answer` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_lna_soal_users`
--

INSERT INTO `tb_lna_soal_users` (`id`, `user_answered`, `user_id`, `answer`) VALUES
(19, '{\"1\": \"answer_c\", \"2\": \"answer_b\", \"3\": \"answer_d\"}', 1, '{\"1\": 1, \"2\": 3, \"3\": 2}'),
(20, '{\"1\": \"answer_d\", \"2\": \"answer_c\", \"3\": \"answer_b\"}', 3, '{\"1\": 1, \"2\": 2, \"3\": 3}'),
(21, NULL, 4, '{\"1\": 1, \"2\": 3, \"3\": 2}'),
(22, NULL, 7, '{\"1\": 2, \"2\": 3, \"3\": 1}'),
(23, '{\"1\": \"answer_c\", \"2\": \"answer_a\", \"3\": \"answer_c\"}', 8, '{\"1\": 3, \"2\": 2, \"3\": 1}');

-- --------------------------------------------------------

--
-- Table structure for table `tb_ptik_soal`
--

CREATE TABLE `tb_ptik_soal` (
  `id` int(11) NOT NULL,
  `questions` longtext NOT NULL,
  `answer_a` longtext NOT NULL,
  `answer_b` longtext NOT NULL,
  `answer_c` longtext NOT NULL,
  `answer_d` longtext NOT NULL,
  `answer_r` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_ptik_soal`
--

INSERT INTO `tb_ptik_soal` (`id`, `questions`, `answer_a`, `answer_b`, `answer_c`, `answer_d`, `answer_r`) VALUES
(1, 'Soal 1 Jawaban A', 'A', 'orang yang bekerja dalam instansi perdagangan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_a'),
(2, 'Jawaban B', 'A', 'B', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_b'),
(3, 'a', 'A', 'orang yang bekerja dalam instansi perdagangan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi perusahaan dan beberapa masalah yang berhubungan dengannya', 'orang yang bekerja dalam instansi pemerintahan dan beberapa masalah yang berhubungan dengannya', 'answer_d');

-- --------------------------------------------------------

--
-- Table structure for table `tb_ptik_soal_users`
--

CREATE TABLE `tb_ptik_soal_users` (
  `id` int(11) NOT NULL,
  `user_answered` longtext DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `answer` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_ptik_soal_users`
--

INSERT INTO `tb_ptik_soal_users` (`id`, `user_answered`, `user_id`, `answer`) VALUES
(19, '{\"1\": \"answer_a\", \"2\": \"answer_b\"}', 1, '{\"1\": 1, \"2\": 3, \"3\": 2}'),
(20, '{\"1\": \"answer_d\", \"2\": \"answer_c\", \"3\": \"answer_b\"}', 3, '{\"1\": 1, \"2\": 2, \"3\": 3}'),
(21, NULL, 7, '{\"1\": 2, \"2\": 3, \"3\": 1}');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_datasoal`
--
ALTER TABLE `tb_datasoal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_enterpreneur_soal`
--
ALTER TABLE `tb_enterpreneur_soal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_enterpreneur_soal_users`
--
ALTER TABLE `tb_enterpreneur_soal_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_lna_soal`
--
ALTER TABLE `tb_lna_soal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_lna_soal_users`
--
ALTER TABLE `tb_lna_soal_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_ptik_soal`
--
ALTER TABLE `tb_ptik_soal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_ptik_soal_users`
--
ALTER TABLE `tb_ptik_soal_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_datasoal`
--
ALTER TABLE `tb_datasoal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_enterpreneur_soal`
--
ALTER TABLE `tb_enterpreneur_soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_enterpreneur_soal_users`
--
ALTER TABLE `tb_enterpreneur_soal_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tb_lna_soal`
--
ALTER TABLE `tb_lna_soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_lna_soal_users`
--
ALTER TABLE `tb_lna_soal_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tb_ptik_soal`
--
ALTER TABLE `tb_ptik_soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_ptik_soal_users`
--
ALTER TABLE `tb_ptik_soal_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
