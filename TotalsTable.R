library(dplyr)

source("FilterBy.R")

TotalsTable <- function(df, year, interval = "month") {

  months <- c("JAN",	"FEB",	"MAR",	"APR", "MAY",	"JUN",
              "JUL",	"AUG",	"SEP",	"OCT",	"NOV",	"DEC", "Total")

  quarters <- c("Q1",	"Q2",	"Q3",	"Q4", "Total")

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }


  TotalsFilter <- list(list("MRN", "", "neq"))
  Total <- getGroupFn(df, year, TotalsFilter)


  totalsTable <- data.frame(Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  totalsTable
}


