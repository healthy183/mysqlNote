-- 原则：小表驱动大表，即小的数据集驱动大的数据集
-- in：当B表的数据集小于A表的数据集时，in优于exists
select * from A where id in (select id from B)


-- exists：当A表的数据集小于B表的数据集时，exists优于in
-- 将主查询A的数据，放到子查询B中做条件验证，根据验证结果（true或false）来决定主查询的数据是否保留

select * from A where exists (select 1 from B where B.id = A.id)

/*
1、EXISTS (subquery)只返回TRUE或FALSE,因此子查询中的SELECT * 也可以用SELECT 1替换,官方说法是实际执行时会
忽略SELECT清单,因此没有区别
2、EXISTS子查询的实际执行过程可能经过了优化而不是我们理解上的逐条对比
3、EXISTS子查询往往也可以用JOIN来代替，何种最优需要具体问题具体分析
*/