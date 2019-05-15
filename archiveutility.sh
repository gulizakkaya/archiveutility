#!/bin/bash

INPUT=/tmp/menu.sh.$$
OUTPUT=/tmp/output.sh.$$
OUTPUT2="/tmp/input.txt"

#dialog --fselect to choose a file 
function fileChooser(){
   __DIR=$1

  __RESULT=$(dialog --clear --title "Choose Directory" --stdout \
                   --title "Choose File"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser /recursos/ )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
  

done


#extract function to extract the zip file
function extractzip(){
  unzip $RESULT
  exit

}

#extract function to extract the tar file
function extracttar(){
        tar -xzf $RESULT
	exit
}

#extract function to extract the rar file
function extractrar(){
        unrar e $RESULT
        exit
}

#extract function to extract the bzip2 file
function extractbzip2(){
	  varnamebzip2="${RESULT}"
        bzip2 -d $varnamebzip2
       exit
       	
}

#extract function to extract the gzip file
function extractgzip(){
        gzip -d $RESULT
       exit
}

#compression function to compress the file to zip file
function compresszip(){
	compressionname;
   varnamezip="${name}.zip"
        zip $varnamezip $RESULT
   exit

}

#compression function to compress the file to tar file
function compresstar(){
	compressionname;
         varnametar="${name}.tar.gz"
 tar -czf $varnametar $RESULT
 exit

}

#compression function to compress the file to rar file
function compressrar(){
	compressionname;
         varnamerar="${name}.rar"
 rar a $varnamerar $RESULT
 exit

}

#compression function to compress the file to bzip2 file
function compressbzip2(){
	bzip2 -z $RESULT
       exit	
}

#compression function to compress the file to gzip file
 function compressgzip(){
        gzip -r $RESULT
       exit
}



function extract(){

#Message box to warn the user for the selection while extracting!
dialog --title "WARNING!" --msgbox "You selected this file $RESULT.Please select type according to file extension" 10 60

#Menu box to show options to a user to select the archiving type
dialog --clear  --help-button --backtitle "*ARCHIVE UTILITY*" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys. \n\
Choose the TASK" 20 60 6 \
Zip "Select if you want to extract the zip file" \
Tar  "Select if you want to extract the tar file" \
Rar  "Select if you want to extract the rar file" \
Bzip2 "Select if you want to extract the bzip2 file" \
Gzip "Select if you want to extract the gzip file" \
Exit "Exit to the shell" 2>"${INPUT}"

#redirection
extracttype=$(<"${INPUT}")
#Case for the extracting, call the function according to a selection
case $extracttype in
        Zip) extractzip ;;
        Tar) extracttar;;
	Rar) extractrar;;
	Bzip2) extractbzip2;;
	Gzip) extractgzip;;
        Exit) echo "Bye"; break;;
esac


}

#Ask to a user for the compression, takes from the user a name for the compression file
function compressionname(){
        # show an inputbox
dialog --title "PLEASE GIVE AN ANSWER " \
--backtitle "*ARCHIVE UTILITY" \
--inputbox "Enter the name for the  file " 8 60 2>$OUTPUT2


# get data stored in $OUTPUT using input redirection
name=$(<$OUTPUT2)

}

#Compression... showed up a menu for user to select one of the compression type 
function compression(){
	
	  dialog --clear  --help-button --backtitle "*ARCHIVE UTILITY*" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys. \n\
Choose the TASK" 15 50 4 \
Zip "Select if you want to compress the zip file" \
Tar  "Select if you want to compress the tar file" \
Rar  "Select if you want to compress the rar file" \
Bzip2 "Select if you want to compress the bzip2 file" \
Gzip "Select if you want to compress the shar file" \
Exit "Exit to the shell" 2>"${INPUT}"


compressiontype=$(<"${INPUT}")
#Case for the compressing, call the function according to a selection
case $compressiontype in
        Zip) compresszip ;;
        Tar) compresstar;;
	Rar) compressrar;;
	Bzip2) compressbzip2;;
	Gzip) compressgzip;;
        Exit) echo "Bye"; break;;
esac


}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "*ARCHIVE UTILITY* " \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys. \n\
Choose the TASK" 15 50 4 \
Extract "Select if you want to extract the file" \
Compress "Select if you want to compress the file" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decision
case $menuitem in
	Extract) extract ;;
	Compress) compression;;
	Exit) echo "BYE"; break;;
esac

done
