<#
.SYNOPSIS
  The "Get-ModulePath" function returns an array of the values found in the $env:PSModulePath variable.

.EXAMPLE
  PS C:\> ModulePath
  C:\Users\Jannus.Fugal\Documents\WindowsPowerShell\Modules
  C:\Program Files\WindowsPowerShell\Modules
  C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules



  Here we run the function by using its built-in alias "ModulePath".  In return, the paths that the current PowerShell instance searches for modules are displayed.

.NOTES
  Name:  Get-ModulePath.ps1
  Author:  Travis Logue
  Version History:  1.1 | 2021-12-30 | Initial Version
  Dependencies:  
  Notes:
  - 

  .
#>
function Get-ModulePath {
  [CmdletBinding()]
  [Alias('ModulePath')]
  param ()
  
  begin {}
  
  process {
    $env:PSModulePath -split ';'
  }
  
  end {}
}