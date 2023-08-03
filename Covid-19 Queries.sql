/*

Queries used for Covid-19 Tableau Project

*/


-- 1. 
-- Total Cases, Deaths and the Death Percentage

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio Project]..['CovidDeaths$']
where continent is not null 
order by 1,2



-- 2. 
-- Total Death Count of Continents
-- World, European Union, International and Income ranges are not included in the above queries and are therefore exluded to stay consistent

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From [Portfolio Project]..['CovidDeaths$']
Where continent is null 
and location not in ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'low income')
Group by location
order by TotalDeathCount desc


-- 3.
-- Percent of Population Infected per Country

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..['CovidDeaths$']
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.
-- Highest Population Infected Globally

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..['CovidDeaths$']
Group by Location, Population, date
order by PercentPopulationInfected desc




