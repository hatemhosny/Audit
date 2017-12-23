ImportCleanSave <- function(inputFile, outputFile) {

  drop.cols <- c("Age",
                 "Residence",
                 "Specify.Residence")

  FixEncoding <- function(df) {
    names(df)[1] <- "Patient.ID"
    # names(df)[1] <- gsub("ï..", "", names(df)[1])
    df
  }


  FixReadmissionData <- function(dataFrame) {

    getFixedVar <- function(x, df, var) {
      if (x[["Event.Name"]] == "Initial Data"){
        result <- x[var]
      } else {
        result <- df %>%
          filter(Patient.ID == x[["Patient.ID"]] & Event.Name == "Initial Data") %>%
          select(var)
      }
      result
    }

    fixVar <- function(df, var) {
      fixedVar <- apply(df, 1, getFixedVar, df, var)


      if (typeof(df[[var]]) == "character") {
        fixedVar <- as.character(fixedVar)
      } else if (typeof(df[[var]]) == "integer") {
        fixedVar <- as.integer(fixedVar)
      } else if (typeof(df[[var]]) == "numeric") {
        fixedVar <- as.numeric(fixedVar)
      }

      output <- mutate(df, !!var := fixedVar)

      output
    }

    output <- dataFrame %>%
      fixVar("MRN") %>%
      fixVar("Name") %>%
      fixVar("Gender") %>%
      fixVar("Date.of.Birth") %>%
      fixVar("Age") %>%
      fixVar("City") %>%
      fixVar("Residence") %>%
      fixVar("Specify.Residence") %>%
      fixVar("Section")

    output
  }

  ConvertChecked <- function(df) {
    df[df=="Unchecked"] <- FALSE
    df[df=="Checked"] <- TRUE
    df
  }

  ConvertYesNo <- function(df) {
    df[df=="No"] <- FALSE
    df[df=="Yes"] <- TRUE
    df
  }

  DropColumns <- function(df, drop.cols) {
    df <- df %>% select(-one_of(drop.cols))
    df
  }

  df <- read.csv(inputFile, stringsAsFactors = FALSE) %>%
    FixEncoding() %>%
    FixReadmissionData %>%
    ConvertChecked() %>%
    ConvertYesNo() %>%
    DropColumns(drop.cols) %>%
    write.csv(outputFile)
}
