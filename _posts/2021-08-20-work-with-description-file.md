This project uses the [House Prices data gotten from Kaggle](https://www.kaggle.com/c/house-prices-advanced-regression-techniques). 

Here is the link to the file [2_WorkWithDescriptionFile](https://htmlpreview.github.io/?https://github.com/tranktle/ml_with_r_h2o/blob/main/ml_with_r_h2o/code/2_WorkWithDescriptionFile.html#2_Explain_the_two_functions_above)

The purpose of this file is to show how to use data_description.txt to find the list of characteristics columns that contain "NA" as inputs. The NAs here do not mean missing values but "contain None", for example, a house that has no Basement. We will do this in two steps: 

1. We want to create a tibble from the description file. This tibble contains 4 columns named index, name (values are name of columns or values of factorial levels), description, num_fac (that contains values: "num_col",  "fac_col", "fac_val" indicating whether the name appeared in the name column is a "numerical column", "factorial column" or "factorial level values")
2. Names of the columns having "NA" meaning "None".

