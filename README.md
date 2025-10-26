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

| **Objective**         | **KPI / Metric**             | **Key Finding (from Mart)** | **Actionable Recommendation** |
|-----------------------|-----------------------------|-----------------------------|-------------------------------|
| **Revenue Analysis**  | Average Order Value (AOV)   | **Desktop AOV ($221.47)** is **17× higher** than Mobile AOV ($12.64). | Prioritize checkout flow stability and features for high-value desktop users. |
| **Optimization Priority** | Conversion Rate (%) | Mobile conversion (0.30%) is nearly **10× lower** than Desktop (2.81%). | Audit and optimize the **mobile site and checkout process** immediately. |
| **Data Quality** | Data Integrity | Successfully unnested complex semi-structured data for reliable reporting. | Maintain strict data quality tests (see `tests/` folder). |

---

## 🧩 3. Data Source & Technology Stack

| **Component**     | **Detail** |
|-------------------|------------|
| **Source**        | Google Analytics Sample Dataset (`bigquery-public-data.google_analytics_sample.ga_sessions_20170801`) |
| **Transformation** | dbt (Data Build Tool) |
| **Warehouse**     | Google BigQuery |
| **Visualization** | *(Placeholder – e.g., Looker / Tableau)* |
| **Orchestration** | dbt Cloud (Scheduling & CI/CD) |

---

## 🏗️ 4. Data Model Overview (Medallion Architecture)

This project follows a **three-layer Medallion architecture**:  
**Staging → Core → Marts** to ensure data lineage, testability, and business utility.

| **Layer** | **Model Name** | **Materialization** | **Purpose** |
|------------|----------------|---------------------|-------------|
| **Source** | `google_analytics` | N/A | Defines the connection to the raw BigQuery public dataset. |
| **Staging** | `stg_ga_hits` | `view` | **Data Flattening:** Unnests the complex `hits` array into one row per user action. Performs cleaning and casts revenue data. |
| **Core (Fact Table)** | `fact_sessions` | `table` | **Dimensional Modeling:** Aggregates hits back to the session level, calculates conversion flags, total revenue, and device metadata. Partitioned & clustered for performance. |
| **Mart** | `mart_conversion_summary` | `view` | **Business Layer:** Aggregates by `device_category` and `traffic_medium`, calculating **AOV** and **Conversion Rate**. Acts as the **Single Source of Truth** for BI reporting. |

---

## ⚙️ 5. Installation and Setup (dbt Cloud Focus)

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
