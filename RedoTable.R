RedoTable <- function(df, year, interval = "month") {

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


  FirstOperationFilter <- list(list("Redo.Operation", TRUE, "neq"))
  First_Operation <- getGroupFn(df, year, FirstOperationFilter)

  Redo_OperationFilter <- list(list("Redo.Operation", TRUE))
  Redo_Operation <- getGroupFn(df, year, Redo_OperationFilter)


  Total <- First_Operation + Redo_Operation

  redoTable <- data.frame(First_Operation, Redo_Operation, Total, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  redoTable
}


