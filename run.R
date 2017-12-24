rm(list = ls())
source("SourceScripts.R")
LoadDependencies(c("dplyr", "xlsx", "lubridate", "circlize"))

raw.data.file <- "../data/data.csv"
clean.data.file <- "../data/data-clean.csv"
output.file <- "../output/audit.xlsx"

# ImportCleanSave(raw.data.file, clean.data.file)
data <- read.csv(clean.data.file, stringsAsFactors = FALSE)

data <- data %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.", FALSE) %>%
  select(-Procedures..choice.Exploration.for.bleeding.)

print("Creating reports...")

# 2017
WriteToExcel(data, output.file, "2017", TotalsTable, 2017)
WriteToExcel(data, output.file, "2017", AdultsPedsTable, 2017, append=TRUE)
WriteToExcel(data, output.file, "2017", AgeGroupsTable, 2017, append=TRUE)
WriteToExcel(data, output.file, "2017", GenderTable, 2017, append=TRUE)
WriteToExcel(data, output.file, "2017", ProceduresTable, 2017, append=TRUE)
WriteToExcel(data, output.file, "2017", TotalsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, output.file, "2017", AdultsPedsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, output.file, "2017", AgeGroupsTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, output.file, "2017", GenderTable, 2017, interval="quarter", append=TRUE)
WriteToExcel(data, output.file, "2017", ProceduresTable, 2017, interval="quarter", append=TRUE)

# All years
WriteToExcel(data, output.file, "Totals", TotalsTable)
WriteToExcel(data, output.file, "Totals", TotalsTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Adults-Peds", AdultsPedsTable)
WriteToExcel(data, output.file, "Adults-Peds", AdultsPedsTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Age Groups", AgeGroupsTable)
WriteToExcel(data, output.file, "Age Groups", AgeGroupsTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Gender", GenderTable)
WriteToExcel(data, output.file, "Gender", GenderTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "City", CityTable)
WriteToExcel(data, output.file, "City", CityTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Week days", WeekDayTable)

WriteToExcel(data, output.file, "Procedures", ProceduresTable)
WriteToExcel(data, output.file, "Procedures", ProceduresTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Redo", RedoTable)
WriteToExcel(data, output.file, "Redo", RedoTable, interval="quarter", append=TRUE)

WriteToExcel(data, output.file, "Surgeon", SurgeonTable)
WriteToExcel(data, output.file, "Surgeon", SurgeonTable, interval="quarter", append=TRUE)

print("Creating plots...")

data %>%
  FilterBy("Section", "Adults") %>%
  FilterByYear(2017) %>%
  WriteToExcel(output.file, "Plots", PlotProcedures, isPlot=TRUE
               , title="Adults 2017", section="Adults")

data %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByYear(2017) %>%
  WriteToExcel(output.file, "Plots", PlotProcedures, isPlot=TRUE
               , title="Pediatrics 2017", section="Pediatrics", append=TRUE)


print("Done!")

# CreateTemplateFrom("../output/audit.xlsx")
