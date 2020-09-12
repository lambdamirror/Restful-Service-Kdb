/2008.09.09 .k ->.q
"kdb+tick 2.8 2014.03.12"
/usage: /q tick/rdb.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]
/host:2100

if[not "w"=first string .z.o;system "sleep 1"];			/buffer on non-Window system

system"l ./tick/rp.q"							/load permission modules

system"l ./tick/sym.q"							/load table scheme

upd:insert								/define upd function

.u.x:.z.x,(count .z.x)_("localhost:2000";"localhost:2010");		/get the ticker plant and history ports, defaults are *000,*010

tp:hopen `$":",.u.x 0

hd:hopen `$":",.u.x 1

.z.pw:{[u;p] tp (`.pe.auth;u;p)}

{.rp.grant[x;] each `sub} each `getQuotes`getQuoteCandles

.z.pg:{[query]
      user:.z.u;
      class:tp (`.pe.getClass;user);
      $[class~`admin; value query;
      class~`subscriber; .rp.pg.sub[user;query]]
      }

/ end of day: save, clear, hdb reload
.u.end:{
	/ args: x: date
	t:tables`.;
	t@:where `g=attr each t@\:`sym;
	.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];
	@[;`sym;`g#] each t;
	.Q.gc[];
	};

/ init schema and sync up from log file ; cd to hdb(so client save can run)
.u.rep:{
	(.[;();:;].)each x;		/interate through x
	if[null first y;:()];		/exit function if no record in d
	-11!y;				/load the daily logfile
	system "cd ./db";
	};

/ get table: dateTime, symbol, bid, ask, bsize, asize
getQuotes:{[x;b;e]
	/ x: symbol
	/ b,e: start and end time

	if[10=type x;x:`$x];
	if[10=type b;b:-12h$b];
	if[10=type e;e:-12h$e];

	if[(-11<>type x);:()];

	htab:enlist [0] 1;
	try:{[x;b;e]
		htab:hd("select from quote where sym=`", (string x), ", (date+time) within (", (string b),";", (string e), ")"); hd".Q.gc[]";
	  htab
	};
	htab:.[try;(x;b;e);{}];

	itab:select from (update date:.z.d from quote) where sym=x, (date+time) within (b;e);

	$[98=type htab;
		ftab:update dateTime:(date+time) from (htab,itab);
		ftab:update dateTime:(date+time) from (itab)]

	delete htab,itab from `.; .Q.gc[];
	select dateTime, symbol:sym, bid, ask, bsize, asize from ftab
	};

/ get table: dateTime, symbol, open, high, low, close, aVol, nQuote
getQuoteCandles:{[x;y;c;b;e]
	/ x: symbol
	/ y: interval (minute)
	/ c: type (`bid`ask)
	/ b,e: start and end time

	if[10=type x;x:`$x];
	if[10=type c;c:`$c];
	y:(`int$y)*60*1000000000;
	if[10=type b;b:-12h$b];
	if[10=type e;e:-12h$e];

	if[(-11<>type x)|(-7<>type y)|(not c in `bid`ask);:()];
	if[c=`bid;v:`bsize];
	if[c=`ask;v:`asize];

	htab:enlist [0] 1;
	try:{[x;b;e]
		htab::hd("select from quote where sym=`", (string x), ", (date+time) within (", (string b),";", (string e), ")"); hd".Q.gc[]";
	  htab
	};
	htab:.[try;(x;b;e);{}];

	itab:select from (update date:.z.d from quote) where sym=x, (date+time) within (b;e);
	$[98=type htab;
	  ftab:update dateTime:(date+time) from (htab,itab);
	  ftab:update dateTime:(date+time) from (itab)]

	delete htab,itab from `.; .Q.gc[];
	?[ftab;();(1#`dateTime)!enlist ({y xbar x};`dateTime;y);
	`symbol`open`high`low`close`aVol`nQuote!
	enlist[1#x;(first;c);(max;c);(min;c);(last;c);(avg;v);(count;c)]]
	};

.[.u.rep;tp"(.u.sub[`;`];`.u `i`L)"];	/connect to ticker plant for (schema;(logcount;log))
