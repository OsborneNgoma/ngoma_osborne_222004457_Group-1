-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 08, 2024 at 08:54 PM
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
-- Database: `ngoma_osborne_cams`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`ngoma_osborne`@`localhost` PROCEDURE `DeleteDataFromTwoTables` (IN `tableName1` VARCHAR(255), IN `condition1` VARCHAR(255), IN `tableName2` VARCHAR(255), IN `condition2` VARCHAR(255))   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    SET @sql1 = CONCAT('DELETE FROM ', tableName1, ' WHERE ', condition1);
    SET @sql2 = CONCAT('DELETE FROM ', tableName2, ' WHERE ', condition2);

    PREPARE stmt1 FROM @sql1;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;

    PREPARE stmt2 FROM @sql2;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

    COMMIT;
END$$

CREATE DEFINER=`ngoma_osborne`@`localhost` PROCEDURE `DisplayAllInformation` ()   BEGIN
    SELECT * FROM Classes;
    SELECT * FROM ClassRepresentatives;
    SELECT * FROM Coordinators;
    SELECT * FROM HODs;
    SELECT * FROM Courses;
    SELECT * FROM Teachers;
    SELECT * FROM Classrooms;
    SELECT * FROM Users;
    SELECT * FROM Timetables;
    SELECT * FROM BookingRecords;
END$$

CREATE DEFINER=`ngoma_osborne`@`localhost` PROCEDURE `InsertDataIntoTable` (IN `tableName` VARCHAR(255), IN `columnNames` TEXT, IN `columnValues` TEXT)   BEGIN
    SET @sql = CONCAT('INSERT INTO ', tableName, ' (', columnNames, ') VALUES (', columnValues, ');');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`ngoma_osborne`@`localhost` PROCEDURE `TeacherCourseCountView` ()   BEGIN
    CREATE OR REPLACE VIEW TeacherCourseCount AS
    SELECT
        T.teacher_id,
        T.Name AS teacher_name,
        COUNT(C.course_id) AS course_count
    FROM
        Teachers T
    LEFT JOIN
        Courses C ON T.teacher_id = C.Teachers_id
    GROUP BY
        T.teacher_id, T.Name;
END$$

CREATE DEFINER=`ngoma_osborne`@`localhost` PROCEDURE `UpdateTableData` (IN `tableName` VARCHAR(255), IN `columnName` VARCHAR(255), IN `newValue` VARCHAR(255), IN `conditionName` VARCHAR(255))   BEGIN
    SET @sql = CONCAT('UPDATE ', tableName, ' SET ', columnName, ' = ? WHERE ', conditionName);
    PREPARE stmt FROM @sql;
    SET @newValue = newValue;
    EXECUTE stmt USING @newValue;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `auditlog`
--

