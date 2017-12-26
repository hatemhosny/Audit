AdultsPedsTable <- function(df, year, interval = "month") {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }


  PediatricsFilter <- list(list("Section", "Pediatrics"))
  Pediatrics <- getGroupFn(df, year, PediatricsFilter)

  AdultsFilter <- list(list("Section", "Adults"))
  Adults <- getGroupFn(df, year, AdultsFilter)


  Total <- Adults + Pediatrics

  adultsPedsTable <- data.frame(Adults, Pediatrics, Total, row.names = usedInterval) %>%
                      t() %>%
                      as.data.frame()

  adultsPedsTable
}
