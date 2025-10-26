# 🏠 E-commerce Conversion & User Journey Analysis

This repository contains the **dbt (data build tool)** project for transforming raw **Google Analytics session data** into actionable business intelligence models—primarily focused on measuring **conversion efficiency** and **customer value**.

---

## 🧭 1. Executive Summary: Driving Business Insight

This project serves as the **backbone of our e-commerce performance reporting**.  
It leverages **dbt on BigQuery** to transform complex, nested user event data into a clean **star schema**.

**Core Goal:**  
Move beyond simple session counts to calculate critical KPIs—specifically **Conversion Rate** and **Average Order Value (AOV)**—to uncover optimization opportunities across **device types** and **traffic sources**.

---

## 🎯 2. Business Objectives & Key Insights

Our analysis currently reveals a **performance disparity** between desktop and mobile users, highlighting the need for targeted mobile optimization.

| **Objective**             | **KPI / Metric**          | **Key Finding (from Mart)**                                                | **Actionable Recommendation**                                                 |
| ------------------------- | ------------------------- | -------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **Revenue Analysis**      | Average Order Value (AOV) | **Desktop AOV ($221.47)** is **17× higher** than Mobile AOV ($12.64).      | Prioritize checkout flow stability and features for high-value desktop users. |
| **Optimization Priority** | Conversion Rate (%)       | Mobile conversion (0.30%) is nearly **10× lower** than Desktop (2.81%).    | Audit and optimize the **mobile site and checkout process** immediately.      |
| **Data Quality**          | Data Integrity            | Successfully unnested complex semi-structured data for reliable reporting. | Maintain strict data quality tests (see `tests/` folder).                     |

---

## 📊 3. E-commerce Conversion Summary Interpretation

Getting a clean final results table from your `mart_conversion_summary` model means your entire dbt pipeline—from unnesting raw data to calculating key metrics—is working perfectly. 🚀  
This table provides **clear, actionable insights** into your e-commerce performance for the analyzed day.

The model groups performance by **`device_category`** and **`traffic_medium`**, allowing you to compare user segments across key metrics.

---

### 1. Revenue & Conversion Analysis (Desktop Dominance)

The most striking insight comes from **desktop users** with a traffic medium of **`(none)`** (likely direct traffic or an undefined source):

- **High Revenue:** This segment generated the majority of total revenue, totaling **\$8,858.76** from 1,424 sessions.
- **Strong Conversion:** The conversion rate is a healthy **2.81%**.
- **Massive AOV:** The Average Order Value is **\$221.47**, indicating that direct desktop visitors are extremely valuable.

| Segment              | Total Revenue | Conversion Rate | AOV          |
| :------------------- | :------------ | :-------------- | :----------- |
| **Desktop / (none)** | \$8,858.76    | 2.81%           | **\$221.47** |
| **Mobile / (none)**  | \$25.28       | 0.30%           | \$12.64      |

**Insight:**  
Our highest-value customers are arriving directly on **desktop** devices and are far more likely to complete large purchases.

---

### 2. Mobile Performance (Area for Improvement)

The **mobile** segment underperforms significantly:

- **Low Conversion:** Only **0.30%**, nearly 10× lower than desktop.
- **Low AOV:** **\$12.64**, suggesting smaller carts or lower-priced items.

**Actionable Insight:**  
There’s likely **friction in the mobile experience or checkout flow**. Immediate optimization of the **mobile UX and checkout funnel** could yield major gains in conversion and revenue.

---

### 3. Traffic Channel Performance (Data Gaps)

Other traffic mediums (`affiliate`, `cpm`, `organic`, `referral`) show **NULL or minimal revenue**, suggesting little to no successful conversions during this snapshot period.

- **Referral Traffic:** 261 sessions and a conversion rate of **0.38%**, but only **\$17.96** in total revenue — indicating low-value or test transactions.

**Actionable Insight:**  
Run this analysis over a **longer time window (e.g., monthly)** to validate whether these channels are consistently underperforming or if this snapshot period is too limited.  
The current pattern indicates these channels may be **inefficient at driving high-value conversions**.

---

### 🧠 Conclusion

Our analysis highlights a classic e-commerce trend:  
**Desktop users are our core revenue drivers, while mobile users represent an untapped opportunity.**

**Strategic Focus:**  
Invest in improving the **mobile conversion funnel**—especially checkout performance and user flow optimization—to close this performance gap and drive incremental revenue growth.

---

## 🧩 4. Data Source & Technology Stack

| **Component**      | **Detail**                                                                                            |
| ------------------ | ----------------------------------------------------------------------------------------------------- |
| **Source**         | Google Analytics Sample Dataset (`bigquery-public-data.google_analytics_sample.ga_sessions_20170801`) |
| **Transformation** | dbt (Data Build Tool)                                                                                 |
| **Warehouse**      | Google BigQuery                                                                                       |
| **Visualization**  | Looker                                                                                                |
| **Orchestration**  | dbt Cloud (Scheduling & CI/CD)                                                                        |

---

## 🏗️ 5. Data Model Overview (Medallion Architecture)

This project follows a **three-layer Medallion architecture**:  
**Staging → Core → Marts** to ensure data lineage, testability, and business utility.

| **Layer**                           | **Model Name**            | **Materialization** | **Purpose**                                                                                                                                                                     |
| ----------------------------------- | ------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**                          | `google_analytics`        | N/A                 | Defines the connection to the raw BigQuery public dataset.                                                                                                                      |
| **analytics_dev_staging**           | `stg_ga_hits`             | `view`              | **Data Flattening:** Unnests the complex `hits` array into one row per user action. Performs cleaning and casts revenue data.                                                   |
| **analytics_dev_core (Fact Table)** | `fact_sessions`           | `table`             | **Dimensional Modeling:** Aggregates hits back to the session level, calculates conversion flags, total revenue, and device metadata. Partitioned & clustered for performance.  |
| **analytics_dev_mart**              | `mart_conversion_summary` | `view`              | **Business Layer:** Aggregates by `device_category` and `traffic_medium`, calculating **AOV** and **Conversion Rate**. Acts as the **Single Source of Truth** for BI reporting. |

---

## ⚙️ 6. Installation and Setup (dbt Cloud Focus)

This project is designed to run primarily within a **dbt Cloud environment** connected to **Google BigQuery**.

### 🧾 Prerequisites

- Access to a **BigQuery project** where transformed data will be written.
- A **dbt Cloud account** with a BigQuery connection configured.
- The BigQuery service account must have **read access** to `bigquery-public-data`.

---

### 🪜 A. Clone Repository

```bash
# Clone this repository into your dbt Cloud IDE or local environment
git clone git@github.com:your-organization/conversion_user_journey.git
```
---
**📊 Summary** This dbt project transforms raw Google Analytics data into actionable business intelligence models for conversion optimization, AOV insights, and data reliability, providing the foundation for scalable, high-impact e-commerce reporting. 

--- 
**Author**: Godwin Oti 

**Contact**: godwinotigo@gmail.com 

**License**: MIT