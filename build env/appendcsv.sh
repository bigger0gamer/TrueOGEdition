COUNTER=$(cat counter)

echo "1,xa,ext/$1,16,1,$COUNTER" >> ../B.csv

COUNTER=$(($COUNTER + 1))
echo $COUNTER > counter
