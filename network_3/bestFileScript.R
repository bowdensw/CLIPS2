# This script loops over multiple subfolders within a parent directory,
# evaluates each .txt file in those folders to find the one with the smallest
# (i.e., most negative) difference between mean looking times for "Consistent"
# and "Inconsistent" events, and stores the results (including the best file
# path and associated statistics) in a summary dataframe for further inspection.

# loop over folders 
parent_dir = "C:/Users/spncr/Downloads/CLIPS2/network_3/errorResults"

folders = list.dirs(parent_dir, recursive = FALSE)


# Initialize empty dataframe to store results
results_df = data.frame(
  folder = character(),
  best_file = character(),
  min_dif = numeric(),
  mean_consistent = numeric(),
  mean_inconsistent = numeric(),
  stringsAsFactors = FALSE
)
# loop over each folder
for(folder in folders){
  
  # get all of the files in the current folder
  files = list.files(path = folder, pattern = ".txt", full.names = TRUE)
  
  min_dif = Inf
  best_file = ""
  mean_consistent = NULL
  mean_inconsistent = NULL
  
  # now loop over each file in the folder 
  for (file in files) {
    options(scipen=999)
    file_name = basename(file)
    
    data = read.table(file, header = FALSE, stringsAsFactors = FALSE)
    
    data$ID = rep(1:100, each = 2)
    data$eventType = rep(c("Consistent", "Inconsistent"), each = 1, times = 100)
    data$eventType = as.factor(data$eventType)
    
    data$looking_time = data$V3
    
    data = data[,-c(1:3)]
    
    
    
    # Calculate largest p-value
    dif = mean(data$looking_time[data$eventType=="Consistent"])-
      mean(data$looking_time[data$eventType=="Inconsistent"])
    
    # Check if this is the best model so far
    if (dif < 0) {
      min_dif = dif
      best_file = file
      mean_consistent = mean(data$looking_time[data$eventType=="Consistent"])
      mean_inconsistent = mean(data$looking_time[data$eventType=="Inconsistent"])
    }
  }
  
  # Append results to dataframe
  results_df = rbind(results_df, data.frame(
    folder = folder,
    best_file = best_file,
    min_dif = min_dif,
    mean_consistent = mean_consistent,
    mean_inconsistent = mean_inconsistent,
    stringsAsFactors = FALSE
  ))
}

fix(results_df)

