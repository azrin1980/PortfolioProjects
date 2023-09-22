

Select *
From PortofolioProject..CovidDeaths

Order by 3,4

--Select *
--From PortofolioProject..CovidVaccinations
--Order by 3,4


--Select Data that we are goig to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortofolioProject..CovidDeaths
Order By 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
From PortofolioProject..CovidDeaths
Where location like 'M%sia%'
Order By 1,2



-- Looking at Total Cases vs Total Deaths
-- Show percentage of population that got covid

Select Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
From PortofolioProject..CovidDeaths
Where location like 'M%sia%'
Order By 1,2


--Looking at countries with highest infection rate compared to Population

Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/Population))*100 as PercentPopulationInfected
From PortofolioProject..CovidDeaths
--Where location like 'M%sia%'
Group by Location, population
Order By PercentPopulationInfected desc


--Showing Countries with Highest Death Count per populations

Select Location, Population, Max(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProject..CovidDeaths
--Where location like 'M%sia%'
Where continent is NOT NULL
Group by Location, population
Order By TotalDeathCount desc


Select *
From PortofolioProject..CovidDeaths
Where continent is NOT NULL
Order by 3,4


-- brake down by continent


Select Location, Population, Max(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProject..CovidDeaths
--Where location like 'M%sia%'
Where continent is null
Group by Location
Order By TotalDeathCount desc


--Showing continent with Highest Death count per population 

Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProject..CovidDeaths
--Where location like 'M%sia%'
Where continent is not null
Group by continent
Order By TotalDeathCount desc


--GLOBAL NUMBERS

Select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortofolioProject..CovidDeaths
Where continent is not null
Group By date
Order by 1,2