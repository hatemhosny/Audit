CreateTemplateFrom <- function(source, output="template.xlsx", sheet.to.keep="Charts",
                               PSscript="CreateTemplate.ps1") {

  system2("powershell", args=c("-file", PSscript, source, output, sheet.to.keep))

  # if (!file.exists(source)) print(paste("The source file:", source, "does not exist"))
  # stopifnot(file.exists(source))
  #
  # copyAndLoadWorkbook <- function(source.file, output.file) {
  #     file.copy(source.file, output.file, overwrite=TRUE)
  #     wb <- loadWorkbook(output.file)
  #   wb
  # }
  #
  # wb <- copyAndLoadWorkbook(source, output)
  # sheets <- getSheets(wb)
  # sheets.to.remove <- setdiff(names(sheets), sheet.to.keep)
  #
  # for (sheetName in sheets.to.remove) {
  #   removeSheet(wb, sheetName = sheetName)
  # }
  #
  # saveWorkbook(wb, output)

}
