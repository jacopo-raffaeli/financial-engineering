# financial-engineering

## Project Overview

This repository contains a curated collection of MATLAB projects focused on practical applications in financial engineering. Topics include derivatives pricing, quantitative risk management, and structured products. 

Each project is self-contained, featuring reproducible code, results, and visualizations. Shared functions are organized in the `lib` directory for reuse across projects.

---

## Repository Structure

```
financial-engineering/
│
├── docs/       # Additional documentation
├── lib/        # Shared MATLAB functions
├── projects/   # Individual project folders
├── .gitignore   
└── README.md
```

Each project folder typically includes:

```
project-name/
│
├── data/           
│   ├── raw/
│   ├── interim/    
│   └── processed/
│
├── results/        # Generated outputs, plots, metrics
│   ├── figures/
│   └── report.md   # Exported main.mlx for visualization  
│
├── src/            # MATLAB functions and scripts
├── main.mlx        # MATLAB live script demonstrating workflow and results
└── README.md       # Project description and instructions
```

---

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/jacopo-raffaeli/financial-engineering.git
    ```
2. Open MATLAB and navigate to the desired project folder.
3. Run the `main.mlx` live script to reproduce results and visualizations.

---

## How to Run Projects

Each project contains a `main.mlx` MATLAB live script that demonstrates the workflow and produces results:

1. Navigate to the project folder (e.g., `projects/1-option-pricing/`)
2. Open `main.mlx` in MATLAB
3. Run all sections to reproduce the analysis, figures, and results
4. View exported results in the `results/` folder

---

## Projects

1. [Option Pricing](projects/1-option-pricing/README.md)
2. [Interest Rates Bootstrap](projects/2-interest-rates-bootstrap/README.md)
3. <!-- Add project name and brief description here -->


