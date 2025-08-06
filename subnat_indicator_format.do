* subnational indicators

clear all

program main
// 	gdp
// 	pov_gini
	wsei
// 	wage_worker
// 	rai
// 	protected_area
// 	tax
// 	mpi
// 	jqi
end 

program gdp
	** GDP+forest+%exposed+emission
	import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/spatial_Indicators_Levels_0_1_2.csv, clear 
	rename sovereign country_wb
	rename l0_code level0_code
	rename l0_name level0_name
	rename l1_code level1_code
	rename l1_name level1_name
	rename l2_code level2_code
	rename variable indicator
	rename var_label indicator_label
	
	gen outcome_area = "Effective Macroeconomic and Fiscal Management" if indicator == "total_gdp"
	replace outcome_area = "Green and Blue Planet and Resilient Populations" if indicator == "forest"
	replace outcome_area = "Green and Blue Planet and Resilient Populations" if indicator == "percent_exposed"
	replace outcome_area = "Vision" if indicator == "total_emission_kt"
	gen scorecard_side = "Client context"
	replace scorecard_side = "Vision" if indicator == "total_emission_kt"
	
	drop if !inlist(year,2019,2022) & inlist(indicator, "total_gdp", "percent_exposed", "total_emission_kt")
	drop if !inlist(year,2015,2020) & indicator == "forest"
	
	measurement_type
	
	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/gdp.dta", replace
end

program pov_gini
	* poverty & inequality subnational 
	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/poverty_gini.xlsx", sheet("Sheet1") firstrow clear
	gen country_wb = Country
	replace Line=round(Line, .01)

	gen indicator = "povline_3.00" if Line == 3.00
	replace indicator = "povline_4.20" if Line == 4.20
	replace indicator = "povline_8.30" if Line == 8.30
	replace indicator = "gini" if Line == 0

	rename Value value
	rename Year year
	rename Aggregation subnatid1
	
	replace value = value * 100 if indicator == "gini"

	fix_geo
	measurement_type

	drop if missing(indicator)
	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/pov_gini.dta", replace
end

program wsei
	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/water_sanitation_elec_int.xlsx", sheet("subnat") firstrow clear
	gen i = _n
	rename imp_wat_rec value1
	rename imp_san_rec value2
	rename electricity value3
	rename internet value4

	reshape long value, i(i) j(j)

	gen indicator = "water" if j == 1
	replace indicator = "sanitation" if j == 2
	replace indicator = "electricity" if j == 3
	replace indicator = "internet" if j == 4
	drop i 

	gen country_wb = countrycode

	replace value = value * 100

	tempfile water_sanitation_elec_int
	save `water_sanitation_elec_int', replace

	* water sanitation electricity internet national

	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/water_sanitation_elec_int.xlsx", sheet("national") firstrow clear
	gen i = _n
	rename imp_wat_rec value1
	rename imp_san_rec value2
	rename electricity value3
	rename internet_acc value4

	reshape long value, i(i) j(j)

	gen indicator = "water" if j == 1
	replace indicator = "sanitation" if j == 2
	replace indicator = "electricity" if j == 3
	replace indicator = "internet" if j == 4

	drop i 
	gen country_wb = countrycode

	replace value = value * 100
	
	append using `water_sanitation_elec_int'
	fix_geo
	measurement_type

	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wsei.dta", replace
	
	keep if inlist(indicator, "water", "sanitation")
	replace indicator = "water_v" if indicator == "water"
	replace indicator = "sanitation_v" if indicator == "sanitation"

	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wsei_v.dta", replace
end

