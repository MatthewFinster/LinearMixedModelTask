# Repeated Measures Analysis of Cognitive Task Performance

This project analyses repeated measures data from a study investigating the effects of word type, cue condition, and race on cognitive task reading times. Using linear mixed models, the project explores interaction effects while accounting for within-subject variability.

## Project Overview

The dataset includes reading times (in milliseconds) collected from 36 participants performing tasks under various conditions:
- **Word Type**: Form vs Colour
- **Cue Condition**: Normal vs Congruent
- **Race**: Black, Hispanic, or White

- ### Objectives
1. **Graphical Exploration**:
   - Visualise the effects of word type, cue condition, and race on reading times to inform model specification.
2. **Linear Mixed Model Specification and Fitting**:
   - Fit a linear mixed model accounting for repeated measures and interactions between fixed effects (e.g., word type, cue condition, race).
3. **Variance-Covariance Estimation**:
   - Derive and estimate variance-covariance matrices for random effects and residuals.
4. **Model Diagnostics and Validation**:
   - Assess model fit using residual plots and agreement between predicted and observed values.
5. **Hypothesis Testing**:
   - Test for significance of fixed and random effects using likelihood ratio tests and interpret results.
6. **Post-Hoc Comparisons**:
   - Conduct pairwise comparisons of means and test interaction effects to assess specific hypotheses.
7. **Manual Calculations**:
   - Validate statistical results through manual calculations of residuals and other metrics for selected cases.

- ## Files in This Repository
- `Analysis of Repeated Measures (linear mixed models) code.R`: R script containing all the code used for data preparation, model fitting, diagnostics, and visualisations.
- `Analysis of Repeated Measures (linear mixed models) assignment.pdf`: PDF report with detailed analyses, visualisations, and interpretations.

## Methods
- **Statistical Analysis**: Linear Mixed Models (LMMs) were used to account for fixed effects (word type, cue condition, and race) and random effects (subject-specific variability).
- **Software**: R (version 4.3.3) and RStudio.
- **Documentation**: The analysis was documented in LaTeX and compiled into a professional PDF report using Overleaf.

## How to View or Run
1. **View the Report**:
   - Open `Analysis of Repeated Measures (linear mixed models) assignment.pdf` to see the complete analysis and results.

2. **Run the Code**:
   - Open the `Analysis of Repeated Measures (linear mixed models) code.R` script in RStudio to explore the analysis step-by-step.

## Data Usage Notice

The dataset (`Cognitive.csv`) used for this project is not included in this repository due to academic integrity and plagiarism concerns. Sharing or distributing the data may violate university policies, as this project was completed as part of an academic assignment. 

If you are interested in understanding the analysis or methods, please refer to the provided R script and report. For any additional information, you may contact the repository owner directly.

## License

This repository is licensed under the [Creative Commons Attribution-NonCommercial-NoDerivs (CC BY-NC-ND)](https://creativecommons.org/licenses/by-nc-nd/4.0/) license.

The content is shared for educational purposes and as part of a portfolio. Redistribution, reuse for academic submissions, or plagiarism is strictly prohibited.
