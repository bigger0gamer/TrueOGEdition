# String to use for the game's Title ID
# This will automatically rename armips output file, edit SYSTEM.CNF & psxbuild .cat all to match
# So you can easily rename the Title ID by just changing this variable and rebuilding
# I recommend keeping something placeholder sounding while dev/testing, like TRUE_OGD.EV
TITLE_ID='TRUE_OGD.EV'
VERSION_STRING='True_OG-Development_Build'

# armips
sed s/TITLE_ID/$TITLE_ID/ TrueOG.asm > temp.asm
armips -strequ VERSION_STRING $VERSION_STRING temp.asm 
rm temp.asm

# repack A.VFS
cd ../build\ env
quickbms -w -r digimon_vfs2.bms "Digimon Rumble Arena (USA)/A.VFS" "Digimon Rumble Arena (USA)/inject"

# edit SYSTEM.CNF + .cat & psxbuild
cp "Digimon Rumble Arena (USA)/SYSTEM.CNF" "Digimon Rumble Arena (USA)/SYSTEM.bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (USA)/SYSTEM.CNF"
cp "Digimon Rumble Arena (USA).cat" "Digimon Rumble Arena (USA).bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (USA).cat"
psxbuild -c "Digimon Rumble Arena (USA).cat" TrueOG.bin

# restore clean SYSTEM.CNF + .cat
mv "Digimon Rumble Arena (USA)/SYSTEM.bak" "Digimon Rumble Arena (USA)/SYSTEM.CNF"
mv "Digimon Rumble Arena (USA).bak" "Digimon Rumble Arena (USA).cat"

# open output in emulator
mednafen TrueOG.cue
