/*
Queries used for Global Video Game Sales Tableau Project

*/

Select * 
FROM [Portfolio Project].dbo.VgSales 
Where Year Is Not Null 
Order By 1



-- 1.
-- Total Video Game Sales for Each Region

Select SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales
Where Year Is Not Null 
Order By 1



-- 2.
-- Total Video Game Sales for Each Publisher

Select Publisher, SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Where Year Is Not Null 
Group By Publisher
Order By 6 desc



-- 3.
-- Total Video Game Sales for Each Platform

Select Platform, SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Where Year Is Not Null 
Group By Platform
Order By 6 desc



-- 4.
-- Total Video Game Sales for the Top 10 Best Selling Platforms


With top10 As
    (Select TOP(10) platform, SUM(Global_Sales)*1000000 AS Total_Global_Sales
    FROM [Portfolio Project].dbo.VgSales 
	Where Year Is Not Null 
	Group By platform
	Order By 2 desc)

Select *
from top10
Union all
Select 'All other' as platform, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Where platform not in
        (select platform
        from top10)
		AND Year Is Not Null 



-- 5.
-- Best Selling Video Game Genres

Select Genre, SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Where Year Is Not Null 
Group By Genre
Order By 6 desc



-- 6.
-- Total Video Game Sales for Each Year

Select Year, SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Where Year Is Not Null 
Group By Year
Order By 1 desc



-- 7.
-- Best Selling Game of Each Region

Select Name, SUM(NA_Sales)*1000000 As Total_NA_Sales, SUM(EU_Sales)*1000000 As Total_EU_Sales, SUM(JP_Sales)*1000000 As Total_JP_Sales, 
		SUM(Other_Sales)*1000000 As Total_Other_Sales, SUM(Global_Sales)*1000000 AS Total_Global_Sales
FROM [Portfolio Project].dbo.VgSales 
Group By Name
Order By 6 desc

