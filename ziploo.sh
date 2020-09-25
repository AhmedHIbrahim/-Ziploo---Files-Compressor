
#!/bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
#____Compress | Uncompress_______
$DIALOG --title 'Ziploo Compressing program' --msgbox 'This tiny program uses two functions to compress and uncompress (gzip & bzip2).To have a succeful compressing mission please follow the later provided instructions.Hope you gonna have great compressing missions with this program \n \n Ahmed.H.Ibrahim' 40 450

# if user cancels, exit
if [ $? == 1 ]; then exit; fi

$DIALOG --clear --title "missions " \
        --menu "which mission do you wanna do?" 20 51 4 \
        "1"  "to compress" \
        "2" "to uncompress" 2> $tempfile


retval=$?

choice=`cat $tempfile`



#__________Compress (gzip |bzip2) | Uncompress (ungzip | unbzip2)___________

case $retval in
  0)
    if [ $choice -eq 1 ]
      then
               $DIALOG --clear --title "compressing missions " \
              --menu "Choose  from the compressing missions:" 20 51 4 \
               "1" "gzip" \
               "2" "bzip2"  2> $tempfile
               retval1=$?
               choice1=`cat $tempfile`
               # if user cancels, exit
               if [ $retval1 == 1 ]; then exit; fi 
      else
               $DIALOG --clear --title "uncompressing missions " \
              --menu "Choose  from the uncompressing missions:" 20 51 4 \
               "1" "ungzip" \
               "2" "unbzip2"  2> $tempfile
               retval2=$?
               choice2=`cat $tempfile`
               # if user cancels, exit
               if [ $retval2 == 1 ]; then exit; fi 
    fi  ;;
  1)
    echo "Cancel pressed." 
exit ;;
  255)
    echo "ESC pressed.";;
esac

#________(Choose a single file or Document to compress) ___________
#________(or a compressed file to uncompress it) ___________

 $DIALOG --title 'Instructions while choosing a file or folder' --msgbox ' ((1))-Please choose a file without its absolute path 
e.g {{/home/$whoami/Pictures}} just write "Pictures" and delete the other things in the inbox. \n \n ((2))-For compressing multiple files , please compine them in one folder and compress it ,Thanks for your understanding.  \n \n ((3))-The uncompressing mission will save the content in a "ziploo" folder in your home directory.' 40 450

# if user cancels, exit
if [ $? == 1 ]; then exit; fi


FILE=`$DIALOG --stdout --title "Please choose a file."   --fselect $HOME/ 14 55  `

# if user cancels, exit
if [ $? == 1 ]; then exit; fi



#________compress_functions________________
case $retval1 in
  0) 
       
        dialog --title "New compression file name " \
	--backtitle "New compression file name" \
	--inputbox "Please , write the new compressed file name " 8 60 2>$tempfile
	namee=`cat $tempfile`
 
     if [ $choice1 -eq 1 ]
     
      then
        tar cvzf  $namee.tar.gz $FILE
      else 
        tar cvfj $namee.tar.bz2 $FILE
     fi
    ;;
  1)
    echo "Cancel pressed." 
exit ;;
  255)
    echo "ESC pressed.";;
esac 

# if user cancels, exit
if [ $? == 1 ]; then exit; fi

#_____Uncompress functions for gzip & bzip2_________

case $retval2 in
  0) 
     whoo=$(whoami)
     mkdir -p /home/$whoo/ziploo
     if [  $choice2 -eq 1 ]
     
      then
        tar -xvf $FILE -C $HOME/ziploo
      else 
        tar -xvf $FILE -C $HOME/ziploo
     fi
    ;;
  1)
    echo "Cancel pressed."
  ;;
  255)
    echo "ESC pressed.";;
esac 

# if user cancels, exit
if [ $? != 1 ];
then  
dialog --title "State" \
--msgbox "\n The mission has been done" 6 50
fi

#The End
