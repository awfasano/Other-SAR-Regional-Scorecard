
use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/subnat_template.dta", clear 
keep if disputed == "D"
tempfile disputed
save `disputed', replace

use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/pov_gini.dta", clear
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/protected_area.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/rai.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/tax.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wage_worker.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wsei.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wsei_v.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/mpi.dta"
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/jqi.dta"


tempfile indicators
save `indicators', replace

use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/subnat_template.dta", clear 
keep if disputed == "ND"
merge 1:1 country_wb level1_name measurement_type indicator using `indicators', keepusing(value year) keep(1 3) nogen
merge 1:1 country_wb level1_name geo_level measurement_type indicator using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/country_indicators.dta", nogen
merge 1:1 country_wb level1_name geo_level measurement_type indicator using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/country_indicators_v.dta", nogen
merge 1:1 country_wb level1_name geo_level measurement_type indicator using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/country_indicators_csc.dta", nogen


append using `disputed'
drop if inlist(indicator,"total_gdp","percent_exposed", "total_emission_kt", "forest")
append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/gdp.dta", force

drop if missing(level0_code)

keep country_wb geo_level level0_code level0_name level1_code level1_name level2_code level2_name disputed outcome_area scorecard_side indicator indicator_label value year measurement_type
order country_wb geo_level level0_code level0_name level1_code level1_name level2_code level2_name disputed outcome_area scorecard_side indicator indicator_label value year measurement_type

recast byte value
export excel using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/SAR_subnational_indicators.xlsx", firstrow(variables) replace

forvalues i = 0(1)2 {
clear
import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/SAR_subnational_indicators.xlsx", sheet("Sheet1") firstrow
keep  if  geo_level==`i'

export delimited using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/SAR_subnational_indicators_ADM`i'.csv", nolabel replace
	
}

// * test
// use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/jqi.dta", clear
// // duplicates tag country_wb level1_name measurement_type indicator, g(dup)
// // keep if dup > 0
// // -
// tempfile indicators
// save `indicators', replace

// use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/subnat_template.dta", clear 
// keep if disputed == "ND"
// merge 1:1 country_wb level1_name measurement_type indicator using `indicators', keepusing(value year) keep(2)
