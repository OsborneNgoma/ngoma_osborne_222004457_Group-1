-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 20, 2024 at 11:43 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ngoma_osborne_222004457`
--

-- --------------------------------------------------------

--
-- Table structure for table `auditlog`
--
-- Error reading structure for table ngoma_osborne_222004457.auditlog: #1932 - Table 'ngoma_osborne_222004457.auditlog' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.auditlog: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`auditlog`' at line 1

-- --------------------------------------------------------

--
-- Table structure for table `bookingrecords`
--
-- Error reading structure for table ngoma_osborne_222004457.bookingrecords: #1932 - Table 'ngoma_osborne_222004457.bookingrecords' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.bookingrecords: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`bookingrecords`' at line 1

-- --------------------------------------------------------

--
-- Stand-in structure for view `bookingrecords_view`
-- (See below for the actual view)
--
CREATE TABLE `bookingrecords_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--
-- Error reading structure for table ngoma_osborne_222004457.classes: #1932 - Table 'ngoma_osborne_222004457.classes' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.classes: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`classes`' at line 1

-- --------------------------------------------------------

--
-- Stand-in structure for view `classes_view`
-- (See below for the actual view)
--
CREATE TABLE `classes_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `classrepresentatives`
--
-- Error reading structure for table ngoma_osborne_222004457.classrepresentatives: #1932 - Table 'ngoma_osborne_222004457.classrepresentatives' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.classrepresentatives: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`classrepresentatives`' at line 1

--
-- Triggers `classrepresentatives`
--
DELIMITER $$
CREATE TRIGGER `AfterUpdateClassRepresentative` AFTER UPDATE ON `classrepresentatives` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('ClassRepresentatives', NEW.rep_id, 'Update');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `classrepresentatives_view`
-- (See below for the actual view)
--
CREATE TABLE `classrepresentatives_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `classrooms`
--
-- Error reading structure for table ngoma_osborne_222004457.classrooms: #1932 - Table 'ngoma_osborne_222004457.classrooms' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.classrooms: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`classrooms`' at line 1

-- --------------------------------------------------------

--
-- Stand-in structure for view `classrooms_view`
-- (See below for the actual view)
--
CREATE TABLE `classrooms_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--
-- Error reading structure for table ngoma_osborne_222004457.coordinators: #1932 - Table 'ngoma_osborne_222004457.coordinators' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.coordinators: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`coordinators`' at line 1

--
-- Triggers `coordinators`
--
DELIMITER $$
CREATE TRIGGER `AfterUpdateCoordinator` AFTER UPDATE ON `coordinators` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('Coordinators', NEW.coordinator_id, 'Update');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `coordinators_view`
-- (See below for the actual view)
--
CREATE TABLE `coordinators_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--
-- Error reading structure for table ngoma_osborne_222004457.courses: #1932 - Table 'ngoma_osborne_222004457.courses' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.courses: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`courses`' at line 1

--
-- Triggers `courses`
--
DELIMITER $$
CREATE TRIGGER `AfterDeleteCourse` AFTER DELETE ON `courses` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('Courses', OLD.course_id, 'Delete');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `courses_view`
-- (See below for the actual view)
--
CREATE TABLE `courses_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `courseteacherview`
-- (See below for the actual view)
--
CREATE TABLE `courseteacherview` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `deleteclassrepresentativesview`
-- (See below for the actual view)
--
CREATE TABLE `deleteclassrepresentativesview` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `deletecoordinatorsview`
-- (See below for the actual view)
--
CREATE TABLE `deletecoordinatorsview` (
);

-- --------------------------------------------------------

--
-- Table structure for table `hods`
--
-- Error reading structure for table ngoma_osborne_222004457.hods: #1932 - Table 'ngoma_osborne_222004457.hods' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.hods: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`hods`' at line 1

--
-- Triggers `hods`
--
DELIMITER $$
CREATE TRIGGER `AfterUpdateHOD` AFTER UPDATE ON `hods` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('HODs', NEW.hod_id, 'Update');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `hods_view`
-- (See below for the actual view)
--
CREATE TABLE `hods_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_bookingrecords_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_bookingrecords_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_classes_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_classes_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_classrepresentatives_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_classrepresentatives_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_classrooms_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_classrooms_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_coordinators_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_coordinators_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_courses_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_courses_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_hods_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_hods_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_teachers_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_teachers_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_timetables_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_timetables_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--
-- Error reading structure for table ngoma_osborne_222004457.teachers: #1932 - Table 'ngoma_osborne_222004457.teachers' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.teachers: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`teachers`' at line 1

--
-- Triggers `teachers`
--
DELIMITER $$
CREATE TRIGGER `AfterDeleteTeacher` AFTER DELETE ON `teachers` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('Teachers', OLD.teacher_id, 'Delete');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterUpdateTeacher` AFTER UPDATE ON `teachers` FOR EACH ROW BEGIN
    INSERT INTO AuditLog (table_name, record_id, action)
    VALUES ('Teachers', NEW.teacher_id, 'Update');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `teachers_view`
-- (See below for the actual view)
--
CREATE TABLE `teachers_view` (
);

-- --------------------------------------------------------

--
-- Table structure for table `timetables`
--
-- Error reading structure for table ngoma_osborne_222004457.timetables: #1932 - Table 'ngoma_osborne_222004457.timetables' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.timetables: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`timetables`' at line 1

--
-- Triggers `timetables`
--
DELIMITER $$
CREATE TRIGGER `AfterInsertTimetables` AFTER INSERT ON `timetables` FOR EACH ROW BEGIN
    INSERT INTO BookingRecords (class_id, timetable_id, classroom_id, booking_status, timestamp)
    VALUES (NEW.class_id, NEW.timetable_id, NEW.classroom_id, 'approved', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `timetables_view`
-- (See below for the actual view)
--
CREATE TABLE `timetables_view` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `updateclassrepresentativesview`
-- (See below for the actual view)
--
CREATE TABLE `updateclassrepresentativesview` (
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `updatecoordinatorsview`
-- (See below for the actual view)
--
CREATE TABLE `updatecoordinatorsview` (
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
-- Error reading structure for table ngoma_osborne_222004457.users: #1932 - Table 'ngoma_osborne_222004457.users' doesn't exist in engine
-- Error reading data for table ngoma_osborne_222004457.users: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `ngoma_osborne_222004457`.`users`' at line 1

-- --------------------------------------------------------

--
-- Structure for view `bookingrecords_view`
--
DROP TABLE IF EXISTS `bookingrecords_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `bookingrecords_view`  AS SELECT `bookingrecords`.`booking_id` AS `booking_id`, `bookingrecords`.`class_id` AS `class_id`, `bookingrecords`.`timetable_id` AS `timetable_id`, `bookingrecords`.`classroom_id` AS `classroom_id`, `bookingrecords`.`booking_status` AS `booking_status`, `bookingrecords`.`conflict_resolution` AS `conflict_resolution`, `bookingrecords`.`notification_message` AS `notification_message`, `bookingrecords`.`timestamp` AS `timestamp` FROM `bookingrecords` ;

-- --------------------------------------------------------

--
-- Structure for view `classes_view`
--
DROP TABLE IF EXISTS `classes_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `classes_view`  AS SELECT `classes`.`class_id` AS `class_id`, `classes`.`class_name` AS `class_name`, `classes`.`rep_id` AS `rep_id` FROM `classes` ;

-- --------------------------------------------------------

--
-- Structure for view `classrepresentatives_view`
--
DROP TABLE IF EXISTS `classrepresentatives_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `classrepresentatives_view`  AS SELECT `classrepresentatives`.`rep_id` AS `rep_id`, `classrepresentatives`.`rep_name` AS `rep_name`, `classrepresentatives`.`class_id` AS `class_id` FROM `classrepresentatives` ;

-- --------------------------------------------------------

--
-- Structure for view `classrooms_view`
--
DROP TABLE IF EXISTS `classrooms_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `classrooms_view`  AS SELECT `classrooms`.`classroom_id` AS `classroom_id`, `classrooms`.`classroom_name` AS `classroom_name`, `classrooms`.`capacity` AS `capacity`, `classrooms`.`location` AS `location` FROM `classrooms` ;

-- --------------------------------------------------------

--
-- Structure for view `coordinators_view`
--
DROP TABLE IF EXISTS `coordinators_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `coordinators_view`  AS SELECT `coordinators`.`coordinator_id` AS `coordinator_id`, `coordinators`.`coordinator_name` AS `coordinator_name`, `coordinators`.`sex` AS `sex`, `coordinators`.`email` AS `email`, `coordinators`.`phone_number` AS `phone_number` FROM `coordinators` ;

