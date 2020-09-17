# decode: host port:2345
# |--> 2: exchange number
# |--> 3: module number ( tick.q:0 ; r*.q:1 )
# |--> 4: subscriber number ( rdb.q:0 ; rst.q:1 2...)
# |--> 5: other
# sed -i 's/\r$//' scriptname.sh
screen -dmS DB-tick q tick.q sym ./logs -p 2000
sleep 2s
screen -dmS DB-hdb q tick/hdb.q ./db -p 2010
sleep 2s
screen -dmS DB-rdb q tick/rdb.q localhost:2000 localhost:2010 -p 2100
sleep 1s
screen -dmS DB-feed q feed.q
sleep 1s
cd kdbrest/
screen -dmS DB-rest ./mvnw clean spring-boot:run
cd ..
sleep 1s
echo "Tickerplant started..."
screen -ls
