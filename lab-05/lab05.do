// ==========================================================================

// SOC 4650/5650 - LAB 05 REPLICATION

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

cd "/VOLUMES/Gox HD/GIS/Labs/week-05/Stata"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using lab05.txt, text replace

// ==========================================================================

/* 
file name - lab05.do

project name -	SOC 4650/5650 - Intro to GISc - Spring 2016
                                                                                 
purpose - Lab 05 Replication
	                                                                               
created - 15 Feb 2016

updated - 15 Feb 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This do-file replicates the Stata portion of Lab-05.
*/

/* 
updates - 

*/

// ==========================================================================

/* 
superordinates  - 
- the baltimoreHomeless.dta file from PS2
*/

/* 
subordinates - 

*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. open data from previous session

use "/Volumes/Gox HD/GIS/Problem Sets/PS2/Stata/baltimoreHomeless.dta"

/* note how I used the full file path -- since the working directory has
already been set to the folder on my drive for this week's lab, I need
to use the full file path to open the previous dataset. This is why it
is helpful to really understand how file paths are constructed. You could
also change the directory to the previous problem set, open the data with
a relative file path, and then change the directory to the lab folder 
and save it. However, I think this is a more cumbersome approach. Either
approach, however, is better than manually copying and pasting the dataset
using Windows Explorer or Apple Finder. */

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. save data

save baltimoreHomeless-v2.dta, replace

/* Note how I reference the new file name as "version 2". Some analysts 
prefer dates, some use version numbers. Pick what works best for you. */

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 3. update dataset documentation

label data "Lab 05 - Baltimore Homeless Services, Version 2"

notes _dta: Dateset updated on 15 Feb 2016 to Version 2
notes _dta : Updated dataset contains new variable names and a new binary ///
	variable representing service type

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. rename variables

rename ïOrganization organization
rename Type type
rename Phone phone
rename Hours hours
rename Men men
rename Women women
rename WomenChildren womenKids
rename Youth youth
rename Families families

notes organization: Variable updated on 15 Feb 2016 by Chris
notes type: Variable updated on 15 Feb 2016 by Chris
notes phone: Variable updated on 15 Feb 2016 by Chris
notes hours: Variable updated on 15 Feb 2016 by Chris
notes men: Variable updated on 15 Feb 2016 by Chris
notes women: Variable updated on 15 Feb 2016 by Chris
notes womenKids: Variable updated on 15 Feb 2016 by Chris
notes youth: Variable updated on 15 Feb 2016 by Chris
notes families: Variable updated on 15 Feb 2016 by Chris

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 5. create a binary indicator for each of the categories in typenum

// there is already a value label in my dataset named 'yesno'
label dir

// first variable - dropin shelters
generate dropin = typeNum
recode dropin 1=1 2/4=0
label variable dropin "Service type, drop-in"
label values dropin yesno

notes dropin: Variable created from typeNum on 15 Feb 2016 by Chris

// second variable - emergency shelters
generate emergency = typeNum
recode emergency 1=0 2=1 3/4=0
label variable emergency "Service type, emergency"
label values emergency yesno

notes emergency: Variable created from typeNum on 15 Feb 2016 by Chris

// third variable - emergency and drop-in shelters
generate emergDrop = typeNum
recode emergDrop 1/2=0 3=1 4=0
label variable emergDrop "Service type, emergency and drop-in"
label values emergDrop yesno

notes emergDrop: Variable created from typeNum on 15 Feb 2016 by Chris

// fourth variable - healthcare services
generate healthcare = typeNum
recode healthcare 1/3=0 4=1
label variable healthcare "Service type, healthcare"
label values healthcare yesno

notes healthcare: Variable created from typeNum on 15 Feb 2016 by Chris

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 6. re-order variables

// move the four spatial variables so that they are after organization
order streetAdd streetSuite x y, after(organization)

// move the new service type variables after typeNum
order dropin emergency emergDrop healthcare, after(typeNum)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 7. create codebook

// create specific log file for codebook
log using baltimoreHomelessData.txt, text replace name(codebook)

// generate codebook
codebook, header notes

// close codebook specific file
log close codebook

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 8. save data again

save baltimoreHomeless-v2.dta, replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