-- --------------------------------------------------------

--
-- Structure for view `courses_view`
--
DROP TABLE IF EXISTS `courses_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `courses_view`  AS SELECT `courses`.`course_id` AS `course_id`, `courses`.`course_name` AS `course_name`, `courses`.`Teachers_id` AS `Teachers_id`, `courses`.`credits` AS `credits` FROM `courses` ;

-- --------------------------------------------------------

--
-- Structure for view `courseteacherview`
--
DROP TABLE IF EXISTS `courseteacherview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `courseteacherview`  AS SELECT `c`.`course_name` AS `course_name`, (select `t`.`Name` from `teachers` `t` where `t`.`teacher_id` = `c`.`Teachers_id`) AS `teacher_name` FROM `courses` AS `c` ;

-- --------------------------------------------------------

--
-- Structure for view `deleteclassrepresentativesview`
--
DROP TABLE IF EXISTS `deleteclassrepresentativesview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `deleteclassrepresentativesview`  AS SELECT `classrepresentatives`.`rep_id` AS `rep_id`, `classrepresentatives`.`rep_name` AS `rep_name`, `classrepresentatives`.`class_id` AS `class_id` FROM `classrepresentatives` WHERE `classrepresentatives`.`class_id` is null ;

-- --------------------------------------------------------

--
-- Structure for view `deletecoordinatorsview`
--
DROP TABLE IF EXISTS `deletecoordinatorsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `deletecoordinatorsview`  AS SELECT `coordinators`.`coordinator_id` AS `coordinator_id`, `coordinators`.`coordinator_name` AS `coordinator_name`, `coordinators`.`email` AS `email` FROM `coordinators` WHERE `coordinators`.`email` not like '%example.com' ;

-- --------------------------------------------------------

