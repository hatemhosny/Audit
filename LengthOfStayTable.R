LengthOfStayTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total
  quarters <- Config$Quarters.Total

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroupMean
  }

  los <- list(
    total = "total.length.of.stay",
    pre = "pre.length.of.stay",
    post = "post.length.of.stay"
  )

  df$total.length.of.stay <- as.Date(df[["Date.of.Discharge"]], format = "%Y-%m-%d") -
    as.Date(df[["Date.of.Admission"]], format = "%Y-%m-%d")

  df$pre.length.of.stay <- as.Date(df[["Date.of.Operation"]], format = "%Y-%m-%d") -
    as.Date(df[["Date.of.Admission"]], format = "%Y-%m-%d")

  df$post.length.of.stay <- as.Date(df[["Date.of.Discharge"]], format = "%Y-%m-%d") -
    as.Date(df[["Date.of.Operation"]], format = "%Y-%m-%d")


  TotalFilter <- list(list("Patient.ID", 0, "neq"))
  Total <- getGroupFn(df, year, TotalFilter, los$total)
  Total.pre <- getGroupFn(df, year, TotalFilter, los$pre)
  Total.post <- getGroupFn(df, year, TotalFilter, los$post)

  AdultsFilter <- list(list("Section", "Adults"))
  Adults <- getGroupFn(df, year, AdultsFilter, los$total)
  Adults.pre <- getGroupFn(df, year, AdultsFilter, los$pre)
  Adults.post <- getGroupFn(df, year, AdultsFilter, los$post)

  PediatricsFilter <- list(list("Section", "Pediatrics"))
  Pediatrics <- getGroupFn(df, year, PediatricsFilter, los$total)
  Pediatrics.pre <- getGroupFn(df, year, PediatricsFilter, los$pre)
  Pediatrics.post <- getGroupFn(df, year, PediatricsFilter, los$post)


  # MalesFilter <- list(list("Gender", "Male"))
  # Males <- getGroupFn(df, year, MalesFilter, los$total)
  #
  # FemalesFilter <- list(list("Gender", "Female"))
  # Females <- getGroupFn(df, year, FemalesFilter, los$total)
  #
  # neonatesFilter <- list(list("days.from.operation", 31, "lte"))
  # neonates <- getGroupFn(df, year, neonatesFilter, los$total)
  #
  # infantsFilter <- list(
  #   list("days.from.operation", 31, "mt"),
  #   list("days.from.operation", 365, "lte")
  # )
  # infants <- getGroupFn(df, year, infantsFilter, los$total)
  #
  # toddlersFilter <- list(
  #   list("days.from.operation", 365, "mt"),
  #   list("days.from.operation", 730, "lte")
  # )
  # toddlers <- getGroupFn(df, year, toddlersFilter, "total.length.of.stay")
  #
  # olderFilter <- list(list("days.from.operation", 730, "mt"))
  # older <- getGroupFn(df, year, olderFilter, "total.length.of.stay")



  Table <- data.frame(Total, Total.pre, Total.post,
                      Adults, Adults.pre, Adults.post,
                      Pediatrics, Pediatrics.pre, Pediatrics.post) %>%
    t() %>%
    as.data.frame()

  Table
}
