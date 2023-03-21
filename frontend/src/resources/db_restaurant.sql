-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 21, 2023 at 06:44 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_restaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_type` varchar(256) NOT NULL,
  `table_name` varchar(256) NOT NULL,
  `table_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `table_type`, `table_name`, `table_id`, `date`, `user_id`) VALUES
(1, 'two_seating', 'table 2', NULL, '2023-02-11 14:35:00', 2),
(2, 'two_seating', 'table 1', NULL, '2023-02-11 14:55:00', 1),
(3, 'two_seating', 'table 1', NULL, '2023-02-13 08:48:00', 0),
(4, 'two_seating', 'table 1', NULL, '2023-02-15 09:36:00', 1),
(5, 'four_seating', 'table 1', NULL, '2023-02-15 11:36:00', 2),
(6, 'two_seating', 'table 1', NULL, '2023-03-16 10:25:00', 1),
(7, 'two_seating', 'table 1', NULL, '2023-03-19 14:52:00', 1),
(8, 'two_seating', '1', 0, '2023-03-19 15:07:00', 1),
(9, 'two_seating', 'table 1', 1, '2023-03-20 10:15:00', 1),
(10, 'two_seating', 'table 1', 1, '2023-03-20 13:04:00', 1),
(11, 'two_seating', 'table 1', 1, '2023-03-20 11:59:00', 1),
(12, 'two_seating', 'table 1', 1, '2023-03-21 09:11:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `booktable`
--

CREATE TABLE `booktable` (
  `book_id` int(11) NOT NULL,
  `book_seat` varchar(255) DEFAULT NULL,
  `book_tables` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `book_when` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `price` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `table_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `id` bigint(20) NOT NULL,
  `cart_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`cart_details`)),
  `status` varchar(255) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`price`, `user_id`, `table_details`, `id`, `cart_details`, `status`) VALUES
(0, 1, '{\"table_type\":\"two_seating\",\"table_name\":\"table 1\",\"table_id\":1,\"date\":\"2023-03-20T11:59\",\"user_id\":1}', 20, '[{\"id\":7,\"category_id\":1,\"description\":\"jhjhjhjhj\",\"image\":\"uploads\\\\1672594036909.png\",\"name\":\"jjnhujhjhjhj\",\"category_name\":\"test\",\"price\":1000,\"quantity\":1,\"product_id\":7,\"user_id\":1}]', 'purchased'),
(0, 1, '{\"table_type\":\"two_seating\",\"table_name\":\"table 1\",\"table_id\":1,\"date\":\"2023-03-21T09:11\",\"user_id\":1}', 21, '[{\"id\":6,\"category_id\":1,\"description\":\"ghghghghgh\",\"image\":\"uploads\\\\1672593614189.png\",\"name\":\"fghghghgh\",\"category_name\":\"test\",\"price\":200,\"quantity\":2,\"product_id\":6,\"user_id\":1},{\"id\":8,\"category_id\":4,\"description\":\"bdfdfhdhfhdfb\",\"image\":\"uploads\\\\1672594077103.png\",\"name\":\"Dummy2\",\"category_name\":\"dummy\",\"price\":5000,\"quantity\":1,\"product_id\":8,\"user_id\":1},{\"id\":9,\"category_id\":4,\"description\":\"hghghghghg\",\"image\":\"uploads\\\\1672596343364.png\",\"name\":\"fghgfhghgh\",\"category_name\":\"dummy\",\"price\":444,\"quantity\":1,\"product_id\":9,\"user_id\":1},{\"id\":7,\"category_id\":1,\"description\":\"jhjhjhjhj\",\"image\":\"uploads\\\\1672594036909.png\",\"name\":\"jjnhujhjhjhj\",\"category_name\":\"test\",\"price\":1000,\"quantity\":1,\"product_id\":7,\"user_id\":1}]', 'purchased');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `food_id` int(11) NOT NULL,
  `food_name` varchar(255) DEFAULT NULL,
  `food_star` varchar(255) DEFAULT NULL,
  `food_vote` varchar(255) DEFAULT NULL,
  `food_price` varchar(255) DEFAULT NULL,
  `food_discount` varchar(255) DEFAULT NULL,
  `food_desc` varchar(255) DEFAULT NULL,
  `food_status` varchar(255) DEFAULT NULL,
  `food_type` varchar(255) DEFAULT NULL,
  `food_category` varchar(255) DEFAULT NULL,
  `food_src` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`food_id`, `food_name`, `food_star`, `food_vote`, `food_price`, `food_discount`, `food_desc`, `food_status`, `food_type`, `food_category`, `food_src`) VALUES
