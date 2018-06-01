SummaryTable <- function(df, funs, years, interval="month", ...) {

  if (interval == "quarter") {
    usedInterval <- 4
  } else {
    usedInterval <- 12
  }

  summaryDf <- data.frame()
  i <- 1  # counter to avoid duplicate column names

  for (fn in funs) {

    fnDf <- data.frame()

    for (year in years) {

      yearDf <- fn(df, year, interval=interval, ...) %>%
        t() %>%
        as.data.frame()

      if (interval == "quarter") {

        yearDf <- yearDf %>%
          head(4)%>%
          mutate(quarter=c(1:4), year=year) %>%
          select(year, quarter, everything())

      } else {

        yearDf <- yearDf %>%
          head(12)%>%
          mutate(month=c(1:12), year=year) %>%
          select(year, month, everything())
      }

      fnDf <- rbind(fnDf, yearDf)

    }

    if (count(summaryDf) == 0) {
      summaryDf <- fnDf
    } else {
      summaryDf <- merge(summaryDf, fnDf, by=c("year",interval), sort=FALSE,
                         suffixes = c("",paste0(".", i)))
    }

    i <- i + 1
  }

  summaryDf

}
