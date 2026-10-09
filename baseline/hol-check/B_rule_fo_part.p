fof(tell_1, axiom, s__instance(s__Bug1, s__SoftwareBug)).
fof(tell_2, axiom, s__instance(s__Prog1, s__ComputerProgram)).
fof(tell_3, axiom, s__instance(s__Alice, s__Human)).
fof(tell_4, axiom, s__instance(s__Acme, s__Organization)).
fof(tell_5, axiom, s__bugDiscoverer(s__Bug1, s__Prog1, s__Alice)).
fof(tell_6, axiom, s__bugInProgram(s__Bug1, s__Prog1, s__Acme)).
fof(merge_15080, axiom, s__subclass(s__Human, s__CognitiveAgent)).
fof(merge_1659, axiom, s__subclass(s__CognitiveAgent, s__SentientAgent)).
fof(merge_1649, axiom, s__subclass(s__SentientAgent, s__AutonomousAgent)).
fof(merge_17111, axiom, s__subclass(s__Organization, s__AutonomousAgent)).
fof(instance_subclass, axiom, ![X,C,S]: ((s__instance(X,C) & s__subclass(C,S)) => s__instance(X,S))).
fof(subclass_trans, axiom, ![A,B,C]: ((s__subclass(A,B) & s__subclass(B,C)) => s__subclass(A,C))).
fof(ask, conjecture, ?[D]: (s__instance(D, s__Discovering) & s__agent(D, s__Alice) & s__patient(D, s__Bug1))).
fof(cyber_155_fo_part, axiom, ![BUG,PROG,DISC,AG]: ((s__instance(DISC, s__AutonomousAgent) & s__instance(AG, s__AutonomousAgent)) => ((s__instance(BUG, s__SoftwareBug) & s__instance(PROG, s__ComputerProgram) & s__bugDiscoverer(BUG,PROG,DISC) & s__bugInProgram(BUG,PROG,AG)) => ?[X]: (s__instance(X, s__Discovering) & s__agent(X, DISC) & s__patient(X, BUG))))).
