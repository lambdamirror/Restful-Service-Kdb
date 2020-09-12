/2019.06.17 ensure sym has g attr for schema returned to new subscriber
/2008.09.09 .k -> .q
/2006.05.08 add

\d .u
/ initialize w: dict of form tables!RTS's Id
init:{
	/ w: `quote`trade!(,(7i;`USDEUR`JPYAUD);())
	w::t!(count t::tables`.)#()		/empty dict at the init
	}

/ delete a RTS
del:{
	/ x: tables name `quote`trade
	/ y: RTS's id 7i
	w[x]_:w[x;;0]?y					/w[x;;0]?y return index of w[x] where the element at position 0 equal y; w[x]_:n cut off the element nth in w[x]
	};

/ delete all RTS's
.z.pc:{
	/ x: tables name `quote`trade
	del[;x]each t
	};

/ select symbol to publish to RTS; if y~` return raw x
sel:{
	/ x: new messages
	/ y: list of symbols subcribed
	$[`~y;x;select from x where sym in y]
	}

/ publish to RTS's in .u.w
pub:{[t;x]
	/ t: tables name `quote`trade
	/ x: new messages
	{[t;x;w]
		if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]					/if x is not null then call `upd in RTS's Id (first w)
		}[t;x] each w t
	}

/ add new RTS to .u.w
add:{
	/ x: tables name `quote`trade
	/ y: symbol to be subcribed `USDEUR
	/ .z.w: new RTS's id 7i
	$[(count w x)>i:w[x;;0]?.z.w;.[`.u.w;(x;i;1);union;y];w[x],:enlist(.z.w;y)];
	(x;$[99=type v:value x;sel[v]y;@[0#v;`sym;`g#]])
	}

/ handle the list of tables name and symbols sent from RTS
sub:{
	/ x: tables name `quote`trade
	/ y: list of symbols to be subcribed `USDEUR`JPYAUD
	if[x~`;:sub[;y]each t];								/recursive for each table and each symbol
	if[not x in t;'x];									/raise error if table name not identified
	del[x].z.w;											/delete the WHOLE RTS's current subcriptions
	add[x;y]											/add new subcriptions to .u.w
	}											

end:{(neg union/[w[;;0]])@\:(`.u.end;x)}

