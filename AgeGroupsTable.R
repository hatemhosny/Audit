AgeGroupsTable <- function(df, year, interval = "month") {

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

  neonatesFilter <- list(list("days.from.operation", 31, "lte"))
  neonates <- getGroupFn(df, year, neonatesFilter)

  infantsFilter <- list(
    list("days.from.operation", 31, "mt"),
    list("days.from.operation", 365, "lte")
    )
  infants <- getGroupFn(df, year, infantsFilter)

  toddlersFilter <- list(
    list("days.from.operation", 365, "mt"),
    list("days.from.operation", 730, "lte")
    )
  toddlers <- getGroupFn(df, year, toddlersFilter)

  olderFilter <- list(list("days.from.operation", 730, "mt"))
  older <- getGroupFn(df, year, olderFilter)


  Total <- neonates + infants + toddlers + older

  ageGroupsTable <- data.frame(neonates, infants, toddlers, older, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  ageGroupsTable
}
