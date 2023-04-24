
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
	`age` int(3) DEFAULT NULL,
	`phone` varchar(20) DEFAULT NULL,
	`bio` text DEFAULT NULL,
  	`created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	`updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`city` varchar(50) NOT NULL,
	`role` enum('maker', 'giver', 'volunteer', 'staff') NOT NULL,
    PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`, `age`, `phone`, `bio`) 
    VALUES ('User', 'One', 'user1@gmail.com', 'password', 'Augusta', 'volunteer', 21, '4999499931', 'I am a cool guy.');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`, `age`, `phone`, `bio`) 
    VALUES ('User', 'Two', 'user2@gmail.com', 'password', 'Atlanta', 'maker', 21, '4999499931', 'I am a cool guy.');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`, `age`, `phone`, `bio`) 
    VALUES ('User', 'Three', 'user3@gmail.com', 'password', 'Macon', 'giver', 21, '4999499931', 'I am a cool guy.');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`, `age`, `phone`, `bio`) 
    VALUES ('User', 'Four', 'user4@gmail.com', 'password', 'Dalton', 'maker');

INSERT INTO `users` (`first_name`, `last_name`, `email`, `password`, `city`, `role`, `age`, `phone`, `bio`) 
    VALUES ('User', 'Five', 'user5@gmail.com', 'password', 'Atlanta', 'giver', 21, '4999499931', 'I am a cool guy.');

-- Wish Schema

DROP TABLE IF EXISTS `wish`;

CREATE TABLE IF NOT EXISTS `wish` (
	`wish_id` int(11) NOT NULL AUTO_INCREMENT,
  	`wish_name` varchar(50) NOT NULL,
	`maker_email` varchar(100) NOT NULL,
	`giver_email` varchar(100) DEFAULT NULL,
	`volunteer_email` varchar(100) DEFAULT NULL,
  	`wish_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	`wish_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`wish_status` enum('pending', 'approved', 'assigned', 'completed') NOT NULL DEFAULT 'pending',
	`wish_description` TEXT NOT NULL,
	FOREIGN KEY (`maker_email`) REFERENCES `users`(`email`),
	FOREIGN KEY (`giver_email`) REFERENCES `users`(`email`),
	FOREIGN KEY (`volunteer_email`) REFERENCES `users`(`email`),
    PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


INSERT INTO `wish` (`wish_name`, `maker_email`, `wish_description`) 
    VALUES ('Go to Disney Land!', 'user4@gmail.com', 'I am a cancer survivor. I am interested in Football and I want to go to disneyland!');

INSERT INTO `wish` (`wish_name`, `maker_email`,  `wish_description`) 
    VALUES ('Go to Disney Land 2!', 'user2@gmail.com',  'I am a cancer survivor as well. I am interested in Football and I want to go to disneyland!');

DROP TABLE IF EXISTS `messages`;

CREATE TABLE IF NOT EXISTS `messages` (
	`message_id` int(11) NOT NULL AUTO_INCREMENT,
	`sender_email` varchar(100) NOT NULL,
	`receiver_email` varchar(100) NOT NULL,
	`message` TEXT NOT NULL,
	`message_sent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`message_id`),
	FOREIGN KEY (`sender_email`) REFERENCES `users`(`email`),
	FOREIGN KEY (`receiver_email`) REFERENCES `users`(`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `messages` (`sender_email`, `receiver_email`,  `message`) 
    VALUES ('user1@gmail.com', 'user2@gmail.com', 'Hello from 1!');

INSERT INTO `messages` (`sender_email`, `receiver_email`,  `message`) 
    VALUES ('user2@gmail.com', 'user1@gmail.com', 'Hello from 2!');

INSERT INTO `messages` (`sender_email`, `receiver_email`,  `message`) 
    VALUES ('user2@gmail.com', 'user1@gmail.com', 'Hello again from 2!');

INSERT INTO `messages` (`sender_email`, `receiver_email`,  `message`) 
    VALUES ('user1@gmail.com', 'user2@gmail.com', 'Hello again from 1!');
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

## API Contracts

```
GET /users
- Returns all the users
Params (Filters):
- city -> Returns users from a particular city ('Atlanta', 'Athens', 'Dalton', 'Savannah', 'Macon', 'Columbus')
- email -> Returns users based on particular email id
- role -> Returns users based on their role ('maker', 'giver', 'volunteer', 'staff')

Example: GET http://127.0.0.1:5000/users?city=Atlanta&role=maker&email=user1@gmail.com

Returns:
[
	{
		"first_name": "User",
		"last_name": "Ten",
		"email": "user10@gmail.com",
		"role": "maker",
		"city": "Athens"
	},
	{
		"first_name": "User",
		"last_name": "Eleven",
		"email": "user11@gmail.com",
		"role": "maker",
		"city": "Athens"
	},
	{
		"first_name": "User",
		"last_name": "Two",
		"email": "user2@gmail.com",
		"role": "maker",
		"city": "Atlanta"
	}
]

POST /users
- Create user
Params: 
Headers: 
Content-Type: application/json
JSON Payload: 
{
	"first_name": "User",
	"last_name": "Thirteen",
	"email": "user13@gmail.com",
	"role": "staff",
	"city": "Atlanta",
	"password": "password"
}

Example: POST http://127.0.0.1:5000/users

Returns:
{
	"first_name": "User",
	"last_name": "Thirteen",
	"email": "user13@gmail.com",
	"role": "staff",
	"city": "Atlanta"
}

GET /wishes
- Returns all wishes
Params (Filters): 
- city -> Returns wishes from a particular city ('Atlanta', 'Athens', 'Dalton', 'Savannah', 'Macon', 'Columbus')
- maker_email -> Returns wishes made by maker_email
- giver_email -> Returns wishes assigned to giver_email
- volunteer_email -> Returns wishes assigned to volunteer

Example: GET http://127.0.0.1:5000/wishes?city=Atlanta&maker_email=user1@gmail.com&giver_email=user2@gmail.com&volunteer_email=user4@gmail.com

[
	{
		"wish_id": 1002, 
		"wish_description": "Want to go to disney land (long).",
		"wish_name": "Disney land",
		"wish_status": "pending",
		"maker_email": "user1@gmail.com",
		"giver_email": NULL,
		"volunteer_email": NULL,
	}
]

POST /wishes
- Create wish
Params: 
Headers: 
Content-Type: application/json
JSON Payload: 
{
	"wish_description": "Want to go to disney land (long).",
	"wish_name": "Disney land",
	"maker_email": "user1@gmail.com",
}

Example: POST http://127.0.0.1:5000/wishes

Returns:
{
	"wish_id": 10, 
	"wish_description": "Want to go to disney land (long).",
	"wish_name": "Disney land",
	"wish_status": "pending",
	"maker_email": "user1@gmail.com",
	"giver_email": NULL,
	"volunteer_email": NULL,
}


```

## References

1. https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysqlcursor-execute.html