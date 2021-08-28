
# Work with missing values functions-------------------------- 

# Observe missing values and list the column with missing values from highest to lowest
mis_value_listing_f <- function(data){
  #return num_missing, a data contains names of columns with missing values and percentage of missing values
  col_mis_values <- colnames(data)[colSums(is.na(data)) > 0]
  
  num_missing <- map(data %>% select((col_mis_values)), ~sum(is.na(.))) %>% as.data.frame 
  num_missing <- num_missing %>%
    pivot_longer(everything(), names_to = "col_name", values_to =
                   "num_of_miss") %>% arrange(desc(num_of_miss)) %>%
    mutate(percent_miss = num_of_miss/(dim(data)[1]))
  return(num_missing)}

# Function to create description tibble from data_description.txt
create_descrip_tibble_f <- function(){
  # Step 1: Create a tibble
  des_file <- read_lines("../house_dat/data_description.txt",
                         skip_empty_rows = TRUE)
  
  header <- c("name\tdescription\n")
  des_file <- str_c(header, des_file)
  
  des_file_new <- suppressWarnings(read_delim(des_file, delim = "\t")) %>% 
    filter(name != "name") %>%
    mutate_if(is.character, str_trim)  
  
  des_file <- des_file_new %>% mutate(index = 1:nrow(des_file_new))
  
  # Step2: Create num_fac, a column that distinguish which row is a numerical/factorial columns or factor levels
  # Find the indexes of columns
  col_index <- filter(des_file, grepl(':', name)) %>% pull(index)
  
  # Find indexes of numerical columns
  lag_diff <- diff(col_index, lag = 1, differences = 1)
  is_num_col <- (1==lag_diff)
  num_col_index <-  col_index[is_num_col]
  
  # Find the indexes of catergorical columns
  char_col_index <-  col_index[!is_num_col]
  # Add a column named num_fac to distingush between numeical, factorial column or factor_level_values
  
  des_file <- des_file %>% 
    mutate(num_fac = case_when(
      index %in% num_col_index ~ "num_col", 
      index %in% char_col_index ~ "fac_col", 
      TRUE                      ~ "fac_val")) %>%
    select(index, everything())  #to put index column in the first column
  # Step 3: Correct the columnnames:description to put them into separated "name" and "description" columns 
  work_with_col_name<- des_file %>% filter(index %in% col_index) %>%
    separate(col = name, into =c("name", "description"), sep=":") 
  des_file <- rbind(des_file %>% filter(num_fac =="fac_val"), work_with_col_name) %>%
    arrange(index)
  
  return(des_file)
}

# 
find_col_name_f <- function(des_tibble){
  #Find the index values of rows having NA means "None"
  Na_index <- des_file %>% filter(name =="NA") %>% pull(index) 
  
  #Filter the row index of column names
  Col_index <- des_file %>% filter(num_fac=="fac_col") %>% pull(index)
  
  # Find indexes of columns that contains NA means "None"
  Col_contain_Na_index <- c()
  for (i in Na_index){
    Col_contain_Na_index <- append(Col_contain_Na_index,max(Col_index[Col_index < i]) )}
  # Take names of columns that contains NA means "None" based on it indexes
  Thecolname <- des_file %>% filter(index %in% Col_contain_Na_index) %>% pull(name)
  return(Thecolname)
}

#Funtions for imputing data-----------------------------------------------
# Function to impute the numerical columns with mean 
replace_by_mean_f <- function(x) {
    x[is.na(x)] <- mean(x, na.rm = TRUE)
    return(x)}
# Function to impute factorial columns according to the frequency
replace_na_categorical_f <- function(x) {
    x %>% table() %>% as.data.frame() %>% arrange(-Freq) ->> my_df
  
    n_obs <- sum(my_df$Freq)
    pop <- my_df$. %>% as.character()
    set.seed(29)
    x[is.na(x)] <- sample(pop, sum(is.na(x)), replace = TRUE, prob = my_df$Freq)
    return(x)}
# Function to impute the whole data set with mean for numerical columns 
# and frequency for factorical columns
imp_mean_fre_f <- function(df, opt){
  # Impute df, use frequency for factorial columns, use mean/median for numerical columns
  # df: dataframe
  # opt = 1 for mean, opt=2 for using median
  if (opt==1){
    df <-  df %>%
      mutate_if(is.numeric, replace_by_mean_f) %>% 
      mutate_if(is.factor, replace_na_categorical_f)
  } else {
    df <-  df %>%
      mutate_if(is.numeric, replace_by_median_f) %>% 
      mutate_if(is.factor, replace_na_categorical_f)
  }
  return(df)}