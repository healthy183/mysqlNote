-- 1.1
set transaction_isolation='Serializable';

start transaction;

-- 1.3
select * from  account where id = 1;


-- 1.5
commit;

-- 1.7  --1.6commit以后查到更新后记录
select * from  account;
