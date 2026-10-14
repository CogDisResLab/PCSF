# Randomized PCSF Usage Examples
# This file demonstrates the randomized PCSF function for robust network inference

# Load required libraries
library(PCSF)

# Example 1: Basic Randomized PCSF
# Run randomized PCSF with default parameters
set.seed(42)
randomized_result <- PCSF_rand(
  data = phosphoproteomics_data,
  interactome = interactome_network,
  n_iter = 100,           # Number of randomizations
  n_cores = 4,            # Number of CPU cores to use
  seed = 42               # Random seed for reproducibility
)

# View the results
print("Randomized PCSF Results:")
print(names(randomized_result))

# Example 2: Accessing the consensus network
# The consensus network is the most frequently selected edges
consensus_network <- randomized_result$consensus_network
cat("\nConsensus network has", nrow(consensus_network), "edges\n")

# Example 3: Accessing edge selection frequencies
# Get the frequency of each edge being selected across iterations
edge_frequencies <- randomized_result$edge_frequencies
cat("\nTop 10 most frequently selected edges:\n")
print(head(edge_frequencies, 10))

# Example 4: Accessing p-values for edge selection
# P-value indicates how significantly an edge is selected
edge_pvalues <- randomized_result$edge_pvalues
cat("\nTop 10 edges with lowest p-values:\n")
print(head(edge_pvalues[order(edge_pvalues$p_value), ], 10))

# Example 5: Accessing confidence scores
# Confidence score indicates how consistently an edge is selected
edge_confidence <- randomized_result$edge_confidence
cat("\nTop 10 edges with highest confidence:\n")
print(head(edge_confidence[order(edge_confidence$confidence, decreasing = TRUE), ], 10))

# Example 6: Running with custom parameters
# Run randomized PCSF with custom parameters
randomized_result_custom <- PCSF_rand(
  data = phosphoproteomics_data,
  interactome = interactome_network,
  n_iter = 200,           # More iterations for more robust results
  n_cores = 8,            # Use more cores
  seed = 123,
  threshold = 0.7         # Minimum selection frequency threshold
)

# Example 7: Comparing multiple runs
# Run PCSF_rand multiple times with different seeds
set.seed(1)
run1 <- PCSF_rand(data = phosphoproteomics_data, interactome = interactome_network, 
                  n_iter = 50, n_cores = 2, seed = 1)
set.seed(2)
run2 <- PCSF_rand(data = phosphoproteomics_data, interactome = interactome_network, 
                  n_iter = 50, n_cores = 2, seed = 2)
set.seed(3)
run3 <- PCSF_rand(data = phosphoproteomics_data, interactome = interactome_network, 
                  n_iter = 50, n_cores = 2, seed = 3)

# Combine results
combined_results <- list(run1, run2, run3)
cat("\nCombined results from 3 runs:\n")
cat("Run 1 consensus edges:", nrow(run1$consensus_network), "\n")
cat("Run 2 consensus edges:", nrow(run2$consensus_network), "\n")
cat("Run 3 consensus edges:", nrow(run3$consensus_network), "\n")

# Example 8: Using the consensus network for downstream analysis
# The consensus network can be used for:
# - Enrichment analysis
# - Subnetwork extraction
# - Visualization
# - Comparison with other methods

# Example 9: Accessing intermediate results
# The randomized PCSF function also returns intermediate results
cat("\nIntermediate results available:\n")
cat("- consensus_network: Most frequently selected edges\n")
cat("- edge_frequencies: Selection frequency for each edge\n")
cat("- edge_pvalues: Statistical significance of edge selection\n")
cat("- edge_confidence: Confidence score for each edge\n")
cat("- selection_matrix: Matrix of edge selections across iterations\n")
cat("- iteration_results: Results from each iteration\n")

# Example 10: Saving randomized PCSF results
# Save the consensus network for later use
saveRDS(randomized_result, file = "randomized_pcsf_results.rds")

# Load saved results
# saved_result <- readRDS("randomized_pcsf_results.rds")

# Example 11: Running PCSF_rand on a subset of data
# For testing or when dealing with large datasets
subset_data <- phosphoproteomics_data[1:100, ]  # Use first 100 samples
subset_network <- interactome_network[1:50, 1:50]  # Use first 50 nodes

set.seed(42)
subset_result <- PCSF_rand(
  data = subset_data,
  interactome = subset_network,
  n_iter = 50,
  n_cores = 2
)

cat("\nSubset analysis completed with", nrow(subset_result$consensus_network), "edges\n")

# Example 12: Understanding the randomized PCSF algorithm
# The randomized PCSF algorithm:
# 1. Randomly samples the input data multiple times
# 2. Runs PCSF on each sample
# 3. Aggregates results across iterations
# 4. Computes consensus network and statistical measures

# Key advantages:
# - More robust to noise and outliers
# - Provides statistical significance measures
# - Reduces false positives
# - Handles missing data better

# Example 13: Visualizing edge selection frequencies
# Plot the distribution of edge selection frequencies
hist(edge_frequencies$selection_frequency,
     main = "Distribution of Edge Selection Frequencies",
     xlab = "Selection Frequency",
     ylab = "Number of Edges",
     col = "lightblue",
     breaks = 20)

# Example 14: Visualizing p-value distribution
# Plot the distribution of p-values
hist(edge_pvalues$p_value,
     main = "Distribution of Edge P-values",
     xlab = "P-value",
     ylab = "Number of Edges",
     col = "lightgreen",
     breaks = 20)

# Example 15: Combining with enrichment analysis
# Use the consensus network for enrichment analysis
enrichment_result <- call_enr(
  network = randomized_result$consensus_network,
  data = phosphoproteomics_data,
  organism = "human"
)

cat("\nEnrichment analysis completed\n")
cat("Significant pathways:", sum(enrichment_result$significant), "\n")

# Example 16: Extracting subnetworks
# Extract a subnetwork around a specific node
target_node <- "TP53"
subnetwork <- extract_subnetwork(
  network = randomized_result$consensus_network,
  target = target_node,
  radius = 2  # Include 2-hop neighbors
)

cat("\nSubnetwork around", target_node, "has", nrow(subnetwork), "edges\n")

# Example 17: Comparing with standard PCSF
# Compare results from standard PCSF and randomized PCSF
standard_result <- PCSF(
  data = phosphoproteomics_data,
  interactome = interactome_network
)

cat("\nComparison:\n")
cat("Standard PCSF edges:", nrow(standard_result$network), "\n")
cat("Randomized PCSF edges:", nrow(randomized_result$consensus_network), "\n")

# Example 18: Using different randomization strategies
# The randomized PCSF can be customized with different strategies
# (See PCSF_rand documentation for available strategies)

# Example 19: Monitoring progress
# For long-running computations, you can monitor progress
# The function uses parallel processing, so progress depends on n_cores

# Example 20: Best practices for randomized PCSF
# 1. Use sufficient iterations (typically 100-500)
# 2. Use multiple cores for faster computation
# 3. Set a random seed for reproducibility
# 4. Use the consensus network for downstream analysis
# 5. Examine edge frequencies and p-values for quality assessment
# 6. Combine with enrichment analysis for biological interpretation
# 7. Compare with standard PCSF to assess robustness
