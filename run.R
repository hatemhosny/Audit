rm(list = ls())
library(dplyr)

source("ImportCleanSave.R")
source("FilterBy.R")
source("TotalsTable.R")
source("AdultsPedsTable.R")
source("AgeGroupsTable.R")
source("GenderTable.R")
source("ProceduresTable.R")
source("WriteToExcel.R")

# ImportCleanSave("data/data.csv", "data/data-clean.csv")
allData <- read.csv("data/data-clean.csv", stringsAsFactors = FALSE)

data <- allData %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE)

print("Creating reports. Please wait...")

# 2017
WriteToExcel(data, "../output/audit.xlsx", "2017", TotalsTable, 2017)
WriteToExcel(data, "../output/audit.xlsx", "2017", AdultsPedsTable, 2017, append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", AgeGroupsTable, 2017, append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", GenderTable, 2017, append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", ProceduresTable, 2017, append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", TotalsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", AdultsPedsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", AgeGroupsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", GenderTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, "../output/audit.xlsx", "2017", ProceduresTable, 2017, interval="quarter", append=TRUE)

# All years
WriteToExcel(data, "../output/audit.xlsx", "Totals", TotalsTable)
WriteToExcel(data, "../output/audit.xlsx", "Totals-Q", TotalsTable, interval="quarter")
WriteToExcel(data, "../output/audit.xlsx", "Adults-Peds", AdultsPedsTable)
WriteToExcel(data, "../output/audit.xlsx", "Adults-Peds-Q", AdultsPedsTable, interval="quarter")
WriteToExcel(data, "../output/audit.xlsx", "Age Groups", AgeGroupsTable)
WriteToExcel(data, "../output/audit.xlsx", "Age Groups-Q", AgeGroupsTable, interval="quarter")
WriteToExcel(data, "../output/audit.xlsx", "Gender", GenderTable)
WriteToExcel(data, "../output/audit.xlsx", "Gender-Q", GenderTable, interval="quarter")
WriteToExcel(data, "../output/audit.xlsx", "Procedures", ProceduresTable)
WriteToExcel(data, "../output/audit.xlsx", "Procedures-Q", ProceduresTable, interval="quarter")

print("Creating plots...")

data %>%
  FilterBy("Section", "Adults") %>%
  FilterByYear(2017) %>%
  WriteToExcel("../output/audit.xlsx", "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2017", section="Adults")

data %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByYear(2017) %>%
  WriteToExcel("../output/audit.xlsx", "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2017", section="Pediatrics", append=TRUE)


print("Done!")


