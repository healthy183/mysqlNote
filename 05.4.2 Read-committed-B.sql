-- mysql -u root -p spring
-- mysql -u  root  -p  spring

-- 1.2
show variables like 'transaction_isolation'; -- 确认是否'Read-committed'

start transaction;

update spring.account  a set  a.balance =   a.balance -100  where id = 1; 

select * from  spring.account; -- 如果是Read-committed，无commit其他客户端不可以能查到更新后的记录

-- 1.4
commit;

select * from  spring.account;

