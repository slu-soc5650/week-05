// ==========================================================================

// SOC 4650/5650 - LECTURE 05

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

cd "/Users/prenercg/Documents/Active"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using lecture05-code.txt, text replace

// ==========================================================================

/* 
file name - lecture05-code.do

project name -	SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lecture 05 Replication
	                                                                               
created - 10 Feb 2016

updated - 10 Feb 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file replicates the commands demonstrated in Lecture 05
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
The census.dta data installed with Stata.
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// open data

// ==========================================================================

sysuse census.dta // open data

save census80Edited.dta, replace // save as new file

// ==========================================================================

// 1 - Renaming Variables

// ==========================================================================

rename state stateStr // rename the variable state to stateStr

rename state2 stateAbbrev // rename the variable state2 to stateAbbrev


// ==========================================================================
// ==========================================================================

// 2 - Review - Creating New Variables

// ==========================================================================

// create a binary variable for states with populations greater than
// 5 million

generate popHigh = .
replace popHigh = 0 if pop < 5000000
replace popHigh = 1 if pop >= 5000000 & pop < .
label variable popHigh "states with populations >= 5mil"
label define yesno 0 no 1 yes
label values popHigh yesno

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create a binary variable for states with populations less than 1 million

generate popLow = .
replace popLow = 0 if pop >= 1000000 & pop < .
replace popLow = 1 if pop < 1000000
label variable popLow "states with populations < 1mil"
label values popLow yesno

// ==========================================================================
// ==========================================================================

// 3 - Recoding Variables

// ==========================================================================

// create a binary variable for states in New England

generate newEngland = region
recode newEngland 1 = 1 2/4 = 0
label variable newEngland "states in New England"
label values newEngland yesno

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create a binary variable for states in the West

generate west = region
recode west 1/3 = 0 4 = 1
label variable west "states in the West"
label values west yesno

// ==========================================================================
// ==========================================================================

// 4 - Creating a Codebook

// ==========================================================================

// create specific log file for codebook
log using census80Edit_codebook.txt, text replace name(codebook)

// generate codebook
codebook, header notes

// close codebook specific file
log close codebook

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit