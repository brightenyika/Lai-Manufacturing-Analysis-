# Lai Manufacturing Plc - Analyzing and visualizing data in real time for operational efficiency
> *Lai Manufacturing Plc understands the intricacies of optimizing processes, enhancing operational efficiency, and mitigating risks. Their journey has not been without hurdles which includes, the need for real-time reporting, ensuring top-notch data performance, and simplifying complex reports.*

---

## ⚙️ Project Type Flags

- [ ] SQL Data Analysis
- [ ] Exploratory Data Analysis (EDA)
- [ ] Data Cleaning and Transformation
- [ ] Business Analysis
- [ ] Operations Analytics
- [ ] Power BI Service – Publishing dashboards and enabling stakeholder access.

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Objectives](#2-objectives)
3. [Project Scope & Tools](#3-project-scope--tools)
4. [Data Workflow](#5-data-workflow)
5. [ERD - Entity Relationship Diagram](#5-erd--entity-relationship-diagram)
7. [Key Insights](#7-key-insights)
8. [Recommendations](#8-recommendations)
10. [Future Enhancements](#10-future-enhancements)
11. [Author](#11-author)

---

## 1. Project Overview

<!--
  Write 3–5 sentences in plain language.
  Cover: context → problem → approach → outcome.
  Read it out loud. If it sounds like a form - rewrite it.

  WHAT GOOD LOOKS LIKE:
  "A mid-size retail business was seeing inconsistent revenue across
  its regional stores but couldn't identify the root cause. This project
  explored 18 months of transaction data across five regions to determine
  whether underperformance was driven by sales volume, pricing, or return
  rates. The analysis revealed that one region's gap was almost entirely
  explained by an unusually high return rate on a single product category -
  a finding invisible in the company's top-level reporting."

  WHAT TO AVOID:
  "This project analyzes sales data to find trends and insights."
  (Too vague. Could describe 10,000 projects. Describes none of them.)
-->

The company has been facing growing operational challenges that are affecting its overall productivity and efficiency. This project explored data across all sectors within the organization. The analysis revealed that downtime were mainly caused by human error followed by Material shortage. 

---

## 2. Objectives

<!--
  Write objectives that are specific enough to succeed or fail.
  Use action-oriented verbs: Identify, Determine, Quantify, Build, Evaluate.

  WHAT GOOD LOOKS LIKE:
  ✅ "Determine whether customer churn rate correlates with support ticket volume."
  ✅ "Identify the top three revenue-driving product categories across all regions."
  ✅ "Build a reproducible pipeline that ingests and cleans daily sales exports."

  WHAT TO AVOID:
  ❌ "Explore the data."
  ❌ "Gain insights."
  ❌ "Understand trends."
  (These can't fail - which means they can't succeed either.)
-->

- Implement data-driven process optimization strategies to identify and eliminate bottlenecks and inefficiencies in manufacturing operations.
- Create intuitive and user-friendly data visualization dashboards that empower decision-makers at all levels with actionable insights
- Answer crucial questions relating to business using data analysis, such as; Product Performance Analysis, Quality Metrics Analysis, Supplier Performance Analysis,
  Maintenance Analysis, Employee Performance Analysis, and Downtime Events Analysis

---

## 3. Project Scope & Tools

### Scope

<!--
  WHAT GOOD LOOKS LIKE:
  In Scope: "Transaction-level data for Regions A–E, Jan 2023–Jun 2024.
             Analysis covers revenue, return rates, and product category performance."
  Out of Scope: "Customer demographics and marketing spend data were excluded -
                 demographic data was incomplete for two regions, and marketing
                 data sits in a separate system outside this engagement."

  WHAT TO AVOID:
  ❌ Leaving Out of Scope blank. This is the section that protects your credibility.
     If you don't define the fence, reviewers assume you missed things.
-->

| Dimension | Details |
|-----------|---------|
| **In Scope** | Manufacturing production and efficiency analysis, Inventory levels, sales performance and stockout risk assessment, Employee productivity and performance evaluation. |
| **Out of Scope** | Direct implementation of manufacturing process improvements, Live ERP or production management system development, Automated inventory replenishment. |
| **Time Period** | 2023-04-01 – 2023-09-29 |
| **Granularity** | Individual production operation records, product category, supplier, employee, shift, maintenance type, downtime reason and production date. |

### Tools & Technologies

<!--
  List only what you actually used on this project.
  This is not your skills section - it's the project's technical context.
-->

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage | CSV files |
| Data Modeling & Analysis | SQL |
| Data Cleaning and Transformation | Power Query & SQL |
| Analytical Measures | SQL |
| Visualization | Power BI |

---

## 4. Data Workflow

<!--
  Show how data moved through your project - from source to output.
  Every transformation decision should be traceable here.

  WHAT GOOD LOOKS LIKE:
  1. Source: "Monthly CSV exports pulled from the internal POS system.
              Five files, one per region, covering Jan 2023–Jun 2024."
  2. Ingestion: "Loaded into Python using pandas. Files concatenated into
                 a single dataframe (approx. 340,000 rows)."
  3. Cleaning: "Removed 1.2% of rows with null transaction IDs.
                Standardised date formats across regional files.
                Resolved product category naming inconsistencies (3 variants → 1)."
  4. Transformation: "Created a returns_rate field at product-category level.
                      Aggregated to weekly and regional grain for trend analysis."
  5. Analysis: "Descriptive statistics, regional comparison, return rate
                segmentation by product category."
  6. Output: "Summary report (PDF), annotated notebook, processed CSV."

  WHAT TO AVOID:
  ❌ "Data was cleaned and analysed." (No chain. No decisions. No trust.)
-->

```
[Data Source(s)]
      ↓
[Ingestion / Collection Method]
      ↓
[Cleaning & Transformation]
      ↓
[Analysis / Modelling / Querying]
      ↓
[Output / Visualisation / Reporting]
```

1. **Source:** Extracted manufacturing operations data from the database and saved it as a CSV file for analysis.
2. **Ingestion:** Imported the CSV dataset into PostgreSQL for analysis.
3. **Cleaning:**  Standardised data formats, handled missing and null values, corrected date fields, and created categorical data.
4. **Validation:** Checked data accuracy, consistency, duplicate records, missing values and data types to ensure data quality and reliability.
5. **Transformation:** Created SQL queries, aggregate functions, window functions and Common Table Expressions (CTEs) to organise, transform and prepare data for meaningful analysis.
6. **Output:** Developed an interactive Power BI dashboard to present key performance indicators (KPIs), operational trends, performance comparisons and actionable business insights.


---

## 5. ERD - Entity Relationship Diagram

<!--
  An ERD shows how your tables connect to each other visually.
  It is the fastest way for a reviewer to understand the data structure
  of a SQL project without reading every query.

  HOW TO INCLUDE YOUR ERD:
  Option A - Image embed (most common):
    Export your ERD from dbdiagram.io, DBeaver, Lucidchart, or similar.
    Save to /visuals/erd.png and reference it below.

  Option B - dbdiagram.io code block (version-controllable):
    Paste your schema definition code directly in the fenced block below.
    Anyone can paste it into dbdiagram.io to regenerate the visual.

  Option C - Mermaid diagram (renders natively in GitHub):
    Use the mermaid code block syntax below.
    GitHub will render this as a diagram automatically.

  PICK ONE. Don't use all three. Delete the options you don't use.
-->

![ERD Diagram](https://res.cloudinary.com/dtz0urit6/image/upload/q_auto:best,f_jpg/cloudinary-tools-uploads/gjcbwooalschpjyvpv6k)
* A five-table schema - patients, admissions, vitals, and doctor visits joined on shared IDs.

---

## 6. Analysis & Metrics

<!--
  Explain what you measured and how - before you share what you found.

  WHAT GOOD LOOKS LIKE:
  Metric: "Customer Return Rate"
  Definition: "Number of transactions flagged as returns divided by total
               transactions, calculated at product-category and regional grain."
  Why It Matters: "Return rate - not sales volume - was hypothesised to
                  explain regional revenue gaps. This metric tests that hypothesis."

  WHAT TO AVOID:
  ❌ Defining a metric only in code: SUM(returns) / COUNT(transaction_id)
     That's an implementation. Write the plain-language definition here.
     Both belong in your project - the definition in the README,
     the implementation in the code.
-->

### Methods Used

- Descriptive statistics – Summarised production volumes, sales quantities, inventory levels, supplier lead times and equipment downtime to understand overall performance.
- Trend analysis – Analyzed production output, sales performance, quality metrics and downtime patterns across production dates and shifts.
- Segmentation / group comparison – Compared performance across product categories, suppliers, employees, production shifts, maintenance types and downtime reasons.
- KPI analysis – Calculated production efficiency, sales rates, stockout risks, quality pass rates, employee ratings, supplier lead times and downtime contributions.
- Custom transformations in Power BI – Created calculated columns. 

---

## 7. Key Insights

<!--
  Findings + implications. Not just what happened - what it means.

  WHAT GOOD LOOKS LIKE:
  ✅ "Return rates, not sales volume, explain Region A's underperformance.
      Region A's return rate on home goods was 34% - more than double the
      company average. Revenue was not lost at the point of sale; it was
      lost post-sale through refunds. This points to a fulfilment or
      product quality issue specific to that region, not a demand problem."

  WHAT TO AVOID:
  ❌ "Region A had lower revenue than other regions in Q4."
     (That's an observation. It describes what happened.
      An insight says what it means and where to look next.)

  Aim for 3–6 insights. Quality over quantity.
-->

**Medication Services:** Medication-related concerns were the leading reason patients visited the hospital. This points to a needed improvement in refill processes and prescription renewals.

**Readmission Spike:** Readmissions spiked sharply in February, reaching 76 cases, before gradually declining through June. This pattern may indicate a seasonal or post-holiday effect.

**Departmental Performance:** General Medicine (37), Cardiology (35), and ICU (34) lead in readmission volume, showing these departments carry the heaviest recurring patient load.

**Response Times:** Average response times were consistent across departments at approximately 16 minutes, suggesting that response speed is relatively standardized and is unlikely to be a major differentiator in departmental performance.

**Vitals:** The 7-day vitals trend shows that abnormal cases consistently outnumbered normal cases, indicating a persistent pattern rather than a one-time increase.

---

## 8. Recommendations

<!--
  Action-oriented. Addressed to a real audience.
  Tied explicitly to the insight that supports each one.

  WHAT GOOD LOOKS LIKE:
  Priority: High
  Recommendation: "Conduct a fulfilment audit for home goods deliveries
                   in Region A - specifically investigating whether returns
                   correlate with a particular warehouse, carrier, or SKU batch."
  Based On: Insight 1 - return rate anomaly in Region A
  Owner: Operations / Supply Chain team

  WHAT TO AVOID:
  ❌ "Improve the return rate."
     (Not actionable. Doesn't say who, how, or where to start.)
  ❌ "Further analysis is needed."
     (This is a placeholder, not a recommendation.)
-->

| Recommendation | Based On | Suggested Owner |
|-------------------------|----------|-----------------|
| Standardize post-discharge monitoring hospital-wide | Readmissions | Care Coordinators |
| Strengthen discharge planning, prescription renewal concern, and post-discharge follow-up to reduce avoidable readmissions | Readmission spike | Physicians and Case Manager| 
| Prioritize resources and staffing for high-demand departments, particularly Emergency, Pulmonology, Cardiology, and ICU | Departmental Performance | Head of Departments |
| Investigate root causes behind the high abnormal-vitals ratio | Vitals | Doctors |

---

<!--
  WHAT GOOD LOOKS LIKE:
  Assumption: "Transaction records were assumed to be complete for all five regions.
               No validation was performed against source system record counts."
  Limitation: "The analysis cannot distinguish between returns initiated by
               the customer vs. returns initiated by the business (e.g., recalls).
               If business-initiated returns are concentrated in Region A, the
               return rate finding may reflect a policy decision, not a quality issue."

  WHAT TO AVOID:
  ❌ Leaving this section blank or writing "None known."
     Every project has limitations. Documenting them is a sign of
     analytical maturity - not a confession of failure.
-->

---

## 10. Future Enhancements

<!--
  WHAT GOOD LOOKS LIKE:
  ✅ "Automate the monthly data pull from the POS export folder using
      a scheduled Python script, replacing the current manual process."
  ✅ "Expand the return rate analysis to include carrier-level data,
      which was unavailable in this dataset but exists in the logistics system."

  WHAT TO AVOID:
  ❌ "Add a machine learning model."
     (Vague, and disconnected from the actual findings of this project.)
  ❌ Listing aspirational features that don't follow logically from the work.
-->

- [ ] Incorporate additional data sources such as pharmacy records, laboratory results, and patient satisfaction surveys for deeper analysis.
- [ ] Develop machine learning models to predict patient readmissions, abnormal vital signs, and high-risk patients.
- [ ] Automated alerts to monitor response times, patient volume, and critical healthcare metrics.

---

## 11. Author

**Bright Enyika**

*Data Analyst*
- 🔗 [https://www.linkedin.com/in/bright-enyika/]
- 💼 [https://brightenyika.github.io/#]

---

*Last updated: August 2025*
