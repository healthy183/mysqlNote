
-- mysql认为在即使存在联合索引，但是第一个字段就开始范围搜索出来的结果集太大，导致回表效率低，还不如全表搜索快
EXPLAIN SELECT * FROM employees WHERE name > 'LiLei' AND age = 22 AND position ='manager';

-- 强制使用索引，但是也不见得快多少，因为要回表
EXPLAIN SELECT * FROM employees force index(idx_name_age_position) WHERE name > 'LiLei' AND age = 22 AND position ='manager';

-- 以下两条sql来验证下时效，第一条0.015s，第二条0.015s
SELECT * FROM employees WHERE name > 'LiLei' and age = 12 and position  ="a5";
SELECT * FROM employees force index(idx_name_age_position) WHERE  name > 'LiLei' and age = 12 and position ="a5";

-- 使用覆盖索引也是 0.031s
SELECT name,age,position FROM employees  WHERE  name > 'LiLei' and age = 12 and position ="a5";
EXPLAIN SELECT name,age,position FROM employees  WHERE  name > 'LiLei' and age  = 12 and position ="a5";

-- 大表or、in会使用索引 小表实测也会，教材说不会，这是为什么?
EXPLAIN SELECT * FROM employees WHERE name in ('LiLei','HanMeimei','Lucy') and age = 12 and position  ="a5";
EXPLAIN SELECT * FROM employees WHERE  (name = 'LiLei' or name = 'HanMeimei') and age = 12 and position  ="a5";

-- like也会使用索引
-- 另外like有时候会触发‘索引下推’，从而减少回表数据，加快查询效率 
EXPLAIN SELECT * FROM employees WHERE name like 'LiLei%' AND age = 22 AND position ='manager';





