install.packages("ggplot2")

library(ggplot2)

# Add gender labels
male$gender <- "Male"
female$gender <- "Female"

# Combine into one dataframe
combined <- rbind(male[, c("age", "qx", "gender")],
                  female[, c("age", "qx", "gender")])

# Plot mortalit rate by age and gender
ggplot(combined, aes(x = age, y = qx, color = gender)) +
  geom_line(linewidth = 1) +
  labs(title = "Mortality Rate (qₓ) by Age and Gender",
       x = "Age",
       y = "Mortality Rate (qₓ)",
       color = "Gender") +
  theme_minimal()

ggsave("plots/mortality_by_gender.png", width = 8, height = 6)

library(ggplot2)

# Combine male and female data
combined_ex <- rbind(male, female)

# Plot life expectancy by age and gender
ggplot(combined_ex, aes(x = age, y = ex, color = gender)) +
  geom_line(size = 1) +
  labs(
    title = "Life Expectancy (eₓ) by Age and Gender",
    x = "Age",
    y = "Life Expectancy (eₓ)",
    color = "Gender"
  ) +
  theme_minimal()

ggsave("plots/life_expectancy_by_gender.png", width = 8, height = 6)

# Plot lx (number alive) by age and gender
ggplot(combined_ex, aes(x = age, y = lx, color = gender)) +
  geom_line(size = 1) +
  labs(
    title = "Cohort Survivorship (lₓ) by Age and Gender",
    x = "Age",
    y = "Number Alive (lₓ)",
    color = "Gender"
  ) +
  theme_minimal()

ggsave("plots/lx_by_gender.png", width = 8, height = 6)

##### Calculate survival probability #######

male$px <- 1 - male$qx
female$px <- 1 - female$qx

###rebind male and remale datasets with new column #####

male$gender <- "Male"
female$gender <- "Female"
combined_px <- rbind(male, female)

# Plot px (survival probability)
ggplot(combined_px, aes(x = age, y = px, color = gender)) +
  geom_line(size = 1) +
  labs(
    title = "Survival Probability (pₓ) by Age and Gender",
    x = "Age",
    y = "Survival Probability (pₓ)",
    color = "Gender"
  ) +
  theme_minimal()

ggsave("plots/px_by_gender.png", width = 8, height = 6)

# Plot dx (number of deaths) by age and gender
ggplot(combined_ex, aes(x = age, y = dx, color = gender)) +
  geom_line(size = 1) +
  labs(
    title = "Deaths per Age (dₓ) by Gender",
    x = "Age",
    y = "Number of Deaths (dₓ)",
    color = "Gender"
  ) +
  theme_minimal()

ggsave("plots/dx_by_gender.png", width = 8, height = 6)

####################################################################

# Load male and female data from ONSdata folder
male <- read.csv("ONSdata/male.csv")
female <- read.csv("ONSdata/female.csv")

# Load male and female data from ONSdata folder
male <- read.csv("ONSdata/male.csv")
female <- read.csv("ONSdata/female.csv")

######################Present Value Calculation#############################################

# Flat 3% interest rate
i <- 0.03
v <- 1 / (1 + i)

# Function to compute annuity at each age
compute_annuity <- function(lx_vector) {
  n <- length(lx_vector)
  ax <- numeric(n)
  
  for (x in 1:n) {
    surv_probs <- lx_vector[x:n] / lx_vector[x]  # survival probabilities from age x
    discounts <- v ^ (0:(length(surv_probs) - 1))  # discount factors
    ax[x] <- sum(surv_probs * discounts)  # annuity value
  }
  
  return(ax)
}

# Apply to both male and female
male$ax <- compute_annuity(male$lx)
female$ax <- compute_annuity(female$lx)

# Combine data
combined_annuity <- rbind(male, female)

# Plot annuity values by age and gender
ggplot(combined_annuity, aes(x = age, y = ax, color = gender)) +
  geom_line(size = 1) +
  labs(
    title = "Annuity Value by Age and Gender",
    x = "Age",
    y = "Annuity Value (ax)",
    color = "Gender"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    legend.title = element_text(size = 12)
  )

ggsave("plots/ax_by_age.png", width = 8, height = 6)

######################################################################

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

