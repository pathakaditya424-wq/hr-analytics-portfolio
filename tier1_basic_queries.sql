-- HR Analytics Portfolio
-- Tier 1: Basic Queries

-- 1. Total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. Overall attrition count and rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM attrition_log;

-- 3. Average age, salary and distance from home
SELECT 
    ROUND(AVG(e.age), 1) AS avg_age,
    ROUND(AVG(j.monthlyincome), 2) AS avg_salary,
    ROUND(AVG(e.distancefromhome), 1) AS avg_distance
FROM employees e
JOIN job_details j ON e.employeenumber = j.employeenumber;

-- 4. Employee count by department
SELECT department, COUNT(*) AS total_employees
FROM job_details
GROUP BY department
ORDER BY total_employees DESC;

-- 5. Attrition count by department
SELECT j.department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM job_details j
JOIN attrition_log a ON j.employeenumber = a.employeenumber
GROUP BY j.department
ORDER BY attrition_rate DESC;

-- 6. Average salary by department
SELECT department,
    ROUND(AVG(monthlyincome), 2) AS avg_salary
FROM job_details
GROUP BY department
ORDER BY avg_salary DESC;

-- 7. Gender distribution
SELECT gender, COUNT(*) AS total
FROM employees
GROUP BY gender;

-- 8. Attrition by gender
SELECT e.gender,
    COUNT(*) AS total,
    SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN a.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate
FROM employees e
JOIN attrition_log a ON e.employeenumber = a.employeenumber
GROUP BY e.gender;