program wage_worker
	* salaried worker subnational + national
	* all
	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/salaried_worker.xlsx", sheet("subnat_all") firstrow clear
	gen country_wb = countrycode
	gen indicator = "wage_worker"

	rename salaried_worker value
	replace value = value * 100

	tempfile salaried_worker_all
	save `salaried_worker_all', replace

	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/salaried_worker.xlsx", sheet("national_all") firstrow clear
	gen country_wb = countrycode
	gen indicator = "wage_worker"

	rename salaried_worker value
	replace value = value * 100

	tempfile salaried_worker_all_nat
	save `salaried_worker_all_nat', replace


	* female
	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/salaried_worker.xlsx", sheet("subnat_female") firstrow clear
	gen country_wb = countrycode
	gen indicator = "wage_worker_female"

	rename salaried_worker value
	replace value = value * 100

	tempfile salaried_worker_female
	save `salaried_worker_female', replace

	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/salaried_worker.xlsx", sheet("national_female") firstrow clear
	gen country_wb = countrycode
	gen indicator = "wage_worker_female"

	rename salaried_worker value
	replace value = value * 100

	append using `salaried_worker_all', force
	append using `salaried_worker_all_nat', force
	append using `salaried_worker_female', force

	cap gen subnatid112 = ""
	cap gen subnatid1112 = ""
	
	fix_geo
	measurement_type
	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/wage_worker.dta", replace

end

program rai
	* rai
	import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/rai_adm0.csv, varnames(1) clear 
	drop outcome_area scorecard_side

	tempfile rai_nat
	save `rai_nat', replace

	import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/rai_adm1.csv, varnames(2) clear 
	drop outcome_area scorecard_side

	* afg
	replace level1_name = "Panjsher" if level1_name == "Panjshir"
	replace level1_name = "Sar-e-Pul" if level1_name == "Sari Pul"

	* bgd
	replace level1_name = "Barishal" if level1_name == "Barisal"
	replace level1_name = "Chattogram" if level1_name == "Chittagong"

	*btn
	replace level1_name = "Trashiyangtse" if level1_name == "Yangtse"

	*ind
	replace level1_name = "Andaman and Nicobar Islands" if level1_name == "Andaman and Nicobar"
	replace level1_name = "Delhi" if level1_name == "NCT of Delhi"

	*npl - set as missing (may take more time to compile - anthony will send later)

	*pak
	replace level1_name = "Azad Jammu and Kashmir" if level1_name == "Azad Kashmir"
	replace level1_name = "Balochistan" if level1_name == "Baluchistan"
	replace level1_name = "Federal Capital Territory" if level1_name == "Islamabad"
	replace level1_name = "Gilgit Baltistan" if level1_name == "Northern Areas"
	replace level1_name = "Khyber Pakhtunkhwa" if level1_name == "N.W.F.P."
	replace level1_name = "Federal Capital Territory" if level1_name == "F.C.T."
	replace level1_name = "Sindh" if level1_name == "Sind"
	
	
	
	cap drop level1_code
	append using `rai_nat', force

	measurement_type

	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/rai.dta", replace

end

program protected_area
	* protected areas
	import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/protectedLand_adm0_from_website.csv, varnames(1) clear 
	tempfile protected_area_nat
	save `protected_area_nat', replace

	import delimited /Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/protectedareas_adm1_export.csv, varnames(2) clear 
	collapse (sum)value, by(country_wb level0_name level1_name indicator indicator_label year)

	* afg
	replace level1_name = "Panjsher" if level1_name == "Panjshir"
	replace level1_name = "Sar-e-Pul" if level1_name == "Sari Pul"
	* bgd
	replace level1_name = "Barishal" if level1_name == "Barisal"
	replace level1_name = "Chattogram" if level1_name == "Chittagong"
	*btn
	replace level1_name = "Trashiyangtse" if level1_name == "Trashi Yangtse"
	replace level1_name = "Samdrupjongkhar" if level1_name == "Samdrup Jongkhar"
	replace level1_name = "Wangduephodrang" if level1_name == "Wangdue Phodrang"
	replace level1_name = "Pemagatshel" if level1_name == "Pema Gatshel"
	replace level1_name = "Wangduephodrang" if level1_name == "Wangdue Phodrang"
	replace level1_name = "Pemagatshel" if level1_name == "Pema Gatshel"
	*ind
	replace level1_name = "Andaman and Nicobar Islands" if level1_name == "Andaman and Nicobar"
	replace level1_name = "Delhi" if level1_name == "NCT of Delhi"
	*pak
	replace level1_name = "Azad Jammu and Kashmir" if level1_name == "Azad Kashmir"
	replace level1_name = "Balochistan" if level1_name == "Baluchistan"
	replace level1_name = "Federal Capital Territory" if level1_name == "Islamabad"
	replace level1_name = "Gilgit Baltistan" if level1_name == "Gilgit-Baltistan"
	replace level1_name = "Khyber Pakhtunkhwa" if level1_name == "Khyber-Pakhtunkhwa"
// 	replace level1_name = "Sind" if level1_name == "Sindh"
	
	*npl
	replace level1_name = "Six" if level1_name == "Karnali"
	replace level1_name = "Seven" if level1_name == "Sudur Paschim"
	replace level1_name = "Two" if level1_name == "Madhesh"
	replace level1_name = "Three" if level1_name == "Bagmati"
	replace level1_name = "One" if level1_name == "Koshi"
	replace level1_name = "Four" if level1_name == "Gandaki"
	replace level1_name = "Five" if level1_name == "Lumbini"
	* missing lka - ask anthony


	append using `protected_area_nat', force
	measurement_type
	drop geo_level

	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/protected_area.dta", replace

