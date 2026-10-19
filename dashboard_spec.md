# Part C — Tableau Public Dashboard Specification and Business Narrative

## Data source

Connect Tableau Public to `data/orders_clean.csv` (the cleaned output
from Part B). Set `order_month` to a **String** / text field so values
remain `2026-09`, `2026-10`, and `2026-11`; do not convert it to a date.
All 63 rows are completed orders. The 13 columns and intended Tableau
roles are:

| Column             | Classification | Description                                                           |
|--------------------|----------------|-----------------------------------------------------------------------|
| `order_id`         | Dimension      | Order identifier; do not aggregate as a measure.                      |
| `order_month`      | Dimension      | Month label retained as text in YYYY-MM form.                         |
| `clean_first_name` | Dimension      | Cleaned customer first name.                                          |
| `clean_last_name`  | Dimension      | Cleaned customer last name.                                           |
| `region`           | Dimension      | Sales region.                                                         |
| `rep_name`         | Dimension      | Sales representative name.                                            |
| `item`             | Dimension      | Product/item label.                                                   |
| `category`         | Dimension      | Product category; use for category filter and grouping.               |
| `status`           | Dimension      | Order status; all rows in this file are completed orders.             |
| `unit_price`       | Measure        | Unit price in INR; can be aggregated when appropriate.                |
| `quantity`         | Measure        | Units in each order line.                                             |
| `amount`           | Measure        | Recorded order amount in INR; primary revenue measure.                |
| `revenue_calc`     | Measure        | Calculated unit price multiplied by quantity; use for QA comparisons. |

## KPI cards

- **Total Revenue:** `SUM(amount)` = **INR 346,200**.
- **Total Units Sold:** `SUM(quantity)` = **106 units**.
- **Part A reconciliation:** The Total Revenue card is INR 346,200,
  equal to Part A q05 `total_revenue` (346,200).

## Chart sheets

### 1. Revenue by Region

- **Chart type:** Horizontal bar chart.
- **Rows shelf:** `region`.
- **Columns shelf:** `SUM(amount)`.
- **Colour shelf:** `region` (one consistent colour per region;
  alternatively use a single neutral colour if the legend is
  unnecessary).
- **Why this chart:** Bars make it easy to compare total revenue across
  regions and identify the strongest and weakest regional totals.
- **Exact chart data:**

| Region | Sum of amount (INR) |
|--------|--------------------:|
| East   |               69500 |
| North  |              119300 |
| South  |               82500 |
| West   |               74900 |

### 2. Revenue by Category

- **Chart type:** Horizontal bar chart.
- **Rows shelf:** `category`.
- **Columns shelf:** `SUM(amount)`.
- **Colour shelf:** `category`.
- **Why this chart:** A bar chart provides a direct comparison of
  revenue totals among the three product categories.
- **Exact chart data:**

| Category    | Sum of amount (INR) |
|-------------|--------------------:|
| Apparel     |               77500 |
| Electronics |              142300 |
| Home        |              126400 |

### 3. Revenue Trend by Month and Category

- **Chart type:** Line chart.
- **Rows shelf:** `SUM(amount)`.
- **Columns shelf:** `order_month` (discrete text values, sorted
  ascending: `2026-09`, `2026-10`, `2026-11`).
- **Colour shelf:** `category` (one line per category).
- **Why this chart:** A line chart shows how each category’s revenue
  changes across the three months, making increases and declines
  visible.
- **Exact chart data (INR):**

| Order month     | Apparel | Electronics |   Home | Monthly total |
|-----------------|--------:|------------:|-------:|--------------:|
| 2026-09         |   24700 |       43000 |  30600 |         98300 |
| 2026-10         |   30600 |       49900 |  12600 |         93100 |
| 2026-11         |   22200 |       49400 |  83200 |        154800 |
| **Grand Total** |   77500 |      142300 | 126400 |        346200 |

### 4. Region x Category Detail

- **Chart type:** Text table / crosstab.
- **Rows shelf:** `region`.
- **Columns shelf:** `category`.
- **Colour shelf:** None required; optionally colour by `SUM(amount)`
  using a restrained sequential palette to highlight larger cells.
- **Text/Label shelf:** `SUM(amount)`; include row and column grand
  totals.
- **Why this chart:** A text table gives managers exact
  category-by-region values that can be read without estimating bar
  lengths.
