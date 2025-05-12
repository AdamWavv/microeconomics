# Analysis of the Impact of Working Hours and Health Status on Trust in Public Institutions – A Regression Discontinuity Approach

## 1. Introduction

The purpose of this study is to investigate the impact of working hours and health status on the level of trust in public institutions, particularly the police.  
This analysis focuses on identifying whether exceeding a specific working hours threshold (e.g., 40 hours per week) influences perceived trust in law enforcement, accounting for health status as a potential moderating factor.

### Research Questions:
- Does working more than 40 hours per week affect trust in the police?
- How does health status moderate the relationship between working hours and trust in the police?

### Motivation:
- Trust in public institutions is crucial for social stability.
- Understanding the impact of work-related stress and health conditions on institutional trust can provide insights into broader societal patterns.

---

## 2. Literature Review

- **Angrist & Pischke (2009):** Regression Discontinuity Design as a causal inference tool in social sciences.
- **Lee & Lemieux (2010):** Identifying treatment effects using RDD – application in labor economics.
- **La Ferrara et al. (2012):** The effect of exposure to media on social attitudes and perceptions.

---

### **3. Data Analysis**

---

### **3.1 Data Source and Structure**

The dataset utilized in this analysis is derived from the **EU Statistics on Income and Living Conditions (EU-SILC)**, a comprehensive dataset provided by **Eurostat**. It includes data on income, living conditions, health, and social inclusion for various European Union member states.

* **Data Year:** 2013
* **Target Country:** Germany
* **Number of Observations:** 22,041
* **Number of Variables:** 78

The dataset provides both cross-sectional and longitudinal data, allowing for comprehensive socio-economic analysis. Data was pre-processed and cleaned to ensure consistency and reduce missing values, as detailed in the subsequent sections.

---

### **3.2 Selected Variables and Their Definitions**

Data used in this study was structured into five key categories: demographic, employment, health, financial, and trust-related variables. The specific variables included in the analysis are as follows:

#### **3.2.1 Demographic Variables (`demo`):**

* **PB040** – Personal cross-sectional weight (Weighting variable for individuals aged 16 and over).
* **PB120** – Time spent completing the personal questionnaire (in minutes).
* **PB140** – Year of birth (used to calculate age).
* **PB150** – Sex (1 = Male, 2 = Female).
* **PB190** – Marital status (1 = Single, 2 = Married, etc.).
* **PE010** – Participation in formal education or training (1 = Yes, 2 = No).
* **PL031** – Self-defined current economic status (1 = Employed, 2 = Unemployed, etc.).

---

#### **3.2.2 Employment Variables (`work`):**

* **PL015** – Has ever worked (1 = Yes, 2 = No).
* **PL020** – Actively looking for a job (1 = Yes, 2 = No).
* **PL040** – Employment status (1 = Employed, 2 = Unemployed, etc.).
* **PL060** – Hours worked per week in the main job.
* **PL100** – Hours worked per week in additional jobs.
* **PL140** – Type of contract (1 = Permanent, 2 = Temporary).
* **PL150** – Supervisory responsibility in the main job (1 = Yes, 2 = No).
* **PL190** – Start of the first regular job (year).

---

#### **3.2.3 Health Variables (`health`):**

* **PH010** – Self-perceived general health (1 = Very good, 5 = Very bad).
* **PH020** – Chronic illness (1 = Yes, 2 = No, -1 = Missing).
* **PH030** – Limitation in activities due to health problems (1 = Strongly limited, 2 = Limited, 3 = Not limited).
* **PH040** – Unmet need for medical examination or treatment (1 = Yes, 2 = No).
* **PH070** – Unmet need for dental examination or treatment (1 = Yes, 2 = No).

---

#### **3.2.4 Financial Variables (`finance`):**

* **PY010G** – Cash income (in Euros).
* **PY020G** – Non-cash income (in Euros).
* **PY090G** – Unemployment benefits (in Euros).
* **PY100G** – Old-age benefits (in Euros).
* **PY120G** – Sickness benefits (in Euros).

---

#### **3.2.5 Trust and Well-being Variables (`trust`):**

* **PW010** – Overall life satisfaction (1 = Very satisfied, 5 = Not satisfied).
* **PW130** – Trust in the political system (0-10 scale, 99 = Missing).
* **PW140** – Trust in the legal system (0-10 scale, 99 = Missing).
* **PW150** – Trust in the police (0-10 scale, 99 = Missing).
* **PW190** – Trust in others (0-10 scale).

---

### **3.3 Data Preprocessing and Cleaning**

The data underwent extensive preprocessing to ensure consistency and remove missing values. The steps are outlined below:

#### **3.3.1 Handling Missing Data:**

* Numerical variables were imputed with the **median value**.
* Categorical variables were imputed with the **mode**.
* Missing values coded as `-1` or `99` in the dataset were recoded as missing (`.`) to align with STATA standards.

```stata
* Convert missing values for trust variables to missing (.)
mvdecode PW130 PW140 PW150, mv(99)
```

---

#### **3.3.2 Generated Composite Variables:**

Several composite variables were created to streamline the analysis:

* **Income (`income`):** Sum of cash and non-cash income:

```stata
gen income = PY010G + PY020G
```

