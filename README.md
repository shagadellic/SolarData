------------------------------------------------------------------------------------------------------------
Create a conditions based charge automation process to top up the car from home solar & battery
------------------------------------------------------------------------------------------------------------

example- start charging the car when there is 'x.x kw' solar and the home battery is at 100%
example- stop charging the car when the is '0kw' solar and home battery is at 60%

Car will automatically charge offpeak anyway and top up if required (normal charge setting for me)
40% of home battery is usually enough for my daily commute

----------------------------------------------------------------------------------------------------------
miner.ps1 - collects my solar data into an sqlexpress database. Thing will live on a Pi on local network
----------------------------------------------------------------------------------------------------------

had to fudge my own quasi API as the vendor will not grant me access to it (atm..)
if you have a powerwall things may be different

----------------------------------------------------------------------------------------------------------
new apk - will connect local db and have UI to select conditions to start / stop charging 
----------------------------------------------------------------------------------------------------------

API resourses for car appear available from https://www.teslaapi.io/
App will generate average from realworld data to determine start / stop based on parameters
new app will run on android tablet as part of home automation / IoT hub

----------------------------------------------------------------------------------------------------------
Twitter: @psanders_aus

