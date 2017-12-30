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
  Mortality <- getGroupFn(allDf, year, MortalityFilter, date.filter = "Date.of.mortality.")
  # Mortality <- getGroupFn(df, year, MortalityFilter) # filters by date of operation

  MortalityPercent <- round(Mortality/Total*100, digits = 1)

  totalsTable <- data.frame(Total, Mortality, MortalityPercent, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  totalsTable
}


