thf(t_instance, type, s__instance: $i > $i > $o).
thf(t_subclass, type, s__subclass: $i > $i > $o).
thf(t_bugDiscoverer, type, s__bugDiscoverer: $i > $i > $i > $o).
thf(t_bugInProgram, type, s__bugInProgram: $i > $i > $i > $o).
thf(t_agent, type, s__agent: $i > $i > $o).
thf(t_patient, type, s__patient: $i > $i > $o).
thf(t_holdsDuring, type, s__holdsDuring: $i > $o > $o).
thf(t_BeginFn, type, s__BeginFn: $i > $i).
thf(t_WhenFn, type, s__WhenFn: $i > $i).
thf(t_c1, type, s__Bug1: $i). thf(t_c2, type, s__Prog1: $i). thf(t_c3, type, s__Alice: $i). thf(t_c4, type, s__Acme: $i).
thf(t_c5, type, s__SoftwareBug: $i). thf(t_c6, type, s__ComputerProgram: $i). thf(t_c7, type, s__Human: $i).
thf(t_c8, type, s__Organization: $i). thf(t_c9, type, s__CognitiveAgent: $i). thf(t_c10, type, s__SentientAgent: $i).
thf(t_c11, type, s__AutonomousAgent: $i). thf(t_c12, type, s__Discovering: $i).
thf(tell_1, axiom, s__instance @ s__Bug1 @ s__SoftwareBug).
thf(tell_2, axiom, s__instance @ s__Prog1 @ s__ComputerProgram).
thf(tell_3, axiom, s__instance @ s__Alice @ s__Human).
thf(tell_4, axiom, s__instance @ s__Acme @ s__Organization).
thf(tell_5, axiom, s__bugDiscoverer @ s__Bug1 @ s__Prog1 @ s__Alice).
thf(tell_6, axiom, s__bugInProgram @ s__Bug1 @ s__Prog1 @ s__Acme).
thf(merge_15080, axiom, s__subclass @ s__Human @ s__CognitiveAgent).
thf(merge_1659, axiom, s__subclass @ s__CognitiveAgent @ s__SentientAgent).
thf(merge_1649, axiom, s__subclass @ s__SentientAgent @ s__AutonomousAgent).
thf(merge_17111, axiom, s__subclass @ s__Organization @ s__AutonomousAgent).
thf(instance_subclass, axiom, ![X:$i,C:$i,S:$i]: (((s__instance @ X @ C) & (s__subclass @ C @ S)) => (s__instance @ X @ S))).
thf(subclass_trans, axiom, ![A:$i,B:$i,C:$i]: (((s__subclass @ A @ B) & (s__subclass @ B @ C)) => (s__subclass @ A @ C))).
thf(cyber_155, axiom, ![BUG:$i,PROG:$i,DISC:$i,AG:$i]: (((s__instance @ DISC @ s__AutonomousAgent) & (s__instance @ AG @ s__AutonomousAgent)) => (((s__instance @ BUG @ s__SoftwareBug) & (s__instance @ PROG @ s__ComputerProgram) & (s__bugDiscoverer @ BUG @ PROG @ DISC) & (s__bugInProgram @ BUG @ PROG @ AG)) => ?[X:$i]: ((s__instance @ X @ s__Discovering) & (s__agent @ X @ DISC) & (s__patient @ X @ BUG) & (s__holdsDuring @ (s__BeginFn @ (s__WhenFn @ X)) @ (s__bugInProgram @ BUG @ PROG @ AG)))))).
thf(ask, conjecture, ?[X:$i]: ((s__instance @ X @ s__Discovering) & (s__agent @ X @ s__Alice) & (s__patient @ X @ s__Bug1))).
