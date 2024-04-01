-- mysql -u root -p spring
-- mysql -u  root  -p  spring

-- 1.2
set transaction_isolation='Serializable'; -- 确认是否'Serializable'

start transaction;

-- 1.4 一直在等待
update spring.account  a set  a.balance =   a.balance -100  where id = 1; 

-- 1.5 commit以后才能提交
select * from  account where id = 1;

-- 1.6
commit;

select * from  spring.account;

