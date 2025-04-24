# Life Expectancy & Annuity Model

## Overview

This project shows the development of a cohort life table and associated annuity values from **Excel** to **Python** and finally to **R**.
This is foundational work that serves as a launchpad for future actuarial and data-driven projects.

---

## Model Summary

- **Cohort size**: 100,000 individuals from age 0  
- **Mortality Rate (`qₓ`)**: Simulated to gradually increase with age  
- **Survival Probability (`pₓ`)**: `1 - qₓ`  
- **Alive at age x (`lₓ`)**: Survivors at each age  
- **Deaths (`dₓ`)**: `lₓ * qₓ`  
- **Person-years (`Lₓ`)**: Approximate average alive between ages `x` and `x+1`  
- **Cumulative years (`Tₓ`)**: Total years remaining at age `x`  
- **Life Expectancy (`eₓ`)**: `Tₓ / lₓ`  
- **Annuity Value (`aₓ`)**: Present value of £1 per year while alive from age `x`, discounted assuming constant interest rate

---

## Versions

### Excel Model (Version 1)

- Intuitive spreadsheet version of a life table  
- Step-by-step calculation of each column  
- Embedded annuity value model
- Used for practicing the basic logic of the model  
- Download: [`Excel-model/Life Expectancy and Annuity Model (Excel).xlsx`](./Excel-model/Life%20Expectancy%20and%20Annuity%20Model%20(Excel).xlsx)

---

### Python Model (Version 2)

- Uses `pandas` to compute all life table functions  
- Recursive logic for annuity value (`aₓ`)  
- CSV outputs for life expectancy and annuity results  
- Code: [`Python-model/anuity_model.py`](./Python-model/anuity_model.py)  
- Plot: [`Python-model/plot_life_annuity.py`](./Python-model/plot_life_annuity.py)  (Not yet complete)
- Outputs: [`CSV Outputs/`](./CSV%20Outputs/)

---

### R Model (Version 3)

- Utilizes ONS life tables for males and females 
- Calculates annuity values (assuming a fixed interest rate)
- Visualized gender-based mortality, life expectancy, and annuity differentials 
- Code: [`r-model/life_expectancy_model.R`](./r-model/life_expectancy_model.R)
- Outputs: [`CSV Outputs/`](./CSV%20Outputs/)

---

## What I Learned

- Developed a solid understanding of life table mechanics  
- Practiced recursion, present value concepts, and cohort tracking  
- Applied tools from my economics degree to actuarial modelling  
- Gained practical experience in R, Python, and Excel simultaneously  

---

## Next Steps

- Use real mortality data (ONS or similar)  
- Expand annuity modelling to include different product structures  
- Build interactive dashboards or web-based demos  
- Integrate with actuarial syllabus content (CM1, CS1)  

---

## Tools Used

- **Excel**  
- **Python**: `pandas`, `matplotlib`  
- **R**: Base R, `ggplot2` (optional for plotting)  

---
