* subnational indicators format

* template:
* here we generate a template for all indicator and outcome areas

* append level codes
import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/L0_CODES.csv, clear 
gen geo_level = 0
tempfile l0
save `l0', replace
import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/L1_CODES.csv, clear 
gen geo_level = 1
append using `l0'
duplicates drop l0_code l0_name l1_code l1_name, force
tempfile l01
save `l01', replace

* vision
* 1. Percentage of population living in poverty (at $3.00/day and $4.20/day)
use `l01', clear
gen indicator = "povline_3.00"
gen indicator_label = "Percentage of population living in poverty (at $3.00/day)"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile povline_300
save `povline_300', replace

use `l01', clear
gen indicator = "povline_4.20"
gen indicator_label = "Percentage of population living in poverty (at $4.20/day)"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile povline_420
save `povline_420', replace

use `l01', clear
gen indicator = "povline_8.30"
gen indicator_label = "Percentage of population living in poverty (at $8.30/day)"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile povline_830
save `povline_830', replace

* 2. Average income shortfall from a prosperity standard of $25/day
use `l01', clear
gen indicator = "prosperity_gap"
gen indicator_label = "Average income shortfall from a prosperity standard of $25/day"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile prosperity_gap
save `prosperity_gap', replace

* 3. Gini
use `l01', clear
gen indicator = "gini"
gen indicator_label = "Gini coefficient"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile gini
save `gini', replace

* 3. Greenhouse gas emissions
use `l01', clear
gen indicator = "total_emission_kt"
gen indicator_label = "Greenhouse gas emissions"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile greehouse_gas
save `greehouse_gas', replace

* 4. Percentage of people at high risk from climate-related hazards
use `l01', clear
gen indicator = "climate_hazards"
gen indicator_label = "Percentage of people at high risk from climate-related hazards"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile climate_hazards
save `climate_hazards', replace

* 5. Hectares of key ecosystems
use `l01', clear
gen indicator = "ecosystems"
gen indicator_label = "Hectares of key ecosystems"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile ecosystems
save `ecosystems', replace

* 6. mpi
use `l01', clear
gen indicator = "mdpoor_i1"
gen indicator_label = "Multidimensional Poverty Index"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi
save `mpi', replace

use `l01', clear
gen indicator = "dep_poor1"
gen indicator_label = "MPI: Poor at $4.2"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_poor
save `mpi_poor', replace

use `l01', clear
gen indicator = "dep_educ_com"
gen indicator_label = "MPI: No adults 15+ with primary completion"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_edu_com
save `mpi_edu_com', replace

use `l01', clear
gen indicator = "dep_educ_enr"
gen indicator_label = "MPI: At least one child not enrolled in school"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_edu_enr
save `mpi_edu_enr', replace

use `l01', clear
gen indicator = "dep_infra_elec"
gen indicator_label = "MPI: No access to electricity"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_elec
save `mpi_elec', replace

use `l01', clear
gen indicator = "dep_infra_imps"
gen indicator_label = "MPI: No access to improved sanitation"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_imps
save `mpi_imps', replace

use `l01', clear
gen indicator = "dep_infra_impw"
gen indicator_label = "MPI: No access to improved drinking water"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile mpi_impw
save `mpi_impw', replace

use `l01', clear
gen indicator = "food_insecurity_v"
gen indicator_label = "Percentage of people facing food and nutrition insecurity"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile food_insecurity_v
save `food_insecurity_v', replace

* 9. Percentage of people with access to basic drinking water
use `l01', clear
gen indicator = "water_v"
gen indicator_label = "Percentage of people with access to basic drinking water"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile drinking_water_v
save `drinking_water_v', replace

* 10. Percentage of people with access to basic sanitation services
use `l01', clear
gen indicator = "sanitation_v"
gen indicator_label = "Percentage of people with access to basic sanitation services"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile sanitation_v
save `sanitation_v', replace

* 11. Percentage of people with access to basic hygiene
use `l01', clear
gen indicator = "hygiene_v"
gen indicator_label = "Percentage of people with access to basic hygiene"
gen outcome_area = "Vision"
gen scorecard_side = "Vision"
tempfile hygiene_v
save `hygiene_v', replace



* client context

* 1. Percentage of people covered by social protection and labor programs in the total population and in the poorest quintile
use `l01', clear
gen indicator = "social_protection_total"
gen indicator_label = "Percentage of people covered by social protection and labor programs in the total population"
gen outcome_area = "Protection for the Poorest"
gen scorecard_side = "Client Context"
tempfile social_protection_total
save `social_protection_total', replace

use `l01', clear
gen indicator = "social_protection_poorest"
gen indicator_label = "Percentage of people covered by social protection and labor programs in the poorest quintile"
gen outcome_area = "Protection for the Poorest"
gen scorecard_side = "Client Context"
tempfile social_protection_poorest
save `social_protection_poorest', replace

* 2. Percentage of children who cannot read by end-of-primary-school age
use `l01', clear
gen indicator = "learning_poverty"
gen indicator_label = "Percentage of children who cannot read by end-of-primary-school age"
gen outcome_area = "No Learning Poverty"
gen scorecard_side = "Client Context"
tempfile learning_poverty
save `learning_poverty', replace

* 3. Percentage of children under five stunted
use `l01', clear
gen indicator = "five_stunted"
gen indicator_label = "Percentage of children under five stunted"
gen outcome_area = "Healthier Lives"
gen scorecard_side = "Client Context"
tempfile five_stunted
save `five_stunted', replace

* Universal health coverage service coverage index (0 - 100)
use `l01', clear
gen indicator = "UHC"
gen indicator_label = "Universal health coverage service coverage index (0 - 100)"
gen outcome_area = "Healthier Lives"
gen scorecard_side = "Client Context"
tempfile UHC
save `UHC', replace

* Economies at high risk of or in debt distress
use `l01', clear
gen indicator = "debt_distress"
gen indicator_label = "Economies at high risk of or in debt distress"
gen outcome_area = "Effective Macroeconomic and Fiscal Management"
gen scorecard_side = "Client Context"
tempfile debt_distress
save `debt_distress', replace

* 4. GDP
use `l01', clear
gen indicator = "total_gdp"
gen indicator_label = "GDP"
gen outcome_area = "Effective Macroeconomic and Fiscal Management"
gen scorecard_side = "Client Context"
tempfile gdp
save `gdp', replace

* 5. Tax revenue
use `l01', clear
gen indicator = "Tax Revenue"
gen indicator_label = "Tax Revenue"
gen outcome_area = "Effective Macroeconomic and Fiscal Management"
gen scorecard_side = "Client Context"
tempfile tax
save `tax', replace

* 6. Percentage of people exposed to hazardous air quality
use `l01', clear
gen indicator = "percent_exposed"
gen indicator_label = "Percentage of people exposed to hazardous air quality"
gen outcome_area = "Green and Blue Planet and Resilient Populations"
gen scorecard_side = "Client Context"
tempfile air_quality
save `air_quality', replace

* 7. Percentage of terrestrial and aquatic areas that are protected
use `l01', clear
gen indicator = "Terrestrial and inland waters protected area coverage"
gen indicator_label = "Percentage of terrestrial and aquatic areas that are protected"
gen outcome_area = "Green and Blue Planet and Resilient Populations"
gen scorecard_side = "Client Context"
tempfile protected_area
save `protected_area', replace

* Economies with increasing renewable natural capital per capita
use `l01', clear
gen indicator = "renewable"
gen indicator_label = "Economies with increasing renewable natural capital per capita"
gen outcome_area = "Green and Blue Planet and Resilient Populations"
gen scorecard_side = "Client Context"
tempfile renewable
save `renewable', replace

* 8. Proportion of fish stocks within biologically sustainable levels
use `l01', clear
gen indicator = "fish_stock"
gen indicator_label = "Proportion of fish stocks within biologically sustainable levels"
gen outcome_area = "Green and Blue Planet and Resilient Populations"
gen scorecard_side = "Client Context"
tempfile fish_stock
save `fish_stock', replace

* 9. Percentage of people with access to basic drinking water
use `l01', clear
gen indicator = "water"
gen indicator_label = "Percentage of people with access to basic drinking water"
gen outcome_area = "Inclusive and Equitable Water and Sanitation Services"
gen scorecard_side = "Client Context"
tempfile drinking_water
save `drinking_water', replace

* 10. Percentage of people with access to basic sanitation services
use `l01', clear
gen indicator = "sanitation"
gen indicator_label = "Percentage of people with access to basic sanitation services"
gen outcome_area = "Inclusive and Equitable Water and Sanitation Services"
gen scorecard_side = "Client Context"
tempfile sanitation
save `sanitation', replace

* 11. Percentage of people with access to basic hygiene
use `l01', clear
gen indicator = "hygiene"
gen indicator_label = "Percentage of people with access to basic hygiene"
gen outcome_area = "Inclusive and Equitable Water and Sanitation Services"
gen scorecard_side = "Client Context"
tempfile hygiene
save `hygiene', replace

* 13. Percentage of people facing food and nutrition insecurity
use `l01', clear
gen indicator = "food_insecurity"
gen indicator_label = "Percentage of people facing food and nutrition insecurity"
gen outcome_area = "Sustainable Food Systems"
gen scorecard_side = "Client Context"
tempfile food_insecurity
save `food_insecurity', replace

* 14. Percentage of people with access to reliable transport solutions all year-round
use `l01', clear
gen indicator = "Rural Access Index"
gen indicator_label = "Percentage of people with access to reliable transport solutions all year-round"
gen outcome_area = "Connected Communities"
gen scorecard_side = "Client Context"
tempfile rai
save `rai', replace

* 15. Percentage of population with access to electricity
use `l01', clear
gen indicator = "electricity"
gen indicator_label = "Percentage of population with access to electricity"
gen outcome_area = "Affordable, Reliable and Sustainable Energy for All"
gen scorecard_side = "Client Context"
tempfile electricity
save `electricity', replace

* 16. Percentage of population using the internet
use `l01', clear
gen indicator = "internet"
gen indicator_label = "Percentage of population using the internet"
gen outcome_area = "Digital Connectivity"
gen scorecard_side = "Client Context"
tempfile internet
save `internet', replace

* 18. Population that own a financial account, total (% population ages 15+) 
use `l01', clear
gen indicator = "financial_account_total"
gen indicator_label = "Population that own a financial account, total (% population ages 15+)"
gen outcome_area = "Gender Equality"
gen scorecard_side = "Client Context"
tempfile financial_account_total
save `financial_account_total', replace

* 19. Population that own a financial account, female (% female population ages 15+)
use `l01', clear
gen indicator = "financial_account_female"
gen indicator_label = "Population that own a financial account, female (% female population ages 15+)"
gen outcome_area = "Gender Equality"
gen scorecard_side = "Client Context"
tempfile financial_account_female
save `financial_account_female', replace

* 20. Wage and salaried workers, total (% total employment)
use `l01', clear
gen indicator = "wage_worker"
gen indicator_label = "Wage and salaried workers, total (% total employment)"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile wage_worker_total
save `wage_worker_total', replace

* 21. Wage and salaried workers, female (% female employment)
use `l01', clear
gen indicator = "wage_worker_female"
gen indicator_label = "Wage and salaried workers, female (% female employment)"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile wage_worker_female
save `wage_worker_female', replace 

* 22. Youth not in education, employment, or training, total (% youth population)
use `l01', clear
gen indicator = "youth_not_in_edu_total"
gen indicator_label = "Youth not in education, employment, or training, total (% youth population)"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile youth_not_in_edu_total
save `youth_not_in_edu_total', replace 

* 23. Youth not in education, employment, or training, female (% female youth population)
use `l01', clear
gen indicator = "youth_not_in_edu_female"
gen indicator_label = "Youth not in education, employment, or training, female (% female youth population)"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile youth_not_in_edu_female
save `youth_not_in_edu_female', replace 

* 24. Forest area (millions of hectares)
use `l01', clear
gen indicator = "forest"
gen indicator_label = "Forest area (millions of hectares)"
gen outcome_area = "Green and Blue Planet and Resilient Populations"
gen scorecard_side = "Client Context"
tempfile forest
save `forest', replace 

* 24. JQI
use `l01', clear
gen indicator = "JQdim420"
gen indicator_label = "Job Quality Index"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile jqi
save `jqi', replace 

use `l01', clear
gen indicator = "INC_420"
gen indicator_label = "JQI: Sufficient Income"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile jqi_inc
save `jqi_inc', replace 

use `l01', clear
gen indicator = "hqBEN"
gen indicator_label = "JQI: Job Benefits"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile jqi_ben
save `jqi_ben', replace 

use `l01', clear
gen indicator = "hqSAT"
gen indicator_label = "JQI: Job Satisfaction"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile jqi_sat
save `jqi_sat', replace 

use `l01', clear
gen indicator = "hqSTA"
gen indicator_label = "JQI: Job Stability"
gen outcome_area = "More and Better Jobs"
gen scorecard_side = "Client Context"
tempfile jqi_sta
save `jqi_sta', replace 

use `l01', clear
gen indicator = "fragile"
gen indicator_label = "Percentage of population in fragile and conflict-affected countries living in extreme poverty"
gen outcome_area = "Better Lives for People in Fragility, Conflict, and Violence"
gen scorecard_side = "Client Context"
tempfile fragile
save `fragile', replace 

use `l01', clear
gen indicator = "displaced"
gen indicator_label = "Number of forcibly displaced people"
gen outcome_area = "Better Lives for People in Fragility, Conflict, and Violence"
gen scorecard_side = "Client Context"
tempfile displaced
save `displaced', replace 

use `l01', clear
gen indicator = "private_investment"
gen indicator_label = "Private investment as a percentage of GDP"
gen outcome_area = "More Private Investment"
gen scorecard_side = "Client Context"
tempfile private_invest
save `private_invest', replace 


* append
use `povline_300', clear 
append using `povline_420'
append using `povline_830'
append using `prosperity_gap'
append using `gini'
append using `greehouse_gas'
append using `climate_hazards'
append using `ecosystems'
append using `mpi'
append using `mpi_poor'
append using `mpi_edu_com'
append using `mpi_edu_enr'
append using `mpi_elec'
append using `mpi_imps'
append using `mpi_impw'
append using `social_protection_total'
append using `social_protection_poorest'
append using `learning_poverty'
append using `five_stunted'
append using `gdp'
append using `tax'
append using `air_quality'
append using `protected_area'
append using `fish_stock'
append using `drinking_water'
append using `sanitation'
append using `hygiene'
append using `food_insecurity'
append using `rai'
append using `electricity'
append using `internet'
append using `financial_account_total'
append using `financial_account_female'
append using `wage_worker_total'
append using `wage_worker_female'
append using `youth_not_in_edu_total'
append using `youth_not_in_edu_female'
append using `forest'
append using `jqi'
append using `jqi_inc'
append using `jqi_ben'
append using `jqi_sat'
append using `jqi_sta'
append using `UHC'
append using `renewable'
append using `debt_distress'
append using `fragile'
append using `displaced'
append using `private_invest'
append using `food_insecurity_v'
append using `drinking_water_v'
append using `sanitation_v'
append using `hygiene_v'





rename sovereign country_wb
rename l0_code level0_code
rename l0_name level0_name
rename l1_code level1_code
rename l1_name level1_name
g level2_code = .
g level2_name = .

tempfile subnat_template
save `subnat_template', replace

g measurement_type = "recent"
append using `subnat_template'
replace measurement_type = "previous" if missing(measurement_type)


save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/subnat_template.dta", replace
