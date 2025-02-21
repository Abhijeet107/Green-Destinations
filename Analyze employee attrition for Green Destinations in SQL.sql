create database greendestination ;
use greendestination ;

-- Load & Inspect Data
select * from greendestination limit 10;

-- Calculate Overall Attrition Rate
select count(case when Attrition = 'Yes' then 1 end)*100/count(*)as Attrition_Rate from greendestination ;

-- Attrition by Age Group
SELECT 
    CASE 
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+'
    END AS Age_Group,  
    COUNT(*) AS Total_Employees,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS Attrition_Percentage  
FROM greendestination 
GROUP BY Age_Group  
ORDER BY Attrition_Percentage DESC;

-- Attrition by Years at Company
SELECT 
    YearsatCompany,  
    COUNT(*) AS Total_Employees,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS Attrition_Percentage  
FROM greendestination  
GROUP BY YearsatCompany  
ORDER BY YearsatCompany;

-- Attrition by Income Level
SELECT 
    CASE 
        WHEN MonthlyIncome < 40000 THEN 'Low Income (<40K)'  
        WHEN MonthlyIncome BETWEEN 40000 AND 80000 THEN 'Mid Income (40K-80K)'  
        ELSE 'High Income (>80K)'  
    END AS Income_Level,  
    COUNT(*) AS Total_Employees,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS Attrition_Percentage  
FROM greendestination   
GROUP BY Income_Level  
ORDER BY Attrition_Percentage DESC;

-- Attrition by Department
SELECT  
    Department,  
    COUNT(*) AS Total_Employees,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,  
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS Attrition_Percentage  
FROM greendestination
GROUP BY Department  
ORDER BY Attrition_Percentage DESC;

-- Store Cleaned Data for Tableau
CREATE TABLE cleaned_employee_attrition AS  
SELECT  
    EmployeeNumber,  
    Age,  
    YearsatCompany,  
    MonthlyIncome,  
    Department,  
    Attrition,  
    CASE  
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'  
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'  
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'  
        ELSE '50+'  
    END AS Age_Group,  
    CASE  
        WHEN MonthlyIncome < 40000 THEN 'Low Income (<40K)'  
        WHEN MonthlyIncome BETWEEN 40000 AND 80000 THEN 'Mid Income (40K-80K)'  
        ELSE 'High Income (>80K)'  
    END AS Income_Level  
FROM greendestination;

select * from cleaned_employee_attrition;

