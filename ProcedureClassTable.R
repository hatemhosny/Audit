source("ProceduresClassification.R")

ProcedureClassTable <- function(df, year, interval = "month") {

  classifyProcedures <- function(df, class, ...) {

    checkProcedures <- function(x, df) {
      df[x] == TRUE
    }

    procedures <- c(...)
    index <- sapply(procedures, checkProcedures, df) %>%
      apply(1, all)

    empty <- is.na(df$classified)

    df$classified[index & empty] <- class

    df
  }

  df$classified <- NA

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

  groups <- data.frame(row.names = usedInterval)

  for (x in ProceduresClassification) {
    df <- classifyProcedures(df, class = x[["title"]], x[["procedures"]])
    groups <- cbind(groups, getGroupFn(df, year, list(list("classified", x[["title"]]))))
    colnames(groups)[ncol(groups)] <- x[["title"]]
  }

  Total <- apply(groups, 1, sum)
  groups <- cbind(groups, Total)


  Table <- groups %>%
    t() %>%
    as.data.frame()

  Table
}
