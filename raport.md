# Analysis of the Impact of Working Hours and Health Status on Trust in Public Institutions – A Regression Discontinuity Approach

## 1. Introduction

This report examines the impact of working hours and health status on the level of trust in public institutions, specifically focusing on trust in the political system (`PW130`). The previous definition of the `trust_index` included trust in the political system, legal system, and police. However, the revised definition now focuses solely on trust in the political system (`PW130`). This adjustment aims to provide a more targeted analysis of political trust as influenced by work-related factors and health status.

The purpose of this study is to investigate the impact of working hours and health status on the level of trust in public institutions, particularly the police. This analysis focuses on identifying whether exceeding a specific working hours threshold (40 hours per week) influences perceived trust in law enforcement, accounting for health status as a potential moderating factor.

### Research Questions:

* Does working more than 40 hours per week affect trust in public institutions?
* How does health status moderate the relationship between working hours and trust in institutions?

### Motivation:

* Trust in public institutions is crucial for social stability.
* Understanding the impact of work-related stress and health conditions on institutional trust can provide insights into broader societal patterns.

---

## 2. Literature Review

* **Angrist & Pischke (2009):** Regression Discontinuity Design as a causal inference tool in social sciences.
* **Lee & Lemieux (2010):** Identifying treatment effects using RDD – application in labor economics.
* **La Ferrara et al. (2012):** The effect of exposure to media on social attitudes and perceptions.

---

## 3. Data and Methodology

### 3.1 Dataset Overview

* **Source:** EU-SILC (EU Statistics on Income and Living Conditions)
* **Year:** 2013
* **Country:** Germany
* **Observations:** 22,041
* **Variables:** 78

### 3.2 Data Preprocessing

* Excluded observations with age above 80.
* Converted string variables to numeric where necessary.
* Generated composite variables:

  * Income (`income`) – sum of cash (`PY010G`) and non-cash income (`PY020G`).
  * Health Score (`health_score`) – based on chronic illness (`PH020`) and limitations (`PH030`).
  * Benefits and Allowances (`benefits_allowances`) – sum of various social benefits.
  * Trust Index (`trust_index`) – average trust in political, legal, and police institutions.
  * Working Hours (`total_hours`) – sum of primary (`PL060`) and additional work hours (`PL100`).
  * Over 40 Hours (`over_40_hours`) – binary variable indicating whether the respondent works more than 40 hours per week.

---

### 3.3 Summary of Key Variables

| Variable                 | Description                                | Observations | Value Range |
| ------------------------ | ------------------------------------------ | ------------ | ----------- |
| **income**               | Total Income (Cash + Non-Cash)             | 21,205       | 0 – 597,560 |
| **health\_score**        | Health Status (1-3 scale)                  | 21,207       | 1 – 3       |
| **trust\_index**         | Average Trust in Political System (0-10)   | 21,906       | 0 – 10      |
| **trust\_group**         | Trust Level (1: Low, 2: Moderate, 3: High) | 21,907       | 1 – 3       |
| **benefits\_allowances** | Total Social Benefits                      | 21,757       | 0 – 135,000 |
| **age**                  | Age in 2013                                | 21,220       | 16 – 80     |
| **over\_40\_hours**      | Binary indicator for working > 40 hours    | 21,907       | 0 – 1       |

| Variable                 | Description                                | Observations | Value Range |
| ------------------------ | ------------------------------------------ | ------------ | ----------- |
| **income**               | Total Income (Cash + Non-Cash)             | 21,205       | 0 – 597,560 |
| **health\_score**        | Health Status (1-3 scale)                  | 21,207       | 1 – 3       |
| **trust\_index**         | Average Trust in Institutions (0-10)       | 21,906       | 0 – 10      |
| **trust\_group**         | Trust Level (1: Low, 2: Moderate, 3: High) | 21,907       | 1 – 3       |
| **benefits\_allowances** | Total Social Benefits                      | 21,757       | 0 – 135,000 |
| **age**                  | Age in 2013                                | 21,220       | 16 – 80     |
| **over\_40\_hours**      | Binary indicator for working > 40 hours    | 21,907       | 0 – 1       |

---

### 3.4 Model Specification

A multinomial logistic regression model was employed to assess the relationship between working hours, health status, and trust in public institutions, categorized as Low, Moderate, and High trust levels.

