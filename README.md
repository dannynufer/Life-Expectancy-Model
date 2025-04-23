# Life Expectancy and Annuity Model (Python)

This is a Python-based implementation of a cohort life table and life annuity valuation model. It replicates key actuarial functions, commonly used in CM1/CS1, using simulated mortality data.

## Features

- Calculates:
  - Survival probabilities (`pₓ`)
  - Death counts (`dₓ`)
  - Person-years lived (`Lₓ`)
  - Total future person-years (`Tₓ`)
  - Life expectancy (`eₓ`)
  - Annuity values (`aₓ`) via recursion:  
    \[
    aₓ = 1 + v \cdot pₓ \cdot a_{x+1}
    \]

- Exportable to CSV
- Compatible with substitution of real mortality data

## Tools Used

- Python 3.11
- `pandas` for DataFrame manipulation
- Excel (for initial modeling)

## Discount Rate

The annuity model assumes a constant annual effective interest rate of 3%:

\[
v = \frac{1}{1.03}
\]

## Files

- `mortality_data.csv`: Simulated mortality table input
- `annuity_model.py`: Python script containing all logic and recursive computation
- `life_annuity_results.csv`: Output file with all columns including `eₓ` and `aₓ`

## Next Steps

- Incorporate real ONS or insurance data
- Extend to temporary annuities and assurances
- Port model to R (CS1-aligned)

---

This model supports the development of core actuarial programming skills and aligns with the structure of CM1/CS1 exam methodology.
