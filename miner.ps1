<#

--------------------------------------------------------------------

P.Sanders 15/06/2022 v1.6

Scrape text from selected fields to create a local datasource
of solar and battery conditions throught the day / week etc

Prerequisite is a tokenised URL of the authenticated website.
Login to you solar providers data portal and copy the URL into
config.xml

  <Vendor>
    <URL>https://portal.vendor.com/ui/#/cgi/BLAH123</URL>
    <Title>Vendor Website Title - Google Chrome</Title>
  </Vendor>
  
Use 'find_page_title.ps1' to retrieve the text to put into <Title>  

Run miner.ps1 from task scheduler / cron. Suggest 10 minute loop.

Requires sqlexpress. Connection string also in config.xml

Exposed data can be used for home automation, car charging etc

1.1 initial tested cut
1.2 added battery load capture
1.3 added formatting to clipboard data
1.4 fields read from config.xml
1.5 Removed charge_window field
1.6 Updated instructions

--------------------------------------------------------------------

#>

function Send-Keys {

# --------------------------------------------------------
# Use the C# library to send keystrokes to an application.
#     found online somewhere, cudos to its creator
# --------------------------------------------------------

param (
    [Parameter(Mandatory=$True,Position=1)]
    [string]
    $ApplicationTitle,

    [Parameter(Mandatory=$True,Position=2)]
    [string]
    $Keys,

    [Parameter(Mandatory=$false)]
    [int] $WaitTime
    )


[void] [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class StartActivateProgramClass {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
    }
"@

$p = Get-Process | Where-Object { $_.MainWindowTitle -eq $ApplicationTitle }
if ($p) 
   {
      $h = $p[0].MainWindowHandle
      [void] [StartActivateProgramClass]::SetForegroundWindow($h)
      [System.Windows.Forms.SendKeys]::SendWait($Keys)
      if ($WaitTime) 
      {
          Start-Sleep -Seconds $WaitTime
      }
   }
}

# ---------------------
# Main body starts here
# ---------------------

# Read XML Config
# ---------------

[XML]$Config = Get-Content -path $PSScriptRoot\config.xml

# Connect to database
# -------------------

$DatabaseNode = $Config.SelectNodes('//Database')

foreach ($Node in $DatabaseNode) {

   $SQLServer=$node.servername
   $SQLDBName=$node.databasename
   $SQLUser=$node.username
   $SQLUserPass=$node.UserPass

}

try {
   
$connString = "Data Source=$SQLServer;Database=$SQLDBName;User ID=$SQLUser;Password=$SQLUserPass"
$conn = New-Object System.Data.SqlClient.SqlConnection $connString
$conn.Open()

if ($conn.State -eq "Open") {

   Write-Host "Database connection successful"
   
   }
    
} 

catch {

   Write-Host "Database connection failed, exiting program"
   exit

}

# Fetch vendor URL
# ----------------

$VendorNode = $Config.SelectNodes('//Vendor')

foreach ($Node in $VendorNode) {

    $SiteURL = $Node.URL
    $SiteName = $Node.Title

}

# Select all text & copy to clipboard
# -----------------------------------

Start-Process chrome $SiteURL
Start-Sleep -Seconds 7
Send-Keys $SiteName "^a ^c"
Start-Sleep -Seconds 3

$RawData = Get-Clipboard -Format Text

# Pull out the text we want
# -------------------------

$FieldNode = $config.SelectNodes('//Fields')
$Event = Get-Date -Format "yyyyMMddHHmmss"

foreach ($Node in $FieldNode) {

    $SolarLevel = $RawData[$Node.SolarLevel]
    $GridLevel = $RawData[$Node.GridLevel]
    $BatteryLoad = $RawData[$Node.BatteryLoad]
    $BatteryState = $RawData[$Node.BatteryState]
    $LoadLevel = $RawData[$Node.LoadLevel]
    $BatteryLevel = $RawData[$Node.BatteryLevel]
    
}

# Write to database
# -----------------
                
$SqlInsert = "insert into solar_data (
            
   [event],
   [solar_level],
   [battery_level],
   [battery_load],
   [battery_state],
   [grid_level],
   [load_level]
                       
   )  
               
   Values (
               
   '$Event',
   '$SolarLevel',
   '$BatteryLevel',
   '$BatteryLoad',
   '$BatteryState',
   '$GridLevel',
   '$LoadLevel'
                      
   )
               
   GO"

Invoke-Sqlcmd -serverinstance $SQLServer -Database $SQLDBName -Username $SQLUser -Password $SQLUserPass -query $SqlInsert

# Close previous open sessions
# ----------------------------

$Process = Get-Process | Where-Object {$_.MainWindowTitle -eq $SiteName}
$Process.CloseMainWindow()
Write-Host $Event










