mkdir tmp
mkdir studentfiles
mkdir studentfiles/cpp
mkdir studentfiles/h

for f in *.zip; do 

zipname=${f%.zip}
headername=$zipname.h
cppname=$zipname.cpp

unzip "$f" -d tmp


for g in tmp/*.h; do
finalHeaderName="${g%.h}_$headername"
#echo "$finalHeaderName"
mv $g $finalHeaderName
if [[ $finalHeaderName != *leaker* ]]
then
	mv $finalHeaderName studentfiles/h
else
	rm $finalHeaderName
fi
done;

for g in tmp/*.cpp; do
finalCPPName=${g%.cpp}_$cppname
mv $g $finalCPPName
if [[ $finalCPPName != *leaker* ]]
then
	mv $finalCPPName studentfiles/cpp
else
	rm $finalCPPName
fi
done;


done;
rmdir tmp

read -p 'What assignment is this? (like "Lab3" -- no spaces please)? ' labName

read -p 'What files (up to 3, separated by whitespace) do you want to check for (like "DynamicArray.h")? ' fileName1 fileName2 fileName3
mkdir MOSSfiles
echo $fileName1
echo $fileName2
echo $fileName3
echo "Loading..."

if [[ $fileName1 == *.h ]]
then
find studentfiles/h -name "*${fileName1%.*}*" -exec mv {} MOSSfiles/ \;

elif [[ $fileName1 == *.cpp ]]
then
find studentfiles/cpp -name "*${fileName1%.*}*" -exec mv {} MOSSfiles/ \;

fi

if [[ $fileName2 == *.h ]]
then
find studentfiles/h -name "*${fileName2%.*}*" -exec mv {} MOSSfiles/ \;

elif [[ $fileName2 == *.cpp ]]
then
find studentfiles/cpp -name "*${fileName2%.*}*" -exec mv {} MOSSfiles/ \;

fi

if [[ $fileName3 == *.h ]]
then
find studentfiles/h -name "*${fileName3%.*}*" -exec mv {} MOSSfiles/ \;

elif [[ $fileName3 == *.cpp ]]
then
find studentfiles/cpp -name "*${fileName3%.*}*" -exec mv {} MOSSfiles/ \;

fi

HTMLLINK=$(./moss.pl -l cc -c $labName ./MOSSfiles/* | tail -1)

echo $"LINK IS: \n"
echo $HTMLLINK

destdir=./STUDENTREPORT.html
content=$(curl -L $HTMLLINK)
echo echo "$content" >> "$destdir"
