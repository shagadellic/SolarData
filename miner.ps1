<#

P.Sanders 13/05/2021 v1.1

Crude way of mining data for my solar install, given they wont
give me access to their API.

Vendor website uses server side java to render pages and typical
scraping methods will not work. Hence this 'creative' approach. 

Prerequisite is a session cookie of the authenticated website.
Login to the site on the browser once, then put the url and the
site title into the config.xml file

  <Vendor>
    <URL>https://portal.vendor.com/ui/#/cgi/BLAH123</URL>
    <Title>Vendor Website Title - Google Chrome</Title>
  </Vendor>

Run miner.ps1 from task scheduler / cron. Suggest 10 minute loop.

The mined data can then be used by other apps when connected to the 
database. The charge_window column can be used by connected apps 
for logic status they wish to record. ie: 'charge car start / stop' 
etc

Requires sqlexpress

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

$DatabaseNode = $Config.SelectNodes('//Vendor')

foreach ($Node in $DatabaseNode) {

    $SiteURL = $Node.URL
    $SiteName = $Node.Title

}

# Select all text & copy to clipboard
# -----------------------------------

Start-Process chrome $SiteURL
Start-Sleep -Seconds 5
Send-Keys $SiteName "^a ^c"

$RawData = Get-Clipboard

# Pull out the text we want
# -------------------------

$SolarLevel = $RawData[19]
$BatteryLevel = $RawData[36]
$GridLevel = $RawData[21]
$LoadLevel = $RawData[25]
$Event = Get-Date -Format "yyyyMMddHHmmss"
$ChargeWindow = ''

# Write to database
# -----------------
                
$SqlInsert = "insert into solar_data (
            
   [event],
   [solar_level],
   [battery_level],
   [grid_level],
   [load_level],
   [charge_window]
                    
   )  
               
   Values (
               
   '$Event',
   '$SolarLevel',
   '$BatteryLevel',
   '$GridLevel',
   '$LoadLevel',
   '$ChargeWindow'
                   
   )
               
   GO"

Invoke-Sqlcmd -serverinstance $SQLServer -Database $SQLDBName -Username $SQLUser -Password $SQLUserPass -query $SqlInsert

# Close previous open sessions
# ----------------------------

$Process = Get-Process | Where-Object {$_.MainWindowTitle -eq 'Dashboard - Redback Technologies - Google Chrome'}
$Process.CloseMainWindow()

Write-Host $Event







