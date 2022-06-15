
Want to automate turning stuff on and off using home solar / battery conditions.........
----------------------------------------------------------------------------------------------------------

There are apps that will do this provided they can plug into the vendor API. I wanted to create my own
app and have had to fudge access to the data source as the vendor will not grant me access to their API.

miner.ps1 is a simple scrape program that works on the caveat that you can still cut and paste the 
text results created by server side java. You cannot parse the site as you normally would. I have
it running in a scheduled task every 15 minutes with a nightly reboot.

To make it work...

Edit the config.xml file to connect to your solar vendors web gui - tested with Chrome

Use find_page_title.ps1 to find the site title to put into config.xml

Add your authenticated tokenised URL to the <URL> field

update the fields with the line number you want to retrieve (copy your solar gui page 
and paste to notepad, count line number starting at zero)
  
This all runs well on a preloved (<150 bucks) Intel Nuc siting in the laundry. Very simple 
but it has proven to create a robust 'left field' data source! The field numbers specified
work with the Redback solar portal. They probably all work in a similar way.
                                       
I will get around to creating some apps that will use the data.      
                                     
You may find bits useful for a project.                                      
                                       
Twitter: @psanders_aus

