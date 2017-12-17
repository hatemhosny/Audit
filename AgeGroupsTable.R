library(dplyr)

source("FilterBy.R")

AgeGroupsTable <- function(df, year, interval = "month") {

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

  df$days.from.operation <- as.Date(df[["Date.of.Operation"]], format = "%Y-%m-%d") -
    as.Date(df[["Date.of.Birth"]], format = "%Y-%m-%d")

  neonatesFilter <- list(list("days.from.operation", 31, "lte"))
  neonates <- getGroupFn(df, year, neonatesFilter)

  infantsFilter <- list(
    list("days.from.operation", 31, "mt"),
    list("days.from.operation", 365, "lte")
    )
  infants <- getGroupFn(df, year, infantsFilter)

  olderFilter <- list(list("days.from.operation", 365, "mt"))
  older <- getGroupFn(df, year, olderFilter)


  Total <- neonates + infants + older

  ageGroupsTable <- data.frame(neonates, infants, older, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  ageGroupsTable
}
