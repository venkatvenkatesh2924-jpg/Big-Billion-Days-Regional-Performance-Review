## Big Billion Days Regional Performance Review — SQL, Spreadsheet, Dashboard and AI-Verified Analysis

Welcome! This project takes sales-order data through three stages:

1. **Part A — SQL:** query the data and calculate sales summaries.
2. **Part B — Spreadsheet:** clean customer names, add product information, validate data, and create pivot tables.
3. **Part C — Tableau Public:** build an interactive dashboard to explore revenue.

Complete the stages in order. You can use this README as a checklist while working.

---

## 1. Project overview

The project answers questions such as:
- How many completed orders are there?
- What is the total revenue from completed orders?
- Which region and product category earn the most revenue?
- How does revenue change by month?
- How can revenue be compared across regions and categories?

### Main results to check

| Metric | Expected result |
|---|---:|
| Completed orders | 63 |
| Total recorded revenue | INR 346,200 |
| Average completed-order value | INR 5,495.24 |
| Total units sold | 106 |
| Highest-revenue region | North — INR 119,300 |
| Highest-revenue category | Electronics — INR 142,300 |

Use the recorded `amount` field for revenue reporting.

## 2. Important project files

| File | Purpose |
|---|---|
| `query_results.md` | Part A SQL results and seed-data checks |
| `spreadsheet_notes.md` | Part B formulas, pivot totals, and validation notes |
| `orders_clean.csv` | Cleaned data for Tableau; contains 63 completed orders |
| `spreadsheet_layer.xlsx` | Spreadsheet workbook with cleaned data and summary tabs |
| `dashboard_spec.md` | Tableau chart instructions, expected values, and business findings |
| `dashboard_chart_data.xlsx` | Workbook with data to help build/check the dashboard |
| `README.md` | This beginner's guide |

File names and folders may differ slightly depending on how you downloaded the project.

## 3. Part A — Run the SQL queries

### What is SQL?
SQL is a language for asking questions of data stored in tables. This project uses tables such as `orders`, `customers`, `products`, and `reps`.

### Steps
1. Open your MySQL editor.
2. Run the setup script first. It creates and fills the tables.
3. Run the reporting queries (`q01` through `q13`).
4. Review each result and compare key totals with `query_results.md`.

If your online editor does not retain data between sessions, run the setup script again before running the queries.

### Common SQL commands
- `SELECT` chooses columns to display.
- `FROM` specifies the table.
- `WHERE` filters rows.
- `JOIN` combines related tables.
- `GROUP BY` groups rows for summaries.
- `SUM()` adds values.
- `COUNT()` counts rows or values.
- `AVG()` calculates an average.
- `ORDER BY` sorts results.

