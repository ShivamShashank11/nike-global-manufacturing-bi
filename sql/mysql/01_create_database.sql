-- Create DB + user (adjust password as needed)
CREATE DATABASE IF NOT EXISTS nike_bi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'nike_user'@'localhost' IDENTIFIED BY 'Strong_P@ss_123';
GRANT ALL PRIVILEGES ON nike_bi.* TO 'nike_user'@'localhost';
FLUSH PRIVILEGES;
