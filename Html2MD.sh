#!/bin/bash
# Gets a list of files, ignoring subdirectories, and pastes it into a separate file
find . -maxdepth 1 -not -type d | xclip
xclip -o > ./list.txt
# Creates lists of subdirectories for fixing the image issue later
ls -d */ | xclip
xclip -o > ./dirlist.txt
xclip -o > ./dirlist20.txt
sed -i 's/ /%20/g' ./dirlist20.txt
# A loop that reads each line of the text file and creates an array, one filename per entry
a=0
while true; do 
    IFS=$'\r\n' lines1=($(cat ./list.txt))
    filename=${lines1[$a]}
    IFS=$'\r\n' lines2=($(cat ./dirlist.txt))
    olddir=${lines2[$b]}
    IFS=$'\r\n' lines3=($(cat ./dirlist20.txt))
    newdir=${lines3[$c]}
# A failsafe that breaks the loop once an array entry is found empty
    if [[ -z "$filename" ]]; then
	break
    fi
# Converts the content of the array entry which happens to be an html file and makes a new file with same name as original but with .md extension
    html2text --body-width=0 "${lines1[$a]}" | xclip
    xclip -o > $filename.md
# Fixes the image issue by swapping the flawed subdirectory strings with the %20 ones once they're found in the said file
# PROBLEM: This only works on like the first file in ./dirlist(20).txt
    if grep -q "$olddir" $filename.md; then
	sed -i 's,'"$olddir","$newdir",'g' $filename.md
# Then we begin doing swapping the flawed strings for the images this time
# PROBLEM: It somehow obfuscates the first sed replacement in the previous command such that foo%20bar%20files/ becomes foo%20bar%20file./ WTH
# PROBLEM: This only works on the first folder of ./dirlist(20).txt
# PROBLEM: The sed in the while loop does nothing
	cd $olddir
	find . -maxdepth 1 -not -type d | xclip
	xclip -o > ./imagelist.txt
	xclip -o > ./imagelist20.txt
	sed -i 's/ /%20/g' ./imagelist20.txt
	cd ../
	while true; do
	    IFS=$'\r\n' lines4=($(cat ./$olddir/imagelist.txt))
	    oldimage=${lines4[$d]}
	    IFS=$'\r\n' lines5=($(cat ./$olddir/imagelist20.txt))
	    newimage=${lines4[$e]}
	    if [[ -z "$oldimage" ]]; then
		break
	    fi
	    if [[ -z "$newimage" ]]; then
		break
	    fi
	    sed -i 's,'"$oldimage","$newimage",'g' $filename.md
	    d=$(($d+1))
	    e=$(($e+1))
	done
#	rm ./$olddir/imagelist.txt
#	rm ./$olddir/imagelist20.txt
	b=$(($b+1))
	c=$(($c+1))
    fi
    a=$(($a+1)) # Next array entry
done
# Remove the text files
#rm ./list.txt 
#rm ./dirlist.txt
#rm ./dirlist20.txt
rm *.html # Removes the original files
# Changes [filename].html.md to simply [].md
for file in *.html.md; do
    mv "$file" "$(basename "$file" .html.md)".md 
done
exit
