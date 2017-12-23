GenderTable <- function(df, year, interval = "month") {

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


