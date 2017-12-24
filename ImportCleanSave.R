ImportCleanSave <- function(inputFile, outputFile) {

  drop.cols <- c("Age",
                 "Residence",
                 "Specify.Residence")

  fixEncoding <- function(df) {
    names(df)[1] <- "Name"
    # names(df)[1] <- gsub("ï..", "", names(df)[1])
    df
  }


  fixReadmissionData <- function(df) {

    getFixedVar <- function(x, df, var) {
      if (x[["Event.Name"]] == "Initial Data"){
        result <- x[var]
      } else {
        initial.data <- df %>%
          filter(Patient.ID == as.integer(x[["Patient.ID"]]) & Event.Name == "Initial Data")
        result <- initial.data[1, var]
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

    output <- df %>%
      fixVar("MRN") %>%
      fixVar("Name") %>%
      fixVar("Gender") %>%
      fixVar("Date.of.Birth") %>%
      fixVar("City") %>%
      fixVar("Section")

    output
  }

  convertChecked <- function(df) {
    df[df=="Unchecked"] <- FALSE
    df[df=="Checked"] <- TRUE
    df
  }

  convertYesNo <- function(df) {
    df[df=="No"] <- FALSE
    df[df=="Yes"] <- TRUE
    df
  }

  dropColumns <- function(df, drop.cols) {
    df <- df %>% select(-one_of(drop.cols))
    df
  }

  createIndex <- function(df, col.name="Record.ID") {
    df[col.name] <- seq.int(nrow(df))
    df
  }

  print(paste("Importing and cleaning data from:", inputFile))

  df <- read.csv(inputFile, stringsAsFactors = FALSE) %>%
    fixEncoding() %>%
    fixReadmissionData() %>%
    convertChecked() %>%
    convertYesNo() %>%
    dropColumns(drop.cols) %>%
    RemoveStepProcedures() %>%
    createIndex() %>%
    ReorderColumns() %>%
    write.csv(outputFile, row.names=FALSE)
}
