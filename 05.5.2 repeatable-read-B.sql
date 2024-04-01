-- mysql -u root -p spring 
--

-- 1.2
set transaction_isolation='repeatable-read'; -- 确认是否'repeatable-read'

start transaction;

update spring.account  a set  a.balance =  a.balance -100  where id = 1; 

select * from  spring.account; -- 如果是repeatable-read，不论是否commit，其他客户端都不可以能查到更新后的记录

-- 1.4
commit;

select * from  spring.account;

