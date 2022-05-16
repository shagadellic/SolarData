<#

Sample to find the page title in chrome. 
One browser window open, one tab

copy/paste result into config.xml 

<Title>put in here</Title>

#>

$title = (Get-Process -Name chrome).MainWindowTitle 
write-host $title
