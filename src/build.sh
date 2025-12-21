# String to use for the game's Title ID
# This will automatically rename armips output file, edit SYSTEM.CNF & mkpsxiso .xml all to match
# So you can easily rename the Title ID by just changing this variable and rebuilding
# I recommend keeping something placeholder sounding while dev/testing, like TRUE_OGD.EV
TITLE_ID='TRUE_OGD.EV'
VERSION_STRING='TrueOG_DEV'
NUMBER_SONGS=$(cat NumberSongs.txt)

# armips
sed s/TITLE_ID/$TITLE_ID/ TrueOG.asm > temp.asm
armips -strequ VERSION_STRING $VERSION_STRING -equ NUMBER_SONGS $NUMBER_SONGS temp.asm -sym fuck.sym
rm temp.asm

# repack A.VFS
cd ../build\ env
quickbms -Q -w -r digimon_vfs2.bms "Digimon Rumble Arena (USA)/A.VFS" "Digimon Rumble Arena (USA)/inject"

# edit SYSTEM.CNF + .xml && mkpsxiso
cp "Digimon Rumble Arena (USA)/SYSTEM.CNF" "Digimon Rumble Arena (USA)/SYSTEM.bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (USA)/SYSTEM.CNF"
cp "Digimon Rumble Arena (USA).xml" "Digimon Rumble Arena (USA).bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (USA).xml"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (USA).xml"
mkpsxiso -y -q -o TrueOG.bin -c TrueOG.cue -l $TITLE_ID "Digimon Rumble Arena (USA).xml"

# restore clean SYSTEM.CNF + .xml
mv "Digimon Rumble Arena (USA)/SYSTEM.bak" "Digimon Rumble Arena (USA)/SYSTEM.CNF"
mv "Digimon Rumble Arena (USA).bak" "Digimon Rumble Arena (USA).xml"

# open output in emulator
mednafen TrueOG.cue &> /dev/null
