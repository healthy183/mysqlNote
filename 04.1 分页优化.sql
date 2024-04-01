
-- 案例一 主键分页
select * from employees  es where es.id limit 20000,5;
-- 改善方案:如果id是自增、连续、按主键排序，则可以使用以下方式改善(要求太苛刻)
select * from employees  es where es.id >20000 limit 5;

-- 案例二 非主键分页(没有走索引且extra是Using filesort)
EXPLAIN select * from employees ORDER BY name limit 90000,5;
-- 改善方案 id3的extra是Using index
EXPLAIN select * from employees e inner join (select id from employees order by name limit 10000,5)  ed on e.id = ed.id;

