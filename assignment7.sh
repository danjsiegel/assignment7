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
			clear
			read -p "Enter a directory" userdirectory
			if [ -z $userdirectory ] #-z Checks to make sure the variable is not empty, if it is, it directs you home
				then
				echo "you didn't specify a directory. Taking you to your home directory"
				cd ~
			elif [ $userdirectory = "`" ] #if the user directory is ~, use the eval command to execute the command
				then 
				eval cd "$userdirectory"
			elif [ $userdirectory = "$HOME" ] #if the user directory selected is $HOME, uses the eval command to execute the command
				then
				eval cd "$userdirectory"
			elif [ -d $userdirectory ] #checks to make sure the path is a directory, then it changes your directory
				then
				cd $userdirectory
			else 
				echo "I don't know what $userdirectory is, but it sure isn't a directory"
			fi
			;;

		9) #takes you out of the program
			clear
			echo "thank you"
			;;
		*) #catch all condition, if not a-j
			clear
			echo "$userltr is not a valid input"
			;;
	
	esac
	done	
		