- **Exact chart data (INR):**

| Region      | Apparel | Electronics |   Home | Grand Total |
|-------------|--------:|------------:|-------:|------------:|
| East        |   10600 |       21400 |  37500 |       69500 |
| North       |   19400 |       73400 |  26500 |      119300 |
| South       |   10000 |       28700 |  43800 |       82500 |
| West        |   37500 |       18800 |  18600 |       74900 |
| Grand Total |   77500 |      142300 | 126400 |      346200 |

## Dashboard layout

Use a single dashboard with a fixed top-to-bottom reading order:

1.  **KPI cards first:** place Total Revenue and Total Units Sold side
    by side in a horizontal container at the top.
2.  **Category filter second:** directly below the KPI cards, place a
    single-select or multi-select `category` filter in a narrow
    horizontal top-band container. Configure **Apply to Worksheets → All
    Using This Data Source**, so the filter affects all four worksheets
    (Revenue by Region, Revenue by Category, Revenue Trend by Month and
    Category, and Region x Category Detail).
3.  **Trend chart third:** place Revenue Trend by Month and Category in
    a full-width vertical container beneath the filter band.
4.  **Comparison charts fourth:** place Revenue by Region and Revenue by
    Category side by side in a horizontal container.
5.  **Detail table fifth:** place Region x Category Detail in a
    full-width vertical container at the bottom.

Use a vertical container for the overall dashboard stack; nested
horizontal containers for the KPI cards, filter band, and two comparison
charts; and full-width vertical containers for the trend and detail
sheets. Keep labels and INR number formats consistent across sheets.

With **Use as Filter** enabled on Revenue by Region, clicking a region’s
bar filters the other three worksheets to that selected region’s records
(while the clicked worksheet itself indicates the selected region);
clearing the selection restores all regions.

## Insight and recommendation narrative

### Visualization summary

The dashboard summarises the 63 completed orders in `orders_clean.csv`.
Total recorded revenue is **INR 346,200** across **106 units**. Regional
bars compare East, North, South, and West; category bars compare
Apparel, Electronics, and Home; the monthly line chart exposes
category-level movement from September through November 2026; and the
detail crosstab provides exact region/category values.

### Summary analysis

1.  **North leads regional revenue:** North generated **INR 119,300**,
    compared with East at **INR 69,500**—a difference of **INR 49,800**.
    North is the strongest region by recorded amount, while East is the
    lowest.
2.  **Electronics is the largest category:** Electronics contributed
    **INR 142,300**, ahead of Home at **INR 126,400** and Apparel at
    **INR 77,500**. Electronics is **INR 64,800** above Apparel.
3.  **Home revenue surged in November:** Home increased from **INR
    12,600** in October to **INR 83,200** in November, a rise of **INR
    70,600**. This is the sharpest month-to-month movement among the
    category totals.
4.  **Electronics was comparatively steady:** Electronics rose from
    **INR 43,000** in September to **INR 49,900** in October, then eased
    slightly to **INR 49,400** in November; November remained **INR
    6,400** above September.

### Recommendations

1.  **Build on North’s performance:** Run a targeted Electronics
    promotion with the North sales team, using North’s **INR 119,300**
    total revenue and its **INR 73,400** Electronics revenue as the
    baseline. Judge success by North Electronics revenue and units sold
    in the next reporting month versus this baseline.
2.  **Recover East revenue:** Test a region-specific campaign for East,
    prioritising Electronics and Home, because East recorded the lowest
    regional total at **INR 69,500** (including **INR 21,400**
    Electronics and **INR 37,500** Home). Judge success by East’s total
    revenue and its category mix in the following month.
3.  **Protect the November Home momentum:** Review stock cover and
    replenish Home products ahead of the next comparable selling period,
    because Home revenue reached **INR 83,200** in November versus **INR
    12,600** in October. Judge success by Home revenue, units sold, and
    stockout rate in the next month.

## Reconciliation

The Part B pivot grand total is **INR 346,200**. Each independent
revenue view below must agree with the Total Revenue KPI.

| Reconciliation item               | Total (INR) |
|-----------------------------------|------------:|
| Total Revenue KPI (`SUM(amount)`) |      346200 |
| Sum of Revenue by Region values   |      346200 |
| Sum of Revenue by Category values |      346200 |
| Part B pivot grand total          |      346200 |
