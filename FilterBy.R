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
  df <- df[df[,x] == val,] %>%
    rename_at(vars(starts_with(x)), function(var) "tmp") %>%
    filter_at(vars(starts_with(prefix)), all_vars(. != val)) %>%
    rename_at(vars(starts_with("tmp")), function(var) x)
  df
}

FilterByYear <- function(df, year) {
  start.date <- as.Date(paste(year, "01", "01", sep = "-"))
  end.date <- as.Date(paste(year, "12", "31", sep = "-"))
  patients <- subset(df,
                     as.Date(Date.of.Operation) >= start.date &
                       as.Date(Date.of.Operation) <= end.date
  )
}

FilterByMonth <- function(df, year, month) {
  start.date <- as.Date(paste(year, month, "01", sep = "-"))
  end.date <- as.Date(paste(year, month, days_in_month(start.date), sep = "-"))
  patients <- subset(df,
                     as.Date(Date.of.Operation) >= start.date &
                       as.Date(Date.of.Operation) <= end.date
  )
}


FilterByQuarter <- function(df, year, quarter) {

    if (quarter == "Q1") {
    startMonth <- 1
    endMonth <- 3
  } else if (quarter == "Q2") {
    startMonth <- 4
    endMonth <- 6
  } else if (quarter == "Q3") {
    startMonth <- 7
    endMonth <- 9
  } else if (quarter == "Q4") {
    startMonth <- 10
    endMonth <- 12
  }

  endMonthDate <- as.Date(paste(year, endMonth, "01", sep = "-"))

  start.date <- as.Date(paste(year, startMonth, "01", sep = "-"))
  end.date <- as.Date(paste(year, endMonth, days_in_month(endMonthDate), sep = "-"))

  patients <- subset(df,
                     as.Date(Date.of.Operation) >= start.date &
                       as.Date(Date.of.Operation) <= end.date
  )
}


GetGroup <- function(df, year, filters = list(), apply.filters="and") {

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
      FilterByMonth(year, month) %>%
      nrow()
  }
  group[13] <- sum(group)
  group[14] <- round(mean(group[1:12]), digits = 1)

  group

}

GetGroupByQuarter <- function(df, year, filters = list(), apply.filters="and") {

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
      FilterByQuarter(year, quarter) %>%
      nrow()
  }
  group["Total"] <- sum(group)
  group["Mean"] <- round(mean(group[1:4]), digits = 1)

  group

}


GetGroupMean <- function(df, year, filters = list(), col, apply.filters="and") {

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
      FilterByMonth(year, month)

    group[month] <- filtered.df[[col]] %>%
      as.numeric() %>%
      mean(na.rm=TRUE) %>%
      round(2)
  }

  group[is.nan.data.frame(group)] <- 0
  group[13] <- mean(group, na.rm=TRUE) %>% round(2)

  group

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
