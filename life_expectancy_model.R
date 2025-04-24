# 1. Generate ages from 0 to 100
age <- 0:100

# 2. Simulate mortality rates
base_qx <- 0.001
qx <- pmin(1, base_qx + 0.0003 + (age^1.7) * 0.00001)

# 3. Create lx vector and initialize the first value
lx <- numeric(length(age)) # This creates a vector of 101 zeros
lx[1] <- 100000 # Set the initial number of lives at age 0

# 4. Loop to fill in lx values
for (i in 2:length(age)) {
  lx[i] <- lx[i - 1] * (1 - qx[i - 1])
}

dx <- lx * qx

lx_next <- c(lx[-1], 0)  # shift lx forward, add 0 at the end
Lx <- (lx + lx_next) / 2

Tx <- rev(cumsum(rev(Lx)))  # reverse, cumsum, reverse again

ex <- Tx / lx

############# Annuity Value ###########

# 1. Set discount rate and compute discount factor
interest_rate <- 0.03
v <- 1 / (1 + interest_rate)

# 2. Initialize annuity column with zeros
ax <- numeric(length(age))

# 3. Backward loop to apply recursion
for (i in length(age):1) {
  if (i == length(age)) {
    ax[i] <- 1  # Final year: only one payment
  } else {
    ax[i] <- 1 + v * (1 - qx[i]) * ax[i + 1]
  }
}

# 4. Add annuity values to the life table
life_table$ax <- round(ax, 2)



life_table <- data.frame(
  age = age,
  qx = round(qx, 5),  #Mortality rate at age x
  lx = round(lx, 2),  #Number Alive at age x
  dx = round(dx, 2),  #Number of Deaths at age x
  Lx = round(Lx, 2),  #Person-years lived at age x
  Tx = round(Tx, 2),  #Total person-years lived after age x
  ex = round(ex, 2)   #Life expectancy at age x
)

head(life_table)


plot(age, dx, type = "l", col = "red", lwd = 2, #Cohort deaths at each age Curve
     xlab = "Age", ylab = "Number of Deaths",
     main = "Cohort Death rate Curve")

plot(age, lx, type = "l", col = "blue", lwd = 2, #Cohort Survival Curve
     xlab = "Age", ylab = "Number Alive",
     main = "Cohort Survival Curve")

plot(age, Lx, type = "l", col = "green", lwd = 2, #Cohort Avg Number Alive Curve
     xlab = "Age", ylab = "Avg Number Alive",
     main = "Avg Number Alive by Age")

plot(age, ex, type = "l", col = "yellow", lwd = 2, #Cohort Life Expectancy Curve
     xlab = "Age", ylab = "Life Expectancy",
     main = "Life Expectancy Curve")

######## ex and ax by age #########

plot(age, ex,
     type = "l",
     col = "yellow",
     lwd = 2,
     ylim = c(0, max(ex)), 
     main = "Life Expectancy vs. Annuity Value",
     xlab = "Age",
     ylab = "Years / Present Value")

# Add ax (annuity value) on top
lines(age, ax,
      type = "l",
      col = "orange",
      lwd = 2)

# legend
legend("topright", legend = c("Life Expectancy (eₓ)", "Annuity Value (aₓ)"),
       col = c("yellow", "orange"), lty = 1, lwd = 2)

write.csv(life_table, "life_table.csv", row.names = FALSE)

