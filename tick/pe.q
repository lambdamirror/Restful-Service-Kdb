
\d .pe

@[{system"l ",x};"./tick/users";users:([user:`$()] class:`$(); password:())]

toStr:{[x] $[10h=abs type x;x;string x]}

enc:{[u;p] md5 raze toStr p,u}

del:{.pe.users:delete from .pe.users where user=x;
	 upd[]}

upd:{`:./tick/users set .pe.users}

add:{[u;c;p]
     del u;
     `.pe.users upsert (u;c;enc[u;p]);
     upd[]
     }

getClass:{[u] .pe.users[u][`class]}

addAdm:{[u;p] add[u;`admin;p]}

addSub:{[u;p] add[u;`subscriber;p]}

isSub:{[u] `subscriber~getClass[u]}

isAdm:{[u] `admin~getClass[u]}

auth:{[u;p] enc[u;p]~.pe.users[u][`password]}
