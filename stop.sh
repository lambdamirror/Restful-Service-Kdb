#bash
screen -S CFH-rest -p 0 -X stuff "^C"
screen -S CFH-feed -p 0 -X stuff "^M\\\\\\\\^M"
sleep 2s
screen -S CFH-rdb -p 0 -X stuff "^M\\\\\\\\^M"
screen -S CFH-hdb -p 0 -X stuff "^M\\\\\\\\^M"
screen -S CFH-tick -p 0 -X stuff "^M\\\\\\\\^M"
sleep 1s
echo "Tickerplant stopped..."
screen -ls
