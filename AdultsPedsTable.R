AdultsPedsTable <- function(df, year, interval = "month") {

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
