rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize", "RCurl"))

files <- list(
  raw.data = "../data/data.csv",
  clean.data = "../data/data-clean.csv",
  output = "../output/audit-2018-Q1.xlsx"
)

Config$Years <- 2009:2018
Config$Quarter <- "Q1"
current.Year <- last(Config$Years)

# ExportFromRedcap(files$raw.data)
# ImportCleanSave(files$raw.data, files$clean.data)

allOperations <- read.csv(files$clean.data, stringsAsFactors = FALSE) %>%
  FilterByQuarter(Config$Years, Config$Quarter)

operations <- allOperations %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE)


# cat("Creating plots...", "\n")
#
# operations %>%
#   FilterBy("Section", "Adults") %>%
#   # FilterByYear(2018) %>%
#   FilterByQuarter(2018, "Q1") %>%
#   WriteToExcel(files$output, "Plots", PlotProcedures, isPlot=TRUE
#                , title="Adults 2018-Q1", section="Adults")
#
# operations %>%
#   FilterBy("Section", "Pediatrics") %>%
#   # FilterByYear(2018) %>%
#   FilterByQuarter(2018, "Q1") %>%
#   WriteToExcel(files$output, "Plots", PlotProcedures, isPlot=TRUE
#                , title="Pediatrics 2018-Q1", section="Pediatrics", append=TRUE)


cat("Creating reports...", "\n")

# Current Year
WriteToExcel(operations, files$output, "Year", TotalsTable, current.Year, allDf = allOperations)
WriteToExcel(operations, files$output, "Year", AdultsPedsTable, current.Year, append=TRUE)
WriteToExcel(operations, files$output, "Year", AgeGroupsTable, current.Year, append=TRUE)
WriteToExcel(operations, files$output, "Year", GenderTable, current.Year, append=TRUE)
WriteToExcel(operations, files$output, "Year", ProceduresTable, current.Year, append=TRUE)
WriteToExcel(operations, files$output, "Year-Q", TotalsTable, current.Year, allDf = allOperations, interval="quarter")
WriteToExcel(operations, files$output, "Year-Q", AdultsPedsTable, current.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Year-Q", AgeGroupsTable, current.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Year-Q", GenderTable, current.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Year-Q", ProceduresTable, current.Year, interval="quarter", append=TRUE)


# All years
WriteToExcel(operations, files$output, "Totals", TotalsTable, allDf = allOperations)
WriteToExcel(operations, files$output, "Totals-Q", TotalsTable, allDf = allOperations, interval="quarter")

WriteToExcel(operations, files$output, "Adults-Peds", AdultsPedsTable)
WriteToExcel(operations, files$output, "Adults-Peds-Q", AdultsPedsTable, interval="quarter")

WriteToExcel(operations, files$output, "Ped. Age Groups", AgeGroupsTable)
WriteToExcel(operations, files$output, "Ped. Age Groups-Q", AgeGroupsTable, interval="quarter")

WriteToExcel(operations, files$output, "Gender", GenderTable)
WriteToExcel(operations, files$output, "Gender-Q", GenderTable, interval="quarter")

WriteToExcel(operations, files$output, "City", CityTable)
WriteToExcel(operations, files$output, "City-Q", CityTable, interval="quarter")

WriteToExcel(operations, files$output, "Week days", WeekDayTable)

WriteToExcel(operations, files$output, "Procedures", ProceduresTable)
WriteToExcel(operations, files$output, "Procedures-Q", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(files$output, "Adult Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(files$output, "Pediatric Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Redo.Operation", FALSE) %>%
  WriteToExcel(files$output, "Non-redo Procedures", ProceduresTable, interval="quarter")

WriteToExcel(operations, files$output, "Redo", RedoTable)
WriteToExcel(operations, files$output, "Redo-Q", RedoTable, interval="quarter")

WriteToExcel(operations, files$output, "Surgeons", SurgeonTable)
WriteToExcel(operations, files$output, "Surgeons-Q", SurgeonTable, interval="quarter")

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(files$output, "Adult Surgeons", SurgeonTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(files$output, "Pediatric Surgeons", SurgeonTable, interval="quarter")

WriteToExcel(operations, files$output, "Trainers", TrainersTable)
WriteToExcel(operations, files$output, "Trainers-Q", TrainersTable, interval="quarter")

WriteToExcel(operations, files$output, "Adults-Peds Mortality", AdultsPedsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(operations, files$output, "Ped. Age Groups Mortality", AgeGroupsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(allOperations, files$output, "Procedure Mortality", ProcedureMortalityTable,
             2017, interval="quarter")

WriteToExcel(operations, files$output, "Surgeon Mortality", SurgeonMortalityTable,
             interval="quarter", allDf=allOperations)



cat("Done!", "\n")

# CreateTemplateFrom("../output/audit-2018-Q1.xlsx")
