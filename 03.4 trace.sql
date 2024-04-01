{
  "steps": [
    {
      "join_preparation": {  -- 第一阶段：SQL准备阶段，格式化sql
        "select#": 1,
        "steps": [
          {
            "expanded_query": "/* select#1 */ select `employees`.`id` AS `id`,`employees`.`name` AS `name`,`employees`.`age` AS `age`,`employees`.`position` AS `position`,`employees`.`hire_time` AS `hire_time` from `employees` where (`employees`.`name` > ''a'') order by `employees`.`position` limit 0,1000"
          }
        ] /* steps */
      } /* join_preparation */
    },
    {
      "join_optimization": { -- 第二阶段：SQL优化阶段
        "select#": 1,
        "steps": [
          {
            "condition_processing": { -- 条件处理 
              "condition": "WHERE",
              "original_condition": "(`employees`.`name` > ''a'')",
              "steps": [
                {
                  "transformation": "equality_propagation",
                  "resulting_condition": "(`employees`.`name` > ''a'')"
                },
                {
                  "transformation": "constant_propagation",
                  "resulting_condition": "(`employees`.`name` > ''a'')"
                },
                {
                  "transformation": "trivial_condition_removal",
                  "resulting_condition": "(`employees`.`name` > ''a'')"
                }
              ] /* steps */
            } /* condition_processing */
          },
          {
            "substitute_generated_columns": {
            } /* substitute_generated_columns */
          },
          {
            "table_dependencies": [ -- 表依赖详情
              {
                "table": "`employees`",
                "row_may_be_null": false,
                "map_bit": 0,
                "depends_on_map_bits": [
                ] /* depends_on_map_bits */
              }
            ] /* table_dependencies */
          },
          {
            "ref_optimizer_key_uses": [
            ] /* ref_optimizer_key_uses */
          },
          {
            "rows_estimation": [  -- 预估表查询成本
              {
                "table": "`employees`",
                "range_analysis": {
                  "table_scan": { -- 全表扫描
                    "rows": 83084,  -- 扫描行数
                    "cost": 8596.09 --  成本
                  } /* table_scan */,
                  "potential_range_indexes": [ -- 查询可能用到的成本
                    {
                      "index": "PRIMARY", -- 主键索引
                      "usable": false,
                      "cause": "not_applicable"
                    },
                    {
                      "index": "idx_name_age_position", --  辅助索引
                      "usable": true,
                      "key_parts": [
                        "name",
                        "age",
                        "position",
                        "id"
                      ] /* key_parts */
                    }
                  ] /* potential_range_indexes */,
                  "setup_range_conditions": [
                  ] /* setup_range_conditions */,
                  "group_index_range": {
                    "chosen": false,
                    "cause": "not_group_by_or_distinct"
                  } /* group_index_range */,
                  "skip_scan_range": {
                    "potential_skip_scan_indexes": [
                      {
                        "index": "idx_name_age_position",
                        "usable": false,
                        "cause": "query_references_nonkey_column"
                      }
                    ] /* potential_skip_scan_indexes */
                  } /* skip_scan_range */,
                  "analyzing_range_alternatives": { -- 分析各个索引成本
                    "range_scan_alternatives": [
                      {
                        "index": "idx_name_age_position",
                        "ranges": [
                          "''a'' < name"  --  索引使用范围
                        ] /* ranges */,
                        "index_dives_for_eq_ranges": true,
                        "rowid_ordered": false,  -- 使用索引查询的记录是否按主键排序
                        "using_mrr": false,
                        "index_only": false, -- 是否使用覆盖索引
                        "in_memory": 0.0434783,
                        "rows": 41542,   --  索引扫描的行数
                        "cost": 45206.5, -- 使用索引的成本
                        "chosen": false, --  是否选择使用此索引
                        "cause": "cost"
                      }
                    ] /* range_scan_alternatives */,
                    "analyzing_roworder_intersect": {
                      "usable": false,
                      "cause": "too_few_roworder_scans"
                    } /* analyzing_roworder_intersect */
                  } /* analyzing_range_alternatives */
                } /* range_analysis */
              }
            ] /* rows_estimation */
          },
          {
            "considered_execution_plans": [
              {
                "plan_prefix": [
                ] /* plan_prefix */,
                "table": "`employees`",
                "best_access_path": { -- 最佳访问路径
                  "considered_access_paths": [ --  最终选择的访问路径
                    {
                      "rows_to_scan": 83084,
                      "filtering_effect": [
                      ] /* filtering_effect */,
                      "final_filtering_effect": 0.5,
                      "access_type": "scan", --  访问类型为全表扫描
                      "resulting_rows": 41542,
                      "cost": 8593.99,
                      "chosen": true  --  确定选择
                    }
                  ] /* considered_access_paths */
                } /* best_access_path */,
                "condition_filtering_pct": 100,
                "rows_for_plan": 41542,
                "cost_for_plan": 8593.99,
                "chosen": true
              }
            ] /* considered_execution_plans */
          },
          {
            "attaching_conditions_to_tables": {
              "original_condition": "(`employees`.`name` > ''a'')",
              "attached_conditions_computation": [
                {
                  "table": "`employees`",
                  "rechecking_index_usage": {
                    "recheck_reason": "low_limit",
                    "limit": 1000,
                    "row_estimate": 41542
                  } /* rechecking_index_usage */
                }
              ] /* attached_conditions_computation */,
              "attached_conditions_summary": [
                {
                  "table": "`employees`",
                  "attached": "(`employees`.`name` > ''a'')"
                }
              ] /* attached_conditions_summary */
            } /* attaching_conditions_to_tables */
          },
          {
            "optimizing_distinct_group_by_order_by": {
              "simplifying_order_by": {
                "original_clause": "`employees`.`position`",
                "items": [
                  {
                    "item": "`employees`.`position`"
                  }
                ] /* items */,
                "resulting_clause_is_simple": true,
                "resulting_clause": "`employees`.`position`"
              } /* simplifying_order_by */
            } /* optimizing_distinct_group_by_order_by */
          },
          {
            "reconsidering_access_paths_for_index_ordering": {
              "clause": "ORDER BY",
              "steps": [
              ] /* steps */,
              "index_order_summary": {
                "table": "`employees`",
                "index_provides_order": false,
                "order_direction": "undefined",
                "index": "unknown",
                "plan_changed": false
              } /* index_order_summary */
            } /* reconsidering_access_paths_for_index_ordering */
          },
          {
            "finalizing_table_conditions": [
              {
                "table": "`employees`",
                "original_table_condition": "(`employees`.`name` > ''a'')",
                "final_table_condition   ": "(`employees`.`name` > ''a'')"
              }
            ] /* finalizing_table_conditions */
          },
          {
            "refine_plan": [
              {
                "table": "`employees`"
              }
            ] /* refine_plan */
          },
          {
            "considering_tmp_tables": [
              {
                "adding_sort_to_table": "employees"
              } /* filesort */
            ] /* considering_tmp_tables */
          }
        ] /* steps */
      } /* join_optimization */
    },
    {
      "join_execution": { -- 第三阶段 sql执行阶段
        "select#": 1,
        "steps": [
          {
            "sorting_table": "employees",
            "filesort_information": [
              {
                "direction": "asc",
                "expression": "`employees`.`position`"
              }
            ] /* filesort_information */,
            "filesort_priority_queue_optimization": {
              "limit": 1000,
              "chosen": true
            } /* filesort_priority_queue_optimization */,
            "filesort_execution": [
            ] /* filesort_execution */,
            "filesort_summary": {
              "memory_available": 262144,
              "key_size": 40,
              "row_size": 186,
              "max_rows_per_buffer": 1001,
              "num_rows_estimate": 83084,
              "num_rows_found": 85037,
              "num_initial_chunks_spilled_to_disk": 0,
              "peak_memory_used": 194194,
              "sort_algorithm": "std::stable_sort",
              "unpacked_addon_fields": "using_priority_queue",
              "sort_mode": "<fixed_sort_key, additional_fields>"
            } /* filesort_summary */
          }
        ] /* steps */
      } /* join_execution */
    }
  ] /* steps */
}

--  结论：全表扫描的成本低于索引扫描，所以mysql最终选择全表扫描