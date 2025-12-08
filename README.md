# 📊 LeetCode SQL Solutions (Auto-Synced)

This repository stores my **SQL LeetCode solutions**, automatically synced every 12 hours from a Google Sheet.  
Each problem can belong to multiple SQL topics, and files are organized into folders by concept.

## 📁 Folder Structure (with Descriptions)

```
sql/
├── pivot_unpivot/          # Pivoting rows → columns, unpivoting columns → rows
├── case_statement/         # Conditional logic using CASE expressions
├── agg_functions/          # SUM, AVG, COUNT, MAX/MIN, HAVING operations
├── subquery_cte/           # Subqueries, CTEs, nested queries, WITH clauses
├── tricky/                 # Multi-step or logic-heavy SQL problems
├── recursive_cte/          # Recursive WITH, hierarchical queries
├── relationships/          # Parent-child relations, entity-link problems
├── self_join/              # Self-referencing JOIN operations
├── time_functions/         # DATE, DATETIME, TIMESTAMP operations
├── left_join/              # LEFT JOIN concepts
├── exists_not_in/          # EXISTS, NOT EXISTS, IN, NOT IN logic
├── window_functions/       # RANK, ROW_NUMBER, LEAD, LAG with OVER(PARTITION)
├── simple_select/          # Basic SELECT queries
├── concat/                 # String concatenation
├── null_is_null/           # NULL handling, IS NULL / IS NOT NULL logic
├── regex/                  # Regex-based filtering or matching
├── group_concat/           # GROUP_CONCAT operations
├── cartesian_product/      # CROSS JOIN / Cartesian Products
├── lead_lag/               # LEAD and LAG window functions
├── string_functions/       # SUBSTR, REPLACE, TRIM, LENGTH, etc.
└── store_prod/             # Store and product-related datasets
```

## ⚙️ Automation

- GitHub Actions pull data from Google Sheets every 12 hours.
- Python script generates `.sql` files and places them in topic folders.
- Only changed files are committed.

## 🚀 Adding New Problems

1. Add a new row in the Google Sheet  
2. Fill in `Title` and `Code`  
3. Check all relevant topic columns  
4. Repository updates automatically

---

Simple. Organized. Fully automated.
