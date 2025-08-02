dumpsxiso "Digimon Rumble Arena (USA).bin"
mkdir cleanROM
mv "Digimon Rumble Arena (USA).cue" cleanROM
mv "Digimon Rumble Arena (USA).bin" cleanROM
mkdir "Digimon Rumble Arena (USA)/vfs"
quickbms digimon_vfs2.bms "Digimon Rumble Arena (USA)/A.VFS" "Digimon Rumble Arena (USA)/vfs"
mkdir "Digimon Rumble Arena (USA)/inject"
mkdir "Digimon Rumble Arena (USA)/inject/bin"
cd "Digimon Rumble Arena (USA)"
XAPacker A.XAP
cd ..

dumpsxiso "DigimonTamers - Battle Evolution (Japan).bin"
mv "DigimonTamers - Battle Evolution (Japan).cue" cleanROM
mv "DigimonTamers - Battle Evolution (Japan).bin" cleanROM
rm "DigimonTamers - Battle Evolution (Japan).xml"
cd "DigimonTamers - Battle Evolution (Japan)"
mv A.XAP J.XAP
XAPacker J.XAP
cd J
mv J_012.xa "../../Digimon Rumble Arena (USA)/A"
mv J_013.xa "../../Digimon Rumble Arena (USA)/A"
mv J_011.xa "../../Digimon Rumble Arena (USA)/A"
mv J_015.xa "../../Digimon Rumble Arena (USA)/A"
mv J_010.xa "../../Digimon Rumble Arena (USA)/A"
mv J_014.xa "../../Digimon Rumble Arena (USA)/A"
cd ../..
rm -r "DigimonTamers - Battle Evolution (Japan)"
echo 1,xa,J_010.xa,16,1,125 >> "Digimon Rumble Arena (USA)/A/A.csv"
echo 1,xa,J_011.xa,16,1,123 >> "Digimon Rumble Arena (USA)/A/A.csv"
echo 1,xa,J_012.xa,16,1,121 >> "Digimon Rumble Arena (USA)/A/A.csv"
echo 1,xa,J_013.xa,16,1,122 >> "Digimon Rumble Arena (USA)/A/A.csv"
echo 1,xa,J_014.xa,16,1,126 >> "Digimon Rumble Arena (USA)/A/A.csv"
echo 1,xa,J_015.xa,16,1,124 >> "Digimon Rumble Arena (USA)/A/A.csv"
cd "Digimon Rumble Arena (USA)"
XAPacker A/A.csv
mv A_NEW.XAP A.XAP