CREATE TABLE `auditlog` (
  `log_id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `record_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `log_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookingrecords`
--

CREATE TABLE `bookingrecords` (
  `booking_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `booking_status` enum('pending','approved','rejected') NOT NULL,
  `conflict_resolution` text DEFAULT NULL,
  `notification_message` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `bookingrecords_view`
-- (See below for the actual view)
--
CREATE TABLE `bookingrecords_view` (
`booking_id` int(11)
,`class_id` int(11)
,`timetable_id` int(11)
,`classroom_id` int(11)
,`booking_status` enum('pending','approved','rejected')
,`conflict_resolution` text
,`notification_message` text
,`timestamp` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `rep_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`, `rep_id`) VALUES
(1, 'BIT', NULL),
(2, 'ACC', NULL),
(3, 'ACC YEAR 2', NULL),
(4, 'ACC YEAR 2', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `classes_view`
-- (See below for the actual view)
--
CREATE TABLE `classes_view` (
`class_id` int(11)
,`class_name` varchar(255)
,`rep_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `classrepresentatives`
--

CREATE TABLE `classrepresentatives` (
  `rep_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(120) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `email` varchar(250) NOT NULL,
  `class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classrepresentatives`
--

INSERT INTO `classrepresentatives` (`rep_id`, `first_name`, `last_name`, `phone_number`, `email`, `class_id`) VALUES
(1, 'John Doe', '', 0, '', 1),
(2, 'Jane Smith', '', 0, '', 2),
(3, 'TITI', 'mucyo', 987654, 'hub@gmail', 2);

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

CREATE TABLE `classrooms` (
  `classroom_id` int(11) NOT NULL,
  `classroom_name` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`classroom_id`, `classroom_name`, `capacity`, `location`) VALUES
(1, 'Room A101', 30, 'Building A'),
(2, 'Room B202', 25, 'Building B');

-- --------------------------------------------------------

--
-- Stand-in structure for view `classrooms_view`
-- (See below for the actual view)
--
CREATE TABLE `classrooms_view` (
`classroom_id` int(11)
,`classroom_name` varchar(255)
,`capacity` int(11)
,`location` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `coordinator_id` int(11) NOT NULL,
  `coordinator_name` varchar(255) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coordinators`
--

INSERT INTO `coordinators` (`coordinator_id`, `coordinator_name`, `sex`, `email`, `phone_number`) VALUES
(1, 'Alice Cooper', 'Female', 'alice@example.com', '123-456-7890'),
(2, 'Bob Brown', 'Male', 'bob@example.com', '987-654-3210');

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
`coordinator_id` int(11)
,`coordinator_name` varchar(255)
,`sex` enum('Male','Female')
,`email` varchar(255)
,`phone_number` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `Teachers_id` int(11) DEFAULT NULL,
  `credits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `Teachers_id`, `credits`) VALUES
(3, 'Computer Science 101', 1, 3),
(4, 'Mathematics 201', 2, 4);

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
`course_id` int(11)
,`course_name` varchar(255)
,`Teachers_id` int(11)
,`credits` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `courseteacherview`
-- (See below for the actual view)
--
CREATE TABLE `courseteacherview` (
`course_name` varchar(255)
,`teacher_name` varchar(255)
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
`coordinator_id` int(11)
,`coordinator_name` varchar(255)
,`email` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `hods`
--

CREATE TABLE `hods` (
  `hod_id` int(11) NOT NULL,
  `hod_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `department` varchar(255) NOT NULL,
  `sex` enum('Male','Female') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hods`
--

INSERT INTO `hods` (`hod_id`, `hod_name`, `email`, `phone_number`, `department`, `sex`) VALUES
(3, 'Dr. Smith', 'smith@example.com', '111-222-3333', 'Computer Science', 'Male'),
(4, 'Dr. Johnson', 'johnson@example.com', '444-555-6666', 'Mathematics', 'Female'),
(8, 'nindi', 'n@gm.com', '456639992', 'BIT', 'Male');

--
-- Triggers `hods`
--
DELIMITER $$
CREATE TRIGGER `AfterInsertHOD` AFTER INSERT ON `hods` FOR EACH ROW BEGIN
    DECLARE generated_password VARCHAR(8);
    
    SET generated_password = SUBSTRING(MD5(RAND()) FROM 1 FOR 8);  
    
    INSERT INTO Users (username, password, user_type, user_reference_id)
    VALUES (NEW.hod_name, SHA2(generated_password, 256), 'hod', NEW.hod_id); -- SHA2 with 256 bits
    
END
$$
DELIMITER ;
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
`hod_id` int(11)
,`hod_name` varchar(255)
,`email` varchar(255)
,`phone_number` varchar(20)
,`department` varchar(255)
,`sex` enum('Male','Female')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_bookingrecords_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_bookingrecords_view` (
`booking_id` int(11)
,`class_id` int(11)
,`timetable_id` int(11)
,`classroom_id` int(11)
,`booking_status` enum('pending','approved','rejected')
,`conflict_resolution` text
,`notification_message` text
,`timestamp` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_classes_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_classes_view` (
`class_id` int(11)
,`class_name` varchar(255)
,`rep_id` int(11)
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
`classroom_id` int(11)
,`classroom_name` varchar(255)
,`capacity` int(11)
,`location` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_coordinators_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_coordinators_view` (
`coordinator_id` int(11)
,`coordinator_name` varchar(255)
,`sex` enum('Male','Female')
,`email` varchar(255)
,`phone_number` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_courses_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_courses_view` (
`course_id` int(11)
,`course_name` varchar(255)
,`Teachers_id` int(11)
,`credits` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_hods_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_hods_view` (
`hod_id` int(11)
,`hod_name` varchar(255)
,`email` varchar(255)
,`phone_number` varchar(20)
,`department` varchar(255)
,`sex` enum('Male','Female')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insert_into_teachers_view`
-- (See below for the actual view)
--
CREATE TABLE `insert_into_teachers_view` (
`teacher_id` int(11)
,`Name` varchar(255)
,`email` varchar(255)
,`sex` enum('Male','Female')
,`specialization` varchar(255)
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

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `specialization` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `Name`, `email`, `sex`, `specialization`) VALUES
(1, 'John Teacher', 'johnteacher@example.com', 'Male', 'Computer Science'),
(2, 'Jane Teacher', 'janeteacher@example.com', 'Female', 'Mathematics'),
(3, 'mundi', 'nu@gm.com', 'Male', 'business');

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
`teacher_id` int(11)
,`Name` varchar(255)
,`email` varchar(255)
,`sex` enum('Male','Female')
,`specialization` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `timetables`
--

CREATE TABLE `timetables` (
  `timetable_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `Date` varchar(20) NOT NULL,
  `time_range` varchar(120) NOT NULL,
  `classroom_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `timetables`
--
DELIMITER $$
CREATE TRIGGER `AfterInsertTimetables` AFTER INSERT ON `timetables` FOR EACH ROW BEGIN
    INSERT INTO BookingRecords (class_id, timetable_id, classroom_id, booking_status, timestamp)
    VALUES (NEW.class_id, NEW.timetable_id, NEW.classroom_id, 'Booked', NOW());
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
`coordinator_id` int(11)
,`coordinator_name` varchar(255)
,`sex` enum('Male','Female')
,`email` varchar(255)
,`phone_number` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('teacher','coordinator','hod','representative') NOT NULL,
  `user_reference_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `user_type`, `user_reference_id`) VALUES
(1, 'Dr. Smith', '68e03d1183aa72b573662fcebfb2b0be3f1aa4a88ad77b21dc2c6da14dbedacc', 'hod', 3),
(2, 'Dr. Johnson', '029d07837af490f004f8fbf50fb581cc010eca66b4beb2a6866fdc40829e4bf9', 'hod', 4),
(3, 'titi', '1234', 'representative', 3),
(5, 'mandi', '123456', 'coordinator', 0),
(7, 'nindi', 'dce6dbb1c378ded683d80d143f68f1c3de1b2eec16bd2a1b9c1d0c94383b7589', 'hod', 8),
(8, 'mundi', '123456', 'teacher', 3);

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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auditlog`
--
ALTER TABLE `auditlog`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `bookingrecords`
--
ALTER TABLE `bookingrecords`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `timetable_id` (`timetable_id`),
  ADD KEY `classroom_id` (`classroom_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `rep_id` (`rep_id`);

--
-- Indexes for table `classrepresentatives`
--
ALTER TABLE `classrepresentatives`
  ADD PRIMARY KEY (`rep_id`);

--
-- Indexes for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`classroom_id`);

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`coordinator_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `Teachers_id` (`Teachers_id`);

--
-- Indexes for table `hods`
--
ALTER TABLE `hods`
  ADD PRIMARY KEY (`hod_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`);

--
-- Indexes for table `timetables`
--
ALTER TABLE `timetables`
  ADD PRIMARY KEY (`timetable_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `classroom_id` (`classroom_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auditlog`
--
ALTER TABLE `auditlog`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookingrecords`
--
ALTER TABLE `bookingrecords`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `classrepresentatives`
--
ALTER TABLE `classrepresentatives`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `classrooms`
--
ALTER TABLE `classrooms`
  MODIFY `classroom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `coordinators`
--
ALTER TABLE `coordinators`
  MODIFY `coordinator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hods`
--
ALTER TABLE `hods`
  MODIFY `hod_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `timetables`
--
ALTER TABLE `timetables`
  MODIFY `timetable_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookingrecords`
--
ALTER TABLE `bookingrecords`
  ADD CONSTRAINT `bookingrecords_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `teachers` (`teacher_id`),
  ADD CONSTRAINT `bookingrecords_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetables` (`timetable_id`),
  ADD CONSTRAINT `bookingrecords_ibfk_3` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`);

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`rep_id`) REFERENCES `classrepresentatives` (`rep_id`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`Teachers_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Constraints for table `timetables`
--
ALTER TABLE `timetables`
  ADD CONSTRAINT `timetables_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`),
  ADD CONSTRAINT `timetables_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `timetables_ibfk_3` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
