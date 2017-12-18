library(xlsx)

source("PlotProcedures.R")

WriteToExcel <- function(df, file, sheet, fn, years=2009:2017, isPlot=FALSE, title="",
                         append=FALSE, ...) {

  createOrLoadWorkbook <- function(file) {
    if(file.exists(file)){
      wb <- loadWorkbook(file)
    } else {
      print(paste("Creating a new excel file:", file))
      wb <- createWorkbook(type="xlsx")
    }
    wb
  }

  getWorkSheet <- function(wb, sheetName, append) {
    sheets <- getSheets(wb)
    if (sheetName %in% names(sheets) & append == FALSE) {
      removeSheet(wb, sheetName = sheetName)
      workSheet <- createSheet(wb, sheetName = sheetName)
    } else if (sheetName %in% names(sheets) & append == TRUE) {
      workSheet <- sheets[[sheetName]]
    } else {
      workSheet <- createSheet(wb, sheetName = sheetName)
    }

    workSheet
  }

  getNextEmptyRow <- function(file, sheetName, isPlot) {
    nextEmptyRow <- tryCatch({
      content <- read.xlsx2(file, sheetName = sheetName, header = FALSE,
                            fix.empty.names = FALSE)
      if (append == FALSE){
        1
      } else if (isPlot) {
        nrow(content) * 52
      } else {
        nrow(content) + 3
      }
    }, error = function(err) {
      1
    })
    nextEmptyRow
  }

  wb <- createOrLoadWorkbook(file)
  workSheet <- getWorkSheet(wb, sheetName = sheet, append = append)

  COLNAMES_STYLE <- CellStyle(wb) + Font(wb, isBold=TRUE) +
    Alignment(horizontal="ALIGN_CENTER")

  ROWNAMES_STYLE <- CellStyle(wb) + Font(wb, isBold=TRUE) +
    Alignment(horizontal="ALIGN_LEFT")

  HEADER_STYLE <- list("1" = CellStyle(wb) +
                         Font(wb, heightInPoints=10, isBold=TRUE, color ="9", name="Arial") +
                         Fill(foregroundColor="#0069AA") +
                         Alignment(wrapText=TRUE, horizontal="ALIGN_CENTER"))

  xlsx.addText <- function(sheet, rowIndex, text, textStyle = CellStyle(wb)){
    rows <- createRow(sheet,rowIndex=rowIndex)
    cells <- createCell(rows, colIndex=1)
    setCellValue(cells[[1,1]], text)
    setCellStyle(cells[[1,1]], textStyle)
  }

  nextRow <- getNextEmptyRow(file, sheet, isPlot)

  if(isPlot) {

    image <- PlotProcedures(df, ...)

    xlsx.addText(workSheet, rowIndex=nextRow, text=title,
                 textStyle = CellStyle(wb) + Font(wb, isBold=TRUE))

    addPicture(image, workSheet, scale = 1, startRow = nextRow+1, startColumn = 1)

    res<-file.remove(image)

  } else {

    rowNum <- nrow(fn(df, years[1], ...))

    for (year in years) {

      addDataFrame(fn(data, year, ...), workSheet, startRow = nextRow,
                   colnamesStyle = COLNAMES_STYLE, rownamesStyle = ROWNAMES_STYLE)
      addDataFrame(as.data.frame(year), workSheet, startRow = nextRow,
                   col.names=FALSE, row.names=FALSE, colStyle=HEADER_STYLE)

      nextRow <- nextRow + rowNum + 3
    }
  }

  autoSizeColumn(workSheet, colIndex=1)
  saveWorkbook(wb, file)
}
