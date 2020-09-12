\d .rp

proc:()!()

add:{[s] .rp.proc,:enlist[s]!enlist enlist`}

grant:{[s;u] @[`.rp.proc;s;union;u]}

revoke:{[s;u] @[`.rp.proc;s;except;u]}

pg.sub:{[u;q]
	show u; show q;
	if[not (s:$[10=type q 0;`$(q 0);q 0]) in key .rp.proc;'string[s],": Requests not exist"];
	if[not u in .rp.proc[s]; '"Permission required"];
	value q
	}
