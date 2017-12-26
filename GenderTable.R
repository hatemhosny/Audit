GenderTable <- function(df, year, interval = "month") {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }


  MalesFilter <- list(list("Gender", "Male"))
  Males <- getGroupFn(df, year, MalesFilter)

  FemalesFilter <- list(list("Gender", "Female"))
  Females <- getGroupFn(df, year, FemalesFilter)


  Total <- Males + Females

  genderTable <- data.frame(Males, Females, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  genderTable
}


