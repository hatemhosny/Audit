TotalsTable <- function(df, year, interval = "month") {

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


  totalsTable <- data.frame(Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  totalsTable
}


