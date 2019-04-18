#!/bin/bash
find . -name \*.doc -type f -exec unoconv -f pdf -o {}.pdf {} \;
for file in *.doc.pdf; do
    mv "$file" "$(basename "$file" .doc.pdf)".pdf
done
rm *.doc
find . -maxdepth 1 -not -type d | xclip
xclip -o > ./list.txt
nconvert -l list.txt -out png -o %
rm *.pdf
rm list.txt
exit
