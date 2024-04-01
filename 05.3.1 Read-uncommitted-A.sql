-- 1.1
set transaction_isolation='Read-uncommitted';

start transaction;

-- 1.3
select * from  account;
