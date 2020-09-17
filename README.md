# Restful-Service-Kdb
 
This this an implementation of a simulation for kx database. <br />
As the program starts, there are 5 windows running in total. With the naming in `start.sh`, the 5 windows are: `DB-tick, DB-hdb, DB-rdb, DB-feed, DB-rest`.

## Usages
To start: `./start.sh` <br />
To stop: `./stop.sh` <br />

The bash files makes use of `screen` command in Linux terminal.
## Components
The program includes 3 main modules: **Kx Ticker-plant**, **Kx Sample Feeder**, and **SrpingBoot REST API.**
### 1. Kx Ticker-plant:
All script files for Ticker-plant is in extention `.q` which is the language of kx database, including `tick.q` and folder `tick/`.

The core files are `tick.q, tick/sym.q, tick/u.q, tick/rdb.q, tick/hdb.q`.  <br />
Documentations for them can be found here: https://code.kx.com/q/wp/rt-tick/

There is an extra implementation for account permission, including files `tick/pe.q, tick/rp.q, users`. <br />
Documentation can be found here: https://code.kx.com/q/wp/permissions/ <br />
File `tick/users` stores the username and password of the accounts. Control this file in window `DB-tick`

Port number for this server is:
> tick.q : port 2000 <br />
> tick/hdb.q : port 2010 <br />
> tick/rdb.q : port 2100 <br />
### 2. Kx Sample Feeder:
This module simulates the process of collecting data from tick-data source (broker) to generate 4 ticks every 100ms. <br />
The code is implemented in `feed.py`. 
### 3. SpringBoot REST API:
This module is built in Java. All the files are in folder `kdbrest/`, and an example can be found here: https://spring.io/guides/gs/rest-service/  <br />
Port number of the REST server is `2101`.
## Data Extraction
The database is placed at `localhost`.
There are 2 main queries implemented in `tick/rdb.q` : `getQuotes`, and `getQuoteCandles`. <br />

A typical GET request for candles of bid price for EURUSD with interval=5 minutes, from 2020.09.01 00:00:00 to 2020.09.01 12:00:00 is: 
> localhost:2101/candles?symbol=EURUSD&interval=5&pxType=bid&startTime=2020.09.01D00:00:00&endTime=2020.09.01D12:00:00

Look at folder `DB-data/` for more details on the usage.
