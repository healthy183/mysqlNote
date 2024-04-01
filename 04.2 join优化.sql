mysql关于join查询有两种算法:
NLJ -- 适用于索引字段比较，磁盘扫描次数少
Extra 中未出现 Using join buffer

BNL  -- 两张表做全表扫描然后再内存比较
Extra 中 的Using join buffer (Block Nested Loop)说明该关联查询使用的是 BNL 算法。

/*
对于关联sql的优化
关联字段加索引，让mysql做join操作时尽量选择NLJ算法
小表驱动大表，写多表连接sql时如果明确知道哪张表是小表可以用straight_join写法固定连接驱动方式，省去mysql优化器自己判断的时间
备注:除非明确小表，否则慎用straight_join

驱动表是 t2，被驱动表是 t1。先执行的就是驱动表(执行计划结果的id如果一样则按从上到下顺序执行sql)；优化器一般会优先选择小表做驱动表。
所以使用 inner join 时，排在前面的表并不一定就是驱动表。
当使用left join时，左表是驱动表，右表是被驱动表，
当使用right join时，右表时驱动表，左表是被驱动表，
当使用join时，mysql会选择数据量比较小的表作为驱动表，大表作为被驱动表使用了 NLJ算法。
一般 join 语句中，如果执行计划 Extra 中未出现 Using join buffer 则表示使用的 join 算法是 NLJ。
*/