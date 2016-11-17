#!/bin/bash
FILE=$1
BITRATE=$2
IP=$3
PORT=$4
Iter=$5;
Iter=$(($Iter+$Iter))
echo "file:$FILE"
echo "bitrate:$BITRATE"
echo "IP:$IP"
echo "port:$PORT"

for ((i=0;i<$Iter;i+=2))
do
#echo $i;
j=$(($i+1));
newPORT=$(($PORT+$i))
#echo $j
echo $newPORT;
#echo "f$i"; 
rm -rf ~/f$i.ts
rm -rf ~/f$j.ts
mkfifo ~/f$i.ts
mkfifo ~/f$j.ts
tsloop/tsloop $FILE  > ~/f$i.ts &
tspcrstamp/tspcrstamp ~/f$i.ts $BITRATE  > ~/f$j.ts &
tsudpsend/tsudpsend ~/f$j.ts $IP $newPORT $BITRATE &
done
