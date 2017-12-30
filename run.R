rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize"))

cat("\014")

raw.data.file <- "../data/data.csv"
clean.data.file <- "../data/data-clean.csv"
output.file <- "../output/audit.xlsx"

# ImportCleanSave(raw.data.file, clean.data.file)
allOperations <- read.csv(clean.data.file, stringsAsFactors = FALSE)

operations <- allOperations %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE) %>%
  select(-Procedures..choice.Exploration.for.bleeding.)

cat("Creating reports...", "\n")

# 2017
WriteToExcel(operations, output.file, "2017", TotalsTable, 2017, allDf = allOperations)
WriteToExcel(operations, output.file, "2017", AdultsPedsTable, 2017, append=TRUE)
WriteToExcel(operations, output.file, "2017", AgeGroupsTable, 2017, append=TRUE)
WriteToExcel(operations, output.file, "2017", GenderTable, 2017, append=TRUE)
WriteToExcel(operations, output.file, "2017", ProceduresTable, 2017, append=TRUE)
WriteToExcel(operations, output.file, "2017", TotalsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, output.file, "2017", AdultsPedsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, output.file, "2017", AgeGroupsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, output.file, "2017", GenderTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, output.file, "2017", ProceduresTable, 2017, interval="quarter", append=TRUE)

# All years
WriteToExcel(operations, output.file, "Totals", TotalsTable, allDf = allOperations)
WriteToExcel(operations, output.file, "Totals", TotalsTable, allDf = allOperations, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Adults-Peds", AdultsPedsTable)
WriteToExcel(operations, output.file, "Adults-Peds", AdultsPedsTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Ped. Age Groups", AgeGroupsTable)
WriteToExcel(operations, output.file, "Ped. Age Groups", AgeGroupsTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Gender", GenderTable)
WriteToExcel(operations, output.file, "Gender", GenderTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "City", CityTable)
WriteToExcel(operations, output.file, "City", CityTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Week days", WeekDayTable)

WriteToExcel(operations, output.file, "Procedures", ProceduresTable)
WriteToExcel(operations, output.file, "Procedures", ProceduresTable, interval="quarter", append=TRUE)

notRedo <- operations %>%
  FilterBy("Redo.Operation", FALSE)
WriteToExcel(notRedo, output.file, "Non-redo Procedures", ProceduresTable)

WriteToExcel(operations, output.file, "Redo", RedoTable)
WriteToExcel(operations, output.file, "Redo", RedoTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Surgeon", SurgeonTable)
WriteToExcel(operations, output.file, "Surgeon", SurgeonTable, interval="quarter", append=TRUE)

cat("Creating plots...", "\n")

operations %>%
  FilterBy("Section", "Adults") %>%
  FilterByYear(2017) %>%
  WriteToExcel(output.file, "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2017", section="Adults")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByYear(2017) %>%
  WriteToExcel(output.file, "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2017", section="Pediatrics", append=TRUE)


cat("Done!", "\n")

# CreateTemplateFrom("../output/audit.xlsx")