--
-- Structure for view `hods_view`
--
DROP TABLE IF EXISTS `hods_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `hods_view`  AS SELECT `hods`.`hod_id` AS `hod_id`, `hods`.`hod_name` AS `hod_name`, `hods`.`email` AS `email`, `hods`.`phone_number` AS `phone_number`, `hods`.`department` AS `department`, `hods`.`sex` AS `sex` FROM `hods` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_bookingrecords_view`
--
DROP TABLE IF EXISTS `insert_into_bookingrecords_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_bookingrecords_view`  AS SELECT `bookingrecords`.`booking_id` AS `booking_id`, `bookingrecords`.`class_id` AS `class_id`, `bookingrecords`.`timetable_id` AS `timetable_id`, `bookingrecords`.`classroom_id` AS `classroom_id`, `bookingrecords`.`booking_status` AS `booking_status`, `bookingrecords`.`conflict_resolution` AS `conflict_resolution`, `bookingrecords`.`notification_message` AS `notification_message`, `bookingrecords`.`timestamp` AS `timestamp` FROM `bookingrecords` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_classes_view`
--
DROP TABLE IF EXISTS `insert_into_classes_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_classes_view`  AS SELECT `classes`.`class_id` AS `class_id`, `classes`.`class_name` AS `class_name`, `classes`.`rep_id` AS `rep_id` FROM `classes` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_classrepresentatives_view`
--
DROP TABLE IF EXISTS `insert_into_classrepresentatives_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_classrepresentatives_view`  AS SELECT `classrepresentatives`.`rep_id` AS `rep_id`, `classrepresentatives`.`rep_name` AS `rep_name`, `classrepresentatives`.`class_id` AS `class_id` FROM `classrepresentatives` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_classrooms_view`
--
DROP TABLE IF EXISTS `insert_into_classrooms_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_classrooms_view`  AS SELECT `classrooms`.`classroom_id` AS `classroom_id`, `classrooms`.`classroom_name` AS `classroom_name`, `classrooms`.`capacity` AS `capacity`, `classrooms`.`location` AS `location` FROM `classrooms` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_coordinators_view`
--
DROP TABLE IF EXISTS `insert_into_coordinators_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_coordinators_view`  AS SELECT `coordinators`.`coordinator_id` AS `coordinator_id`, `coordinators`.`coordinator_name` AS `coordinator_name`, `coordinators`.`sex` AS `sex`, `coordinators`.`email` AS `email`, `coordinators`.`phone_number` AS `phone_number` FROM `coordinators` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_courses_view`
--
DROP TABLE IF EXISTS `insert_into_courses_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_courses_view`  AS SELECT `courses`.`course_id` AS `course_id`, `courses`.`course_name` AS `course_name`, `courses`.`Teachers_id` AS `Teachers_id`, `courses`.`credits` AS `credits` FROM `courses` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_hods_view`
--
DROP TABLE IF EXISTS `insert_into_hods_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_hods_view`  AS SELECT `hods`.`hod_id` AS `hod_id`, `hods`.`hod_name` AS `hod_name`, `hods`.`email` AS `email`, `hods`.`phone_number` AS `phone_number`, `hods`.`department` AS `department`, `hods`.`sex` AS `sex` FROM `hods` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_teachers_view`
--
DROP TABLE IF EXISTS `insert_into_teachers_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_teachers_view`  AS SELECT `teachers`.`teacher_id` AS `teacher_id`, `teachers`.`Name` AS `Name`, `teachers`.`email` AS `email`, `teachers`.`sex` AS `sex`, `teachers`.`specialization` AS `specialization` FROM `teachers` ;

-- --------------------------------------------------------

--
-- Structure for view `insert_into_timetables_view`
--
DROP TABLE IF EXISTS `insert_into_timetables_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `insert_into_timetables_view`  AS SELECT `timetables`.`timetable_id` AS `timetable_id`, `timetables`.`class_id` AS `class_id`, `timetables`.`course_id` AS `course_id`, `timetables`.`day_of_week` AS `day_of_week`, `timetables`.`start_time` AS `start_time`, `timetables`.`end_time` AS `end_time`, `timetables`.`classroom_id` AS `classroom_id` FROM `timetables` ;

-- --------------------------------------------------------

--
-- Structure for view `teachers_view`
--
DROP TABLE IF EXISTS `teachers_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `teachers_view`  AS SELECT `teachers`.`teacher_id` AS `teacher_id`, `teachers`.`Name` AS `Name`, `teachers`.`email` AS `email`, `teachers`.`sex` AS `sex`, `teachers`.`specialization` AS `specialization` FROM `teachers` ;

-- --------------------------------------------------------

--
-- Structure for view `timetables_view`
--
DROP TABLE IF EXISTS `timetables_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `timetables_view`  AS SELECT `timetables`.`timetable_id` AS `timetable_id`, `timetables`.`class_id` AS `class_id`, `timetables`.`course_id` AS `course_id`, `timetables`.`day_of_week` AS `day_of_week`, `timetables`.`start_time` AS `start_time`, `timetables`.`end_time` AS `end_time`, `timetables`.`classroom_id` AS `classroom_id` FROM `timetables` ;

-- --------------------------------------------------------

--
-- Structure for view `updateclassrepresentativesview`
--
DROP TABLE IF EXISTS `updateclassrepresentativesview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `updateclassrepresentativesview`  AS SELECT `classrepresentatives`.`rep_id` AS `rep_id`, `classrepresentatives`.`rep_name` AS `rep_name`, `classrepresentatives`.`class_id` AS `class_id` FROM `classrepresentatives` WHERE `classrepresentatives`.`class_id` is not null ;

-- --------------------------------------------------------

--
-- Structure for view `updatecoordinatorsview`
--
DROP TABLE IF EXISTS `updatecoordinatorsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`ngoma_osborne`@`localhost` SQL SECURITY DEFINER VIEW `updatecoordinatorsview`  AS SELECT `coordinators`.`coordinator_id` AS `coordinator_id`, `coordinators`.`coordinator_name` AS `coordinator_name`, `coordinators`.`sex` AS `sex`, `coordinators`.`email` AS `email`, `coordinators`.`phone_number` AS `phone_number` FROM `coordinators` WHERE `coordinators`.`sex` = 'Female' ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
