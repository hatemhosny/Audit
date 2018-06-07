rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize", "RCurl"))

files <- list(
  raw.data = "../data/data.csv",
  clean.data = "../data/data-clean.csv",
  output = "../output/audit-2018-Q1.xlsx",
  output.plots =  "../output/audit-2018-Q1-plots.xlsx"
)

Config$Years <- 2009:2018
Config$Quarter <- "Q1"
this.year <- last(Config$Years)
last.Year <- this.year - 1

ExportFromRedcap(files$raw.data)
ImportCleanSave(files$raw.data, files$clean.data)

allOperations <- read.csv(files$clean.data, stringsAsFactors = FALSE) %>%
  FilterByQuarter(Config$Years, Config$Quarter)

operations <- allOperations %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE)



tables <- list(
  TotalsTable,
  AdultsPedsTable,
  AgeGroupsTable,
  GenderTable,
  CityTable,
  WeekDayTable,
  ProceduresTable,
  RedoTable,
  SurgeonTable,
  TrainersTable,
  AdultsPedsMortalityTable,
  AgeGroupsMortalityTable,
  ProcedureMortalityTable,
  SurgeonMortalityTable
)

cat("Creating plots...", "\n")

operations %>%
  FilterBy("Section", "Adults") %>%
  # FilterByYear(2017) %>%
  FilterByQuarter(2018, "Q1") %>%
  WriteToExcel(files$output.plots, "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2018-Q1", section="Adults", template="")

operations %>%
  FilterBy("Section", "Pediatrics") %>%
  # FilterByYear(2017) %>%
  FilterByQuarter(2018, "Q1") %>%
  WriteToExcel(files$output.plots, "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2018-Q1", section="Pediatrics", template="", append=TRUE)


cat("Creating reports...", "\n")

# This Year
WriteToExcel(operations, files$output, "This Year", TotalsTable, this.year, allDf = allOperations)
WriteToExcel(operations, files$output, "This Year", AdultsPedsTable, this.year, append=TRUE)
WriteToExcel(operations, files$output, "This Year", AgeGroupsTable, this.year, append=TRUE)
WriteToExcel(operations, files$output, "This Year", GenderTable, this.year, append=TRUE)
WriteToExcel(operations, files$output, "This Year", ProceduresTable, this.year, append=TRUE)
WriteToExcel(operations, files$output, "This Year-Q", TotalsTable, this.year, allDf = allOperations, interval="quarter")
WriteToExcel(operations, files$output, "This Year-Q", AdultsPedsTable, this.year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "This Year-Q", AgeGroupsTable, this.year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "This Year-Q", GenderTable, this.year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "This Year-Q", ProceduresTable, this.year, interval="quarter", append=TRUE)


# Last Year
WriteToExcel(operations, files$output, "Last Year", TotalsTable, last.Year, allDf = allOperations)
WriteToExcel(operations, files$output, "Last Year", AdultsPedsTable, last.Year, append=TRUE)
WriteToExcel(operations, files$output, "Last Year", AgeGroupsTable, last.Year, append=TRUE)
WriteToExcel(operations, files$output, "Last Year", GenderTable, last.Year, append=TRUE)
WriteToExcel(operations, files$output, "Last Year", ProceduresTable, last.Year, append=TRUE)
WriteToExcel(operations, files$output, "Last Year-Q", TotalsTable, last.Year, allDf = allOperations, interval="quarter")
WriteToExcel(operations, files$output, "Last Year-Q", AdultsPedsTable, last.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Last Year-Q", AgeGroupsTable, last.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Last Year-Q", GenderTable, last.Year, interval="quarter", append=TRUE)
WriteToExcel(operations, files$output, "Last Year-Q", ProceduresTable, last.Year, interval="quarter", append=TRUE)


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



cat("Creating summary tables", "\n")

WriteToExcel(operations, files$output, "Summary", SummaryTable, funs=tables, isSummary=TRUE,
             allDf=allOperations)

WriteToExcel(operations, files$output, "Summary-Q", SummaryTable, funs=tables, isSummary=TRUE,
             allDf=allOperations, interval="quarter")


cat("Done!", "\n")

# CreateTemplateFrom(files$output)
