-- 1.1
set transaction_isolation='repeatable-read';

start transaction;

-- 1.3 --查看不到更新后记录
select * from  account;


-- 1.5  --查看不到更新后记录
select * from  account;


-- 1.6
commit;

-- 1.7  --查到更新后记录
select * from  account;
