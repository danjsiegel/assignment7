#!/bin/bash
#Dan Siegel
#12.1.16
#Assignment 7
#Creates a menu that completes various tasks. 

	clear   #gives a fesh screen 
	until [ "$usernbr" = '9' ]  #sets the program to repeat until the user inputs j" 
		do
		echo -e "\n Welcome To Dan's Main Menu \n"
		echo 
		echo "	1 -- Display users currently logged in"
		echo "	2 -- Displays Calendar for month and year from 2000 - 2020"
		echo "	3 -- Display Current Directory Path"
		echo "	4 -- Change Directory"
		echo "	5 -- Long List of visible files in current directory"
		echo "	6 -- Display current time and Date and Calendar"
		echo "	7 -- Start vi editor"
		echo "	8 -- Email a file to a user"
		echo -e "	9 -- Exit Program\n"
		

		read -p "Enter a Number: " usernbr  #collects the input the user gives to the command prompt
		echo
		#
		case "$usernbr" in
		1) 
			clear
			finger | more #displays users loggedin, piped to the more command so that the user can review
			;;
		2)		
			read -p "Enter a Month " usermonth
			if [ $usermonth -lt 1 -o $usermonth -gt 12 ]   #if the month is less than 1 or greater than 12, it's not an actual month and it won't work correctly. 
				then
					echo "Since when is $usermonth between 1-12?"
				else 
					
					read -p "Enter a Year " useryear  #if the month is valid, then it prompts the user to then enter a year between 2000 and 2020" 
		 		if  [ $useryear -lt 2000 -o $useryear -gt 2020 ]
					then
						echo "Since when is $useryear between 2000 and 2020?"
					else
					cal $usermonth $useryear #displays the month and year you are lookign for
				fi
			fi
			;;			

		3) 
			clear #displays the current working directory 
			pwd
			;;

		4) 
			clear
			read -p "Enter a directory " userdirectory #promts the user to enter a directory to move to 
			if [ -z $userdirectory ] #-z Checks to make sure the variable is not empty, if it is, it directs you home
				then
				echo "you didn't specify a directory. Taking you to your home directory"
				cd ~
			elif [ $userdirectory = "~" ] #if the user directory is ~, use the eval command to execute the command
				then 
				eval cd "$userdirectory"
			elif [ $userdirectory = \$HOME ] #if the user directory selected is $HOME, uses the eval command to execute the command
				then
				eval cd "$userdirectory"
			elif [ -d $userdirectory ] #checks to make sure the path is a directory, then it changes your directory
				then
				cd $userdirectory
			else 
				echo "I don't know what $userdirectory is, but it sure isn't a directory" #this is the catch all branch, it didn't pass any of the previous validations
			fi
			;;

		5)
			ls -l | more #uses the LS command with long format argument, piped into a more to command to make readable
			;;
		6)  #displays current time and calendar date
			clear
			date
			cal
			;;
		7)
			clear
			read -p "Please type the name of a file you'd like to open in vi " filetovi #prompts the user to enter a file name to open
			if [ -z $filetovi ] #if the input is empty 
				then 
				echo "you need to enter a file name"
			elif [ -a $filetovi ] #-a argument checks that the file exists, if it does it performs our check
				then 
				asciicheck=$(file "$filetovi" | awk '{print $2}' | grep ASCII) #prints variable 2 of the file output, which if it is correct file type will be ASCII. If it's not ASCII the variable ends up blank
				if [ -z $asciicheck ] #if the variable is blank then it is not an ASCII text file
				then
				echo "not a valid file type"
				else
				vi $filetovi #this means that the ascii check variable was populated with a value, meaning that it is an ASCII file
				fi
				
			else 
				vi $filetovi #file doesn't exist, create a new file with that name #this is our catch all, 
				
			fi
			;;
		8)	
			clear
			read -p "Enter the recipient you'd like to email: " emailad #prompts the user for a user to email
			emvalid=$(cat /etc/passwd | grep -o "$emailad" | head -1) #creates a variable that checks that the user exits, if they do not the variable is empty, if they do, it populates the first existiance of the variable 
			if [ -z $emvalid ] #performs a check make sure that the variable is not empty. If it's empty, it means that the user didn't exist in /etc/passwd
			then
				echo "not a valid email"
			else 
				read -p "Subject of the email you'd like to send: " emsubject #ask the user for the subject
				read -p "Message you'd like to send: " emmessage #ask the user for the message
				read -p "Attachment you'd like to add " emattachment #ask the user for an attachment they'd like to add
				attachcheck=$(file "$emattachment" | awk '{print $2}' | grep ASCII) #creates a variable to check if the attachment both exits and is an ascii file
				if [ -z $attachcheck ] #if this variable is empty, it means that the file command did not find ASCII in the output, meaning it doesn't exist or it's not an ASCII file
				then 
				echo "The attachment was not valid, still sending your email" #the attachment was not valid, but it will still send your email 
				echo ""$emmessage"" | mail -s ""$emsubject"" "$emailad" 
				else
				echo ""$emmessage"" | mail -s ""$emsubject"" -a ""$emattachment"" "$emailad" #the attachment was valid and your email will be sent 
				fi
			fi 
			;;
		9) #takes you out of the program
			clear
			echo "thank you"
			;;
		*) #catch all condition, if not 1-9
			clear
			echo "$userltr is not a valid input"
			;;
	
	esac
	done	
		

