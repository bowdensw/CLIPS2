# Load required package
install.packages("pheatmap")  # Run only once
library(pheatmap)

# Load the data
df = read.table(file.choose(), 
                header = FALSE, stringsAsFactors = FALSE)

# Assign column names
colnames(df) = c("trial", "event", "layer", paste0("unit_", 1:20))

# Create a unique label for each row
df$base_label = paste(df$event, df$layer, df$trial, sep = "_")
df$label = make.unique(df$base_label)

# Subset the first four rows
df_small = df[1:4, ]

# Extract only the numeric activations
X = as.matrix(df[, paste0("unit_", 1:20)])
rownames(X) = df$label

# Compute 1 - correlation dissimilarity matrix
cor_matrix = cor(t(X))
dissimilarity_matrix = 1 - cor_matrix

# Plot the RSA matrix as a heatmap
pheatmap(dissimilarity_matrix,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         color = colorRampPalette(c("blue", "white", "red"))(100),
         main = "Representational Dissimilarity Matrix (1 - Correlation)")
