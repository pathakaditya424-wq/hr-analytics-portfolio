-- HR Analytics Portfolio
-- Tier 3: Advanced Queries

-- 1. Rank job roles by attrition rate within each department
SELECT j.department, j.jobrole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate,
    RANK() OVER (PARTITION BY j.department ORDER BY 
        SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) DESC) AS rank
FROM job_details j
JOIN attrition_log a ON j.employeenumber = a.employeenumber
GROUP BY j.department, j.jobrole
ORDER BY j.department, rank;

-- 2. Employees who left earning below department average
WITH dept_avg AS (
    SELECT department,
        AVG(monthlyincome) AS avg_salary
    FROM job_details
    GROUP BY department
),
underpaid_leavers AS (
    SELECT j.employeenumber, j.department, j.jobrole,
        j.monthlyincome, d.avg_salary
    FROM job_details j
    JOIN attrition_log a ON j.employeenumber = a.employeenumber
    JOIN dept_avg d ON j.department = d.department
    WHERE a.attrition = 'Yes'
    AND j.monthlyincome < d.avg_salary
)
SELECT * FROM underpaid_leavers
ORDER BY department, monthlyincome;

-- 3. Salary growth by tenure using window functions
WITH tenure_salary AS (
    SELECT 
        totalworkingyears,
        ROUND(AVG(monthlyincome), 2) AS avg_salary
    FROM job_details
    GROUP BY totalworkingyears
)
SELECT totalworkingyears, avg_salary,
    ROUND(avg_salary - FIRST_VALUE(avg_salary) OVER (ORDER BY totalworkingyears), 2) AS salary_growth,
    ROUND(avg_salary * 100.0 / FIRST_VALUE(avg_salary) OVER (ORDER BY totalworkingyears), 1) AS growth_pct
FROM tenure_salary
ORDER BY totalworkingyears;

-- 4. Combined attrition risk profile using chained CTEs
WITH overtime_risk AS (
    SELECT j.employeenumber,
        CASE WHEN j.overtime = 'Yes' THEN 1 ELSE 0 END AS overtime_flag
    FROM job_details j
),
salary_risk AS (
    SELECT j.employeenumber,
        CASE WHEN j.monthlyincome < 3000 THEN 1 ELSE 0 END AS low_salary_flag
    FROM job_details j
),
age_risk AS (
    SELECT e.employeenumber,
        CASE WHEN e.age <= 33 THEN 1 ELSE 0 END AS young_flag
    FROM employees e
),
risk_profile AS (
    SELECT o.employeenumber,
        o.overtime_flag + s.low_salary_flag + a.young_flag AS risk_score
    FROM overtime_risk o
    JOIN salary_risk s ON o.employeenumber = s.employeenumber
    JOIN age_risk a ON o.employeenumber = a.employeenumber
)
SELECT r.risk_score,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN al.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN al.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM risk_profile r
JOIN attrition_log al ON r.employeenumber = al.employeenumber
GROUP BY r.risk_score
ORDER BY r.risk_score DESC;