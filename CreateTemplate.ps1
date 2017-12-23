# powershell -file CreateTemplate.ps1 ../output/audit.xlsx template.xlsx Charts

$source = $args[0]
$output = $args[1]
$keepSheet = $args[2]

if (-Not(Get-Module -ListAvailable -Name PSExcel)) {
  Install-Module PSExcel -scope CurrentUser -Force
}
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
