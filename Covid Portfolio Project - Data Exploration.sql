/*
Covid 19 Data Exploration 

Skills used: Joins, Temp Tables, Windows Functions, Aggregate Functions, Creating Views

*/

Select Location, date, total_cases, new_cases, total_deaths, population
 From [Portfolio Project]..['CovidDeaths$']
 Where continent is not Null
 order by 1,2



 --Total Cases vs Total Deaths
 -- Shows likelihood of dying of covid in Australia

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS Death_Percentage
 From [Portfolio Project]..['CovidDeaths$']
 where location like 'Australia' and continent is not Null
 order by 1,2



  --Total Cases vs Population
  -- Shows percentage of Australia's population infected with covid

Select Location, date, total_cases, population,(total_cases/population)*100 AS Infection_Percentage
 From [Portfolio Project]..['CovidDeaths$']
 where location like 'Australia' and continent is not Null
 order by 1,2



 -- Countries with Highest Infection Rate compared to Population

 Select Location, Population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_Population_Infected
 From [Portfolio Project]..['CovidDeaths$']
 Where continent is not Null
 Group By Location, Population
 Order By Percent_Population_Infected desc



 -- Countries with Highest Death Count per Population

Select Location, MAX(total_deaths) As Total_Death_Count
 From [Portfolio Project]..['CovidDeaths$']
 Where continent is not Null
 Group By Location
 Order By Total_Death_Count desc



 -- Continents with Highest Death Count

 Select continent, MAX(total_deaths) As Total_Death_Count
 From [Portfolio Project]..['CovidDeaths$']
 Where continent is not Null
 Group By continent
 Order By Total_Death_Count desc



 -- Daily Global Cases and Deaths

 Select date, SUM(new_cases) As Daily_Cases, SUM(new_deaths) As Daily_Deaths
 From [Portfolio Project]..['CovidDeaths$']
 Where continent is not null
 Group By date
 Order By 1,2



 -- Temp Table to perform Calculation on Partition in next query
 Drop Table If Exists #Percent_Population_Vaccinated
 Create Table #Percent_Population_Vaccinated (
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 New_Vaccinations numeric,
 Total_Vaccinated numeric
)



 -- Total Population vs Vaccinations
 -- Shows percentage of population that have been administered atleast one covid vaccine

 insert into #Percent_Population_Vaccinated
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
 Sum(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) As Total_Vaccinated
 From [Portfolio Project]..['CovidDeaths$'] dea
 Join [Portfolio Project]..['CovidVacinations$'] vac
	on dea.location = vac.location
	and dea.date = vac.date
 Where dea.continent is not null



 -- Percentage of Population Vaccinated

 Select *, (Total_Vaccinated/Population)*100 As Vaccination_Percentage
 From #Percent_Population_Vaccinated



 -- Create a View for Percent of Population Vaccinated
 
 Create View Percent_Population_Vaccinated as
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
 Sum(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) As Total_Vaccinated
 From [Portfolio Project]..['CovidDeaths$'] dea
 Join [Portfolio Project]..['CovidVacinations$'] vac
	on dea.location = vac.location
	and dea.date = vac.date
 Where dea.continent is not null