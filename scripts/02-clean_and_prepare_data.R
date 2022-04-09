### Clean and prepare the dataset ###

## Setup Workspace ## 
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)
## Read in the raw data that we created in "scripts/01-gather_data.R" ##

raw_data <-
read_csv(file = "raw_data.csv",
         show_col_types = FALSE)


## clean the data ##

## 01-gather_data.R must have been done already ##

data <-
  raw_data[[1]] |>
strsplit("\n") 

data <-
  tibble(grp = unlist(data))

#extract data about age #
data_age <-
  data |>
  slice(13:19)


# delete all the commas #
data_age <-
  tibble(grp = str_replace_all(data_age$grp, ",", ""))



data_age <-
data_age |>
  mutate(grp = str_squish(grp)) |>
  separate(
    col = grp,
    into = c("age", "own_land", "rented_land", "someone_elses_land", "prof_tech", "mgmt_admin", "clerical", "sales", "services", "industrial", "total", "number_of_women"),
    sep = "\\s"
  ) 


#convert class of elements into numeric (except for "age" column) #
data_age <-
data_age |>
  mutate(across(own_land:number_of_women, as.numeric))

## Do the samething for other topics ##

# extract data about residence #

data_residence <-
  data |>
  slice(22:23) |>
  mutate(grp = str_squish(grp))

# delete all the commas #
data_residence <-
  tibble(grp = str_replace_all(data_residence$grp, ",", ""))

data_residence <-
  data_residence |>
  separate(
    col = grp,
    into = c("residence", "own_land", "rented_land", "someone_elses_land", "prof_tech", "mgmt_admin", "clerical", "sales", "services", "industrial", "total", "number_of_women"),
    sep = "\\s") |>
  mutate(across(own_land:number_of_women, as.numeric))




# extract data about region #

data_region <-
  data |>
  slice(26:34) |>
  mutate(grp = str_squish(grp))

# Delete whitespaces of the name of the regions #
data_region$grp[4] <- "outer_java_bali_1 38.5 2.9 12.6 6.6 0.2 2.8 22.5 4.3 9.5 100.0 4,052"
data_region$grp[7] <- "outer_java_bali_2 53.7 0.4 7.5 6.4 0.3 4.0 18.4 3.2 6.1 100.0 1,703"

# delete all the commmas #
data_region <-
  tibble(grp = str_replace_all(data_region$grp, ",", "."))



data_region <-
  data_region |>
  separate(
    col = grp,
    into = c("region", "own_land", "rented_land", "someone_elses_land", "prof_tech", "mgmt_admin", "clerical", "sales", "services", "industrial", "total", "number_of_women"),
    sep = "\\s") |>
  mutate(across(own_land:number_of_women, as.numeric))

# rename some data #
data_region[1,1] <- "java_bali"
data_region[2,1] <- "java_bali_urban"
data_region[3,1] <- "java_bali_rural"
data_region[5,1] <- "outer_java_bali_1_urban"
data_region[6,1] <- "outer_java_bali_1_rural"
data_region[8,1] <- "outer_java_bali_2_urban"
data_region[9,1] <- "outer_java_bali_2_rural"

# Extract data about education #

data_education <-
  data |>
  slice(37:40) |>
  mutate(grp = str_squish(grp))

# Delete whitespaces of the names #
data_education$grp[1] <- "no_education 40.5 1.5 23.3 0.1 0.0 0.2 15.9 4.5 14.0 100,0 2293"
data_education$grp[2] <- "some_primary 35.7 2.0 17.5 0,1 0.0 0.0 23.2 5.5 16,0 100.0 4369"
data_education$grp[3] <- "primary_completed 33.7 1.8 11.2 0.2 0,0 0,4 26,9 5.8 19.9 100.0 3951"
data_education$grp[4] <- "some_secondary+ 12.2 0.7 2.8 19.6 1.2 10.7 29.7 7.8 15.3 100.0 3714"

# replace all the commmas with dots#
data_education <-
  tibble(grp = str_replace_all(data_education$grp, ",", "."))

data_education <-
  data_education |>
  separate(
    col = grp,
    into = c("education", "own_land", "rented_land", "someone_elses_land", "prof_tech", "mgmt_admin", "clerical", "sales", "services", "industrial", "total", "number_of_women"),
    sep = "\\s") |>
  mutate(across(own_land:number_of_women, as.numeric))

# Extract data about total #

data_total <-
  data |>
  slice(42) |>
  mutate(grp = str_squish(grp))

data_total <-
  tibble(grp = str_replace_all(data_total$grp, ",", ""))

data_total <-
  data_total |>
  separate(
    col = grp,
    into = c("total", "own_land", "rented_land", "someone_elses_land", "prof_tech", "mgmt_admin", "clerical", "sales", "services", "industrial", "total", "number_of_women"),
    sep = "\\s") |>
  mutate(across(own_land:number_of_women, as.numeric))

### Cleaning finished ###

### Save the data ###

write_csv(data_age,
          file = "cleaned_data_age.csv")
write_csv(data_region,
          file = "cleaned_data_region.csv")
write_csv(data_residence,
          file = "cleaned_data_residence.csv")
write_csv(data_education,
          file = "cleaned_data_education.csv")
write_csv(data_total,
          file = "cleaned_data_total.csv")



### Conduct tests ###

## 00-simulation.R must have been done already ##

library(pointblank)

agent <-
  create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(age)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

# Test data about age #

tested_data <- data_age

agent #check if the data pass all the steps

# test data about residence #

tested_data <- data_residence

agent <-
  create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(residence)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

agent #check if the data pass all the steps

# test data about region #

tested_data <- data_region

agent <-
  create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(region)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

agent #check if the data pass all the steps

# test data about education #

tested_data <- data_education

agent <-
  create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(education)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

agent #check if the data pass all the steps

# test data about total #

tested_data <- data_total

agent <-
  create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(total)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

agent #check if the data pass all the steps
