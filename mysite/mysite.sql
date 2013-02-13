-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 13, 2013 at 05:16 PM
-- Server version: 5.5.21
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mysite`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
  `cid` int(30) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) NOT NULL,
  `owner` varchar(30) NOT NULL,
  `start_date` date NOT NULL,
  `no_of_followers` int(30) DEFAULT '0',
  `category` varchar(50) NOT NULL,
  `rating` float DEFAULT '3',
  `desc` varchar(1000) DEFAULT NULL,
  `raters` int(30) DEFAULT '1',
  `approved` varchar(10) DEFAULT 'no',
  PRIMARY KEY (`cid`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`cid`, `cname`, `owner`, `start_date`, `no_of_followers`, `category`, `rating`, `desc`, `raters`, `approved`) VALUES
(1, 'course1', 'godisdj007@gmail.com', '2013-02-10', 1, 'others', 2.83333, 'desc1', 6, 'no'),
(9, 'course2', 'godisdj007@gmail.com', '2013-02-10', 2, 'others', 3.5, 'desc2', 2, 'no'),
(11, 'da', 'godisdj.cobain@gmail.com', '2013-02-12', 2, 'computer science', 3.5, 'design and analysis of \r\nalgorithms', 2, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE IF NOT EXISTS `enrollments` (
  `cid` int(30) NOT NULL,
  `uid` varchar(30) NOT NULL,
  PRIMARY KEY (`cid`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`cid`, `uid`) VALUES
(9, 'godisdj.cobain@gmail.com'),
(11, 'godisdj.cobain@gmail.com'),
(1, 'godisdj007@gmail.com'),
(9, 'godisdj007@gmail.com'),
(11, 'godisdj007@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE IF NOT EXISTS `feedbacks` (
  `uid` varchar(20) NOT NULL,
  `feedback` varchar(200) DEFAULT NULL,
  `post_date` date NOT NULL,
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `fno` bigint(100) NOT NULL AUTO_INCREMENT,
  `cid` int(30) NOT NULL,
  `owner` varchar(30) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `no_of_posts` int(30) NOT NULL DEFAULT '0',
  `start_date` date NOT NULL,
  PRIMARY KEY (`fno`),
  KEY `cid` (`cid`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `forums`
--

INSERT INTO `forums` (`fno`, `cid`, `owner`, `fname`, `no_of_posts`, `start_date`) VALUES
(2, 11, 'godisdj007@gmail.com', 'what is the syllabus for this course?', 0, '2013-02-12');

-- --------------------------------------------------------

--
-- Table structure for table `forumsposts`
--

CREATE TABLE IF NOT EXISTS `forumsposts` (
  `pno` bigint(30) NOT NULL AUTO_INCREMENT,
  `cid` int(30) NOT NULL,
  `fno` bigint(30) NOT NULL,
  `posted_by` varchar(30) NOT NULL,
  `posted_on` date NOT NULL,
  `likes` int(30) DEFAULT '0',
  `content` varchar(300) NOT NULL,
  PRIMARY KEY (`pno`),
  KEY `cid` (`cid`),
  KEY `fno` (`fno`),
  KEY `posted_by` (`posted_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `forumsposts`
--

INSERT INTO `forumsposts` (`pno`, `cid`, `fno`, `posted_by`, `posted_on`, `likes`, `content`) VALUES
(2, 11, 2, 'godisdj.cobain@gmail.com', '2013-02-13', 0, 'asldkjasdlkhdkhjdlkasjdlj'),
(3, 11, 2, 'godisdj.cobain@gmail.com', '2013-02-13', 0, 'post added 1');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `cid` int(30) NOT NULL,
  `lno` bigint(100) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `ldesc` varchar(200) NOT NULL,
  `postdate` date NOT NULL,
  `filetype` varchar(10) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `submitted_by` varchar(30) DEFAULT NULL,
  `likes` int(30) DEFAULT '0',
  PRIMARY KEY (`cid`,`lno`),
  KEY `submitted_by` (`submitted_by`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`cid`, `lno`, `lname`, `ldesc`, `postdate`, `filetype`, `filename`, `submitted_by`, `likes`) VALUES
(11, 0, 'introduction', 'this lesson gives you a brief introduction of the course', '2013-02-12', 'pdf', 'slides_algo-intro-annotated-final.pdf', 'godisdj.cobain@gmail.com', 0),
(11, 1, 'Merge Sort Motivation and Example', 'merge sort example', '2013-02-12', 'video', '1 - 3 - Merge Sort Motivation and Example (9 min).mp4', 'godisdj.cobain@gmail.com', 0),
(11, 2, '1 - 4 - Merge Sort Pseudocode (13 min)', 'desc of merge sort', '2013-02-12', 'video', '1 - 4 - Merge Sort Pseudocode (13 min).mp4', 'godisdj007@gmail.com', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(30) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `name`, `email`, `password`) VALUES
(1, 'devesh joshi', 'godisdj007@gmail.com', 'morzinraat'),
(9, 'use2', 'godisd', 'asdf'),
(10, 'dev', 'godisdj.cobain@gmail.com', 'pass'),
(11, 'dev', 'godisdj@gmail.com', 'pass'),
(13, 'asd', 'godisdj00@gmail.com', 'qwe'),
(14, 'op', 'opop@wed.com', 'kj');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `courses` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forums`
--
ALTER TABLE `forums`
  ADD CONSTRAINT `forums_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `courses` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forums_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `forumsposts`
--
ALTER TABLE `forumsposts`
  ADD CONSTRAINT `forumsposts_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `courses` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forumsposts_ibfk_2` FOREIGN KEY (`posted_by`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `forumsposts_ibfk_3` FOREIGN KEY (`fno`) REFERENCES `forums` (`fno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `courses` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lessons_ibfk_2` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
