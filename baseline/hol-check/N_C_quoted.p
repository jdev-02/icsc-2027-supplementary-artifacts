fof(tell_1, axiom, s__instance(s__Org1, s__Organism)).
fof(tell_2, axiom, s__attribute(s__Org1, s__Nocturnal)).
fof(merge_1855_subrelation_attribute_property, axiom, ![X,Y]: (s__attribute(X,Y) => s__property(X,Y))).
fof(gemini_rule3_quoted, axiom, ![ORG]: ((s__instance(ORG, s__Organism) & s__property(ORG, s__Nocturnal)) => ?[T,N]: (s__instance(N, s__Nighttime) & s__during(T,N) & s__holdsDuring(T, q__property(ORG, s__Awake))))).
fof(ask, conjecture, ?[T,N]: (s__instance(N, s__Nighttime) & s__during(T,N) & s__holdsDuring(T, q__property(s__Org1, s__Awake)))).
