# Life Expectancy Model

## Overview

This is the beginning of a project to create a comprehensive life expectancy model. This Excel version simulates a cohort life table, calculating key actuarial metrics such as mortality rates, survival probabilities, and life expectancy. It sets the foundation for more advanced actuarial analysis in the future.

## Model Details

- **Cohort size**: 100,000 individuals from age 0  
- **Mortality Rate `qₓ`**: Simulated to gradually increase from age 0 to 100  
- **Survival Probability `pₓ`**: Calculated as `1 - qₓ`  
- **Number Alive `lₓ`**: Tracks the number of people alive at age `x`  
- **Number of Deaths `dₓ`**: Calculated as `lₓ * qₓ`  
- **Person-years Lived `Lₓ`**: Average number of people alive between ages `x` and `x+1`  
- **Total Person Years Remaining `Tₓ`**: Sum of `Lₓ` values from age `x` onward  
- **Life Expectancy `eₓ`**: Calculated as `Tₓ / lₓ`  
- **Annuity Value `aₓ`**: Present value of receiving £1 per year while alive from age `x` onward, using a constant interest rate

## Simulated Data

The mortality rate `qₓ` was simulated using a custom formula that gradually increases with age. The structure allows for easy substitution of real data.

## What I Learned

- Gained hands-on experience with fundamental actuarial functions  
- Applied transferable skills from my economics degree to actuarial tasks  

## Next Steps

- Build Python version (then R)  
- Align with CM1/CS1: Incorporate formulas and methodologies from the CS1 and CM1 syllabus  
- Use real mortality rate data: Replace simulated `qₓ` with real-world data (e.g. from ONS)  
- Annuity product modelling: Expand to simulate different annuity types and payment structures

---

## Python Expansion

This project now includes a fully coded life table and life annuity model written in Python.

### New Features

- Life expectancy (`eₓ`) and annuity value (`aₓ`) calculated recursively  
- Present value of a £1 annuity-due built from survival probabilities and discounting  
- Fully exportable results via CSV  

### Tools Used

- Excel  
- Python (`pandas`)  
