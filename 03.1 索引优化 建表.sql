DROP TABLE IF EXISTS employees; 

CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL DEFAULT '' COMMENT '姓名',
  `age` int(11) NOT NULL DEFAULT '0' COMMENT '年龄',
  `position` varchar(20) NOT NULL DEFAULT '' COMMENT '职位',
  `hire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入职时间',
  PRIMARY KEY (`id`),
  KEY `idx_name_age_position` (`name`,`age`,`position`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='员工记录表';

INSERT INTO employees(name,age,position,hire_time) VALUES('LiLei',22,'manager',NOW());
INSERT INTO employees(name,age,position,hire_time) VALUES('HanMeimei', 23,'dev',NOW());
INSERT INTO employees(name,age,position,hire_time) VALUES('Lucy',23,'dev',NOW());

select *  from employees;

drop procedure IF EXISTS insert_emp;

delimiter ;;
create procedure insert_emp()
begin
 declare i int;
 set i = 1;
while (i<100000) do
  INSERT INTO employees(name,age,position) VALUES(CONCAT('zhuge',i),i,'dev');
  set i = i + 1;
  end while;
 end;;
 delimiter ;
 
 call insert_emp();
 
select *  from employees;


