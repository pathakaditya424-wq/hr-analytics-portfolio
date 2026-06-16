-- HR Analytics Portfolio
-- Tier 2: Intermediate Queries

-- 1. Attrition by job role
SELECT j.jobrole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM job_details j
JOIN attrition_log a ON j.employeenumber = a.employeenumber
GROUP BY j.jobrole
ORDER BY attrition_rate DESC;

-- 2. Overtime impact on attrition
SELECT j.overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM job_details j
JOIN attrition_log a ON j.employeenumber = a.employeenumber
GROUP BY j.overtime;

-- 3. Attrition by age group
SELECT 
    CASE 
        WHEN age <= 33 THEN 'Young (18-33)'
        WHEN age <= 50 THEN 'Mid-Career (34-50)'
        ELSE 'Senior (51+)'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM employees e
JOIN attrition_log a ON e.employeenumber = a.employeenumber
GROUP BY age_group
ORDER BY attrition_rate DESC;

-- 4. Attrition by salary bracket
SELECT 
    CASE 
        WHEN j.monthlyincome < 3000 THEN 'Low (<3K)'
        WHEN j.monthlyincome < 6000 THEN 'Mid (3K-6K)'
        WHEN j.monthlyincome < 10000 THEN 'High (6K-10K)'
        ELSE 'Very High (10K+)'
    END AS salary_bracket,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM job_details j
JOIN attrition_log a ON j.employeenumber = a.employeenumber
GROUP BY salary_bracket
ORDER BY attrition_rate DESC;

-- 5. Attrition by marital status
SELECT e.maritalstatus,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM employees e
JOIN attrition_log a ON e.employeenumber = a.employeenumber
GROUP BY e.maritalstatus
ORDER BY attrition_rate DESC;

-- 6. Average salary by gender
SELECT e.gender,
    ROUND(AVG(j.monthlyincome), 2) AS avg_salary
FROM employees e
JOIN job_details j ON e.employeenumber = j.employeenumber
GROUP BY e.gender;

-- 7. Job satisfaction vs attrition
SELECT s.jobsatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM satisfaction s
JOIN attrition_log a ON s.employeenumber = a.employeenumber
GROUP BY s.jobsatisfaction
ORDER BY s.jobsatisfaction;