#### Model Equation:

```
mlogit trust_group c.age c.income c.total_hours i.over_40_hours c.benefits_allowances i.health_score i.employment_status
```

---

### 4. Results

#### 4.1 Multinomial Logistic Regression

* **Number of Observations:** 550
* **Pseudo R²:** 0.0197 (low explanatory power)
* **Overall Model Significance:** LR chi² = 15.33, p = 0.7573

| Variable      | Coefficient | Std. Error | p-value |
| ------------- | ----------- | ---------- | ------- |
| Over 40 hours | 0.6034      | 0.6126     | 0.325   |
| Income        | 2.82e-07    | 7.13e-06   | 0.968   |
| Total Hours   | 0.0077      | 0.0224     | 0.731   |
| Health Score  | -0.7727     | 0.3905     | 0.048   |
| Benefits      | -9.35e-06   | 0.000017   | 0.588   |

* **Significant Variables:**

  * `Health Score (Mild Issues)` negatively affects trust in the political system (p = 0.048).
  * Working over 40 hours per week is not statistically significant in affecting trust in the political system (p = 0.325).

This adjustment in the definition of `trust_index` narrows the interpretation to political trust only, potentially reducing the impact of work-related stress on broader institutional trust.

* **Number of Observations:** 550
* **Pseudo R²:** 0.0197 (very low explanatory power)
* **Overall Model Significance:** LR chi² = 15.33, p = 0.7573

| Variable      | Coefficient | Std. Error | p-value |
| ------------- | ----------- | ---------- | ------- |
| Over 40 hours | 0.6034      | 0.6126     | 0.325   |
| Income        | 2.82e-07    | 7.13e-06   | 0.968   |
| Total Hours   | 0.0077      | 0.0224     | 0.731   |
| Health Score  | -0.7727     | 0.3905     | 0.048   |
| Benefits      | -9.35e-06   | 0.000017   | 0.588   |

* **Significant Variables:**

  * `Health Score (Mild Issues)` negatively affects trust (p = 0.048).

---

### 4.2 Marginal Effects Analysis

| Variable      | dy/dx     | Std. Error | p-value |
| ------------- | --------- | ---------- | ------- |
| Over 40 Hours | 0.1154    | 0.0509     | 0.023   |
| Income        | -3.35e-08 | 4.66e-07   | 0.943   |
| Total Hours   | -0.0005   | 0.0015     | 0.744   |

* Individuals working over 40 hours per week have a **11.54% higher probability** of being in the Low Trust category (p = 0.023). This finding remains significant even after redefining `trust_index` to focus solely on the political system.

| Variable      | dy/dx     | Std. Error | p-value |
| ------------- | --------- | ---------- | ------- |
| Over 40 Hours | 0.1154    | 0.0509     | 0.023   |
| Income        | -3.35e-08 | 4.66e-07   | 0.943   |
| Total Hours   | -0.0005   | 0.0015     | 0.744   |

* Individuals working over 40 hours per week have a **11.54% higher probability** of being in the Low Trust category (p = 0.023).

---

### 4.3 Robustness Checks

* **Hausman Test:** No significant difference between models (`p = 1.000`).
* **Combining Categories:** No significant reason to combine trust categories (`p > 0.60`).

---

### 5. Conclusions and Implications

* Working over 40 hours per week is associated with a higher probability of being in the Low Trust category, specifically in the context of political trust (`PW130`).
* Health status, particularly mild health issues, significantly reduces political trust (p = 0.048).
* Income and social benefits do not significantly affect political trust levels.

### Policy Implications:

* Implement targeted support for overworked and mildly unhealthy individuals to mitigate negative perceptions of the political system.

* Further research is necessary to explore interactions between working hours and health status, especially in relation to broader institutional trust, including legal and police systems.

* Working over 40 hours per week is associated with a higher probability of being in the Low Trust category.

* Health status, particularly mild health issues, significantly reduces trust in institutions.

* Income and social benefits do not significantly affect trust levels.

### Policy Implications:

* Implement targeted support for overworked and mildly unhealthy individuals to mitigate negative perceptions of public institutions.
* Further analysis is warranted to explore long-term effects and potential interactions with socio-economic variables.

---

### 6. STATA Code

```stata

.*-----------------------------------*
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

```

---

Would you like any further refinements or additional sections? 👍🙂
