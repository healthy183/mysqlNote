-- 1.2
show variables like 'transaction_isolation'; -- 确认是否'Read-uncommitted'

start transaction;

update account  a set  a.balance =   a.balance -100  where id = 1; 

select * from  account; -- 如果是Read-uncommitted，无需commit其他客户端可以能查到更新后的记录

-- 1.4
rollback;

select * from  account;

