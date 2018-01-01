AdultsPedsMortalityTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  Pediatrics <- getGroupFn(df, year, list(list("Section", "Pediatrics")))
  PediatricsMortalityFilter <- list(list("Section", "Pediatrics"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Pediatrics.Mortality <- getGroupFn(allDf, year, PediatricsMortalityFilter)
  Pediatrics.Mortality.Percent <- round(Pediatrics.Mortality/Pediatrics*100, digits = 1)

  Adults <- getGroupFn(df, year, list(list("Section", "Adults")))
  AdultsMortalityFilter <- list(list("Section", "Adults"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Adults.Mortality <- getGroupFn(allDf, year, AdultsMortalityFilter)
  Adults.Mortality.Percent <- round(Adults.Mortality/Adults*100, digits = 1)

  Table <- data.frame(Adults, Adults.Mortality, Adults.Mortality.Percent,
                      Pediatrics, Pediatrics.Mortality, Pediatrics.Mortality.Percent,
                      row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE)

  Table
}
