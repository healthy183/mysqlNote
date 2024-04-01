CREATE TABLE   `account` (
id int(11) NOT NULL AUTO_INCREMENT,
 name varchar(255) DEFAULT NULL,
 balance int(11) DEFAULT NULL,
 PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO spring.account (name, balance) VALUES ('lilei', '450');
INSERT INTO spring.account (name, balance) VALUES ('hanmei', '16000');
INSERT INTO spring.account (name, balance) VALUES ('lucy', '2400');

select * from  spring.account;