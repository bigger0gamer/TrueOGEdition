# String to use for the game's Title ID
# This will automatically rename armips output file, edit SYSTEM.CNF & psxbuild .cat all to match
# So you can easily rename the Title ID by just changing this variable and rebuilding
# I recommend keeping something placeholder sounding while dev/testing, like TRUE_OGD.EV
TITLE_ID='TRUE_OGD.EV'
VERSION_STRING='TrueOG-DEV-BUILD'

# armips
sed s/TITLE_ID/$TITLE_ID/ TrueOG.asm > temp.asm
sed -i s/VERSION_STRING/$VERSION_STRING/ temp.asm
armips temp.asm
rm temp.asm

# repack A.VFS
cd ../build\ env
quickbms -w -r digimon_vfs2.bms "Digimon Rumble Arena (US)/A.VFS" "Digimon Rumble Arena (US)/inject"

# edit SYSTEM.CNF + .cat & psxbuild
cp "Digimon Rumble Arena (US)/SYSTEM.CNF" "Digimon Rumble Arena (US)/SYSTEM.bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (US)/SYSTEM.CNF"
cp "Digimon Rumble Arena (US).cat" "Digimon Rumble Arena (US).bak"
sed -i s/SLUS_014.04/$TITLE_ID/ "Digimon Rumble Arena (US).cat"
psxbuild -c "Digimon Rumble Arena (US).cat" TrueOG.bin

# restore clean SYSTEM.CNF + .cat
rm "Digimon Rumble Arena (US)/SYSTEM.CNF"
rm "Digimon Rumble Arena (US).cat"
cp "Digimon Rumble Arena (US)/SYSTEM.bak" "Digimon Rumble Arena (US)/SYSTEM.CNF"
cp "Digimon Rumble Arena (US).bak" "Digimon Rumble Arena (US).cat"
rm "Digimon Rumble Arena (US)/SYSTEM.bak"
rm "Digimon Rumble Arena (US).bak"

# open output in emulator
mednafen TrueOG.cue
