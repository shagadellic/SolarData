------------------------------------------------------------------------------------------------------------
Create conditions based charge automation to top up EV from home solar & battery
------------------------------------------------------------------------------------------------------------

example- start charging the car when there is '4 kw' solar and the home battery is at 100%

example- stop charging the car when the is '0 kw' solar and home battery is at 60%

Car will automatically top up off peak if required (normal charge setting for me)
40% of home battery is usually enough for my daily commute

Could use the data to control all sorts of guff...

----------------------------------------------------------------------------------------------------------
miner.ps1 - collects data into an sqlexpress database.
----------------------------------------------------------------------------------------------------------

I have had to fudge my own 'API' as the vendor will not grant me access to theirs (atm..)

Edit the config.xml file to connect to your solar vendors web gui - tested with Chrome

Use find_page_title.ps1 to find the site title to put into config.xml

Add the tokenised URL to the <URL> field

update the fields with the line number you want to retrieve (copy your solar gui page 
  
and paste to notepad, count line number starting at zero)
  
This all runs well on a preloved (<150 bucks) Intel Nuc 

if you have a powerwall you are probably laughing at the need for this ;)
                                       
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

