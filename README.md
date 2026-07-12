# Data Engineering & Customer Analytics: Maximizing E-Commerce Lifetime Value (CLV)

## 📌 Project Overview & Business Problem
**The Challenge:** A global e-commerce retail group sitting on over 500,000 raw transactional logs asked a critical question: *"How do we optimize our marketing spend and protect leaking revenue?"*
**The Solution:** I engineered an end-to-end data infrastructure pipeline that ingests raw sales data, cleans transactional noise, models a custom behavioral segmentation engine (RFM Analysis) in Python, maps it into a relational SQL Star Schema database, and exposes dynamic revenue opportunities via Power BI.

---

## 🛠️ Tech Stack & Architecture Archetype
* **Data Extraction & Feature Engineering:** Python (Pandas, Openpyxl)
* **Data Modeling & Storage:** MySQL Workbench (Relational Star Schema)
* **Database Driver / Pipeline Orchestration:** SQLAlchemy & PyMySQL
* **Business Intelligence Framework:** Power BI Desktop (DAX Modeling)

* ┌────────────────────────┐      ┌────────────────────────┐      ┌────────────────────────┐
    │   1. Raw Excel Log     │ ───► │  2. Python Engine      │ ───► │ 3. MySQL Warehousing  │
    │ (500k chaotic sales)   │      │ (Cleaning & RFM Data)  │      │ (Structured Star Repo) │
    └────────────────────────┘      └────────────────────────┘      └────────────────────────┘
                                                                                │
                                                                                ▼
                                                                    ┌────────────────────────┐
                                                                    │  4. Power BI Front     │
                                                                    │ (Dynamic Executive UI) │
                                                                    └────────────────────────┘
  ## 💻 Technical Implementation Deep-Dive

### 1. Python Data Cleansing & Feature Engineering
Raw data presents massive anomalies. I used Pandas to execute strict corporate validation rules:
* Dropped records lacking explicit `CustomerID` variables.
* Enforced positive purchase thresholds to strip cancellations and product returns.
* Isolated regular stock item sales by purging manual/administrative postage strings using RegEx (`^[A-Za-z]`).
* Computed customer-level Recency, Frequency, and Monetary (RFM) vectors mapped directly to percentiles, classifying users into actionable segments (*Champions*, *At Risk*, *Lost*).

### 2. Database Data Modeling (MySQL Star Schema)
To ensure fast analytics query speeds, I designed a production-grade relational warehouse instead of pushing flat tables into the visualization framework. 

* **Fact Table:** `fact_sales` (capturing quantities, invoice dates, prices, and composite line item revenue totals).
* **Dimension Tables:** `dim_customers` (storing engineered behavioral segments, score tiers, and country attributes) and `dim_products`.
* **Database Constraints:** Enforced strict `PRIMARY KEY` and `FOREIGN KEY` referential integrity constraints to protect structural mapping stability.

---

## 📈 Executive Insights & Financial Impact
Connecting the database model into Power BI via a direct local server port allowed me to build executive KPIs using advanced DAX equations (`CALCULATE`, `COALESCE`, `DIVIDE`). 

### Core Analytical Findings:
1. **Total Enterprise Footprint:** The complete historical sales pipeline evaluated totals **$8.76M**.
2. **Customer Concentration Risk:** A staggering **66.68% of total revenue** is driven entirely by our *Champions* segment. This reveals high operational vulnerability; losing even 5% of this top tier would severely impact corporate margins.
3. **Leaking/At-Risk Revenue:** Identified **$243.36K** locked inside the *At Risk* and *Can't Lose Them* categories. This represents an immediate, data-backed opportunity for the marketing team to execute targeted retention or re-engagement campaigns.

---

## 🔧 Real-World Engineering Hurdles & Debugging Log
* **The Missing Location Field (The Column Drop):** During Python aggregation, the geographic `Country` marker was inadvertently dropped. I patched the pipeline by constructing a clean dimension mapping using a data frame merge (`pd.merge`) and executed a localized `TRUNCATE` script via SQL constraints to successfully restore cross-border tracking features.
* **SQLAlchemy 2.0 Syntax Adaptation:** Navigated standard transaction engine updates by wrapping system controls inside explicit execution strings (`text()`), ensuring secure connection protocols.
