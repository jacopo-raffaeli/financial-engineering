# Interest Rate Curve Bootstrapping

Construction of zero-coupon discount curves from market instruments using the bootstrap methodology for fixed income pricing and risk management.

## Overview

This project implements a robust bootstrapping algorithm to construct a complete zero-coupon yield curve from liquid market instruments across different maturity segments. The methodology is essential for pricing interest rate derivatives, bond valuation, and risk management in fixed income portfolios.

## Key Features

- **Multi-Instrument Calibration**
  - Money market deposits (short-term rates)
  - STIR (Short-Term Interest Rate) futures (medium-term rates)
  - Interest rate swaps (long-term rates)

- **Professional Market Conventions**
  - Multiple day count conventions (ACT/365, ACT/360, 30/360)
  - Bid-ask spread handling
  - Proper interpolation techniques for gap-filling

- **Yield Curve Construction**
  - Bootstrapping from liquid market quotes
  - Smooth discount factor curve generation
  - Zero-rate term structure extraction

- **Production-Ready Implementation**
  - Excel data import capability
  - Configurable date handling
  - Extensible architecture for additional instruments

## Methodology

### Bootstrapping Algorithm

The bootstrapping process constructs a piecewise discount curve by sequentially calibrating to market instruments:

1. **Short End (Deposits)**: 
   - Direct discount factor calculation from money market rates
   - Uses ACT/360 day count convention
   - Typical maturities: overnight to 12 months

2. **Middle Section (Futures)**:
   - Calibration to STIR futures (e.g., Euribor futures)
   - Interpolation between known points for intermediate dates
   - Forward rate consistency enforcement

3. **Long End (Swaps)**:
   - Iterative bootstrapping from swap rates
   - Par swap equation solving for each maturity
   - Uses 30/360 day count for fixed leg
   - Typical maturities: 2 to 50 years

### Mathematical Framework

The discount factor B(t,T) for maturity T is derived such that market instruments are priced at par:

- **Deposits**: `B(t,T) = 1 / (1 + δ × L)` where δ is the year fraction and L is the deposit rate
- **Futures**: Forward rate consistency with `B(t,S) = B(t,T) × B(T,S)`
- **Swaps**: Solving `1 = c × BPV + B(t,T) × (1 + δ × c)` for the final discount factor

### Day Count Conventions

- **ACT/365**: Used for zero-rate calculations
- **ACT/360**: Money market deposits and futures
- **30/360 European**: Swap fixed leg cash flows

## Project Structure

```
2-interest-rates-bootstrap/
├── src/
│   ├── Bootstrap.m          # Core bootstrapping algorithm
│   └── ReadExcelData.m      # Market data import utility
├── data/
│   └── raw/
│       └── MktData_CurveBootstrap.xlsx  # Market quotes
├── results/                 # Output curves and plots
├── main.mlx                 # MATLAB Live Script (interactive demo)
└── README.md                # This file
```

## Usage

### Prerequisites

- MATLAB R2019b or later
- Financial Toolbox (for date utilities and year fraction calculations)

### Running the Analysis

1. Navigate to the project directory:
   ```matlab
   cd projects/2-interest-rates-bootstrap
   ```

2. Open and run the main live script:
   ```matlab
   open main.mlx
   ```

3. The script will:
   - Import market data from the Excel file
   - Execute the bootstrapping algorithm
   - Generate the complete discount curve
   - Visualize zero rates and forward rates
   - Export results for downstream applications

### Example Usage

```matlab
% Load market data
[dates, rates] = ReadExcelData('data/raw/MktData_CurveBootstrap.xlsx', 'dd/mm/yyyy');

% Bootstrap the yield curve
[curveDates, discountFactors] = Bootstrap(dates, rates);

% Extract zero rates
settlement = dates.settlement;
yearFracs = yearfrac(settlement, curveDates, 3); % ACT/365
zeroRates = -log(discountFactors) ./ yearFracs;

% Visualize the curve
plot(curveDates, zeroRates * 100);
xlabel('Maturity Date');
ylabel('Zero Rate (%)');
title('Bootstrapped Zero-Coupon Yield Curve');
```

## Input Data Format

The Excel file should contain market quotes in a structured format:

- **Sheet 1**: All market data
  - Settlement date
  - Deposit rates (bid/ask) with maturity dates
  - Futures prices (bid/ask) with start/end dates
  - Swap rates (bid/ask) with maturity dates

Market quotes should be expressed in percentage terms (e.g., 3.5 for 3.5%).

## Output

The bootstrapping algorithm produces:

- **Discount Curve**: Vector of discount factors B(t,T) for each maturity
- **Zero Rates**: Continuously compounded zero rates
- **Forward Rates**: Implied forward rates between consecutive maturities

These outputs can be used for:
- Pricing interest rate derivatives (swaps, caps, floors, swaptions)
- Marking-to-market fixed income portfolios
- Risk analysis and scenario testing
- Regulatory capital calculations

## Technical Highlights

- **Market-Standard Methodology**: Implements industry-standard bootstrapping techniques used by financial institutions
- **Robust Interpolation**: Linear interpolation in zero-rate space for smooth curves
- **Flexible Design**: Easy to extend with additional instrument types (OIS, basis swaps, etc.)
- **Data Validation**: Handles bid-ask spreads by using mid-market rates

## Applications

This yield curve construction is fundamental for:

- **Derivative Pricing**: Fair value calculation for interest rate derivatives
- **Risk Management**: Computing DV01, duration, and convexity
- **Portfolio Analytics**: Mark-to-market valuation of bond portfolios
- **Trading Strategies**: Identifying arbitrage opportunities and relative value trades

## References

- Hagan, P. S., & West, G. "Interpolation Methods for Curve Construction"
- Hull, J. C. "Options, Futures, and Other Derivatives" - Interest Rate Markets chapter
- Brigo, D., & Mercurio, F. "Interest Rate Models - Theory and Practice"

## License

This project is part of the [financial-engineering](../../README.md) repository.

