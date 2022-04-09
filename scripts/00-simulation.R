### Workspace Setup ###

library(tidyverse)

## Create simulated data ##

## About age ##
set.seed(823)

simulated_data_age <-
tibble(
  age = c("15-19", "20-24", "25-29", "30-34","35-39", "40-44", "45-49"),
  own_land = rnorm(7, mean = 30, sd = 5),
  rented_land = rnorm(7, mean = 5, sd = 1),
  someone_elses_land = rnorm(7, mean = 15, sd = 3),
  prof_tech = rnorm(7, mean = 1, sd = 0.5),
  mgmt_admin = rnorm(7, mean = 1, sd = 0.5),
  clerical = rnorm(7, mean = 5, sd = 1),
  sales = rnorm(7, mean = 5, sd = 1),
  services = rnorm(7, mean = 5, sd = 1),
  industrial = rnorm(7, mean = 20, sd = 3),
  number_of_women = rnorm(7, mean = 2000, sd = 100)
)

## About Residence ##

simulated_data_residence <-
  tibble(
    age = c("urban", "rural"),
    own_land = rnorm(2, mean = 3, sd = 1),
    rented_land = rnorm(2, mean = 3, sd = 1),
    someone_elses_land = rnorm(2, mean = 3, sd = 1),
    prof_tech = rnorm(2, mean = 3, sd = 1),
    mgmt_admin =rnorm(2, mean = 3, sd = 1),
    clerical = rnorm(2, mean = 3, sd = 1),
    sales = rnorm(2, mean = 30, sd = 10),
    services = rnorm(2, mean = 20, sd = 10),
    industrial = rnorm(2, mean = 17, sd = 1),
    number_of_women = rnorm(2, mean = 7000, sd = 1000)
  )

## About Region ##

simulated_data_region <-
  tibble(
    age = c("java_bali", "java_bali_urban", "java_bali_rural", "outer_java_bali_1", "outer_java_bali_1_urban", "outer_java_bali_1_rural","outer_java_bali_2", "outer_java_bali_2_urban", "outer_java_bali_2_rural" ),
    own_land = rnorm(9, mean = 20, sd = 5),
    rented_land = rnorm(9, mean = 3, sd = 1),
    someone_elses_land = rnorm(9, mean = 15, sd = 5),
    prof_tech = rnorm(9, mean = 3, sd = 1),
    mgmt_admin =rnorm(9, mean = 3, sd = 1),
    clerical = rnorm(9, mean = 3, sd = 1),
    sales = rnorm(9, mean = 30, sd = 10),
    services = rnorm(9, mean = 20, sd = 10),
    industrial = rnorm(9, mean = 17, sd = 1),
    number_of_women = rnorm(9, mean = 4000, sd = 1000)
  )


## About education ##
simulated_data_education <-
  tibble(
    age = c("no_education", "some_primary", "primary_completed", "some_secondary+"),
    own_land = rnorm(4, mean = 3, sd = 1),
    rented_land = rnorm(4, mean = 3, sd = 1),
    someone_elses_land = rnorm(4, mean = 3, sd = 1),
    prof_tech = rnorm(4, mean = 3, sd = 1),
    mgmt_admin =rnorm(4, mean = 3, sd = 1),
    clerical = rnorm(4, mean = 3, sd = 1),
    sales = rnorm(4, mean = 30, sd = 10),
    services = rnorm(4, mean = 20, sd = 10),
    industrial = rnorm(4, mean = 17, sd = 1),
    number_of_women = rnorm(4, mean = 7000, sd = 1000)
  )


## Test ##
library(pointblank)

tested_data <- simulated_data_age

agent <-
create_agent(tbl = tested_data) |>
  col_is_character(columns = vars(age)) |>
  col_is_integer(columns = vars(own_land, rented_land, someone_elses_land, prof_tech, mgmt_admin, clerical, sales, services, industrial,  number_of_women)) |>
  rows_complete() |>
  interrogate()

agent

  

