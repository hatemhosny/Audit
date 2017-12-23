# powershell -file CreateTemplate2.ps1 ../output/audit2-Copy.xlsx template.xlsx Charts

$source = $args[0]
$output = $args[1]
$keepSheet = $args[2]

# Install-Module PSExcel -scope CurrentUser
Import-Module PSExcel

Copy-Item -Path $PSScriptRoot\$source -Destination $PSScriptRoot\$output

$Excel = New-Excel -Path $PSScriptRoot\$output
$WorkBook = $Excel | Get-Workbook
$WorkSheets = $Workbook | Get-Worksheet
ForEach ($WorkSheet in $WorkSheets) {
  if ($WorkSheet.Name -ne $keepSheet) {
    $WorkBook.Worksheets.Delete($WorkSheet)
  }
}
 
$Excel | Close-Excel -Save
