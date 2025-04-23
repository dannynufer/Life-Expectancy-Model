#Life Expectancy Model

## Overview:
This is the beginning of a project to create a comprehensive life expectancy model. This excel version simulates a cohort life table, calculating key actuarial metrics such as mortality rates, survival probabilities, and life expectancy. It sets the foundation for more advanced actuarial analysis in the future.

## Model Details: 

- Cohort size: 100,000 individuals from age 0
- Mortality Rate `qₓ`: Simulated to gradually increase from age 0 till age 100  
- Survival Probability`pₓ`: Calculated as 1 - `qₓ`
- Number Alive `lₓ`: Tracks the number of people alive at age `x`  
- Number of Deaths `dₓ`: Determined by `lₓ * qₓ`
- Person-years Lived `Lₓ`:  Average number of people alive between ages `x` and `x+1`   
- Total Person Years Remaining `Tₓ`: Sum of `Lₓ` from age `x` until the end of the table (age 100)
- Life Expectancy `eₓ`: Calculated as `Tₓ / lₓ`
- Annuity Value `aₓ`: Present value of receiving £1 per year while alive from age `x` onward (life annuity) considering a constant interest rate

### Simulated Data
The mortality rate `qₓ` was simulated using a custom formula that gradually increases with age. The structure allows for easy substitution of real data.

## What I Learned
- Gained hands-on experience with fundamental actuarial functions.
- Applied transferrable skills from my economics degree to actuarial tasks.
  
## Next Steps:
- **Build Python Version** (then R).
- **Align with CM1/CS1:** Align model with actuarial exam standards, incorporating formulas and methodologies from the CS1 and CM1 Syllabus.
- **Use real mortality rate data:** Replace the simulated mortality rates with real-world data from sources such as the ONS.
- **Annuity Product Modelling:** Expand the model to simulate different annuity products, considering payment structures and interest scenarios.

## Tools Used
- Excel
- (Planned) Python `NumPy`, `Pandas`, `matplotlib`

## File Access
[Download the Excel Model](./Life%20Expectancy%20and%20Annuity%20Model%20(Excel).xlsx)
