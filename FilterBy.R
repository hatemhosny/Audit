FilterBy <- function(df, x, val=TRUE, match="eq") {
  # filter out NA
  df <- df[complete.cases(df[,x]),]

  if (match == "neq") {
    df[df[,x] != val,]
  } else if (match == "lt") {
    df[df[,x] < val,]
  } else if (match == "lte") {
    df[df[,x] <= val,]
  } else if (match == "mt") {
    df[df[,x] > val,]
  } else if (match == "mte") {
    df[df[,x] >= val,]
  } else {
    df[df[,x] == val,]
  }
}

FilterIsolated <- function(df, x, val=TRUE, prefix="Procedures..choice.") {

  print(x)


  df <- df[df[,x] == val,] %>%
    rename_at(vars(starts_with(x)), ~"tmp") %>%
    filter_at(vars(starts_with(prefix)), all_vars(. != val)) %>%
    rename_at(vars(starts_with("tmp")), ~x)
  df
}

FilterByYear <- function(df, year, date.filter = "Date.of.Operation") {
  start.date <- as.Date(paste(year, "01", "01", sep = "-"))
  end.date <- as.Date(paste(year, "12", "31", sep = "-"))
  df[df[[date.filter]] >= start.date & df[[date.filter]] <= end.date ,]
}

FilterByMonth <- function(df, year, month, date.filter = "Date.of.Operation") {
  start.date <- as.Date(paste(year, month, "01", sep = "-"))
  end.date <- as.Date(paste(year, month, days_in_month(start.date), sep = "-"))
  df[df[[date.filter]] >= start.date & df[[date.filter]] <= end.date ,]
}


FilterByQuarter <- function(df, year, quarter, inclusive = TRUE, date.filter = "Date.of.Operation") {

  end.year <- last(Config$Years)
  end.quarter <- Config$Quarter

  if (quarter == "Q1") {
    startMonth <- 1
    endMonth <- 3
  } else if (quarter == "Q2") {
    startMonth <- 4
    endMonth <- 6

    if (inclusive == TRUE && (last(year) < end.year | end.quarter == "Q2" | end.quarter == "Q3" | end.quarter == "Q4")) {
      startMonth <- 1
    }

  } else if (quarter == "Q3") {
    startMonth <- 7
    endMonth <- 9

    if (inclusive == TRUE && (last(year) < end.year | end.quarter == "Q3" | end.quarter == "Q4")) {
      startMonth <- 1
    }

  } else if (quarter == "Q4") {
    startMonth <- 10
    endMonth <- 12

    if (inclusive == TRUE && (last(year) < end.year | end.quarter == "Q4")) {
      startMonth <- 1
    }

  }

  endMonthDate <- as.Date(paste(last(year), endMonth, "01", sep = "-"))

  start.date <- as.Date(paste(first(year), startMonth, "01", sep = "-"))
  end.date <- as.Date(paste(last(year), endMonth, days_in_month(endMonthDate), sep = "-"))
  df[df[[date.filter]] >= start.date & df[[date.filter]] <= end.date ,]
}


GetGroup <- function(df, year, filters = list(), apply.filters="and", ...) {

  group <- c()
  for (month in 1:12) {

    filtered.df <- df

    if (apply.filters == "or") {
      filtered.df <- filtered.df[0,]
      for (filter in filters) {
        filtered.i.df <- do.call(FilterBy, append(filter, list(df), 0))
        filtered.df <- rbind(filtered.df, filtered.i.df, stringsAsFactors=FALSE)
      }
    } else {
      for (filter in filters) {
        filtered.df <- do.call(FilterBy, append(filter, list(filtered.df), 0))
      }
    }
    group[month] <- filtered.df %>%
      FilterByMonth(year, month, ...) %>%
      nrow()
  }
  group[13] <- sum(group)
  group[14] <- getMean(group[1:12])

  group

}

GetGroupByQuarter <- function(df, year, filters = list(), apply.filters="and", inclusive = Config$Quarters.Inclusive, ...) {

  group <- c()
  for (quarter in c("Q1", "Q2", "Q3", "Q4")) {

    filtered.df <- df

    if (apply.filters == "or") {
      filtered.df <- filtered.df[0,]
      for (filter in filters) {
        filtered.i.df <- do.call(FilterBy, append(filter, list(df), 0))
        filtered.df <- rbind(filtered.df, filtered.i.df, stringsAsFactors=FALSE)
      }
    } else {
      for (filter in filters) {
        filtered.df <- do.call(FilterBy, append(filter, list(filtered.df), 0))
      }
    }

    group[quarter] <- filtered.df %>%
      FilterByQuarter(year, quarter, inclusive = inclusive, ...) %>%
      nrow()
  }

  if (inclusive == TRUE) {
    group["Total"] <- max(group, na.rm = TRUE)
  } else {
    group["Total"] <- sum(group)
  }


  if (inclusive == TRUE) {
    quarters <- c()
    quarters <- c(quarters, group[1])
    quarters <- c(quarters, if_else(group[2] > group[1], group[2] - group[1], group[2]))
    quarters <- c(quarters, if_else(group[3] > group[2], group[3] - group[2], group[3]))
    quarters <- c(quarters, if_else(group[4] > group[3], group[4] - group[3], group[4]))

    group["Mean"] <- getMean(quarters)

  } else {

    group["Mean"] <- getMean(group[1:4])

  }

  group

}


GetGroupMean <- function(df, year, filters = list(), col, apply.filters="and", ...) {

  is.nan.data.frame <- function(x) {
    do.call(cbind, lapply(x, is.nan))
  }

  group <- c()
  for (month in 1:12) {

    filtered.df <- df

    if (apply.filters == "or") {
      filtered.df <- filtered.df[0,]
      for (filter in filters) {
        filtered.i.df <- do.call(FilterBy, append(filter, list(df), 0))
        filtered.df <- rbind(filtered.df, filtered.i.df, stringsAsFactors=FALSE)
      }
    } else {
      for (filter in filters) {
        filtered.df <- do.call(FilterBy, append(filter, list(filtered.df), 0))
      }
    }

    filtered.df <- filtered.df %>%
      FilterByMonth(year, month, ...)

    group[month] <- filtered.df[[col]] %>%
      as.numeric() %>%
      getMean()
  }

  group[is.nan.data.frame(group)] <- 0
  group[13] <- getMean(group)

  group

}

removeZeros <- function(x) {
  x[x != 0]
}

convertNANtoZero <- function(x) {
  if (is.list(x) | is.vector(x) | is.data.frame(x)) {
    x[is.na(x) | is.nan(x) | is.infinite(x)] <- 0
  } else if (is.nan(x) | is.infinite(x)) {
      x <- 0
  }

  x
}

getMean <- function(x, digits=0) {
  x %>%
    removeZeros() %>%
    mean(na.rm=TRUE) %>%
    convertNANtoZero() %>%
    round(digits)
}

# Usage:
# -------------
# result <- df %>%
#           FilterBy("Surgeon.1", "Hatem Hosny") %>%
#           FilterBy("Section", "Pediatrics") %>%
#           FilterByMonth(2017, 11)
#
# nrow(result)
#
#
#
# myfilters <- list(
#   list("Section", "Adults"),
#   list("Surgeon.1", "Hatem Hosny")
# )
#
# mygroup <- GetGroup(data, 2017, 11, myfilters)
