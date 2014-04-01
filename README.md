Scripts
=======
This is where I host my bash scripts now.

## CtrlCapslock.sh 

Swaps your left ctrl key with Caps Lock

## Doc2Png.sh

Changes .doc files into .png by batch. Remember to make a special directory for the .doc files to convert. You can pretty much change the file format from png to whatever nconvert allows. Speaking of which, dependencies include [nconvert](http://www.xnview.com/en/nconvert/#features) and unoconv.

## Html2MD.sh

This one's in development. It turns html files into markdown files, even the images in their image folders. Remember to make a special directory for the .html files to convert. It uses Aaron's html2text to do the conversion which can be downloaded [here](https://github.com/aaronsw/html2text). The image part is difficult since it needs the whitespaces in the markdown files' image links to be converted to %20, and that's a pain. Feel free to help me fix that.

## Url2MD.sh

Converts a list of URLs in a certain directory to markdown files. Remember to make a special directory for the files to convert. It uses Brett Terpstra's [read2text](http://cdn3.brettterpstra.com/downloads/Read2Text1.zip) to convert them. The list must alternate the lines between title and url.
