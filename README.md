# 📊 LeetCode SQL Solutions (Auto-Synced)

This repository stores my **SQL LeetCode solutions**, automatically synced every 6 hours from a Google Sheet.  
Each problem can belong to multiple SQL topics, and files are organized into folders by concept.

## 📁 Folder Structure

```
sql/
  pivot_unpivot/
  case_statement/
  agg_functions/
  subquery_cte/
  tricky/
  recursive_cte/
  relationships/
  self_join/
  time_functions/
  left_join/
  exists_not_in/
  window_functions/
  simple_select/
  concat/
  null_is_null/
  regex/
  group_concat/
  cartesian_product/
  lead_lag/
  string_functions/
  store_prod/
```

## ⚙️ Automation

- GitHub Actions pull data from Google Sheets every 12 hours.
- Python script generates `.sql` files and places them in topic folders.
- Only changed files are committed.

## 🚀 How to Add New Problems

1. Add a new row in the Google Sheet  
2. Fill in `Title`, and `Code`  
3. Check all relevant topic columns  
4. Repo updates automatically

---

Simple. Organized. Fully automated.
