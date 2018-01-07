rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize"))

raw.data.file <- "../data/data.csv"
clean.data.file <- "../data/data-clean.csv"
output.file <- "../output/audit.xlsx"

# ImportCleanSave(raw.data.file, clean.data.file)
allOperations <- read.csv(clean.data.file, stringsAsFactors = FALSE)

operations <- allOperations %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE) %>%
  select(-Procedures..choice.Exploration.for.bleeding.)


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

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(output.file, "Adult Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(output.file, "Pediatric Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Redo.Operation", FALSE) %>%
  WriteToExcel(output.file, "Non-redo Procedures", ProceduresTable)

WriteToExcel(operations, output.file, "Redo", RedoTable)
WriteToExcel(operations, output.file, "Redo", RedoTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Surgeons", SurgeonTable)
WriteToExcel(operations, output.file, "Surgeons", SurgeonTable, interval="quarter", append=TRUE)

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(output.file, "Adult Surgeons", SurgeonTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(output.file, "Pediatric Surgeons", SurgeonTable, interval="quarter")

WriteToExcel(operations, output.file, "Trainers", TrainersTable)
WriteToExcel(operations, output.file, "Trainers", TrainersTable, interval="quarter", append=TRUE)

WriteToExcel(operations, output.file, "Adults-Peds Mortality", AdultsPedsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(operations, output.file, "Ped. Age Groups Mortality", AgeGroupsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(allOperations, output.file, "Procedure Mortality", ProcedureMortalityTable,
             2017, interval="quarter")

WriteToExcel(operations, output.file, "Surgeon Mortality", SurgeonMortalityTable,
             interval="quarter", allDf=allOperations)



cat("Done!", "\n")

# CreateTemplateFrom("../output/audit.xlsx")
