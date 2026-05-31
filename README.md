# BRIGHT-COFFEE-SHOP

***

# Bright Coffee Shop Sales Analysis

## Project Description
This project is a comprehensive data analysis case study for **Bright Coffee Shop**, focusing on providing actionable business insights through sales performance analysis. The project involves analyzing daily transactional data across three New York City store locations to identify revenue drivers, understand time-based purchasing patterns, and track product performance. The goal is to assist the coffee shop in optimizing its inventory, staffing strategy, and seasonal offerings.

## Raw Data
The source dataset consists of **daily transactional records** for all items sold across three NYC store locations.
- **Dataset Content:** Daily transaction records including product details, pricing, quantity, store location, and timestamps.
- **Key Statistics:** The dataset includes **149,116 total transactions** across 9 product categories, 29 product types, and 80 SKUs.
- **Total Revenue:** The analyzed data accounts for approximately **R698,812** in revenue over 6 months.
- **Data Period:** 1 January 2023 – 30 June 2023

## Tools Used
- **Project Planning:** Miro — used to map out the project workflow, define objectives, and structure the analysis pipeline.
- **Gantt Diagram:** Canva — used to plan and visualize the project timeline and task schedule.
- **Data Processing:** Databricks (SQL) — used for ETL, data cleaning, type conversion, metric calculation, and aggregation.
- **Pivots & Graphs:** Microsoft Excel — used for exploratory pivot table analysis and supplementary charts.
- **Dashboards:** Power BI — used to build the interactive 5-page sales performance dashboard.
- **Presentation:** Microsoft PowerPoint — used to compile findings into a structured stakeholder presentation.

## Queries — Databricks
The data processing phase was handled within **Databricks** using SQL to transform raw transactional data into an analysis-ready format. Key SQL tasks included:

- **Data Cleaning:** Handling missing or inconsistent values and standardizing date/time formats.
- **Type Conversion:** Converting text-based prices and quantities into numeric formats for calculations.
- **Calculation of Key Metrics:**
  - `total_revenue`: `transaction_qty * unit_price`
  - `avg_spend_per_transaction`: `SUM(total_revenue) / COUNT(DISTINCT transaction_id)`
  - `avg_revenue_per_unit`: `SUM(total_revenue) / SUM(transaction_qty)`
  - `profit_margin`: derived from unit price and cost benchmarks
- **Categorization:** Using conditional logic to classify transactions by:
  - **Time of day** — Morning Rush, Mid Morning, Afternoon, Evening Rush, Night
  - **Day type** — Weekday vs Weekend
  - **Spend bucket** — Minimal, Moderate, Substantial, Premium
- **Aggregation:** Grouping transactions by store location, product category, product detail, date, month, quarter, and time period.

## Key Insights Found
- **Top-Selling Categories:** Coffee dominates with **58,416 units sold**, followed by Tea at **45,449 units** — affordable categories drive the highest volume, aligning with the brand's "luxury at accessible prices" philosophy.
- **Store Performance:** **Hell's Kitchen** is the top-performing location at **R236,511** in revenue, benefiting from high commuter and tourist foot traffic. **Lower Manhattan** lags at **R230,057** due to strong local competition.
- **Peak Revenue Window:** **Mid Morning (9am–12pm)** generates **R220,148** — the highest of any time slot — as customers grab coffee before and during work hours.
- **Seasonal Trends:**
  - **June is the busiest month** at 24% of all transactions, driven by winter demand for hot drinks.
  - **January and February together account for only 23%** of transactions, suppressed by summer heat.
  - **April–June (Q2) = 63%** of all transactions, confirming a strong winter skew.
- **Day of Week:** Monday records the highest revenue (**R102,000**) as commuters kick off the week. Saturday is the weakest day at **R96,500**.
- **Worst Sellers:** Packaged Chocolate (487 units), Branded Products (747 units), and Loose Tea (1,210 units) underperform despite carrying higher price points.
- **Revenue Growth:** Monthly revenue grew by **+103.8%** from January (R81,678) to June (R166,486).

## Strategic Recommendations
- **Optimize Staffing:** Ensure full staffing during the Mid Morning window (9am–12pm) every weekday to reduce wait times and maximize the peak revenue period.
- **Introduce a Summer Cold Drinks Menu:** Launch iced coffees, iced teas, and cold brew options in January–February to capture off-season revenue lost to summer heat.
- **Boost Lower Manhattan Performance:** Run location-specific weekday morning loyalty deals and partner with nearby offices to differentiate from competitors.
- **Activate Low-Volume, High-Margin SKUs:** Use in-store sampling, influencer partnerships, and bundling to promote Branded Products and Coffee Beans during peak hours.
- **Launch a Loyalty Programme:** A "Buy 5, Get 1 Free" or points-based system will increase visit frequency, particularly on low-traffic Saturdays.
- **Host Weekend Events:** Latte art classes, coffee tastings, and food pairings will attract new customer segments and drive Saturday revenue.
- **Expand the Food Menu:** Add trendy light meals (avocado toast, salads, vegan and gluten-free options) to grow basket size and mid-afternoon footfall.

## Repository Structure
- `README.md` — This project overview.
- `Project Description:` *(https://github.com/nmchunu753-wq/CASE-STUDY-1-BRIGHT-COFFEE-SHOP/blob/main/Project%20Description%20%26%20Raw%20Data/Bright%20Coffee%20Shop%20Case%20Study%20Description.pdf)*
- `coffee_sales_queries.sql` — *(link to Databricks SQL queries)*
- `Miro Flowchart` — *(link to project planning board)*
- `Gantt Time Plan` — *(link to Canva Gantt diagram)*
- `Excel Analysis File — Pivots & Graphs:` *(link to Excel file)*
- `BrightCoffeeShop_Presentation.pdf` — *(link to PowerPoint presentation)*
- `Dashboards:` *(link to Power BI .pbix file)*

***
