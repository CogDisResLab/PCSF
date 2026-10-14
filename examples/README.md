# PCSF Examples

This directory contains comprehensive usage examples for the PCSF (Protein Complex Subnetwork Finder) package.

## Overview

The examples demonstrate:
- Basic PCSF usage
- Randomized PCSF for significance testing
- Network construction and visualization
- Plotting and enrichment analysis

## Prerequisites

Before running these examples, ensure you have:
1. PCSF package installed
2. Required R packages loaded
3. Sample data available (the examples use built-in data)

## Running the Examples

Each example file can be run independently in R:

```r
# Source the example file
source("examples/01_basic_usage.R")

# Or run interactively
Rscript examples/01_basic_usage.R
```

## Example Files

### 01_basic_usage.R
Demonstrates basic PCSF usage:
- Running PCSF on a phosphoproteomics dataset
- Interpreting the results
- Basic network extraction

### 02_randomized_usage.R
Shows randomized PCSF for significance testing:
- Running randomized PCSF multiple times
- Computing empirical p-values
- Assessing significance of results

### 03_network_construction.R
Explains network construction:
- Building interactome networks
- Filtering and preprocessing
- Visualizing network structure

### 04_plotting_examples.R
Contains 15 plotting and visualization examples:
- Subnetwork plots
- Enrichment analysis plots
- Network visualization
- Custom plot styling

## Example Output

Each example generates:
- Console output showing PCSF results
- Network plots (PNG files)
- Enrichment analysis results
- Statistical summaries

## Troubleshooting

If you encounter issues:
1. Ensure all required R packages are installed
2. Check that the PCSF package is properly loaded
3. Verify sample data is available
4. Review the PCSF documentation for function parameters

## Additional Resources

- Main PCSF documentation: `../README.md`
- Function reference: `../man/`
- Test suite: `../tests/testthat.R`

## Contributing

To add new examples:
1. Create a new R file in this directory
2. Follow the naming convention: `NN_description.R`
3. Include comments explaining the example
4. Test the example before committing
