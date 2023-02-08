kinase(k2).
kinase(k1).
kinase(k3).

phosphosite(s1).
phosphosite(s2).
phosphosite(s3).
phosphosite(s4).
phosphosite(s5).

perturbation(delta1).
perturbation(delta2).


effect(inhibiton).
effect(excitation).

occupancy(up).
occupancy(down).
occupancy(unchanged).


subclocation(loc1).

protein(p1).
protein(p2).


cell_line(c1).




knowntarget(kinase(k1), phosphosite(s1)).
knowntarget(kinase(k1), phosphosite(s2)).
knowntarget(kinase(k2), phosphosite(s2)).
knowntarget(kinase(k3),phosphosite(s3)).
knowntarget(kinase(k3), phosphosite(s3)).
knowntarget(kinase(k3), phosphosite(s4)).
knowntarget(kinase(k3), phosphosite(s5)).

plocation(protein(p1), subclocation(loc1), cell_line(c1)).
klocation(kinase(k1), subclocation(loc1), cell_line(c1)).
klocation(kinase(k2), subclocation(loc1), cell_line(c1)).
klocation(kinase(k3), subclocation(loc1), cell_line(c1)).
plocation(protein(p2), subclocation(loc1), cell_line(c1)).

perturbs(perturbation(delta1),phosphosite(s3),occupancy(down)).
perturbs(perturbation(delta2),phosphosite(s2),occupancy(down)).
perturbs(perturbation(delta1),phosphosite(s1),occupancy(down)).
perturbs(perturbation(delta1),phosphosite(s4),occupancy(up)).
perturbs(perturbation(delta1),phosphosite(s5),occupancy(down)).

ison(phosphosite(s1),kinase(k3)).
ison(phosphosite(s2),kinase(k3)).
ison(phosphosite(s3),protein(p1)).
ison(phosphosite(s4),protein(p2)).
ison(phosphosite(s5),protein(p2)).


doesDinhibitKinC(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)).

doesDinhibitKinC2(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)),
  (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
  colocalisation(protein(P),kinase(K)).


colocalisation(protein(P), kinase(K)) :-
  plocation(protein(P), subclocation(L), cell_line(c1)),
  klocation(kinase(K), subclocation(L), cell_line(c1)).

sharedtarget(phosphosite(S)) :-
      knowntarget(kinase(K1), phosphosite(S)),
      knowntarget(kinase(K2), phosphosite(S)),
      kinase(K1) \= kinase(K2).

uniquetarget(phosphosite(S)) :- phosphosite(S), \+sharedtarget(phosphosite(S)).

doesDinhibitKinC3(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)),
  uniquetarget(phosphosite(S)),
  (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
  colocalisation(protein(P),kinase(K)).

doesDactivateKinC(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(up)),
  (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
  colocalisation(protein(P),kinase(K)).
  uniquelytargeted(phosphosite(S), kinase(K)).


% query(doesDactivateKinC(perturbation(D),kinase(K),cell_line(c1))).


majoritycheck(perturbation(D), kinase(K)) :-
  (findall(phosphosite(P), doesDinhibitKinC3(perturbation(D), kinase(K), cell_line(C)), L1),
    findall(phosphosite(P1), doesDactivateKinC(perturbation(D), kinase(K), cell_line(C)), L2)),
    length(L1, Length1), length(L2, Length2),
    compare('>', Length1, Length2).


% query(majoritycheck(perturbation(delta1), kinase(k3))).

doesDinhibitKinC4(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)),
  (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
  colocalisation(protein(P),kinase(K)),
  uniquelytargeted(phosphosite(S), kinase(K)),
  majoritycheck(perturbation(D), kinase(K)).






query(doesDinhibitKinC(perturbation(D),kinase(K),cell_line(c1))).
query(doesDinhibitKinC2(perturbation(D),kinase(K),cell_line(c1))).
query(doesDinhibitKinC3(perturbation(D),kinase(K),cell_line(c1))).
query(doesDinhibitKinC4(perturbation(D),kinase(K),cell_line(c1))).


% query(doesDinhibitKinC(perturbation(D),kinase(k3),cell_line(c1))).
% query(doesDinhibitKinC2(perturbation(D),kinase(k3),cell_line(c1))).
% query(doesDinhibitKinC3(perturbation(D), kinase(k3), cell_line(c1))).
% query(doesDinhibitKinC4(perturbation(D),kinase(k3),cell_line(c1))).










%