(1, 'irani', '4.5', '500', '500.00', '0.00', 'full', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(2, 'peri peri', '4.5', '500', '600.00', '3.00', 'full', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(3, 'pepper', '4.5', '500', '480.00', '0.00', 'full', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(4, 'normal', '4.5', '500', '400.00', '2.00', 'full', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(5, 'peri peri', '4', '250', '320.00', '0.00', 'half', 'normal', 'meat', 'al-faham', 'taco/taco-1.png'),
(6, 'normal', '4', '500', '220.00', '1.00', 'half', 'new dishes', 'meat', 'al-faham', 'taco/taco-1.png'),
(7, 'pepper', '4.5', '500', '240.00', '2.00', 'half', 'seasonal dishes online only', 'meat', 'al-faham', 'taco/taco-1.png'),
(8, 'burger', '4.5', '100', '120.00', '2.00', 'Veg', 'new dishes', 'veg', 'snacks', 'taco/burrito-6.png'),
(9, 'sandwich', '4.5', '600', '150.00', '0.00', 'NonVeg', 'new dishes', 'meat', 'snacks', 'burrito/burrito-6.png'),
(10, 'burger', '4.5', '500', '150.00', '3.00', 'NonVeg', 'best seller', 'meat', 'snacks', 'burrito/burrito-6.png'),
(11, 'sandwich', '4.5', '250', '120.00', '0.00', 'Veg', 'best seller', 'veg', 'snacks', 'burrito/burrito-6.png'),
(12, 'green apple', '4.5', '300', '110.00', '2.00', 'Special', 'new dishes', 'veg', 'mojito', 'drink/drink-2.png'),
(13, 'strawberry', '4.5', '500', '130.00', '0.00', 'Special', 'best seller', 'veg', 'mojito', 'drink/drink-2.png'),
(14, 'mint', '4', '400', '170.00', '2.00', 'Special', 'seasonal dishes', 'veg', 'mojito', 'drink/drink-2.png'),
(15, 'blue mint', '4', '500', '140.00', '2.00', 'Special', 'best seller', 'veg', 'mojito', 'drink/drink-2.png'),
(16, 'pineapple', '4.5', '500', '110.00', '0.00', 'Special', 'best seller', 'veg', 'mojito', 'drink/drink-2.png'),
(17, 'blackcurrant', '4.5', '500', '210.00', '2.00', 'Special', 'best seller', 'veg', 'mojito', 'drink/drink-2.png'),
(18, 'fresh lime', '4.5', '500', '60.00', '0.00', 'Special Drink', 'best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(19, 'soda lime', '4', '500', '40.00', '2.00', 'Special', 'normal', 'veg', 'drinks', 'drink/drink-5.png'),
(20, 'mint lime', '4.5', '500', '70.00', '2.00', 'Special', 'best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(21, 'passion fruit lime', '4', '699', '80.00', '2.00', 'Special', 'best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(22, 'sp lime', '4.5', '500', '60.00', '2.00', 'Special', 'seasonal dishes', 'veg', 'drinks', 'drink/drink-5.png'),
(23, 'vannilla', '4.5', '500', '160.00', '2.00', 'Icecream shake', 'best seller', 'veg', 'shake', 'drink/drink-1.png'),
(24, 'strawberry', '4.5', '500', '180.00', '2.00', 'Icecream shake', 'best seller', 'veg', 'shake', 'drink/drink-1.png'),
(25, 'pista', '3.5', '500', '160.00', '1.00', 'Icecream shake', 'new dishes seasonal dishes', 'veg', 'shake', 'drink/drink-1.png'),
(26, 'chocolate', '4.5', '500', '140.00', '0.00', 'Icecream shake', 'best seller', 'veg', 'shake', 'drink/drink-1.png'),
(27, 'shamam', '4', '200', '350.00', '0.00', 'Fruit shake', 'normal', 'veg', 'shake', 'drink/drink-1.png'),
(28, 'banana', '4', '100', '310.00', '0.00', 'Fruit shake', 'new dishes', 'veg', 'shake', 'drink/drink-1.png'),
(29, 'chikkoos', '3.5', '300', '340.00', '2.00', 'Fruit shake', 'new dishes', 'veg', 'shake', 'drink/drink-1.png'),
(30, 'manthi', '4.5', '500', '740.00', '0.00', 'Chicken half', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(31, 'manthi', '4.5', '500', '360.00', '1.00', 'Chicken qtr', 'best seller', 'meat', 'al-faham', 'taco/taco-1.png'),
(32, 'manthi', '4.5', '500', '1250.00', '0.00', 'Chicken full', 'new dishes', 'meat', 'al-faham', 'taco/taco-1.png'),
(33, 'irani', '3', '500', '210.00', '1.00', 'Qtr', 'seasonal dishes online only', 'meat', 'al-faham', 'taco/taco-1.png'),
(34, 'peri peri', '4', '199', '230.00', '0.00', 'Qtr', 'normal', 'meat', 'al-faham', 'taco/taco-1.png'),
(35, 'laham shorba', '4', '299', '1300.00', '0.00', 'Special', 'normal', 'meat', 'al-faham', 'taco/taco-1.png'),
(36, 'grape', '4.5', '999', '120.00', '0.00', 'Special', 'normal', 'veg', 'shake', 'drink/drink-1.png'),
(37, 'anar', '4.5', '999', '800.00', '0.00', 'Cashewnut special', 'best seller', 'veg', 'snacks', 'burrito/burrito-6.png'),
(38, 'avacado', '4.5', '999', '450.00', '0.00', 'Special', 'best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(39, 'paloma', '4.5', '599', '350.00', '0.00', 'Special drink', 'new dishes seasonal dishes', 'veg', 'drinks', 'drink/drink-5.png'),
(40, 'orange', '4', '999', '50.00', '1.00', 'juice', 'best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(41, 'pappaya', '3.5', '999', '70.00', '0.00', 'juice', 'seasonal dishes best seller', 'veg', 'drinks', 'drink/drink-5.png'),
(42, 'roll', '4.5', '9999', '30.00', '0.00', 'Meat', 'best seller', 'meat', 'snacks', 'burrito/burrito-6.png');

-- --------------------------------------------------------

--
-- Table structure for table `foodcategories`
--

CREATE TABLE `foodcategories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `foodcategories`
--

INSERT INTO `foodcategories` (`id`, `name`, `image`) VALUES
(1, 'test', 'uploads\\1672424999070.png'),
(4, 'dummy', 'uploads\\1672594057639.png');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `table_type` varchar(255) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `description`, `image`, `name`, `category_name`, `price`) VALUES
(6, 1, 'ghghghghgh', 'uploads\\1672593614189.png', 'fghghghgh', 'test', 200),
(7, 1, 'jhjhjhjhj', 'uploads\\1672594036909.png', 'jjnhujhjhjhj', 'test', 1000),
(8, 4, 'bdfdfhdhfhdfb', 'uploads\\1672594077103.png', 'Dummy2', 'dummy', 5000),
(9, 4, 'hghghghghg', 'uploads\\1672596343364.png', 'fghgfhghgh', 'dummy', 444);

-- --------------------------------------------------------

--
-- Table structure for table `taleconfig`
--

CREATE TABLE `taleconfig` (
  `table_id` int(11) NOT NULL,
  `table_type` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `table_description` varchar(255) DEFAULT NULL,
  `table_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `taleconfig`
--

INSERT INTO `taleconfig` (`table_id`, `table_type`, `table_name`, `count`, `table_description`, `table_image`) VALUES
(1, 'two_seating', 'table_1', 5, 'dcfchgf', 'uploads\\1672163114286.png'),
(2, 'two_seating', 'table_2', 5, 'gfgggf', 'uploads\\1672848587044.png'),
(3, 'four_seating', 'table_1', 8, '4 seeting', 'uploads\\1672848620168.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_phone` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_birth` varchar(255) DEFAULT NULL,
  `user_gender` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_email`, `user_phone`, `user_password`, `user_birth`, `user_gender`) VALUES
(1, 'roffinvarghese', 'roffinvarghese123@gmail.com', '9567509143', 'Password@123', '1997-02-18', 'male'),
(2, 'BiffinVarghese', 'biffin@test.com', '8848906983', 'Password@123', '2022-02-21', 'male');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booktable`
--
ALTER TABLE `booktable`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`food_id`);

--
-- Indexes for table `foodcategories`
--
ALTER TABLE `foodcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taleconfig`
--
ALTER TABLE `taleconfig`
  ADD PRIMARY KEY (`table_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `booktable`
--
ALTER TABLE `booktable`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `food_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `foodcategories`
--
ALTER TABLE `foodcategories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `taleconfig`
--
ALTER TABLE `taleconfig`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
