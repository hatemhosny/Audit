RedoTable <- function(df, year, interval = "month", allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }


  FirstOperationFilter <- list(list("Redo.Operation", FALSE))
  First.Operation <- getGroupFn(df, year, FirstOperationFilter)

  Redo.OperationFilter <- list(list("Redo.Operation", TRUE))
  Redo.Operation <- getGroupFn(df, year, Redo.OperationFilter)


  Total <- First.Operation + Redo.Operation

  Table <- data.frame(First.Operation, Redo.Operation, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE)

  Table
}


