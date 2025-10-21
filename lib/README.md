# lib - Shared Library Functions

This directory contains shared MATLAB functions and utilities used across multiple projects in the repository.

## Contents

### Setup.m
Initialization script for setting up the MATLAB workspace:
- Clears workspace, command window, and figures
- Sets random number generator seed for reproducibility
- Adds shared library and project-specific folders to the MATLAB path
- Defines path variables for common directories (results, figures, src, data)

### InitializeProject.m
Function to initialize project environment with path management:
- Resets MATLAB path to default
- Adds shared library folder to path
- Adds project-specific folders (src, data, results)
- Ensures reproducible random number generation

### PlotUtils.m
Utility class for creating consistent plots across projects:
- Standard plotting styles and formatting
- Font and axes configuration
- Customizable plot appearance for professional visualizations