end

program tax
	* tax revenue
	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/taxrevenue_adm1.xlsx", sheet("Sheet1") firstrow clear
	collapse (sum) value, by(country_wb level0_code level0_name indicator indicator_label Year)

	drop if Year == .
	drop if country_wb == "LKA"& Year == 2020
	drop if country_wb == "LKA"& Year == 2021
	replace level0_code = "LKA231" if country_wb == "LKA"
	replace level0_code = "IND115" if country_wb == "IND"

	tempfile tax_nat
	save `tax_nat', replace

	import excel "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/taxrevenue_adm1.xlsx", sheet("Sheet1") firstrow clear
	drop if Year == .
	drop if country_wb == "LKA"& Year == 2020
	drop if country_wb == "LKA"& Year == 2021

	replace level1_name = "Delhi" if level1_name == "NCT Delhi"
	replace level1_name = "Jammu and Kashmir" if level1_name == "Jammu & Kashmir"
	replace level1_name = "Eastern" if level1_name == "Eastern Province"
	replace level1_name = "Western" if level1_name == "Western Province"
	replace level1_name = "Northern" if level1_name == "Northern Province"
	replace level1_name = "One" if level1_name == "Koshi"
	replace level1_name = "Three" if level1_name == "Bagmati"
	replace level1_name = "Five" if level1_name == "Lumbini"
	replace level1_name = "Two" if level1_name == "Madesh"
	replace level1_name = "Seven" if level1_name == "Sudurpaschim"
	replace level1_name = "Four" if level1_name == "Gandaki"
	replace level1_name = "Six" if level1_name == "Karnali"

	append using `tax_nat'
	rename Year year
	measurement_type
	drop geo_level

	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/tax.dta", replace
end 

