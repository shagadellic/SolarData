----------------------------------------------------------------------------------------------------------
Wanted to collect solar data and automate turning stuff on and off based on solar / battery conditions...
----------------------------------------------------------------------------------------------------------

I have had to fudge my own solar 'API' as the vendor will not grant me access to theirs (atm..)

Edit the config.xml file to connect to your solar vendors web gui - tested with Chrome

Use find_page_title.ps1 to find the site title to put into config.xml

Add your authenticated tokenised URL to the <URL> field

update the fields with the line number you want to retrieve (copy your solar gui page 
  
and paste to notepad, count line number starting at zero)
  
This all runs well on a preloved (<150 bucks) Intel Nuc siting in the laundry
                                       
Was fun to circumvent server side Java that snookered all the usual powershell html parsing.
Very simple but it has proven to create a robust left field data source! 
                                       
I will get around to creating some apps that will use the data.      
                                     
If you are a real programmer and can do this better / less lines of code / whatever.. please share!                                       
                                       
Twitter: @psanders_aus

