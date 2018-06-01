TotalsTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  TotalsFilter <- list(list("Patient.ID", "", "neq"))
  Total <- getGroupFn(df, year, TotalsFilter)

  MortalityFilter <- list(list("Mortality", TRUE), list("Date.of.mortality.", "", "neq"))

  # use date of operation
  Mortality <- getGroupFn(allDf, year, MortalityFilter)

  # use date of mortality
  # Mortality <- getGroupFn(df, year, MortalityFilter, date.filter = "Date.of.mortality.")

  Mortality.Percent <- round(Mortality/Total*100, digits = 1) %>% convertNANtoZero()

  Table <- data.frame(Total, Mortality, Mortality.Percent, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE)

  Table
}
