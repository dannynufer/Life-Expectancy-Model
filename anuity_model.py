import pandas as pd #Import pandas library so we can work with dataframes

df = pd.read_csv("mortality_data.csv")# Load the CSV

df["px"] =  1 - df["qx"] #ccreates a new column px which is equal to 1 - qx (survival probability = 1 - mortality rate)

df["dx"] = df["lx"]*df["qx"] #creates a new column dx which is equal to lx * qx (number of deaths in age group x)

df["lx_next"] = df["lx"].shift(-1) # next year's population

df["Lx"] = (df["lx"] + df["lx_next"]) / 2  # average number alive during year x

df["Tx"] = df["Lx"][::-1].cumsum()[::-1] # creates a new column Tx which is the cumulative sum of Lx from the end to the beginning of the dataframe

df["ex"] = df["Tx"] / df["lx"]  # life expectancy at age x = total years / lives

# Set the annual discount rate and compute the discount factor
interest_rate = 0.03
v = 1 / (1 + interest_rate)  # Discount factor

# Create a new column to hold annuity values, initialized to zero
df["ax"] = 0.0

# Loop from the second-last row back to the top
# (we go backwards because each aₓ depends on aₓ₊₁)
for i in reversed(range(len(df) - 1)):
    
    # Apply the recursion formula:
    # aₓ = 1 + v * pₓ * aₓ₊₁
    df.loc[i, "ax"] = 1 + v * df.loc[i, "px"] * df.loc[i + 1, "ax"]

df.to_csv("life_annuity_results.csv", index=False) # Save the results to a new CSV file

print(df.head()) # print the first 5 rows of the dataframe to check the calculations