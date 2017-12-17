rm(list = ls())
library(dplyr)

source("ImportCleanSave.R")
source("FilterBy.R")
source("AdultsPedsTable.R")
source("AgeGroupsTable.R")
source("ProceduresTable.R")
source("WriteToExcel.R")

# ImportCleanSave("data/data.csv", "data/data-clean.csv")
data <- read.csv("data/data-clean.csv", stringsAsFactors = FALSE)

WriteToExcel(data, "output/audit.xlsx", "Sheet1", AdultsPedsTable, 2017)
WriteToExcel(data, "output/audit.xlsx", "Adults-Peds", AdultsPedsTable)
WriteToExcel(data, "output/audit.xlsx", "Adults-Peds-Q", AdultsPedsTable, interval="quarter")
WriteToExcel(data, "output/audit.xlsx", "Age Groups", AgeGroupsTable)
WriteToExcel(data, "output/audit.xlsx", "Age Groups-Q", AgeGroupsTable, interval="quarter")
WriteToExcel(data, "output/audit.xlsx", "Procedures", ProceduresTable)
WriteToExcel(data, "output/audit.xlsx", "Procedures-Q", ProceduresTable, interval="quarter")

data %>%
  FilterBy("Section", "Adults") %>%
  FilterByYear(2017) %>%
  WriteToExcel("output/audit.xlsx", "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2017", section="Adults")

data %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByYear(2017) %>%
  WriteToExcel("output/audit.xlsx", "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2017", section="Pediatrics", append=TRUE)


#
# PediatricsFilter <- list()
# Pediatrics <- GetGroupByQuarter(data, 2017)
