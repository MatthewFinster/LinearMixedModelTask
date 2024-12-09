### Add packages we use in Assignment

library("tidyverse")
library("plyr")
library("ggplot2")
library("nlme")
library("xtable")
library("multcomp")

###################################################################################################################################################################################

### 1. Graphical analysis

## Reading the csv

setwd("C:/Users/anais/OneDrive/Bureau/Matt/Etudies/STA5ARM/Assessment 2 (Assignment) folder-20240321")
Cognitive <- read.csv("Cognitive.csv")
View(Cognitive)

## Means of combinations of Race (Race), type of Word (W) and type of Cue condition (C)
means <- ddply(Cognitive,.(Race, W, C), summarize, mean_T = mean(T))
print(means)

## Plotting Figure 1
plot <- ggplot(data = means, aes(x = factor(W), y = mean_T, colour = factor(C))) +
  geom_point(aes(colour = factor(C))) +
  geom_line(aes(group = factor(C), colour = factor(C))) +
  facet_grid(. ~ Race ) +
  labs(x = "W", y = "T_mean", colour = "C")
print(plot)

##############################################################################################################################################################

#### 3. Diagnostics of the final linear mixed model

## Fit Model 1 using REML.

Model1 <- lme(T ~ W + C + R2 + R3 + W:C + W:R2 + W:R3 + C:R2 + C:R3 + W:C:R2 + W:C:R3, 
             random = ~ 1 + C | Adult, weights = varIdent(form = ~ 1 | C),
            method = "REML", data = Cognitive)

## Checking the agreement between the predicted marginal values of T and the observed mean 
## values of T as a function of W, grouped by C and Race

# Generating the predicted marginal values of T
Cognitive <- mutate(Cognitive, Marg_T_values = fitted(Model1, level = 0))
View(Cognitive)

# Figure 2: Plot of the predicted marginal values of T and the observed mean values of T 
# as a function of W, grouped by C and Race

plot2 <- ggplot(data = Cognitive, aes(x = factor(W), y = Marg_T_values, colour = factor(C))) +
  geom_point(aes(colour = factor(C)), size = 8, shape = 22) +
  geom_point(data = means, aes(x = factor(W), y = mean_T, colour = factor(C)), size = 4, shape = 15) +
  facet_grid(. ~ Race ) +
  labs(x = "W", y = "T", colour = "C") +
  scale_y_continuous(limits = c(174, 180))
print(plot2)

##########################################################################################################################################################

#### 4. Variance-covariance estimates of the final linear mixed model

## The estimate of the D matrix

D_hat <- getVarCov(Model1) # Gives the D matrix
D_hat <- round(D_hat, 2)
D_hat

## The estimate of the R matrix

R_hat <- getVarCov(Model1, type = "conditional")[[1]]
R_hat

## Calculating estimate of the variance-covariance matrix of the response vector

Z <- matrix(c(1, 1, 1, 1, 0, 1, 0, 1), ncol = 2)
Z

Var_Y <- Z %*% D_hat
Var_Y

Var_Y <- Var_Y %*% t(Z)
Var_Y

Var_Y <- Var_Y + R_hat
Var_Y


##########################################################################################################################################################

#### 5. Fixed effect estimates of the final linear mixed model

# Producing Table 1 of fixed effects estimates
Table_1 <- summary(Model1)$tTable
Table_1 <- round(Table_1, 2)
Table_1
# Outputting this table
Table_1_L <- xtable(Table_1, align = "cccccc", digits = c(2,2,2,0,2,2), label = 'Table 1', caption = 'Estimates of fixed effects')
print(Table_1_L, include.rownames = TRUE, caption.placement = "top", file = "Assign_StNo.tex", append = TRUE)

# Estimating the contrast beta9 - beta6 and testing the null hypothesis beta9 - beta6 = 0.
C1 <- matrix(c(0, 0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0), 1)
beta9_6_Contrast <- glht(Model1, linfct = C1)
summary(beta9_6_Contrast)

# Estimating the contrast beta11 - beta10 and testing the null hypothesis beta11 - beta10 = 0.
C2 <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1), 1)
beta11_10_Contrast <- glht(Model1, linfct = C2)
summary(beta11_10_Contrast)


####################################################################################################################################################################

#### 6. Testing for random effects

#Model 1 with the random effect of C
Model1 <- lme(T ~ W + C + R2 + R3 + W:C + W:R2 + W:R3 + C:R2 + C:R3 + W:C:R2 + W:C:R3, 
              random = ~ 1 + C | Adult, weights = varIdent(form = ~ 1 | C),
              method = "REML", data = Cognitive)

#Model 2 without the random effect of C, yet still with the random intercept
Model2 <- lme(T ~ W + C + R2 + R3 + W:C + W:R2 + W:R3 + C:R2 + C:R3 + W:C:R2 + W:C:R3, 
              random = ~ 1 | Adult, weights = varIdent(form = ~ 1 | C),
              method = "REML", data = Cognitive)

# Obtaining the likelihood ratio observed test statistic, LRT = 2ln(LRR) - 2ln(LNR).
anova(Model1, Model2) # Obtain ln(LRR) and ln(LNR)
LRT <- anova(Model1, Model2)$L.Ratio[-1] # Obtain LRT = 2ln(LRR) - 2ln(LNR)

# Calculating the p-value for the REML based likelihood ratio test
p_value <- (0.5 * pchisq(LRT, df = 1, lower.tail = FALSE)) + (0.5 * pchisq(LRT, df = 2, lower.tail = FALSE))
p_value

###################################################################################################################################################################

#### 7. Testing for fixed effects

## Testing the null hypothesis that there are no three-way interaction effects, using ML-based likelihood ratio test.


# Fitting model 2 using ML
Model2 <- lme(T ~ W + C + R2 + R3 + W:C + W:R2 + W:R3 + C:R2 + C:R3 + W:C:R2 + W:C:R3, 
            random = ~ 1 | Adult, weights = varIdent(form = ~ 1 | C),
            method = "ML", data = Cognitive)
#Fitting model 3 using ML
Model3 <- lme(T ~ W + C + R2 + R3 + W:C + W:R2 + W:R3 + C:R2 + C:R3, 
              random = ~ 1 | Adult, weights = varIdent(form = ~ 1 | C),
              method = "ML", data = Cognitive)

anova(Model2, Model3)

## Testing the null hypothesis that there are no two-way interaction effects, using ML-based likelihood ratio test.

#Fitting model 3 using ML
Model4 <- lme(T ~ W + C + R2 + R3, 
              random = ~ 1 | Adult, weights = varIdent(form = ~ 1 | C),
              method = "ML", data = Cognitive)

anova(Model3, Model4)