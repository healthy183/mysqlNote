-- 1.1
set transaction_isolation='Read-committed';

start transaction;

-- 1.3 --查看不到更新后记录
select * from  account;


-- 1.5  --查看更新后记录
select * from  account;
