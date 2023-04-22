
## Install the Flask Dependencies

```bash
pip install -r requirements.txt
```

## Creating the tables and database

```sql
CREATE DATABASE IF NOT EXISTS `flask_app_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `flask_app_db`;

-- Locations Schema

DROP TABLE IF EXISTS `locations`;

CREATE TABLE IF NOT EXISTS `locations` (
	`city` varchar(50) NOT NULL,
    `latitude` decimal(10, 6) NOT NULL,
    `longitude` decimal(10, 6) NOT NULL,
	PRIMARY KEY (`city`)
);
	
insert into locations values ('Atlanta', '33.7488', '-84.3877');
insert into locations values ('Savannah', '32.0761', '-81.0883');
insert into locations values ('Macon', '32.8381', '-83.6347');
insert into locations values ('Augusta', '33.4666', '-81.9666');
insert into locations values ('Athens', '33.9500', '-83.3833');
insert into locations values ('Dalton', '34.7755', '-84.9862');
insert into locations values ('Columbus', '32.4922', '-84.9402');

-- Users Schema

DROP TABLE IF EXISTS `users`;

CREATE TABLE IF NOT EXISTS `users` (
	`email` varchar(100) NOT NULL,
  	`first_name` varchar(50) NOT NULL,
  	`last_name` varchar(50) NOT NULL,
  	`password` varchar(255) NOT NULL,
  	`created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	`updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`city` varchar(50) NOT NULL,
	`role` enum('maker', 'giver', 'volunteer', 'staff') NOT NULL,
	FOREIGN KEY (`city`) REFERENCES `locations`(`city`),
    PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`) 
    VALUES ('User', 'One', 'user1@gmail.com', 'password', 'Augusta', 'volunteer');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`) 
    VALUES ('User', 'Two', 'user2@gmail.com', 'password', 'Atlanta', 'maker');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`) 
    VALUES ('User', 'Three', 'user3@gmail.com', 'password', 'Macon', 'giver');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`) 
    VALUES ('User', 'Four', 'user4@gmail.com', 'password', 'Dalton', 'maker');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`) 
    VALUES ('User', 'Five', 'user5@gmail.com', 'password', 'Atlanta', 'giver');

-- Wish Schema

DROP TABLE IF EXISTS `wish`;

CREATE TABLE IF NOT EXISTS `wish` (
	`wish_id` int(11) NOT NULL AUTO_INCREMENT,
  	`wish_name` varchar(50) NOT NULL,
	`maker_email` varchar(100) NOT NULL,
	`giver_email` varchar(100) DEFAULT NULL,
	`volunteer_email` varchar(100) DEFAULT NULL,
  	`created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	`updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`wish_status` enum('pending', 'approved', 'assigned', 'completed') NOT NULL DEFAULT 'pending',
	`wish_details` TEXT NOT NULL,
	FOREIGN KEY (`maker_email`) REFERENCES `users`(`email`),
	FOREIGN KEY (`giver_email`) REFERENCES `users`(`email`),
	FOREIGN KEY (`volunteer_email`) REFERENCES `users`(`email`),
    PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


INSERT INTO `wish` (`wish_name`, `maker_email`, `wish_details`) 
    VALUES ('Go to Disney Land!', 'user4@gmail.com', 'I am a cancer survivor. I am interested in Football and I want to go to disneyland!');

INSERT INTO `wish` (`wish_name`, `maker_email`,  `wish_details`) 
    VALUES ('Go to Disney Land 2!', 'user2@gmail.com',  'I am a cancer survivor as well. I am interested in Football and I want to go to disneyland!');
```


## Update the configuration (config.py)

According to your database update the below properties.

```shell
DEBUG = True
SECRET_KEY = 'flask-app'
MYSQL_HOST = 'localhost'
MYSQL_USER = 'root'
MYSQL_PASSWORD = 'root'
MYSQL_DB = 'flask_app_db'
MYSQL_PORT = 3306
```

## Run the Application

```bash
python main.py
```

## References

1. https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysqlcursor-execute.html