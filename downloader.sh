#!/bin/bash
echo "Starting the download of berserk chapters from https://readberserk.com/"
curl -k -s https://readberserk.com/ | grep "btn btn-sm btn-primary mr-2" | cut -d '"' -f2 > ./working/chaplist.txt;
for f in $(cat ./working/chaplist.txt); do
	chap=$(echo $f | cut -d "/" -f5);
	echo "Downloading $chap"
	mkdir ./working/$chap;
	curl -k -s $f | grep "class=\"pages__img\"" | cut -d '"' -f4 > ./working/$chap/imglist.txt;
	count=1;
	for x in $(cat ./working/$chap/imglist.txt); do
		case $x in
			*".jpg")
				curl -k -s $x > ./working/$chap/$count.jpg;
				;;
			*".jpeg")
				curl -k -s $x > ./working/$chap/$count.jpeg;
				;;
			*".png")
				curl -k -s $x > ./working/$chap/$count.png;
				;;
		esac
		let "count=count+1";
	done
done
echo "Downloads done :)"
rm -f ./working/*.txt
rm -f ./working/*/*.txt
mv ./working/* ./output/
echo "Files available in ./output/"
