thf(t1, type, s__instance: $i > $i > $o). thf(t2, type, s__attribute: $i > $i > $o). thf(t3, type, s__property: $i > $i > $o).
thf(t4, type, s__during: $i > $i > $o). thf(t5, type, s__holdsDuring: $i > $o > $o).
thf(t6, type, s__Org1: $i). thf(t7, type, s__Organism: $i). thf(t8, type, s__Nocturnal: $i). thf(t9, type, s__Nighttime: $i). thf(t10, type, s__Awake: $i).
thf(tell_1, axiom, s__instance @ s__Org1 @ s__Organism).
thf(tell_2, axiom, s__attribute @ s__Org1 @ s__Nocturnal).
thf(merge_1855, axiom, ![X:$i,Y:$i]: ((s__attribute @ X @ Y) => (s__property @ X @ Y))).
thf(gemini_rule3, axiom, ![ORG:$i]: (((s__instance @ ORG @ s__Organism) & (s__property @ ORG @ s__Nocturnal)) => ?[T:$i,N:$i]: ((s__instance @ N @ s__Nighttime) & (s__during @ T @ N) & (s__holdsDuring @ T @ (s__property @ ORG @ s__Awake))))).
thf(ask, conjecture, ?[T:$i,N:$i]: ((s__instance @ N @ s__Nighttime) & (s__during @ T @ N) & (s__holdsDuring @ T @ (s__property @ s__Org1 @ s__Awake)))).
