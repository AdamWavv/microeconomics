*-----------------------------------*
*   WGRYWANIE DANYCH   *
*-----------------------------------*

import excel "/Users/aleksandra/Downloads/Mikroekonometria/DE_oczyszczone_2013_personal_final.xlsx", sheet("DE_2013p_EUSILC") firstrow clear


*-----------------------------------*
*   ANALIZA DANYCH - PRZYGOTOWANIE ZMIENNYCH  *
*-----------------------------------*

* Struktura danych
describe

* Wyświetlenie pierwszych 5 rekordów
list in 1/5

* Sprawdzenie brakujących wartości
misstable summarize

* Sprawdzenie unikalnych wartości dla kluczowych zmiennych
tabulate PB150  // Płeć
tabulate PB190  // Stan cywilny


*-----------------------------------*
*   TWORZENIE ZMIENNYCH KOMPOZYTOWYCH   *
*-----------------------------------*

* Wiek
gen age = PB110 - PB140
label var age "Wiek w 2013 roku"
keep if age <= 80

* Grupa wiekowa
gen age_group = .
replace age_group = 1 if age < 30
replace age_group = 2 if age >= 30 & age < 67
replace age_group = 3 if age >= 67
label define age_grp 1 "Young Adults" 2 "Adults" 3 "Seniors"
label values age_group age_grp

* Dochód
gen income = PY010G + PY020G
label var income "Cash and Non-Cash Income"
keep if income >= 0
summarize income
histogram income, normal

* Zasiłki i świadczenia
* Sprawdzenie typu danych przed utworzeniem zmiennej

describe PY090 PY100G PY110G PY120G

* Konwersja do typu numerycznego (jeśli potrzebna)
destring PY090 PY100G PY110G PY120G, replace force

* Tworzenie zmiennej benefits_allowances
gen benefits_allowances = PY090 + PY100G + PY110G + PY120G
label var benefits_allowances "Benefits and Allowances"
keep if benefits_allowances >= 0

* Godziny pracy
gen total_hours = PL060 + PL100
label var total_hours "Total Hours Worked"
gen over_40_hours = (total_hours > 40)
label define over40 0 "40 hours or less" 1 "Over 40 hours"
label values over_40_hours over40

* Zdrowie
gen health_score = .
replace health_score = 3 if PH020 == 1 & PH030 == 1
replace health_score = 2 if (PH020 == 1 & PH030 != 1) | (PH030 == 2)
replace health_score = 1 if PH020 == 2 & PH030 == 3
label define health_lbl 1 "No Health Issues" 2 "Mild Issues" 3 "Severe Issues"
label values health_score health_lbl

* Status zatrudnienia
gen employment_status = PL040
replace employment_status = 1 if PL040 == 0 & PL020 == 1
replace employment_status = 2 if PL040 == 0 & PL015 == 1
label define emp_status 0 "Employed" 1 "Actively Seeking" 2 "Never Worked"
label values employment_status emp_status

* Zaufanie
mvdecode PW130, mv(99)
egen trust_index = rowmean(PW130)
label var trust_index "Average Trust Index"
gen trust_group = .
replace trust_group = 1 if trust_index < 3
replace trust_group = 2 if trust_index >= 3 & trust_index <= 7
replace trust_group = 3 if trust_index > 7
label define trust_lbl 1 "Low Trust" 2 "Moderate Trust" 3 "High Trust"
label values trust_group trust_lbl


*-----------------------------------*
*   ANALIZA DANYCH - REGRESJA LOGITOWA   *
*-----------------------------------*

* Flaga danych kompletnych
capture drop to_use
gen to_use = !missing(age_group, income, health_score, employment_status, trust_index)

* Lista zmiennych do modelu
global xvars "c.age c.income c.total_hours i.over_40_hours c.benefits_allowances i.health_score i.employment_status"

* Model wielomianowy logitowy
mlogit trust_group $xvars if to_use, baseoutcome(1)
est store ml1


*-----------------------------------*
*   TESTY ISTOTNOŚCI   *
*-----------------------------------*

test c.age  
test c.income
test c.total_hours
test c.benefits_allowances

test [2]1.over_40_hours = [3]1.over_40_hours


*-----------------------------------*
*   POŁĄCZENIE KATEGORII   *
*-----------------------------------*

*ssc install spost13_ado
mlogtest, combine


*-----------------------------------*
*   TESTY NIEZALEŻNOŚCI ALTERNATYW   *
*-----------------------------------*

mlogit trust_group $xvars if to_use & trust_group != 3, baseoutcome(1)
est store ml2
hausman ml1 ml2, alleqs constant


*-----------------------------------*
*   INTERPRETACJA WSPÓŁCZYNNIKÓW   *
*-----------------------------------*

*esttab ml1, eform nobase unstack


*-----------------------------------*
*   EFEKTY KRAŃCOWE   *
*-----------------------------------*

margins , dydx(income total_hours benefits_allowances)
margins, at(over_40_hours = (0 1))
marginsplot, plotdimension(over_40_hours)


