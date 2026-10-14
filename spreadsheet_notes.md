# Part B — Spreadsheet Cleaning and Pivot Layer

## Formula log

The formulas below are the formulas entered in the first data row of
`orders` (row 2), then filled down through row 91. The original q09
columns occupy A:J.

| Added column           | First-row formula                                                     | Purpose                                                                               |
|:-----------------------|:----------------------------------------------------------------------|:--------------------------------------------------------------------------------------|
| `clean_first_name` (K) | `=PROPER(TRIM(C2))`                                                   | Trims surrounding/repeated spaces and applies proper case to the original first name. |
| `clean_last_name` (L)  | `=PROPER(TRIM(D2))`                                                   | Trims surrounding/repeated spaces and applies proper case to the original last name.  |
| `category` (M)         | `=VLOOKUP(G2,products!$A$2:$C$10,2,FALSE)`                            | Exact-match category lookup; the product table range is absolute.                     |
| `unit_price` (N)       | `=XLOOKUP(G2,products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")` | Exact item-price lookup; returns `UNKNOWN_ITEM` for an unlisted item.                 |
| `revenue_calc` (O)     | `=N2*H2`                                                              | Unit price multiplied by quantity using cell references.                              |

The `XLOOKUP` fallback was tested outside the data range using the key
`Mystery Item`; the result is `UNKNOWN_ITEM`. No seed order uses a
missing product item.

## Aggregate results

Calculated on the 63 rows in `completed_orders`, using `amount`:

| Statistic | Spreadsheet result |
|:----------|-------------------:|
| COUNT     |                 63 |
| SUM       |             346200 |
| AVERAGE   |            5495.24 |
| MIN       |               1100 |
| MAX       |              15600 |

## Pivot table 1 — Sum of amount by category and region

| Category    |  East |  North | South |  West | Grand Total |
|:------------|------:|-------:|------:|------:|------------:|
| Apparel     | 10600 |  19400 | 10000 | 37500 |       77500 |
| Electronics | 21400 |  73400 | 28700 | 18800 |      142300 |
| Home        | 37500 |  26500 | 43800 | 18600 |      126400 |
| Grand Total | 69500 | 119300 | 82500 | 74900 |      346200 |

## Pivot table 2 — Sum of amount and count of order_id by order_month

| Order month | Sum of amount | Count of order_id |
|:------------|--------------:|------------------:|
| 2026-09     |         98300 |                19 |
| 2026-10     |         93100 |                20 |
| 2026-11     |        154800 |                24 |
| Grand Total |        346200 |                63 |

## Reconciliation

Part A q05 returns `total_orders = 63`, `total_revenue = 346200`, and
`avg_order_value = 5495.24` for completed orders.

| Metric  | Spreadsheet | Part A q05 | Match/Mismatch |
|:--------|------------:|-----------:|:---------------|
| COUNT   |          63 |         63 | Match          |
| SUM     |      346200 |     346200 | Match          |
| AVERAGE |     5495.24 |    5495.24 | Match          |

## Data validation

- **Missing amounts:** The three missing amounts are order IDs 1001,
  1010, 1064, matching Part A q02. They are all non-completed orders
  (`pending`), so they are excluded by the `status = completed` filter
  and do not affect the completed-order amount aggregates. In the CSV,
  genuinely missing numeric values are left empty rather than changed to
  zero, because zero would incorrectly imply a known zero-value order.

- **Consistent data types:** `order_id`, `quantity`, `unit_price`,
  `amount`, and `revenue_calc` are numeric values; missing `amount`
  values remain blank. `order_month` is kept as text in `YYYY-MM` format
  (for example, `2026-09`) rather than being converted to a date. Names,
  region, representative, item, category, and status are text.

- **Duplicate IDs:** No duplicate `order_id` values were found among
  completed orders.

- **Largest amount / outlier review:** Using the standard 1.5 × IQR
  rule, Q1 = 2800, Q3 = 7200, IQR = 4400, and the upper fence is 13800.
  Therefore, 15600 is an upper outlier. The largest completed-order
  `amount` is 15600; every order ID with that amount is 1061, 1065,
  1069, and 1077. No amount was changed or removed.

- **Decision for the next analyst:** Keep `order_month` as text and
  preserve missing amounts as blanks; do not infer a date or replace
  missing amounts with zero. Keep `revenue_calc` separate from recorded
  `amount` so discrepancies can be reviewed rather than silently
  overwriting source values.

## Setup

- Tabs created: `orders` and `products`; the workbook also contains
  `completed_orders`, `pivot_category_region`, and `pivot_month` for the
  cleaned data and summaries.
- Rows imported into `orders`: 90 data rows (plus one header row).
- `products` tab range: `A1:C10` (header plus 9 products), loaded from
  `SELECT item, category, unit_price FROM products ORDER BY item`.
- Before creating `completed_orders`, filtered `status = completed`,
  then sorted visible rows by `amount` from largest to smallest. The 63
  visible rows were copied as values, and the raw `first_name` and
  `last_name` columns were omitted; the cleaned name columns were
  retained.
- `orders_clean.csv` export range: header plus 63 completed-order
  records only (64 lines total); aggregates and pivot tables are stored
  outside the export range / on separate tabs.
