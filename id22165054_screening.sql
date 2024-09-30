-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 30, 2024 at 09:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id22165054_screening`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_child`
--

CREATE TABLE `add_child` (
  `id` varchar(255) NOT NULL,
  `patient_id` int(255) NOT NULL,
  `child_name` varchar(255) NOT NULL,
  `parent_name` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `phone_no` varchar(255) NOT NULL,
  `weight` varchar(255) NOT NULL,
  `height` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `add_child`
--
DELIMITER $$
CREATE TRIGGER `delete_doctor_detials` AFTER DELETE ON `add_child` FOR EACH ROW UPDATE doctors_detials SET no_of_patient = (SELECT COUNT(id) FROM add_child WHERE id = OLD.id) , completed_patient = (SELECT COUNT(id) FROM add_child WHERE id = OLD.id) WHERE id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_add` AFTER INSERT ON `add_child` FOR EACH ROW INSERT INTO patient_table(id,patient_id,child_name,parent_name,age,image_path) VALUES(NEW.id,NEW.patient_id,NEW.child_name,NEW.parent_name,NEW.dob,NEW.image_path)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_delete` AFTER DELETE ON `add_child` FOR EACH ROW DELETE FROM patient_table WHERE patient_id = OLD.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_update` AFTER UPDATE ON `add_child` FOR EACH ROW UPDATE patient_table SET child_name = NEW.child_name,parent_name =NEW.parent_name,age=NEW.dob,image_path = NEW.image_path WHERE patient_id = NEW.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_doctor_detials` AFTER INSERT ON `add_child` FOR EACH ROW UPDATE doctors_detials SET no_of_patient = (SELECT COUNT(id) FROM add_child WHERE id = NEW.id) WHERE id = NEW.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adhd`
--

CREATE TABLE `adhd` (
  `S.NO` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adhd`
--

INSERT INTO `adhd` (`S.NO`, `Questions`) VALUES
(1, 'Fidgets with hands or feet or squirms in seat'),
(2, 'Leaves seat when he is suppose to stay in his seat'),
(3, 'Runs about or climbs too much when he is suppose to stay seated'),
(4, 'Has difficulty playing or starting quiet games'),
(5, 'Is “on the go” or often acts as if “driven by a motor”'),
(6, 'Talks too much'),
(7, 'Blurts out answers before questions have been completed'),
(8, 'Has difficulty waiting his/her turn'),
(9, 'Interrupts or bothers others when they are talking or playing games'),
(10, 'How is your child doing in reading?'),
(11, 'How is your child doing in writing?'),
(12, 'How is your child doing in math?'),
(13, 'How does your child get along with you?'),
(14, 'How does the child get along with others');

-- --------------------------------------------------------

--
-- Table structure for table `anxiety`
--

CREATE TABLE `anxiety` (
  `S.no` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anxiety`
--

INSERT INTO `anxiety` (`S.no`, `Questions`) VALUES
(1, 'Refuses to share'),
(2, 'Does not understand other people’s feelings'),
(3, 'Fights with other children'),
(4, 'Blames others for his or her trouble'),
(5, 'Does not listen to rules'),
(6, 'Teases others'),
(7, 'Takes things that do not belong to him or her');

-- --------------------------------------------------------

--
-- Table structure for table `attention`
--

CREATE TABLE `attention` (
  `S.no` int(11) NOT NULL,
  `Question` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attention`
--

INSERT INTO `attention` (`S.no`, `Question`) VALUES
(1, 'Fidgety, unable to sit still'),
(2, 'Daydream too much'),
(3, 'Have trouble concentrating'),
(4, 'Act as if driven by a motor'),
(5, 'Distract easily');

-- --------------------------------------------------------

--
-- Table structure for table `depression`
--

CREATE TABLE `depression` (
  `S.no` int(200) NOT NULL,
  `Questions` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `depression`
--

INSERT INTO `depression` (`S.no`, `Questions`) VALUES
(1, 'Feels sad, unhappy'),
(2, 'Feels hopeless'),
(3, 'Is down on him or herself'),
(4, 'Seems to be having less fun'),
(5, 'Worries a lot');

-- --------------------------------------------------------

--
-- Table structure for table `doctors_detials`
--

CREATE TABLE `doctors_detials` (
  `id` varchar(255) NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `no_of_patient` bigint(255) NOT NULL,
  `age` int(100) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) NOT NULL,
  `Specialization` varchar(255) NOT NULL,
  `completed_patient` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `doctors_detials`
--
DELIMITER $$
CREATE TRIGGER `login_update` AFTER UPDATE ON `doctors_detials` FOR EACH ROW UPDATE login_user SET email_id = NEW.email_id WHERE id = NEW.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `register_update` AFTER UPDATE ON `doctors_detials` FOR EACH ROW UPDATE register_user SET name=NEW.doctor_name,email_id=NEW.email_id,Specialization=NEW.Specialization WHERE id=NEW.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `finemotor`
--

CREATE TABLE `finemotor` (
  `S.NO` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `finemotor`
--

INSERT INTO `finemotor` (`S.NO`, `Questions`, `age`) VALUES
(1, 'mature pincer grasp', 11),
(2, 'Points to parts of doll', 25),
(3, 'Copy circle', 39),
(4, 'Draw person with 3 parts', 55),
(5, 'Writes alphabets', 56),
(7, 'Copy 3 shapes', 64),
(8, 'Picks 5 objects from the group', 66),
(9, 'Bottun / Unbotton', 66);

-- --------------------------------------------------------

--
-- Table structure for table `growthmotor`
--

CREATE TABLE `growthmotor` (
  `S.NO` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `growthmotor`
--

INSERT INTO `growthmotor` (`S.NO`, `Questions`, `age`) VALUES
(1, 'Holds head steady', 4),
(2, 'Rolls from back to stomach', 5),
(3, 'Raises self to sitting position', 11),
(4, 'standing with support', 11),
(5, 'Walks with support', 11),
(6, 'Walks without support', 19),
(7, 'Jumps in place', 29),
(8, 'Hops continuously', 52),
(9, 'Heel to toe walk 4 consecutive steps', 60);

-- --------------------------------------------------------

--
-- Table structure for table `login_user`
--

CREATE TABLE `login_user` (
  `id` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `login_user`
--
DELIMITER $$
CREATE TRIGGER `register_userUpdate` AFTER UPDATE ON `login_user` FOR EACH ROW UPDATE register_user SET password= NEW.password WHERE id=NEW.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `patient_table`
--

CREATE TABLE `patient_table` (
  `id` varchar(255) NOT NULL,
  `patient_id` int(255) NOT NULL,
  `child_name` varchar(255) NOT NULL,
  `parent_name` varchar(255) NOT NULL,
  `age` int(100) NOT NULL,
  `conditions` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `Growth_condition` varchar(255) DEFAULT NULL,
  `completed_growth` varchar(255) DEFAULT NULL,
  `completed_Behaviour` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `patient_table`
--
DELIMITER $$
CREATE TRIGGER `insert_trigger` AFTER UPDATE ON `patient_table` FOR EACH ROW BEGIN
    DECLARE column1_inserted BOOLEAN;
    DECLARE column2_inserted BOOLEAN;
    

    -- Check if both columns are inserted
    SET column1_inserted = NEW.completed_growth IS NOT NULL;
    SET column2_inserted = NEW.completed_behaviour IS NOT NULL;

    -- If both columns are inserted, proceed with insertion
    
    IF column1_inserted AND column2_inserted THEN
        UPDATE doctors_detials SET completed_patient = completed_patient+1 WHERE id = NEW.id;

        
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `register_user`
--

CREATE TABLE `register_user` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `registration_no` text NOT NULL,
  `Specialization` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `register_user`
--
DELIMITER $$
CREATE TRIGGER `delete_addchild` AFTER DELETE ON `register_user` FOR EACH ROW DELETE FROM add_child WHERE id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctors_detials_add` AFTER INSERT ON `register_user` FOR EACH ROW INSERT INTO doctors_detials(id,doctor_name,no_of_patient,image_path,email_id,Specialization,completed_patient) VALUES(NEW.id,NEW.name,0,"../uploads/doctors_image/default.jpg",NEW.email_id,NEW.Specialization,0)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctors_detials_delete` AFTER DELETE ON `register_user` FOR EACH ROW DELETE FROM doctors_detials WHERE id = OLD.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `login_user_add` AFTER INSERT ON `register_user` FOR EACH ROW INSERT INTO login_user(id,email_id,password) VALUES (NEW.id,NEW.email_id,NEW.password)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `login_user_delete` AFTER DELETE ON `register_user` FOR EACH ROW DELETE FROM login_user WHERE id = OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `social`
--

CREATE TABLE `social` (
  `S.NO` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social`
--

INSERT INTO `social` (`S.NO`, `Questions`, `age`) VALUES
(1, 'Social smile', 2),
(2, 'Concept of one', 46),
(3, 'Plays and talks with peers', 50),
(4, 'Points to middle', 65),
(5, 'Writes own name', 72);

-- --------------------------------------------------------

--
-- Table structure for table `speechs`
--

CREATE TABLE `speechs` (
  `S.NO` int(11) NOT NULL,
  `Questions` varchar(255) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `speechs`
--

INSERT INTO `speechs` (`S.NO`, `Questions`, `age`) VALUES
(1, 'says 2 words', 19),
(2, 'uses word for personal needs ', 27),
(3, 'Tells gender when asked', 33),
(4, 'On instruction place objects', 36),
(5, 'Asks simple questions', 36),
(6, 'Answer 2 questions', 40),
(7, 'Name one colour', 45),
(8, 'Tells use of two objects', 45),
(9, 'Tells function of 3 body parts', 57),
(10, 'Answers why questions', 63),
(11, 'Names days of the week in order', 70),
(12, 'Uses 5-6 word sentences', 72);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_child`
--
ALTER TABLE `add_child`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `adhd`
--
ALTER TABLE `adhd`
  ADD PRIMARY KEY (`S.NO`);

--
-- Indexes for table `anxiety`
--
ALTER TABLE `anxiety`
  ADD PRIMARY KEY (`S.no`);

--
-- Indexes for table `attention`
--
ALTER TABLE `attention`
  ADD PRIMARY KEY (`S.no`);

--
-- Indexes for table `depression`
--
ALTER TABLE `depression`
  ADD PRIMARY KEY (`S.no`);

--
-- Indexes for table `doctors_detials`
--
ALTER TABLE `doctors_detials`
  ADD UNIQUE KEY `email_id` (`email_id`) USING BTREE;

--
-- Indexes for table `finemotor`
--
ALTER TABLE `finemotor`
  ADD PRIMARY KEY (`S.NO`);

--
-- Indexes for table `growthmotor`
--
ALTER TABLE `growthmotor`
  ADD PRIMARY KEY (`S.NO`);

--
-- Indexes for table `register_user`
--
ALTER TABLE `register_user`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `email_id` (`email_id`),
  ADD UNIQUE KEY `registration_no` (`registration_no`) USING HASH;

--
-- Indexes for table `social`
--
ALTER TABLE `social`
  ADD PRIMARY KEY (`S.NO`);

--
-- Indexes for table `speechs`
--
ALTER TABLE `speechs`
  ADD PRIMARY KEY (`S.NO`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_child`
--
ALTER TABLE `add_child`
  MODIFY `patient_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `adhd`
--
ALTER TABLE `adhd`
  MODIFY `S.NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `anxiety`
--
ALTER TABLE `anxiety`
  MODIFY `S.no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `attention`
--
ALTER TABLE `attention`
  MODIFY `S.no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `depression`
--
ALTER TABLE `depression`
  MODIFY `S.no` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `finemotor`
--
ALTER TABLE `finemotor`
  MODIFY `S.NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `growthmotor`
--
ALTER TABLE `growthmotor`
  MODIFY `S.NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `social`
--
ALTER TABLE `social`
  MODIFY `S.NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `speechs`
--
ALTER TABLE `speechs`
  MODIFY `S.NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
