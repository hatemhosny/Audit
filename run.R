rm(list = ls())
library(dplyr)

source("ImportCleanSave.R")
source("FilterBy.R")
source("TotalsTable.R")
source("AdultsPedsTable.R")
source("AgeGroupsTable.R")
source("GenderTable.R")
source("WeekDayTable.R")
source("CityTable.R")
source("ProceduresTable.R")
source("RedoTable.R")
source("SurgeonTable.R")
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
WriteToExcel(data, "../output/audit.xlsx", "Totals", TotalsTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Adults-Peds", AdultsPedsTable)
WriteToExcel(data, "../output/audit.xlsx", "Adults-Peds", AdultsPedsTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Age Groups", AgeGroupsTable)
WriteToExcel(data, "../output/audit.xlsx", "Age Groups", AgeGroupsTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Gender", GenderTable)
WriteToExcel(data, "../output/audit.xlsx", "Gender", GenderTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "City", CityTable)
WriteToExcel(data, "../output/audit.xlsx", "City", CityTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Week days", WeekDayTable)

WriteToExcel(data, "../output/audit.xlsx", "Procedures", ProceduresTable)
WriteToExcel(data, "../output/audit.xlsx", "Procedures", ProceduresTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Redo", RedoTable)
WriteToExcel(data, "../output/audit.xlsx", "Redo", RedoTable, interval="quarter", append=TRUE)

WriteToExcel(data, "../output/audit.xlsx", "Surgeon", SurgeonTable)
WriteToExcel(data, "../output/audit.xlsx", "Surgeon", SurgeonTable, interval="quarter", append=TRUE)

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
