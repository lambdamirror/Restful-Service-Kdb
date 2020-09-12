
h:neg hopen `:localhost:2000 /connect to tickerplant 
syms:`AUDCAD`AUDCHF`AUDJPY`AUDNZD`AUDUSD`CADCHF`CADJPY`CHFJPY`CHFNOK`CHFPLN`EURAUD`EURCAD`EURCHF`EURGBP`EURILS`EURJPY`EURNOK`EURNZD`EURPLN`EURSEK`EURTRY`EURUSD`GBPAUD`GBPCAD`GBPCHF`GBPJPY`GBPNOK`GBPNZD`GBPPLN`GBPUSD /ins
prices:syms!0.95 0.65 75.6 1.07 0.71 0.68 79.2 115.5 9.9 4.1 1.6 1.57 1.1 0.9 4.0 124.87 10.73 1.78 4.41 10.28 8.21 1.17 1.83 1.75 1.19 138.71 11.92 1.97 4.9 1.3 /starting prices 
n:4 /number of rows per update
flag:1 /generate 10% of updates for trade and 90% for quote
getmovement:{[s] rand[0.0001]*prices[s]} /get a random price movement 
/generate trade price
getprice:{[s] prices[s]+:rand[1 -1]*getmovement[s]; prices[s]} 
getbid:{[s] prices[s]-getmovement[s]} /generate bid price
getask:{[s] prices[s]+getmovement[s]} /generate ask price
/timer function
.z.ts:{
	s:n?syms;
	h(".u.upd";`quote;(n#.z.N;s;getbid'[s];getask'[s];`float$(100000+n?1000000);`float$(100000+n?1000000))); 
	}
/trigger timer every 100ms
\t 100
"Updating..."
