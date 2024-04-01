-- 使用了联合索引中的name(key_len是74)，在排序的时候用了age(extra中不是using filesort)
explain  SELECT * FROM employees WHERE name = 'LiLei'  and position  ="dev" order by age; 
-- 由于跳过了age，所以是排序没有应用到索引 (extra是using filesort)
explain  SELECT * FROM employees WHERE name = 'LiLei'   order by position; 
-- extra是null 
explain  SELECT * FROM employees WHERE name = 'LiLei' and age = 11  order by position; 
-- extra是null 
explain  SELECT * FROM employees WHERE name = 'LiLei'  order by  age,position; 
-- extra是Using filesort,因为position,age不符合索引顺序
explain  SELECT * FROM employees WHERE name = 'LiLei'  order by  position,age; 
-- extra是null，因为age是常量，mysql内部做了优化(这个本来age都是11,没必要排序)
explain  SELECT * FROM employees WHERE name = 'LiLei' and age = 11  order by position,age; 

-- mysql默认是升序，position是desc，需要重新排序，所以extra是Using filesort
explain  SELECT * FROM employees WHERE name = 'LiLei'   order by age asc,position desc; 
-- extra是Using index condition; Using filesort 对于排序来说，多个相等条件也是范围查询 
explain  SELECT * FROM employees WHERE name in ( 'LiLei' ,'abc') order by age,position; 

-- extra是'Using where; Using filesort'
explain  SELECT * FROM employees WHERE name > 'a' order by name; 

-- 使用了覆盖索引，extra是'Using where; Using index'
explain  SELECT name,age,position FROM employees WHERE name > 'a' order by name; 

/*
优化总结：
1、MySQL支持两种方式的排序filesort和index，Using index是指MySQL扫描索引本身完成排序。index效率高，filesort效率低。
2、order by满足两种情况会使用Using index。
 1) order by语句使用索引最左前列。
 2) 使用where子句与order by子句条件列组合满足索引最左前列。
3、尽量在索引列上完成排序，遵循索引建立（索引创建的顺序）时的最左前缀法则。
4、如果order by的条件不在索引列上，就会产生Using filesort。
5、能用覆盖索引尽量用覆盖索引
6、group by与order by很类似，其实质是先排序后分组，遵照索引创建顺序的最左前缀法则。对于group by的优化如果不需要排序的可以加上order by null禁止排序。注意，where高于having，能写在where中的限定条件就不要去having限定了。
*/