* **Health Score (`health_score`):**

  * 1 = No health issues (`PH020 = 2` and `PH030 = 3`)
  * 2 = Mild health issues (`PH020 = 1` or `PH030 = 2`)
  * 3 = Severe health issues (`PH020 = 1` and `PH030 = 1`)

```stata
gen health_score = .
replace health_score = 1 if PH020 == 2 & PH030 == 3
replace health_score = 2 if PH020 == 1 | PH030 == 2
replace health_score = 3 if PH020 == 1 & PH030 == 1
```

* **Trust Index (`trust_index`):**

  * Calculated as the mean of trust in political, legal, and police institutions.

```stata
egen trust_index = rowmean(PW130 PW140 PW150)
```

---

#### **3.3.3 Distribution Analysis and Visualizations:**

**a) Distribution of Income (`income`):**

```stata
histogram income, normal title("Income Distribution")
```

**b) Distribution of Trust Index (`trust_index`):**

```stata
histogram trust_index, bin(20) normal title("Trust Index Distribution")
```

**c) Distribution of Work Hours (`total_hours`):**

```stata
histogram total_hours, normal title("Total Hours Worked Distribution")
```

---

### **3.4 Summary Statistics for Key Variables:**

| Variable      | Obs    | Mean      | Std. Dev. | Min | Max     |
| ------------- | ------ | --------- | --------- | --- | ------- |
| income        | 22,023 | 16,027.04 | 24,244.27 | 0   | 597,560 |
| health\_score | 21,770 | 4.66      | 1.84      | 2   | 16      |
| trust\_index  | 22,041 | 5.34      | 2.43      | 0   | 10      |
| total\_hours  | 22,041 | 38.65     | 11.27     | 0   | 80      |

---

### **3.5 Income Analysis by Trust Group:**

```
. tabstat income, by(trust_group) statistics(mean sd min max)
```

```
trust_group |      Mean        SD       Min       Max
------------+----------------------------------------
   Low Trust |   16121.4  22053.51         0  175235.3
Moderate Trust |  16032.97  24493.94         0  583868.5
   High Trust |   15966.5  23893.62         0    597560
------------+----------------------------------------
      Total |  16027.04  24244.27         0    597560
-----------------------------------------------------
```

---

### **3.6 Summary and Next Steps:**

* Data was successfully cleaned and preprocessed, resulting in 22,041 observations and 78 variables.
* Key composite variables (`income`, `trust_index`, `health_score`) were generated to facilitate regression analysis.
* Distributions were visualized to assess data skewness and potential outliers.
* The next step involves implementing regression models to assess the impact of overwork, income, and health on trust in public institutions.

---

## 4. Methodology

### 4.1 Regression Discontinuity Design (RDD)

- Assignment variable: Working hours (binary threshold: 40 hours).
- Treatment group: Individuals working more than 40 hours per week.
- Control group: Individuals working 40 hours or less.

### 4.2 RDD Equation

\[
Y_i = \alpha + \tau D_i + \gamma X_i + \epsilon_i
\]

Where:  
- \( Y_i \) – Trust in police (`PW150`)  
- \( D_i \) – Treatment indicator (`over_40_hours`)  
- \( X_i \) – Covariates (`PH020`, `PH030`, `PB150`, `PB190`)  
- \( \tau \) – Treatment effect (working more than 40 hours)  
- \( \gamma \) – Effect of control variables

---

## 5. Results

### 5.1 Descriptive Statistics

| Variable | Mean | Std. Dev. | Min | Max |
|----------|------|-----------|-----|-----|
| Working hours | XX | XX | 0 | 80 |
| Trust in police | XX | XX | 1 | 10 |
| Chronic illness | XX | XX | 0 | 1 |

---

### 5.2 RDD Estimation Results

| Variable        | Coefficient | Std. Error | p-value |
|-----------------|-------------|------------|---------|
| Over 40 hours   | XX          | XX         | XX      |
| Chronic illness | XX          | XX         | XX      |
| Gender          | XX          | XX         | XX      |
| Marital status  | XX          | XX         | XX      |

---

### 5.3 Robustness Checks

- Checking for potential manipulation of the running variable (`working hours`).
- Assessing heterogeneity of treatment effects by gender and health status.

---

## 6. Conclusion

- Summary of key findings:
  - The impact of excessive working hours on trust in police is statistically significant/insignificant.
  - Health status moderates the relationship, with chronic illness amplifying/reducing the effect of working hours.

- Policy implications:
  - Potential need for work-hour regulations to mitigate trust erosion in public institutions.
  - Interventions targeting health support in high-stress occupations.

- Suggestions for further research:
  - Exploring other public institutions (e.g., legal system, government).
  - Analysis over multiple years to capture long-term effects.

---

## 7. STATA Code

```stata
* Import data
use "path_to_data.dta", clear

* Generate treatment variable
gen over_40_hours = (PL060 + PL100) > 40

* Regression Discontinuity Design
rddreg PW150 over_40_hours PH020 PH030 PB150 PB190, cutoff(40)

* Display results
reg PW150 over_40_hours PH020 PH030 PB150 PB190

* Export graph
estat trendplots
graph export "rdd_analysis.svg", replace
