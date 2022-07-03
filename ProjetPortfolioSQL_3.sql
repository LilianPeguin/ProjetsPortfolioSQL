-------------------------------
Covid 19 Exploration de donnees
-------------------------------

Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4


-- Sélection des données avec lesquels on vas commencer

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 1,2


-- Total des cas vs Total des décès
-- Montre les chance de mourir du covid dans un pays

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
and continent is not null 
order by 1,2


-- Total des cas vs Population
-- Montre quel pourcentage de la population est infecté avec le covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
order by 1,2


-- Pays avec le plus gros ratio d'infection comparé avec le total de la population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- Pays avec le plus gros ratio de décès comparé avec le total de la population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- Continents avec le plus gros ratio de décès comparé avec le total de la population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- Nombres Globaux

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2
