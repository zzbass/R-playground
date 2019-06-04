# install.packages("tidyverse")
# install.packages("xlsx") 
# install.packages("rJava")
# install.packages("data.table")

# solving rjava.dll issue during loading library(xlsx)
Sys.getenv("JAVA_HOME")
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_211')

# work directory setup
setwd("D:\\Users\\251303\\data R\\CodeTandem\\")
# print(getwd()) -- path validation

library(tidyverse)
library(xlsx)
library(data.table)
library(readxl)

# read data from csv file
df_medial_csv <- read.csv("medial_utf_libre2.csv", header=TRUE, encoding = "UTF-8")
print(df_medial_csv)
write_csv(df_medial_csv,"vystup.csv")

# creating a subset of data from the source; the goal is to remove repeated row ID
df_medial_csv_blank <- subset(df_medial_csv, Title!="Title")
exclude_contributor <- c("Contributor", "\n        Administrator\n")


##df_mcb_00 <- pull(df_medial_csv, Contributor)
##df_mcb_00 <- subset(df_medial_csv, Contributor!="\\n.*Administrator")
##df_mcb_00 <- subset(df_medial_csv, Title=regex("\\d"))

df_mcb_01 <- subset(df_medial_csv, Contributor!=exclude_contributor)

df_mcb_00 <- df_medial_csv %>% map_dfc(str_trim)


# test of triming the whitespaces from the beginnning and the end of a string
## testring <- str_trim("     Admin     ", side = c("both"))  
## print(testring)

# test of a function to be applied on a certain row in a dataframe
f = function(x, output) {
  Contributor = x[3]
  str_trim(x, side=c("both"))
}

df_medial_csv_blank_white <- apply(df_medial_csv_blank, 2, f)

# creating a subset ; all withou Contributor = "Administrator"
df_medial_csv_blank_white_admin <- subset(df_medial_csv_blank_white, Contributor!="Administrator")


# read data from xlsx file
df_medial <- read.xlsx("medial_xlsx.xlsx", 1, as.data.frame=TRUE, header = TRUE)
print(df_medial)

sessionInfo() 
#df <- df_medial
#fwrite(df,"temp.csv")
#table_df_medial <- fread("temp.csv",encoding = "Latin-1")