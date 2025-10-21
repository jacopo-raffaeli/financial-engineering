# lib - Shared Library Functions

This directory contains shared MATLAB functions and utilities used across multiple projects in the repository.

## Contents

### Setup.m
Initialization script for setting up the MATLAB workspace, including:
- Clearing workspace and command window
- Setting random number generator seed for reproducibility
- Adding shared library and project-specific folders to the MATLAB path

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

## Usage

Include the library in your project by adding it to the MATLAB path:

```matlab
addpath(genpath(fullfile('..','..','lib')));
```

Or use the `InitializeProject()` function at the beginning of your project scripts.
