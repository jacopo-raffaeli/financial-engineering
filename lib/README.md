# lib - Shared Library Functions

This directory contains shared MATLAB functions and utilities used across multiple projects in the repository.

## Contents

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

