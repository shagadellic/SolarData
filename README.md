------------------------------------------------------------------------------------------------------------
Create conditions based charge automation to top up EV from home solar & battery
------------------------------------------------------------------------------------------------------------

example- start charging the car when there is '4 kw' solar and the home battery is at 100%

example- stop charging the car when the is '0 kw' solar and home battery is at 60%

Car will automatically top up off peak if required (normal charge setting for me)
40% of home battery is usually enough for my daily commute

----------------------------------------------------------------------------------------------------------
miner.ps1 - collects data into an sqlexpress database. Thing will live on a Pi on local network
----------------------------------------------------------------------------------------------------------

had to fudge my own quasi API as the vendor will not grant me access to it (atm..)

find_page_title.ps1 - find the site title to put into config.xml

if you have a powerwall things may be different with API access

----------------------------------------------------------------------------------------------------------
under development - app with UI to select conditions to start / stop charging 
----------------------------------------------------------------------------------------------------------

API resourses for car appear available from https://www.teslaapi.io/

App will generate average from db data to determine start / stop based on parameters

Params to reduce cycling in overcast conditions 

android or perhaps a windows / powershell / poshgui runs on home automation / IoT hub

----------------------------------------------------------------------------------------------------------

If you have the cash, just buy more panels and a bigger battery - dont worry about active management ;)

Twitter: @psanders_aus