### Example query

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM orders
WHERE status = 'completed';
```

Expected result: **63 completed orders**, **INR 346,200 total revenue**, and an average order value of approximately **INR 5,495.24**, when the project data is loaded correctly.

### Seed-data checks

| Table | Expected rows |
|---|---:|
| `reps` | 4 |
| `products` | 9 |
| `customers` | 24 |
| `orders` | 90 |

Three orders have missing amounts: **1001, 1010, and 1064**. These are pending orders, not completed orders.

## 4. Part B — Understand the cleaned spreadsheet

The spreadsheet layer:
- Cleans customer names using trimming and proper case.
- Looks up each product's category and unit price.
- Calculates `revenue_calc` as `unit_price × quantity`.
- Filters to completed orders.
- Creates pivot tables by region/category and month.
- Checks spreadsheet totals against SQL.

### Important columns in `orders_clean.csv`

| Column | Meaning |
|---|---|
| `order_id` | Order identifier |
| `order_month` | Month label such as `2026-09` |
| `clean_first_name` | Cleaned customer first name |
| `clean_last_name` | Cleaned customer last name |
| `region` | Sales region |
| `rep_name` | Sales representative |
| `item` | Product name |
| `category` | Product category |
| `unit_price` | Price per unit, in INR |
| `quantity` | Number of units |
| `amount` | Recorded order amount, in INR |
| `revenue_calc` | Calculated unit price multiplied by quantity |
| `status` | Order status; all rows in this cleaned file are completed |

`amount` and `revenue_calc` are kept separately so you can compare the recorded value with the calculated value without overwriting the source amount.

### Data-quality decisions
- Blank amounts remain blank; they are not changed to zero.
- `order_month` remains text in `YYYY-MM` format.
- No duplicate order IDs were found among completed orders.
- The largest completed-order amount is INR 15,600, for order IDs 1061, 1065, 1069, and 1077. These values were reviewed, not removed.

### Expected spreadsheet totals

| Statistic | Expected result |
|---|---:|
| Count | 63 |
| Sum of amount | 346,200 |
| Average amount | 5,495.24 |
| Minimum amount | 1,100 |
| Maximum amount | 15,600 |

Monthly totals:

| Month | Revenue (INR) | Completed orders |
|---|---:|---:|
| 2026-09 | 98,300 | 19 |
| 2026-10 | 93,100 | 20 |
| 2026-11 | 154,800 | 24 |
| **Total** | **346,200** | **63** |

## 5. Part C — Build the Tableau Public dashboard

### Connect the data
1. Open Tableau Public.
2. Choose **Text File** as the data source.
3. Select `orders_clean.csv`.
4. Check that all 13 columns appear.
5. Keep `order_month` as **String/Text**, not a date. Values should remain `2026-09`, `2026-10`, and `2026-11`.
6. Create a worksheet to begin building charts.

### Create two KPI cards

**Total Revenue**
- Drag `amount` into the view.
- Set the aggregation to `SUM`.
- Format it as INR or a number with comma separators.
- Expected value: **INR 346,200**.

**Total Units Sold**
- Drag `quantity` into the view.
- Set the aggregation to `SUM`.
- Expected value: **106**.

Make one worksheet for each KPI and place both at the top of the dashboard.

### Create four charts

**Chart 1 — Revenue by Region**
- Drag `region` to Rows.
- Drag `amount` to Columns and confirm it is `SUM(amount)`.
- Choose horizontal bars.
- Expected values: East 69,500; North 119,300; South 82,500; West 74,900.

**Chart 2 — Revenue by Category**
- Drag `category` to Rows.
- Drag `amount` to Columns and confirm it is `SUM(amount)`.
- Choose horizontal bars.
- Expected values: Apparel 77,500; Electronics 142,300; Home 126,400.

**Chart 3 — Revenue Trend by Month and Category**
- Drag `order_month` to Columns.
- Drag `amount` to Rows and use `SUM(amount)`.
- Choose a line chart.
- Drag `category` to Color to show one line per category.
- Sort the month labels ascending.

**Chart 4 — Region x Category Detail**
- Drag `region` to Rows.
- Drag `category` to Columns.
- Drag `amount` to Text/Label and use `SUM(amount)`.
- Show row and column totals if available.

See `dashboard_spec.md` for the complete chart values and more detailed instructions.

### Assemble the dashboard
Place the elements in this order:
1. Total Revenue and Total Units Sold KPI cards.
2. A `category` filter below the KPIs.
3. The monthly revenue trend across the dashboard width.
4. Revenue by Region and Revenue by Category side by side.
5. The Region x Category Detail table at the bottom.

Configure the category filter to apply to **all worksheets using this data source**.

For interactivity, enable **Use as Filter** on the Revenue by Region chart. Clicking a region's bar should filter the other charts to that region. Clear the selection to see all regions again.

### Save and publish
Save the workbook while you work. To share it, use Tableau Public's save/publish option and sign in when prompted. Before publishing, check the visibility and data-sharing implications: Tableau Public workbooks are intended for public sharing.

## 6. What the dashboard shows

1. **North leads regional revenue:** INR 119,300.
2. **Electronics is the largest category:** INR 142,300.
3. **Home revenue rose sharply in November:** from INR 12,600 in October to INR 83,200 in November.
4. **Revenue totals reconcile:** the KPI, regional totals, category totals, and Part B pivot grand total should all equal INR 346,200.

### Suggested business actions
- Review what is working for Electronics in North and test a targeted promotion.
- Investigate East's lower overall revenue and consider a region-specific campaign.
- Check Home-product stock availability after the strong November result.

These are suggestions based on this dataset. Measure later results before deciding whether an action worked.

## 7. Troubleshooting

**A SQL query says a table does not exist.**  
Run the table-creation and data-insertion setup script first.

**Your totals do not match.**  
Check that you filtered to `status = completed` and used `SUM(amount)` for revenue. Do not substitute `SUM(unit_price)` or `SUM(revenue_calc)` for recorded revenue.

**Tableau treats `order_month` as a date.**  
Change the field type to String/Text and sort the labels ascending.

**A chart total is too high.**  
Check that `amount` uses `SUM(amount)` and that a join or relationship has not duplicated rows.

**A filter changes only one chart.**  
Edit the category filter and apply it to all worksheets using the same data source.

**An amount is blank.**  
Do not automatically replace it with zero. Check the order status and source data first.

**The dashboard total is not INR 346,200.**  
Clear selections and filters, then check that the source is the 63-row completed-order CSV.

## 8. Final checklist

- [ ] SQL setup ran successfully.
- [ ] Seed table row counts match the expected counts.
- [ ] Reporting queries ran and results were reviewed.
- [ ] Spreadsheet totals and pivot tables were checked.
- [ ] Tableau is connected to `orders_clean.csv`.
- [ ] `order_month` is text.
- [ ] Total Revenue shows INR 346,200.
- [ ] Total Units Sold shows 106.
- [ ] All four chart worksheets are included.
- [ ] The category filter applies to all worksheets.
- [ ] Clicking a region filters the other charts.
- [ ] Revenue totals reconcile across SQL, spreadsheet, and dashboard.
- [ ] The workbook is saved; publish only if you intend to share it publicly.

## 9. Recommended learning order

1. **SQL:** `SELECT`, `WHERE`, `ORDER BY`, aggregate functions, `GROUP BY`, and `JOIN`.
2. **Spreadsheets:** sort, filter, `TRIM`, `PROPER`, lookup formulas, and pivot tables.


3. **Tableau:** dimensions and measures, Rows/Columns shelves, marks, filters, dashboards, and interactive actions.

**Tip:** Build one chart at a time and verify its total before adding it to the dashboard. That makes errors easier to find.
