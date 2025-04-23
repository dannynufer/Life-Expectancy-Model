# Cohort Life Expectancy Model

## Most Recent Update:
Created a full actuarial life table in Excel. It calculates survival metrics between ages 0-100. 
The model follows standard actuarial logic and consists of the following columns:

- `qₓ` — Probability of death between age `x` and `x+1`  
- `pₓ` — Probability of survival to age `x+1`  
- `lₓ` — Number of people alive at age `x`  
- `dₓ` — Number of deaths during year `x`  
- `Lₓ` — Person-years lived between age `x` and `x+1`  
- `Tₓ` — Total person-years lived after age `x`  
- `eₓ` — Life expectancy at age `x`

### Simulated Data
The mortality rate `qₓ` was simulated using a custom formula that gradually increases with age. The goal is to eventually use real data


## Tools Used
- Excel
- Python (NumPy, Pandas)

## Status
In Progress — building the Excel framework before translating to Python
