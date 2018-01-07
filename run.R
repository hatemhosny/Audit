rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize", "RCurl"))

files <- list(
  raw.data = "../data/data.csv",
  clean.data = "../data/data-clean.csv",
  output = "../output/audit.xlsx"
)

ExportFromRedcap(files$raw.data)
ImportCleanSave(files$raw.data, files$clean.data)

allOperations <- read.csv(files$clean.data, stringsAsFactors = FALSE)

operations <- allOperations %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE) %>%
  select(-Procedures..choice.Exploration.for.bleeding.)


cat("Creating plots...", "\n")

operations %>%
  FilterBy("Section", "Adults") %>%
  FilterByYear(2017) %>%
  WriteToExcel(files$output, "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2017", section="Adults")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByYear(2017) %>%
  WriteToExcel(files$output, "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2017", section="Pediatrics", append=TRUE)


cat("Creating reports...", "\n")

# 2017
WriteToExcel(operations, files$output, "2017", TotalsTable, 2017, allDf = allOperations)
WriteToExcel(operations, files$output, "2017", AdultsPedsTable, 2017, append=TRUE)
WriteToExcel(operations, files$output, "2017", AgeGroupsTable, 2017, append=TRUE)
WriteToExcel(operations, files$output, "2017", GenderTable, 2017, append=TRUE)
WriteToExcel(operations, files$output, "2017", ProceduresTable, 2017, append=TRUE)
WriteToExcel(operations, files$output, "2017", TotalsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "2017", AdultsPedsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "2017", AgeGroupsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "2017", GenderTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "2017", ProceduresTable, 2017, interval="quarter", append=TRUE)

# All years
WriteToExcel(operations, files$output, "Totals", TotalsTable, allDf = allOperations)
WriteToExcel(operations, files$output, "Totals", TotalsTable, allDf = allOperations, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Adults-Peds", AdultsPedsTable)
WriteToExcel(operations, files$output, "Adults-Peds", AdultsPedsTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Ped. Age Groups", AgeGroupsTable)
WriteToExcel(operations, files$output, "Ped. Age Groups", AgeGroupsTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Gender", GenderTable)
WriteToExcel(operations, files$output, "Gender", GenderTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "City", CityTable)
WriteToExcel(operations, files$output, "City", CityTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Week days", WeekDayTable)

WriteToExcel(operations, files$output, "Procedures", ProceduresTable)
WriteToExcel(operations, files$output, "Procedures", ProceduresTable, interval="quarter", append=TRUE)

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(files$output, "Adult Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(files$output, "Pediatric Procedures", ProceduresTable, interval="quarter")

operations %>%
  FilterBy("Redo.Operation", FALSE) %>%
  WriteToExcel(files$output, "Non-redo Procedures", ProceduresTable)

WriteToExcel(operations, files$output, "Redo", RedoTable)
WriteToExcel(operations, files$output, "Redo", RedoTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Surgeons", SurgeonTable)
WriteToExcel(operations, files$output, "Surgeons", SurgeonTable, interval="quarter", append=TRUE)

operations %>%
  FilterBy("Section", "Adults") %>%
  WriteToExcel(files$output, "Adult Surgeons", SurgeonTable, interval="quarter")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  WriteToExcel(files$output, "Pediatric Surgeons", SurgeonTable, interval="quarter")

WriteToExcel(operations, files$output, "Trainers", TrainersTable)
WriteToExcel(operations, files$output, "Trainers", TrainersTable, interval="quarter", append=TRUE)

WriteToExcel(operations, files$output, "Adults-Peds Mortality", AdultsPedsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(operations, files$output, "Ped. Age Groups Mortality", AgeGroupsMortalityTable,
             interval="quarter", allDf=allOperations)

WriteToExcel(allOperations, files$output, "Procedure Mortality", ProcedureMortalityTable,
             2017, interval="quarter")

WriteToExcel(operations, files$output, "Surgeon Mortality", SurgeonMortalityTable,
             interval="quarter", allDf=allOperations)



cat("Done!", "\n")

# CreateTemplateFrom("../output/audit.xlsx")
