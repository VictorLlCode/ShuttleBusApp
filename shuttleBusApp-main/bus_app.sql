-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 05, 2023 at 11:27 AM
-- Server version: 8.0.32-0ubuntu0.22.04.2
-- PHP Version: 8.1.2-1ubuntu2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int NOT NULL,
  `title` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addedOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleteOn` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buses`
--

CREATE TABLE `buses` (
  `id` int NOT NULL,
  `bus_number` int NOT NULL,
  `capacity` int NOT NULL,
  `make` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` int NOT NULL,
  `status` enum('available','unavailable','maintenance') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buses`
--

INSERT INTO `buses` (`id`, `bus_number`, `capacity`, `make`, `model`, `year`, `status`) VALUES
(1, 1, 30, 'Ford', 'Transit', 2021, 'available'),
(2, 2, 5, 'Chevrolet', 'Express', 2019, 'unavailable'),
(3, 3, 13, 'Mercedes-Benz', 'Sprinter', 2020, 'maintenance');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `hire_date` date NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `current_stop` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `first_name`, `last_name`, `license_number`, `phone_number`, `email`, `hire_date`, `status`, `current_stop`) VALUES
(1, 'John', 'Doe', 'L-1234', '555-1234', 'john.doe@example.com', '2020-01-01', 'active', 0),
(2, 'Jane', 'Smith', 'L-5678', '555-5678', 'jane.smith@example.com', '2021-05-01', 'active', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `driver_bus_assignments`
--

CREATE TABLE `driver_bus_assignments` (
  `id` int NOT NULL,
  `driver_id` int NOT NULL,
  `bus_id` int NOT NULL,
  `assignment_date` date NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `driver_bus_assignments`
--

INSERT INTO `driver_bus_assignments` (`id`, `driver_id`, `bus_id`, `assignment_date`, `status`) VALUES
(1, 1, 1, '2023-05-04', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `driver_shifts`
--

CREATE TABLE `driver_shifts` (
  `id` int NOT NULL,
  `driver_id` int NOT NULL,
  `schedule_id` int NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `driver_shifts`
--

INSERT INTO `driver_shifts` (`id`, `driver_id`, `schedule_id`, `date`) VALUES
(1, 1, 1, '2023-05-06'),
(2, 2, 2, '2023-05-07'),
(3, 1, 1, '2023-05-10'),
(4, 2, 2, '2023-05-11');

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` int NOT NULL,
  `route_name` varchar(100) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `stops` text,
  `estimated_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `route_name`, `origin`, `destination`, `stops`, `estimated_time`) VALUES
(1, 'Red Route', 'Main Campus', 'Downtown Campus', 'Stop 1, Stop 2, Stop 3', '00:30:00'),
(2, 'Blue Route', 'North Campus', 'South Campus', 'Stop 1, Stop 2, Stop 3, Stop 4', '01:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `route_stops`
--

CREATE TABLE `route_stops` (
  `id` int NOT NULL,
  `route_id` int NOT NULL,
  `stop_id` int NOT NULL,
  `stop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `arrival_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int NOT NULL,
  `route_id` int NOT NULL,
  `bus_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `days` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `route_id`, `bus_id`, `start_time`, `end_time`, `days`) VALUES
(1, 1, 1, '07:00:00', '08:00:00', 'Monday, Wednesday, Friday'),
(2, 2, 2, '08:00:00', '09:30:00', 'Tuesday, Thursday');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int NOT NULL,
  `subscription_type` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `duration_days` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `subscription_type`, `description`, `price`, `duration_days`) VALUES
(1, 'Monthly Pass', 'Unlimited access to the shuttle bus service for one month', '50.00', 30),
(2, 'Semester Pass', 'Unlimited access to the shuttle bus service for the entire semester', '150.00', 120),
(3, 'Annual Pass', 'Unlimited access to the shuttle bus service for one year', '500.00', 365),
(4, '10-Ride Pass', '10 rides on the shuttle bus service', '20.00', NULL),
(5, '30-Ride Pass', '30 rides on the shuttle bus service', '50.00', NULL),
(6, 'Weekend Pass', 'Unlimited access to the shuttle bus service during weekends', '30.00', NULL),
(7, 'Night Pass', 'Unlimited access to the shuttle bus service during specified night-time hours', '40.00', NULL),
(8, 'Faculty/Staff Pass', 'Unlimited access to the shuttle bus service for university faculty and staff members', '300.00', 365),
(9, 'Student Pass', 'Unlimited access to the shuttle bus service for students at a discounted rate', '250.00', 365),
(10, 'Visitor Pass', 'Temporary access to the shuttle bus service for guests and visitors', '10.00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('admin','user','driver','guest','visitor','faculty','staff','student') NOT NULL DEFAULT 'user',
  `assigned_bus_id` int DEFAULT NULL,
  `assigned_route_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `user_type`, `assigned_bus_id`, `assigned_route_id`) VALUES
(1, 'driver1', 'driver1@test.com', '$2y$10$rsv4kcltIfvnBRLhPvUXu.5A3HmqAjUBd26.7hJV9SmbjatZUN7m2', 'driver', 1, 1),
(2, 'testuser', 'test@test.com', '$2y$10$n3VvN9WPYkQdyM/8GPBmAezmUZE4XOC0BNMOcR9jJpSyhwoeKecqO', 'user', NULL, NULL),
(9, 'admin1', 'admin1@admin.com', '$2y$10$a33/sBPoUf5TDqyRCA5ptuloAcVOgGI2nnIH4Vc3ZFleBHxUd4dOC', 'admin', NULL, NULL),
(11, 'hello', 'hello@what.com', '$2y$10$iyx1mj4LvnIHhJDafKvaH.ZNNHcqRj1NNfN4vUEpoH8G0OB2DntZO', 'user', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_subscriptions`
--

CREATE TABLE `user_subscriptions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `subscription_id` int NOT NULL,
  `start_date` date NOT NULL,
  `expiry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_subscriptions`
--

INSERT INTO `user_subscriptions` (`id`, `user_id`, `subscription_id`, `start_date`, `expiry_date`) VALUES
(1, 9, 8, '2023-05-03', '2023-06-02'),
(2, 11, 10, '2023-05-03', '2023-06-02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bus_number` (`bus_number`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_bus_assignments`
--
ALTER TABLE `driver_bus_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `bus_id` (`bus_id`);

--
-- Indexes for table `driver_shifts`
--
ALTER TABLE `driver_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route_stops`
--
ALTER TABLE `route_stops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_id` (`route_id`),
  ADD KEY `bus_id` (`bus_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_assigned_bus_id` (`assigned_bus_id`),
  ADD KEY `fk_assigned_route_id` (`assigned_route_id`);

--
-- Indexes for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `subscription_id` (`subscription_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buses`
--
ALTER TABLE `buses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver_bus_assignments`
--
ALTER TABLE `driver_bus_assignments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `driver_shifts`
--
ALTER TABLE `driver_shifts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `route_stops`
--
ALTER TABLE `route_stops`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driver_bus_assignments`
--
ALTER TABLE `driver_bus_assignments`
  ADD CONSTRAINT `driver_bus_assignments_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_bus_assignments_ibfk_2` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_shifts`
--
ALTER TABLE `driver_shifts`
  ADD CONSTRAINT `driver_shifts_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`),
  ADD CONSTRAINT `driver_shifts_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`);

--
-- Constraints for table `route_stops`
--
ALTER TABLE `route_stops`
  ADD CONSTRAINT `route_stops_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`),
  ADD CONSTRAINT `schedules_ibfk_2` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_assigned_bus_id` FOREIGN KEY (`assigned_bus_id`) REFERENCES `buses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assigned_route_id` FOREIGN KEY (`assigned_route_id`) REFERENCES `routes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD CONSTRAINT `user_subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_subscriptions_ibfk_2` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
