/usage: q hdb.q ../db -p 2010

if[1>count .z.x;show"Supply directory of historical database";exit 0];

hdb:.z.x 0

@[{system"l ",x};hdb;{show "Error message - ",x;exit 0}]	/Mount the Historical Date Partitioned Database
