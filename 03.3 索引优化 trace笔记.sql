EXPLAIN select * from employees where name > 'a' ; -- mysql觉得如果用索引还要回表，还不如全表扫描

EXPLAIN select name,age,position from employees where name > 'a' ; -- 查询条件都是索引字段，根据‘索引下推’原则引用了索引

-- 那为什么此语句走索引呢？可以通过trace查看sql执行逻辑
EXPLAIN select * from employees where name > 'zzz';


set  session  optimizer_trace="enabled=on",end_markers_in_json=on;  -- 开启trace
EXPLAIN select  *  from  employees  where  name  >  'a'  order  by  position;
select  *  from  employees  where  name  >  'a'  order  by  position;
SELECT  *  FROM  information_schema.OPTIMIZER_TRACE;

set session optimizer_trace="enabled=off"; -- 关闭trace
