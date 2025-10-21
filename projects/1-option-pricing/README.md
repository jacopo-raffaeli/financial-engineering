# Option Pricing Models

A comprehensive implementation and comparative analysis of derivative pricing methodologies for European, Barrier, and Bermudan options using MATLAB.

## Overview

This project demonstrates the implementation of various numerical methods for pricing equity options, including analytical closed-form solutions and computational approaches. The analysis includes pricing accuracy comparisons, convergence studies, and sensitivity analysis (Greeks computation).

## Key Features

- **Multiple Pricing Methods**
  - Analytical closed-form solutions (Black-Scholes framework)
  - Cox-Ross-Rubinstein (CRR) binomial tree model
  - Monte Carlo simulation with variance reduction techniques

- **Option Types Supported**
  - European Call and Put options
  - European Barrier options (Up-and-In)
  - Bermudan options (early exercise features)

- **Numerical Analysis**
  - Error convergence studies for tree and Monte Carlo methods
  - Variance reduction using antithetic variables
  - Greeks computation (Gamma) for risk management

- **Performance Optimization**
  - Automatic parameter tuning for desired accuracy thresholds
  - Computational efficiency comparisons across methods

## Methodology

### Pricing Techniques

1. **Closed-Form Solutions**: Utilizes Black-Scholes formula for European options and barrier option extensions for instant pricing with no approximation error.

2. **Binomial Tree (CRR)**: Implements the Cox-Ross-Rubinstein model with configurable time steps, demonstrating O(1/M) convergence where M is the number of steps.

3. **Monte Carlo Simulation**: Path-based simulation approach with demonstrated O(1/√M) convergence, enhanced with antithetic variates for variance reduction.

### Convergence Analysis

The project rigorously tests numerical convergence:
- Binomial tree methods exhibit linear convergence (error ∝ 1/M)
- Monte Carlo methods follow root convergence (error ∝ 1/√M)
- Comparative error plots on log-log scale validate theoretical predictions

### Greeks and Risk Metrics

Gamma (Γ) sensitivity analysis is performed for barrier options across a range of underlying asset prices, comparing:
- Analytical formulas for instant computation
- Numerical finite-difference approximations

## Project Structure

```
1-option-pricing/
├── src/                        # Core pricing functions
│   ├── EuropeanOptionClosed.m  # Closed-form pricer
│   ├── EuropeanOptionCRR.m     # CRR binomial tree
│   ├── EuropeanOptionMC.m      # Monte Carlo pricer
│   ├── EuropeanOptionKI*.m     # Barrier option pricers
│   ├── BermudanOptionCRR.m     # Bermudan option pricer
│   └── ...                     # Additional utilities
├── data/                       # Market parameters
├── results/                    # Generated outputs
│   ├── figures/               # Visualization plots
│   └── summary.md             # Detailed analysis report
├── Main.mlx                   # MATLAB Live Script (interactive)
└── README.md                  # This file
```

## Results

Detailed results, visualizations, and numerical examples are available in the [full summary document](results/summary.md), which includes:

- Pricing comparisons across all methods
- Convergence plots demonstrating error scaling
- Gamma sensitivity profiles for barrier options
- Bermudan vs. European price comparisons with varying dividend yields

## Usage

### Prerequisites

- MATLAB R2019b or later
- Financial Toolbox (for validation comparisons)

### Running the Analysis

1. Navigate to the project directory:
   ```matlab
   cd projects/1-option-pricing
   ```

2. Open and run the main live script:
   ```matlab
   open Main.mlx
   ```

3. The script will:
   - Load market parameters from `data/raw/params.mat`
   - Execute all pricing methodologies
   - Generate convergence plots
   - Compute and visualize Greeks
   - Export results to the `results/` directory

### Example

```matlab
% Price a European Call option
S0 = 1.0;      % Spot price
K = 1.0;       % Strike price
r = 0.03;      % Risk-free rate
q = 0.06;      % Dividend yield
T = 0.25;      % Time to maturity (3 months)
sigma = 0.22;  % Volatility

% Using closed-form solution
price = EuropeanOptionClosed(S0, K, r, q, T, sigma, 1);

% Using CRR binomial tree
nSteps = 100;
priceCRR = EuropeanOptionCRR(S0, K, r, q, T, sigma, nSteps, 1);

% Using Monte Carlo simulation
nSims = 1e6;
priceMC = EuropeanOptionMC(S0, K, r, q, T, sigma, nSims, 1);
```

## Technical Highlights

- **Robust Implementation**: All methods validated against analytical benchmarks
- **Computational Efficiency**: Optimized MATLAB code with vectorized operations
- **Academic Rigor**: Convergence rates verified empirically
- **Production Quality**: Modular design with reusable components

## References

- Cox, J. C., Ross, S. A., & Rubinstein, M. (1979). "Option pricing: A simplified approach"
- Black, F., & Scholes, M. (1973). "The Pricing of Options and Corporate Liabilities"
- Hull, J. C. "Options, Futures, and Other Derivatives" (Latest Edition)

## License

This project is part of the [financial-engineering](../../README.md) repository.

