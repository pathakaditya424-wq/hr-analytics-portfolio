# 📊 HR Analytics Portfolio Project

End-to-end HR analytics project built on the IBM HR Attrition dataset  
(1,470 employees · 35 columns · PostgreSQL + Power BI)

---

## 🛠 Tech Stack
| Tool | Purpose |
|------|---------|
| PostgreSQL + pgAdmin 4 | Database design & SQL analysis |
| Power BI Desktop | Interactive dashboard |
| IBM HR Dataset (Kaggle) | Source data |

---

## 🗄 Database Schema
Four normalized tables linked via `EmployeeNumber`:

| Table | Contents |
|-------|----------|
| `employees` | Age, gender, education, marital status |
| `job_details` | Role, department, salary, tenure, overtime |
| `satisfaction` | Job, environment, relationship scores |
| `attrition_log` | Attrition status, performance, promotion |

---

## 🔍 SQL Analysis
20+ queries across three complexity tiers:

| Tier | Concepts |
|------|----------|
| Tier 1 — Basic | SELECT, GROUP BY, ORDER BY, aggregates, JOINs |
| Tier 2 — Intermediate | CASE bucketing, subqueries, multi-table JOINs |
| Tier 3 — Advanced | Window functions, RANK(), PARTITION BY, chained CTEs |

---

## 💡 Key Business Insights

| Finding | Insight |
|---------|---------|
| Overall attrition | 16% — 237 of 1,470 employees |
| Worst department | Sales — 20.6% attrition |
| Worst job role | Sales Representative — 39.8% |
| Overtime impact | 3× more likely to quit — 30.5% vs 10.4% |
| Age risk | Under 33s leave at 24.6% rate |
| Salary impact | Low earners leave 5× more — 25.2% vs 4.9% |
| Underpaid leavers | 198 employees left earning below dept average |

---

## 📊 Power BI Dashboard
4-page interactive dashboard with dark sidebar navigation:

| Page | Visuals |
|------|---------|
| Attrition Overview | KPI cards, dept attrition, top roles, overtime impact |
| Salary Analysis | Attrition by bracket, salary by tenure, gender pay |
| Demographics | Attrition by age, gender distribution, marital status |
| Employee Details | Underpaid leavers, performance rating, dept summary |

**Color scheme:** `#1E1E2E` sidebar · `#6C63FF` accent · `#FF6B6B` high attrition

---

## 📌 Resume Highlights
- Designed normalized 4-table PostgreSQL schema from 35-column IBM HR dataset
- Wrote 20+ SQL queries using JOINs, CTEs, window functions and subqueries
- Identified overtime employees are **3× more likely to quit** — 30.5% vs 10.4%
- Discovered lowest paid employees leave at **5× the rate** of highest earners
- Built 4-page Power BI dashboard with dark sidebar navigation visualizing HR KPIs
