
--Select location
--From PortfolioProject..CovidDeaths





--Select Location, date, total_cases, new_cases, total_deaths,population
--From PortfolioProject..CovidDeaths
--order by 2 



--Select Location, date, Cast(total_cases as bigint) as TotalCases, Cast(total_deaths as bigint) as TotalDeaths, Cast(total_deaths as bigint)/Cast(total_cases*100 as bigint) as RateOfDeath
--From PortfolioProject..CovidDeaths
--where location like '%Kingdom%'
--order by 2




--Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentageOfPopulationWithCovid
--From PortfolioProject..CovidDeaths
--where location like '%World%'
--order by 1,2 desc



--Select Location, population, Max(cast(total_cases as int)) as HighestInfectionCount, Max((cast(total_cases as int)/population))*100 as PercentagePopulationInfected
--From PortfolioProject..CovidDeaths
--where continent is not null
--	and location = 'india'
--Group by location,population
--order by PercentagePopulationInfected 



--Select Location, Max(cast(total_deaths as int)) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--where continent is not null
--Group by location
--order by TotalDeathCount desc



--Select location, Max(cast(total_deaths as int)) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--where continent is null
--	and location not like '%income'
--Group by location
--order by TotalDeathCount desc




--Select location, population, Max(cast(total_deaths as int)) as TotalDeathCount, Max((total_deaths/population))*100 as PercentageOfPopulationDead
--From PortfolioProject..CovidDeaths
--where continent is null
--	and location not like '%income'
--	and location not like '%union'
--Group by location, population
--order by TotalDeathCount desc




--Select date, Sum(new_cases) as WeeklyTotalCases, Sum(new_deaths) as WeeklyTotalDeaths, Sum(New_deaths)/Sum(New_cases)*100 as TotalDeathPercentage
--From PortfolioProject..CovidDeaths
----where location like '%Kingdom%'
--where continent is not null
--group by date
--Having Sum(New_Cases) > 2
--	and Sum(New_Deaths) > 0
--order by 1




--Select Dth.continent, Dth.location, Dth.date, Dth.population, cast(Vac.new_vaccinations as int) as NewVaccinations
--, Sum(Cast(Vac.new_vaccinations as bigint)) OVER (Partition by Dth.location order by Dth.location, Dth.date) as RollingPeopleVaccinated
----, (Max(RollingPeopleVaccinated)/Dth.population)*100 OVER (Partition by Dth.location)
--From PortfolioProject..CovidDeaths Dth
--join PortfolioProject..CovidVaccinations Vac
--	On Dth.location = Vac.location
--	and Dth.date = Vac.date
--where Dth.continent is not null
--	and Dth.location not like '%income'
--	and Dth.location not like '%union'
--Order by 2,3



--With PopVsVac (Continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated)
--as
--(
--Select Dth.continent, Dth.location, Dth.date, Dth.population, cast(Vac.new_vaccinations as int) as NewVaccinations
--, Sum(Cast(Vac.new_vaccinations as bigint)) OVER (Partition by Dth.location order by Dth.location, Dth.date) as RollingPeopleVaccinated
----, (Max(RollingPeopleVaccinated)/Dth.population)*100 OVER (Partition by Dth.location)
--From PortfolioProject..CovidDeaths Dth
--join PortfolioProject..CovidVaccinations Vac
--	On Dth.location = Vac.location
--	and Dth.date = Vac.date
--where Dth.continent is not null
--	and Dth.location not like '%income'
--	and Dth.location not like '%union'
----Order by 2,3
--)
--Select *, (RollingPeopleVaccinated/population)*100 as PercentagePopulationVaccinated
--From PopVsVac

Select Dth.location, Dth.population, Sum(Dth.new_cases) as TotalCases, Sum(Dth.new_deaths) as TotalDeaths, max(Cast(Vac.people_vaccinated as bigint)) as PeopleVaccinated, Sum(Dth.new_cases)/Dth.Population*100 as PercentageOfPopulationInfected, max(Cast(Vac.people_vaccinated as bigint))/Dth.population*100 as PercentagePopulationVaccinated, Sum(Dth.new_deaths)/Sum(Dth.New_cases)*100 as PercentageOfInfectedDead
From PortfolioProject..CovidDeaths Dth
join PortfolioProject..CovidVaccinations Vac
	on Dth.location = Vac.location
	and Dth.date = Vac.date
where Dth.location like '%income'
Group by Dth.location, Dth.population












--Create View PercentagePopulationVaccinated as
--Select Dth.continent, Dth.location, Dth.date, Dth.population, cast(Vac.new_vaccinations as int) as NewVaccinations
--, Sum(Cast(Vac.new_vaccinations as bigint)) OVER (Partition by Dth.location order by Dth.location, Dth.date) as RollingPeopleVaccinated
----, (Max(RollingPeopleVaccinated)/Dth.population)*100 OVER (Partition by Dth.location)
--From PortfolioProject..CovidDeaths Dth
--join PortfolioProject..CovidVaccinations Vac
--	On Dth.location = Vac.location
--	and Dth.date = Vac.date
--where Dth.continent is not null
--	and Dth.location not like '%income'
--	and Dth.location not like '%union'
----Order by 2,3