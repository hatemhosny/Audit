RedoTable <- function(df, year, interval = "month") {

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
  First_Operation <- getGroupFn(df, year, FirstOperationFilter)

  Redo_OperationFilter <- list(list("Redo.Operation", TRUE))
  Redo_Operation <- getGroupFn(df, year, Redo_OperationFilter)


  Total <- First_Operation + Redo_Operation

  redoTable <- data.frame(First_Operation, Redo_Operation, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  redoTable
}


