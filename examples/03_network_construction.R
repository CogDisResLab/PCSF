# ============================================================================
# PCSF Package - Network Construction Examples
# ============================================================================
# This file demonstrates how to construct and use interaction networks
# with the PCSF package.
# ============================================================================

# Load required libraries
library(PCSF)

# ============================================================================
# Example 1: Basic Network Construction from Phosphoproteomics Data
# ============================================================================
# This example shows how to construct a network from phosphoproteomics data
# and interactome information.

# Step 1: Load phosphoproteomics data
# The data should contain:
# - Protein identifiers
# - Phosphosite information
# - Enrichment scores or p-values

# Example: Load your phosphoproteomics data
# phospho_data <- read.csv("your_phosphoproteomics_data.csv")

# Step 2: Load interactome network
# The interactome should be a bipartite graph with:
# - Protein nodes
# - Phosphosite nodes
# - Edges representing phosphorylation relationships

# Example: Load interactome data
# interactome <- readRDS("your_interactome.rds")

# Step 3: Construct the network
# The construct_interactome function creates a network object
# from phosphoproteomics data and interactome information

# Example:
# network <- construct_interactome(
#   phospho_data = phospho_data,
#   interactome = interactome,
#   threshold = 0.01  # Optional: significance threshold
# )

# Step 4: View network structure
# print(network)
# summary(network)

# ============================================================================
# Example 2: Network with Multiple Phosphoproteomics Datasets
# ============================================================================
# This example shows how to combine multiple phosphoproteomics datasets

# Example: Load multiple datasets
# dataset1 <- read.csv("phospho_dataset1.csv")
# dataset2 <- read.csv("phospho_dataset2.csv")
# dataset3 <- read.csv("phospho_dataset3.csv")

# Combine datasets
# combined_data <- rbind(dataset1, dataset2, dataset3)

# Construct network from combined data
# network <- construct_interactome(
#   phospho_data = combined_data,
#   interactome = interactome,
#   threshold = 0.001  # More stringent threshold for combined data
# )

# ============================================================================
# Example 3: Network with Different Thresholds
# ============================================================================
# This example demonstrates how different thresholds affect network structure

# Example: Try different thresholds
# thresholds <- c(0.1, 0.05, 0.01, 0.001)

# for (threshold in thresholds) {
#   network <- construct_interactome(
#     phospho_data = phospho_data,
#     interactome = interactome,
#     threshold = threshold
#   )
#   
#   cat(sprintf("Network with threshold %.3f:\n", threshold))
#   cat(sprintf("  Nodes: %d\n", length(V(network))))
#   cat(sprintf("  Edges: %d\n", length(E(network))))
#   cat("\n")
# }

# ============================================================================
# Example 4: Network Analysis
# ============================================================================
# After constructing a network, you can analyze its properties

# Example: Analyze network properties
# network <- construct_interactome(
#   phospho_data = phospho_data,
#   interactome = interactome,
#   threshold = 0.01
# )

# Calculate network statistics
# node_degrees <- degree(network)
# top_nodes <- sort(node_degrees, decreasing = TRUE)[1:10]
# 
# cat("Top 10 nodes by degree:\n")
# print(head(top_nodes))

# Find connected components
# components <- clusters(network)
# cat(sprintf("Number of connected components: %d\n", components$no))
# cat(sprintf("Largest component size: %d\n", max(components$csize)))

# ============================================================================
# Example 5: Network Visualization
# ============================================================================
# Basic network visualization (see plotting examples for more details)

# Example: Basic plot
# plot(network, 
#      vertex.size = 5,
#      vertex.label = V(network)$name,
#      edge.arrow.size = 0.5,
#      main = "PCSF Network")

# ============================================================================
# Example 6: Network with Enrichment Analysis
# ============================================================================
# Combine network construction with enrichment analysis

# Example:
# network <- construct_interactome(
#   phospho_data = phospho_data,
#   interactome = interactome,
#   threshold = 0.01
# )

# Perform enrichment analysis on network
# enrichment_results <- enrichment_analysis(
#   network = network,
#   phospho_data = phospho_data,
#   interactome = interactome
# )

# View top enriched terms
# top_enrichment <- head(enrichment_results, 10)
# print(top_enrichment)

# ============================================================================
# Example 7: Saving and Loading Networks
# ============================================================================
# Save constructed networks for later use

# Example: Save network
# saveRDS(network, "my_pcsf_network.rds")

# Example: Load network later
# loaded_network <- readRDS("my_pcsf_network.rds")

# Example: Save network with metadata
# save_metadata <- list(
#   date = Sys.Date(),
#   threshold = 0.01,
#   phospho_data_source = "your_data_source"
# )
# saveRDS(list(network = network, metadata = save_metadata), 
#         "my_pcsf_network_with_metadata.rds")

# Example: Load network with metadata
# loaded_data <- readRDS("my_pcsf_network_with_metadata.rds")
# loaded_network <- loaded_data$network
# metadata <- loaded_data$metadata

# cat("Network loaded with metadata:\n")
# print(metadata)

# ============================================================================
# Example 8: Interactive Network Exploration
# ============================================================================
# For interactive exploration, you can use igraph's interactive features

# Example: Interactive plot (if available in your environment)
# plot(network, 
#      vertex.size = 5,
#      vertex.label = V(network)$name,
#      edge.arrow.size = 0.5,
#      main = "PCSF Network (Interactive)",
#      vertex.color = ifelse(V(network)$type == "protein", "blue", "red"))

# ============================================================================
# Example 9: Network Filtering
# ============================================================================
# Filter network based on various criteria

# Example: Filter by node type
# protein_nodes <- V(network)[V(network)$type == "protein"]
# phospho_nodes <- V(network)[V(network)$type == "phosphosite"]

# Example: Filter by degree
# high_degree_nodes <- V(network)[degree(network) >= 5]

# Example: Create subnetwork with high-degree nodes
# subnetwork <- induced_subgraph(network, high_degree_nodes)

# Example: Filter by enrichment score
# high_enrichment_nodes <- V(network)[V(network)$enrichment_score >= 0.5]

# ============================================================================
# Example 10: Network Comparison
# ============================================================================
# Compare networks from different conditions or datasets

# Example: Load multiple networks
# network_control <- readRDS("control_network.rds")
# network_treated <- readRDS("treated_network.rds")

# Compare network properties
# control_stats <- list(
#   nodes = length(V(network_control)),
#   edges = length(E(network_control)),
#   avg_degree = mean(degree(network_control))
# )
# 
# treated_stats <- list(
#   nodes = length(V(network_treated)),
#   edges = length(E(network_treated)),
#   avg_degree = mean(degree(network_treated))
# )

# cat("Network comparison:\n")
# cat(sprintf("Control: %d nodes, %d edges, avg degree %.2f\n", 
#             control_stats$nodes, control_stats$edges, control_stats$avg_degree))
# cat(sprintf("Treated: %d nodes, %d edges, avg degree %.2f\n", 
#             treated_stats$nodes, treated_stats$edges, treated_stats$avg_degree))

# ============================================================================
# Notes
# ============================================================================
# - Always check that your phosphoproteomics data and interactome are properly formatted
# - Adjust thresholds based on your data quality and biological context
# - Consider using different network construction parameters for different experimental conditions
# - Save your networks with metadata for reproducibility
# - For large networks, consider sampling or filtering to improve visualization and analysis
