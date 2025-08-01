echo "Converting music to .xa..."
cd songs
mkdir ../../build\ env/Digimon\ Rumble\ Arena\ \(USA\)/A/ext/
find -exec psxavenc -t xa -c 2 {} {}.xa \;

echo "Moving all .xa music to A/ext..."
find -wholename "*.xa" -exec mv {} ../../build\ env/Digimon\ Rumble\ Arena\ \(USA\)/A/ext/ \;

echo "Adding all .xa music to B.csv..."
cd ../../build\ env/Digimon\ Rumble\ Arena\ \(USA\)/A/ext/
cp ../A.csv ../B.csv
cp ../../../appendcsv.sh .
echo "127" > counter
ls | grep .xa | wc -l > ../../../../src/NumberSongs.txt

find -wholename "*.xa" -exec sh appendcsv.sh {} \;

echo "Repacking A.XAP..."
cd ../..
XAPacker A/B.csv
mv B_NEW.XAP A.XAP
rm -r A/ext
