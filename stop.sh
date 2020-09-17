#bash
screen -S DB-rest -p 0 -X stuff "^C"
screen -S DB-feed -p 0 -X stuff "^M\\\\\\\\^M"
sleep 2s
screen -S DB-rdb -p 0 -X stuff "^M\\\\\\\\^M"
screen -S DB-hdb -p 0 -X stuff "^M\\\\\\\\^M"
screen -S DB-tick -p 0 -X stuff "^M\\\\\\\\^M"
sleep 1s
echo "Tickerplant stopped..."
screen -ls
