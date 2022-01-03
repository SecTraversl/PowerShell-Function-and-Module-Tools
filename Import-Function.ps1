<#
.SYNOPSIS
  The "Import-Function" function takes a given -Path and will import the PowerShell functions in the given .ps1 file or directory.

.EXAMPLE
  PS C:\> ls .\just_a_temp_dir\*.ps1

      Directory: C:\Users\Jannus.Fugal\Documents\Temp\temp\just_a_temp_dir

  Mode                 LastWriteTime         Length Name
  ----                 -------------         ------ ----
  -b----          7/9/2019   3:26 PM           2925 Get-CPU.ps1
  -b----          7/9/2019   3:18 PM           3716 Get-RAM.ps1
  -b----        12/23/2021  11:43 AM             44 Test.ps1


  PS C:\> get-cpu
  get-cpu : The term 'get-cpu' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
  At line:1 char:1
  + get-cpu
  + ~~~~~~~
      + CategoryInfo          : ObjectNotFound: (get-cpu:String) [], CommandNotFoundException
      + FullyQualifiedErrorId : CommandNotFoundException

  PS C:\> Import-Function .\just_a_temp_dir\
  PS C:\>
  PS C:\> Get-CPU

  Name                            Cpu% Description
  ----                            ---- -----------
  audiodg                         0.24 Windows Audio Device Graph Isolation
  brave                           0.15 Brave Browser
  brave                           0.00 Brave Browser
  brave                           0.00 Brave Browser
  brave                           0.00 Brave Browser
  brave                           0.00 Brave Browser
  AppUIMonitor                    0.00
  ApplicationFrameHost            0.00 Application Frame Host
  agent_ovpnconnect_1594367036109 0.00
  armsvc                          0.00 Adobe Acrobat Update Service

.NOTES
  Name:  Import-Function.ps1
  Author:  Travis Logue
  Version History:  2.1 | 2021-12-23 | Total rehaul of the tool
  Dependencies:  
  Notes:
  - This was the game-changer document that showed me how to import functions into the global scope with a "[<scope-modifier:>]", specifically the syntax of "function global:My-FavoriteFunction {":  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-5.1#using-scope-modifiers

  - Additional article that was helpful when doing research:  https://stackoverflow.com/questions/38469234/how-to-source-all-powershell-scripts-from-a-directory
  
  - Another post:  https://devblogs.microsoft.com/scripting/how-to-reuse-windows-powershell-functions-in-scripts/

  .
#>
function Import-Function {
  [CmdletBinding()]
  param (
    [Parameter()]
    [string[]]
    $Path
  )
  
  begin {}
  
  process {

    foreach ($EachPath in $Path) {
    
      $PS1Files = Get-ChildItem -Path $EachPath -Filter *.ps1

      $FilesWithDeclaredFunctions = $PS1Files | Select-String "^function.*{" | % { ($_ -split ":\d+",2)[0] }
  
      foreach ($File in $FilesWithDeclaredFunctions) {
        $Content = Get-Content $File
        $NewContent = $Content -replace "^function\s+","function global:"
        $SingleStringContent = $NewContent | Out-String
        Invoke-Expression $SingleStringContent
      }

    }

  }
  
  end {}
}