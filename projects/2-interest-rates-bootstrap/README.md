# 2-interest-rates-bootstrap

## Project Overview

Interest rate curve bootstrapping from market data (deposits, futures, swaps) with sensitivity analysis.

## Key Features

- **Market Instruments**: Money market deposits, STIR futures, interest rate swaps
- **Curve Construction**: Bootstrap methodology with proper day count conventions (ACT/365, ACT/360, 30/360)
- **Analysis**: Zero-rate term structure, discount factors, sensitivity metrics

## Results

Detailed analysis available in [results/summary.md](results/summary.md) (`main.mlx` exported), including:

- Discount curve construction
- Zero and forward rate visualization
- Sensitivity analysis for swaps and bonds

## References

- Hagan, P. S., & West, G. "Interpolation Methods for Curve Construction"
- Hull, J. C. "Options, Futures, and Other Derivatives" - Interest Rate Markets chapter
- Brigo, D., & Mercurio, F. "Interest Rate Models - Theory and Practice"

## License

This project is part of the [financial-engineering](../..) repository.
