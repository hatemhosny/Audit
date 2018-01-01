# playground for code testing


x <- new.env()
attach(x)

# detach(x)
# rm(x)


df[df[[date.filter]] >= start.date & df[[date.filter]] <= start.date ,]

var <- "Mortality"

dfx <- data[data["MRN"]>20000,]

dfx <- data[data["Mortality"] == TRUE,]

dfx <- data[data[["Date.of.Operation"]] > as.Date("2015-1-1") &
            data[["Date.of.Operation"]] < as.Date("2016-1-1")
            ,]


dfx <- data %>%
  FilterBy("Mortality") %>%
  FilterByMonth(2017, 12, date.filter = "Date.of.mortality.")
nrow(dfx)

sum(data$Mortality)
library(rlang)
str(data$MRN)


# All years
WriteToExcel(operations, "../output/test.xlsx", "Totals-new", TotalsTable, allDf = allOperations)
WriteToExcel(data, "../output/test.xlsx", "Totals-new", TotalsTable, interval = "quarter", append = TRUE)


dfx <- data %>%
  FilterBy("Procedures..choice.Exploration.for.bleeding.") %>%
  FilterBy("Mortality")


dfx$Mortality



WriteToExcel(operations, "../output/test.xlsx", "2017", TotalsTable, 2017, allDf = allOperations)
WriteToExcel(allOperations, "../output/test.xlsx", "Procedure Mortality", ProcedureMortalityTable,
             2017, interval="quarter")


others <- allOperations %>%
  FilterBy("Procedures..choice.Other.") %>%
  select(MRN, Event.Name, Procedure., starts_with("Procedures..choice."))
procedures <- lapply(apply(others == TRUE, 1, which), names)
procedures <- as.data.frame(lapply(procedures, paste, collapse = ', ')) %>%
  t() %>%
  gsub(pattern = "Procedures..choice.", replacement = "", fixed = TRUE) %>%
  gsub(pattern = ".", replacement = " ", fixed = TRUE)
others <- cbind(others, procedures) %>%
  select(MRN, Event.Name, procedure.details=Procedure., procedures)

write.csv(others, "../output/other.csv", row.names = FALSE)

str(others)

