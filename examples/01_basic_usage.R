# Basic Usage Examples for PCSF Package
# This file demonstrates the core PCSF function usage

# Load required libraries
library(PCSF)
library(igraph)
library(visNetwork)

# Example 1: Basic PCSF on a small network
# ------------------------------------------------
# Create a small test network (protein-protein interaction)
# Nodes: proteins, Edges: interactions
test_edges <- data.frame(
  from = c("A", "A", "B", "B", "C", "C", "D", "D", "E"),
  to = c("B", "C", "C", "D", "D", "E", "E", "A", "F")
)

# Create interaction network
test_network <- construct_interactome(test_edges)

# Run PCSF with default parameters
result <- PCSF(test_network, k = 3)

# View results
print(result)
print(head(result$clusters))

# Example 2: PCSF with custom parameters
# ------------------------------------------------
# Run PCSF with specific parameters
result_custom <- PCSF(
  test_network,
  k = 5,                    # Number of clusters
  alpha = 0.5,              # Edge weight parameter
  beta = 0.3,               # Node weight parameter
  gamma = 0.2               # Clustering penalty parameter
)

# Compare results
print("Default parameters:")
print(result$clusters)
print("\nCustom parameters:")
print(result_custom$clusters)

# Example 3: Accessing PCSF components
# ------------------------------------------------
# PCSF returns a list with multiple components
# Access individual components
clusters <- result$clusters
cluster_sizes <- sapply(clusters, length)
print(paste("Number of clusters:", length(clusters)))
print(paste("Cluster sizes:", paste(cluster_sizes, collapse = ", ")))

# Access cluster assignments
node_assignments <- result$node_assignments
print(head(node_assignments))

# Access cluster graph (MST on cluster graph)
cluster_graph <- result$cluster_graph
print(cluster_graph)

# Example 4: Visualizing results
# ------------------------------------------------
# Plot the PCSF result
plot(result, main = "PCSF Clustering Results")

# Get subnetwork for a specific cluster
cluster_1_nodes <- clusters[[1]]
cluster_1_subnetwork <- induced_subgraph(test_network, cluster_1_nodes)

# Plot the subnetwork
plot(cluster_1_subnetwork, main = "Cluster 1 Subnetwork")

# Example 5: Using PCSF with different network sizes
# ------------------------------------------------
# Create a larger test network
set.seed(42)
large_edges <- data.frame(
  from = sample(letters[1:20], 100, replace = TRUE),
  to = sample(letters[1:20], 100, replace = TRUE)
)

large_network <- construct_interactome(large_edges)

# Run PCSF on larger network
result_large <- PCSF(large_network, k = 6)

# Check performance
print(paste("Number of nodes:", vcount(large_network)))
print(paste("Number of edges:", ecount(large_network)))
print(paste("Number of clusters:", length(result_large$clusters)))

# Example 6: Understanding the PCSF output structure
# ------------------------------------------------
# The PCSF result is a list with the following components:
# - clusters: List of clusters (each cluster is a vector of node names)
# - node_assignments: Named vector mapping each node to its cluster
# - cluster_graph: The minimum spanning tree on the cluster graph
# - objective_value: The objective function value
# - iterations: Number of iterations performed
# - convergence: Convergence status

# Access all components
cat("=== PCSF Result Structure ===\n")
cat("Clusters:\n")
print(str(clusters))
cat("\nNode Assignments:\n")
print(str(node_assignments))
cat("\nCluster Graph:\n")
print(str(cluster_graph))
cat("\nObjective Value:", result$objective_value, "\n")
cat("Iterations:", result$iterations, "\n")
cat("Convergence:", result$convergence, "\n")
