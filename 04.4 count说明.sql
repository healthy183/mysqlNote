count(*)查询优化

EXPLAIN select count(1) from employees;
EXPLAIN select count(id) from employees;
EXPLAIN select count(name) from employees;
EXPLAIN select count(*) from employees;

四个sql的执行计划一样，说明这四个sql执行效率应该差不多
字段有索引：count(*)≈count(1)>count(字段)>count(主键 id) //字段有索引，count(字段)统计走二级索引，二级索引存储数据比主键索引少，所以count(字段)>count(主键 id)
字段无索引：count(*)≈count(1)>count(主键 id)>count(字段) //字段没有索引count(字段)统计走不了索引，count(主键 id)还可以走主键索引，所以count(主键 id)>count(字段)

count(1)跟count(字段)执行过程类似，不过count(1)不需要取出字段统计，就用常量1做统计，count(字段)还需要取出字段，所以理论上count(1)比count(字段)会快一点。
count(*) 是例外，mysql并不会把全部字段取出来，而是专门做了优化，不取值，按行累加，效率很高，所以不需要用count(列名)或count(常量)来替代 count(*)。
为什么对于count(id)，mysql最终选择辅助索引而不是主键聚集索引？因为二级索引相对主键索引存储数据更少，检索性能应该更高，mysql内部做了点优化(应该是在5.7版本才优化)。

关于表总行数查询
1、查询mysql自己维护的总行数
对于myisam存储引擎的表做不带where条件的count查询性能是很高的，因为myisam存储引擎的表的总行数会被mysql存储在磁盘上，查询不需要计算
对于innodb存储引擎的表mysql不会存储表的总记录行数(因为有MVCC机制，后面会讲)，查询count需要实时计算

2、show table status
如果只需要知道表总行数的估计值可以用如下sql查询，性能很高
show table status like  'tableName';

3、将总数维护到Redis里
插入或删除表数据行的时候同时维护redis里的表总行数key的计数值(用incr或decr命令)，但是这种方式可能不准，很难保证表操作和redis操作的事务一致性

4、增加数据库计数表
插入或删除表数据行的时候同时维护计数表，让他们在同一个事务里操作