program mpi
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_BGD_2016_pov_420usd_2021PPP.dta", clear
	append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_BTN_2017_pov_420usd_2021PPP.dta"
	append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_LKA_2016_pov_420usd_2021PPP.dta"
	append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_MDV_2016_pov_420usd_2021PPP.dta"
	append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_NPL_2010_pov_420usd_2021PPP.dta"
	append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_PAK_2015_pov_420usd_2021PPP.dta"
	drop if inlist(ID, "Rural", "Urban", "Female", "Male", "0-14 years old", "15-64 years old", "65+ years old")

	foreach v in mdpoor_i1 dep_poor1 dep_educ_com dep_educ_enr dep_infra_elec dep_infra_imps dep_infra_impw {
		preserve
		keep code year ID `v'
		gen component = "`v'"
		rename `v' value
		save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta", replace
		restore
	}
	
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/mdpoor_i1.dta", clear
	foreach v in dep_poor1 dep_educ_com dep_educ_enr dep_infra_elec dep_infra_imps dep_infra_impw {
		append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta"
	}

	replace value = value * 100
	rename component indicator
	gen component = "Multidimensional Poverty Index" if indicator == "mdpoor_i1"
	replace component = "Poor at $4.2" if indicator == "dep_poor1" 
	replace component = "No adults 15+ with primary completion" if indicator == "dep_educ_com" 
	replace component = "At least one child not enrolled in school" if indicator == "dep_educ_enr" 
	replace component = "No access to electricity" if indicator == "dep_infra_elec" 
	replace component = "No access to improved sanitation" if indicator == "dep_infra_imps" 
	replace component = "No access to improved drinking water" if indicator == "dep_infra_impw" 
	
	tempfile mpi_prev
	save `mpi_prev', replace

	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/indicators/MPI_SAR_2022_long.dta", clear
	keep if category == "Subnational" | category == "National"
	drop if ID == " Male"
	gen indicator = "mdpoor_i1" if component == "Multidimensional Poverty Index"
	replace indicator = "dep_poor1" if component == "Poor at $4.2"
	replace indicator = "dep_educ_com" if component == "No adults 15+ with primary completion"
	replace indicator = "dep_educ_enr" if component == "At least one child not enrolled in school"
	replace indicator = "dep_infra_elec" if component == "No access to electricity"
	replace indicator = "dep_infra_imps" if component == "No access to improved sanitation"
	replace indicator = "dep_infra_impw" if component == "No access to improved drinking water"
	
	append using `mpi_prev'

	gen country_wb = code
	gen subnatid1= ID
	
	fix_geo
	measurement_type
	
	replace level1_name = "North Western" if subnatid1 == "6 – North-western" & country_wb == "LKA"
	replace level1_name = "North Central" if subnatid1 == "7 – North-central" & country_wb == "LKA"
	replace level1_name = "North Central" if subnatid1 == "6 - North-western" & country_wb == "LKA"
	replace level1_name = "North Western" if subnatid1 == "7 - North-central" & country_wb == "LKA"
	
	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/mpi.dta", replace
	
end 

program jqi
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/JQI/SAR_JQI.dta", clear
	drop if !inlist(year, 2016, 2022) & countrycode == "BGD"
	drop if !inlist(year, 2019, 2023) & countrycode == "IND"
	drop if !inlist(year, 2019, 2023) & countrycode == "LKA"
	drop if !inlist(year, 2018, 2020) & countrycode == "PAK"
	
	drop if missing(subnatid1)
	collapse (mean) JQdim420 INC_420 hqBEN hqSAT hqSTA [iw=weight], by(countrycode year subnatid1)
	gen country_wb = countrycode
	
	foreach v in JQdim420 INC_420 hqBEN hqSAT hqSTA {
		preserve
		keep countrycode country_wb year subnatid1 `v'
		gen component = "`v'"
		rename `v' value
		save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta", replace
		restore
	}
	
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/JQdim420.dta", clear
	foreach v in INC_420 hqBEN hqSAT hqSTA {
		append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta"
	}
 
	replace value = value * 100 if component != "JQdim420"
	rename component indicator
	gen component = "Job Quality Index" if indicator == "JQdim420"
	replace component = "Sufficient Income ($4.2)" if indicator == "INC_420" 
	replace component = "Job Benefits" if indicator == "hqBEN" 
	replace component = "Job Satisfaction" if indicator == "hqSAT" 
	replace component = "Job Stability" if indicator == "hqSTA" 

	tempfile jqi_subnat
	save `jqi_subnat', replace
	
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/JQI/SAR_JQI.dta", clear
	drop if !inlist(year, 2016, 2022) & countrycode == "BGD"
	drop if !inlist(year, 2019, 2023) & countrycode == "IND"
	drop if !inlist(year, 2019, 2023) & countrycode == "LKA"
	drop if !inlist(year, 2018, 2020) & countrycode == "PAK"
	
	drop if missing(subnatid1)
	collapse (mean) JQdim420 INC_420 hqBEN hqSAT hqSTA [iw=weight], by(countrycode year)
	gen country_wb = countrycode
	
	foreach v in JQdim420 INC_420 hqBEN hqSAT hqSTA {
		preserve
		keep countrycode country_wb year `v'
		gen component = "`v'"
		rename `v' value
		save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta", replace
		restore
	}
	
	use "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/JQdim420.dta", clear
	foreach v in INC_420 hqBEN hqSAT hqSTA {
		append using "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/pov_temp/`v'.dta"
	}


	replace value = value * 100 if component != "JQdim420"
	rename component indicator
	gen component = "Job Quality Index" if indicator == "JQdim420"
	replace component = "Sufficient Income ($4.2)" if indicator == "INC_420" 
	replace component = "Job Benefits" if indicator == "hqBEN" 
	replace component = "Job Satisfaction" if indicator == "hqSAT" 
	replace component = "Job Stability" if indicator == "hqSTA" 
	
	append using `jqi_subnat'
	
	cap gen subnatid112 = ""
	cap gen subnatid1112 = ""
	
	fix_geo
	measurement_type
	save "/Users/sizhen/Library/CloudStorage/OneDrive-Personal/SAR/scorecards/subnat/output/final_indicators/jqi.dta", replace
end 

program fix_geo

	cap drop level0_code
	gen level0_code = ""
	replace level0_code = "AFG1" if country_wb == "AFG"
	replace level0_code = "BGD23" if country_wb == "BGD"
	replace level0_code = "BTN31" if country_wb == "BTN"
	replace level0_code = "IND115" if country_wb == "IND"
	replace level0_code = "MDV154" if country_wb == "MDV"
	replace level0_code = "NPL175" if country_wb == "NPL"
	replace level0_code = "PAK188" if country_wb == "PAK"
	replace level0_code = "LKA231" if country_wb == "LKA"

	cap drop level0_name
	gen level0_name = ""
	replace level0_name = "Afghanistan" if country_wb == "AFG"
	replace level0_name = "Bangladesh" if country_wb == "BGD"
	replace level0_name = "Bhutan" if country_wb == "BTN"
	replace level0_name = "India" if country_wb == "IND"
	replace level0_name = "Maldives" if country_wb == "MDV"
	replace level0_name = "Nepal" if country_wb == "NPL"
	replace level0_name = "Pakistan" if country_wb == "PAK"
	replace level0_name = "Sri Lanka" if country_wb == "LKA"

	split(subnatid1), p(" - ")
	split(subnatid11), p("-")
	split(subnatid111), p(" – ")

	gen level1_name = ""
	replace level1_name = subnatid12
	replace level1_name = subnatid112 if level1_name == ""
	replace level1_name = subnatid1112 if level1_name == ""

	replace level1_name = "Barishal" if level1_name == "Barisal"
	replace level1_name = "Chattogram" if level1_name == "Chittagong"
	replace level1_name = "Chhukha" if level1_name == "Chukha"
	replace level1_name = "Haa" if level1_name == "Ha"
	replace level1_name = "Lhuentse" if level1_name == "Lhuntshi"
	replace level1_name = "Monggar" if level1_name == "Mongar"
	replace level1_name = "Pemagatshel" if level1_name == "Pema Gatshel"
	replace level1_name = "Samdrupjongkhar" if level1_name == "Samdrup Jongkhar"
	replace level1_name = "Trashiyangtse" if level1_name == "Tashi Yangtse" 
	replace level1_name = "Trashiyangtse" if level1_name == "Trashi Yangtse"
	replace level1_name = "Wangduephodrang" if level1_name == "Wangdi Phodrang"
	replace level1_name = "Wangduephodrang" if level1_name == "Wangdue Phodrang"
	replace level1_name = "Andaman and Nicobar Islands" if level1_name == "A & N Island"
	replace level1_name = "Andaman and Nicobar Islands"  if level1_name == "Andaman & Nicober"
	replace level1_name = "Dadra and Nagar Haveli" if level1_name == "D & N Haveli"
	replace level1_name = "Dadra and Nagar Haveli" if level1_name == "Dadra & Nagar Haveli"
	replace level1_name = "Dadra and Nagar Haveli" if level1_name == "Dadra & Nagar Haveli & Daman & Diu"
	replace level1_name = "Dadra and Nagar Haveli" if level1_name == "Dadra and Nagar Haveli and Daman and Diu"
	replace level1_name = "Daman and Diu" if level1_name == "Daman & Diu"
	replace level1_name = "Jammu and Kashmir" if level1_name == "Jammu & Kashmir"

	replace level1_name = "Gujarat" if level1_name == "Gujrat"
	replace level1_name = "Maharashtra" if level1_name == "Maharastra"
	replace level1_name = "Puducherry" if level1_name == "Pondicheri"
	replace level1_name = "Puducherry" if level1_name == "Puduchery"
	replace level1_name = "Uttarakhand" if level1_name == "Uttaranchal"
	replace level1_name = "Uttarakhand" if level1_name == "Uttrakhand"

	replace level1_name = "Central" if level1_name == "Central Province" & country_wb == "LKA"
	replace level1_name = "Eastern" if level1_name == "Eastern Province" & country_wb == "LKA"
	replace level1_name = "North Central" if level1_name == "North Central Province" & country_wb == "LKA"

	replace level1_name = "Northern" if level1_name == "Northern Province" & country_wb == "LKA"
	replace level1_name = "North Western" if level1_name == "North Western Province" & country_wb == "LKA"
	replace level1_name = "North Western" if level1_name == "North-western" & country_wb == "LKA"

	
	replace level1_name = "North Central" if subnatid1 == "7 – North-Central" & country_wb == "LKA"
	replace level1_name = "North Western" if subnatid1 == "6 – North-Western" & country_wb == "LKA"

	replace level1_name = "Sabaragamuwa" if level1_name == "Sabaragamuwa Province"
	replace level1_name = "Southern" if level1_name == "Southern Province"
	replace level1_name = "Uva" if level1_name == "Uva Province"
	replace level1_name = "Western" if level1_name == "Western Province"
	replace level1_name = "Alifu Alifu" if level1_name == "Alif Alif"
	replace level1_name = "Alifu Dhaalu" if level1_name == "Alif Dhaal"
	replace level1_name = "Gaafu Alifu" if level1_name == "Gaafu Alif"
	replace level1_name = "Haa Alifu" if level1_name == "Haa Alif"
	replace level1_name = "Male'" if level1_name == "Male '"
	replace level1_name = "Male'" if level1_name == "Malé"
	replace level1_name = "Seenu" if level1_name == "Seenu/Addu"

	replace level1_name = "Three" if level1_name == "Bagmati"
	replace level1_name = "Two" if level1_name == "Central" & country_wb == "NPL"
	replace level1_name = "One" if level1_name == "Eastern" & country_wb == "NPL"
	replace level1_name = "Five" if level1_name == "Far-west"
	replace level1_name = "Four" if level1_name == "Gandaki"
	replace level1_name = "Six" if level1_name == "Karnali"
	replace level1_name = "One" if level1_name == "Koshi"
	replace level1_name = "Five" if level1_name == "Lumbini"
	replace level1_name = "Two" if level1_name == "Madhesh"
	replace level1_name = "Four" if level1_name == "Mid-west"
	replace level1_name = "One" if level1_name == "Province 1"
	replace level1_name = "Two" if level1_name == "Province 2"
	replace level1_name = "Five" if level1_name == "Province 5"
	replace level1_name = "Seven" if level1_name == "Sudurpaschim"
	replace level1_name = "Seven" if level1_name == "Sudurpashchim"

	replace level1_name = "Three" if level1_name == "Western" & country_wb == "NPL"
	replace level1_name = "Federal Capital Territory" if level1_name == "Islamabad"
	replace level1_name = "Khyber Pakhtunkhwa" if level1_name == "KP"
	replace level1_name = "Khyber Pakhtunkhwa" if level1_name == "Khyber/Pakhtoonkhua"
	
end

program measurement_type
	drop if missing(year)
	egen max_year = max(year), by(country_wb indicator)
	egen min_year = min(year), by(country_wb indicator)

	gen measurement_type = "previous" if year == min_year
	replace measurement_type = "recent" if year == max_year
	

end

main
