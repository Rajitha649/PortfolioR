
--Data cleaning

--SELECT * 
--FROM ResumePortpolio..CovidDeaths
--WHERE continent is not null
--ORDER BY 3,4

--Select Location, date, total_cases, new_cases, total_deaths, population
--FROM ResumePortpolio..CovidDeaths
--where continent is not null
----ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

--Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From ResumePortpolio..CovidDeaths
--Where location like '%United Kindom%'
--and continent is not null 
--order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

--Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
--From ResumePortpolio..CovidDeaths
----Where location like '%United Kingdopm%'
--order by 1,2


-- Countries with Highest Infection Rate compared to Population

--Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
--From ResumePortpolio..CovidDeaths
----Where location like '%india%'
--Group by Location, Population
--order by PercentPopulationInfected desc

--- Countries with Highest Death Count per Population

--Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
--From ResumePortpolio..CovidDeaths
----Where location like '%states%'
--Where continent is not null 
--Group by Location
--order by TotalDeathCount desc



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

--Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
--From ResumePortpolio..CovidDeaths
----Where location like '%states%'
--Where continent is not null 
--Group by continent
--order by TotalDeathCount desc

--Total Population vs Vaccinations

--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--From ResumePortpolio..CovidDeaths dea
--Join ResumePortpolio..CovidVaccination vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

--by using withclause to get total papulation vs vaccinations

--With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
--as
--(
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--From ResumePortpolio..CovidDeaths dea
--Join ResumePortpolio..CovidVaccination vac
--	On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null 

--)
--Select *, (RollingPeopleVaccinated/Population)*100
--From PopvsVac