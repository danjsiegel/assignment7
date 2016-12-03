#!/bin/bash
#Dan Siegel
#12.1.16
#Assignment 7
#Creates a menu that completes various tasks. 

	clear   #gives a fesh screen 
	until [ "$userltr" = '9' ]  #sets the program to repeat until the user inputs j" 
		do
		echo -e "\n Welcome To Dan's Main Menu \n"
		echo 
		echo "	1 -- Display users currently logged in"
		echo "	2 -- Displays Calendar for month and year from 2000 - 2020"
		echo "	3 -- Display Current Directory Path"
		echo "	4 -- Change Directory"
		echo "	5 -- Long List of visible files in current directory"
		echo "	6 -- Display current time and Date and Calendar"
		echo "	7 -- start vi editory"
		echo "	8 -- Email a file to a user"
		echo -e "	9 -- Exit Program\n"
		

		read -p "Enter a letter: " userltr  #collects the input the user gives to the command prompt
		echo
		#
		case "$userltr" in
		1) 
			clear
			finger | more 
			;;
		2)		
			read -p "Enter a Month " usermonth
			if [ $usermonth -lt 1 -o $usermonth -gt 12 ]
				then
					echo "Since when is $usermonth between 1-12?"
				else 
					
					read -p "Enter a Year " useryear
		 		if  [ $useryear -lt 2000 -o $useryear -gt 2020 ]
					then
						echo "Since when is $useryear between 2000 and 2020?"
					else
					cal $usermonth $useryear
				fi
			fi
			;;			

		3) 
			clear
			pwd
			;;

		4) 
			

		a|A)   #collects a subject, recipient, attachment, and a message you'd like to send to a user" 
			clear
			read -p "subject: " subject
			read -p "recipient: " recep
			read -p "attachment: " attachment
			read -p "your message: " message
			currentdir=$(pwd)
			echo ""$message"" | mail -s ""$subject"" -a "$attachment" "$recep"
			;;
		b|B) #gives list of all logged in users
			clear
			finger | more -10
			;;

		c|C) #gives the date
			clear
			date
			;;
		d|D) #gives the calendar 
			clear
			cal
			;;
		e|E) #gives the current working directory
			clear
			pwd
			;;	
		f|F) #lists contents of current directory
			clear
			ls
			;;
		g|G) #requests a web address and performs an ip lookup
			clear
			read -p "Name of website: " webaddress
			nslookup "$webaddress"
			;;
		h|H) #gives you your fortune
			clear
			fortune
			;;
		i|I) #cat's a file
			clear
			read -p "Name of your file: " filetocat
			currentdir=$(pwd)
			"$currentdir"/"$filetocat"
			;;

		1) #takes you out of the program
			clear
			echo "thank you"	
			;;
		*) #catch all condition, if not a-j
			clear
			echo "$userltr is not a valid input"
			;;
	
	esac
	done	
		
