AgeGroupsMortalityTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  df <- df %>%
    FilterBy("Section", "Pediatrics")

  df$days.from.operation <- as.Date(df[["Date.of.Operation"]], format = "%Y-%m-%d") -
    as.Date(df[["Date.of.Birth"]], format = "%Y-%m-%d")

  allDf <- allDf %>%
    FilterBy("Section", "Pediatrics")

  allDf$days.from.operation <- as.Date(allDf[["Date.of.Operation"]], format = "%Y-%m-%d") -
    as.Date(allDf[["Date.of.Birth"]], format = "%Y-%m-%d")


  NeonatesFilter <- list(list("days.from.operation", 31, "lte"))
  Neonates <- getGroupFn(df, year, NeonatesFilter)
  NeonatesMortalityFilter <- list(list("days.from.operation", 31, "lte"),
                                    list("Mortality", TRUE),
                                    list("Date.of.mortality.", "", "neq"))
  Neonates.Mortality <- getGroupFn(allDf, year, NeonatesMortalityFilter)
  Neonates.Mortality.Percent <- round(Neonates.Mortality/Neonates*100, digits = 1) %>%
    convertNANtoZero()


  InfantsFilter <- list(
    list("days.from.operation", 31, "mt"),
    list("days.from.operation", 365, "lte")
  )
  Infants <- getGroupFn(df, year, InfantsFilter)
  InfantsMortalityFilter <- list(list("days.from.operation", 31, "mt"),
                                 list("days.from.operation", 365, "lte"),
                                 list("Mortality", TRUE),
                                 list("Date.of.mortality.", "", "neq"))
  Infants.Mortality <- getGroupFn(allDf, year, InfantsMortalityFilter)
  Infants.Mortality.Percent <- round(Infants.Mortality/Infants*100, digits = 1) %>%
    convertNANtoZero()


  ToddlersFilter <- list(
    list("days.from.operation", 365, "mt"),
    list("days.from.operation", 730, "lte")
  )
  Toddlers <- getGroupFn(df, year, ToddlersFilter)
  ToddlersMortalityFilter <- list(list("days.from.operation", 365, "mt"),
                                 list("days.from.operation", 730, "lte"),
                                 list("Mortality", TRUE),
                                 list("Date.of.mortality.", "", "neq"))
  Toddlers.Mortality <- getGroupFn(allDf, year, ToddlersMortalityFilter)
  Toddlers.Mortality.Percent <- round(Toddlers.Mortality/Toddlers*100, digits = 1) %>%
    convertNANtoZero()


  ChildrenFilter <- list(list("days.from.operation", 730, "mt"))
  Children <- getGroupFn(df, year, ChildrenFilter)
  ChildrenMortalityFilter <- list(list("days.from.operation", 730, "mt"),
                                  list("Mortality", TRUE),
                                  list("Date.of.mortality.", "", "neq"))
  Children.Mortality <- getGroupFn(allDf, year, ChildrenMortalityFilter)
  Children.Mortality.Percent <- round(Children.Mortality/Children*100, digits = 1) %>%
    convertNANtoZero()

  Table <- data.frame(Neonates, Neonates.Mortality, Neonates.Mortality.Percent,
                      Infants, Infants.Mortality, Infants.Mortality.Percent,
                      Toddlers, Toddlers.Mortality, Toddlers.Mortality.Percent,
                      Children, Children.Mortality, Children.Mortality.Percent,
                      row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  row.names(Table) <- gsub(row.names(Table), pattern = ".", replacement = " ", fixed = TRUE)

  Table
}
