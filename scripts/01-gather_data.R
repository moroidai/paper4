### Read in data from pdf ###

## Data is available at https://dhsprogram.com/pubs/pdf/FR95/FR95.pdf. It's also in "inputs" folder at https://github.com/moroidai/Final-Paper. I will analyze the data from page 24 about women's occupation in Indonesia##

## Set-up Workspace ##
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("pdftools")) install.packages("pdftools")
library(tidyverse)
library(pdftools)

# Download a file #
download.file(url = "https://dhsprogram.com/pubs/pdf/FR95/FR95.pdf",
              destfile = "FR95.pdf")

# Read in teh pdf file as character vectors #
raw_data <-
  pdf_text("FR95.pdf")

# make it into tibble #
raw_data <-
  raw_data |>
  tibble()

# pick a page that we are interested in #
raw_data <-
  raw_data |>
  slice(58)

# save as a raw_data.csv #

write_csv(x =raw_data,
          file = "raw_data.csv")
