




kinase(k2).
kinase(k1).
kinase(k3).
protein(p1)
protein(p2).

phosphosite(s1).
phosphosite(s2).
phosphosite(s3).
phosphosite(s4).
phosphosite(s5).

deletionOF((kinase(k1))).
deletionOF((kinase(k2))).

occupancy(up).
occupancy(down).
occupancy(unaffected).



perturbs(deletionOF((kinase(k1))), phosphosite(s1), occupancy(down), 0.1).
perturbs(deletionOF((kinase(k1))), phosphosite(s3), occupancy(down), 0.2).
perturbs(deletionOF((kinase(k2))), phosphosite(s2), occupancy(unaffected), 0.3).
perturbs(deletionOF((kinase(k1))), phosphosite(s4), occupancy(down), 0.2).
perturbs(deletionOF((kinase(k1))), phosphosite(s5), occupancy(down), 0.2).

phosphorylates(kinase(k1), phosphosite(s1), kinase(k3)).
phosphorylates(kinase(k2), phosphosite(s2), kinase(k3)).
phosphorylates(kinase(k3), phosphosite(s3), protein(p1)).
phosphorylates(kinase(k3), phosphosite(s4), protein(p2)).
phosphorylates(kinase(k3), phosphosite(s5), protein(p2)).



%%% s(phosphosite) is on k(kinase) or p(protein
ison(phosphosite(s1),kinase(k3)).
ison(phosphosite(s2),kinase(k3)).
ison(phosphosite(s3),protein(p1)).
ison(phosphosite(s4),protein(p2)).
ison(phosphosite(s5),protein(p2)).






doesSilofKwork(deletionOF((kinase(K))) :-
    phosphorylates(kinase(K), phosphosite(S), kinase(P)),
    perturbs(deletionOF((kinase(K))), phosphosite(S), occupancy(down), _).

%
doesSilofKwork2(deletionOF((kinase(K))) :-
    phosphorylates(kinase(K), phosphosite(S), kinase(P)),
    \+sharedtarget(kinase(K), kinase(_K2), phosphosite(S)),
    perturbs(deletionOF((kinase(K))), phosphosite(S), occupancy(down), _).

%
sharedtarget(kinase(K),kinase(K2),phosphosite(S)):-
                  (phosphorylates(kinase(K), phosphosite(S), kinase(P)),
                  phosphorylates(kinase(K2), phosphosite(S), kinase(P)),
                  K1 \= K2).



%
doesSilofKwork2(deletionOF((kinase(K))) :-
    phosphorylates(kinase(K), phosphosite(S), kinase(P)),
    \+sharedtarget(kinase(K), kinase(_K2), phosphosite(S)),
    findall(phosphosite(S),
    perturbs(deletionOF((kinase(K))), phosphosite(S), occupancy(up), _))

doesSilofKwork3b(DelK) :-
                          knowntarget(DelK,Pst,Tprot),
                          \+sharedKinasetarget(DelK,_K2,Tprot),
                          (findall(Pst,
                          (perturbs(DelK,Pst,_,up,_) ; perturbs(DelK,Pst,_,unaffected,_)),
                          L),
                          findall(Pst2,
                          perturbs(DelK,Pst2,_,down,_),
                          M)),
                          length(M, Length1), length(L, Length2),
                          compare('>', Length1, Length2).

doesSilofKwork3(DelK) :-
                          knowntarget(DelK,Pst),
                          \+sharedtargetB(DelK,_K2,Pst),
                          (findall(Pst,
                          (perturbs(DelK,Pst,_,up,_) ; perturbs(DelK,Pst,_,unaffected,_)),
                          L),
                          findall(Pst2,
                          perturbs(DelK,Pst2,_,down,_),
                          M)),
                          length(M, Length1), length(L, Length2),
                          compare('>', Length1, Length2).



















ykinasecompcheck(DelK1, K2):-
        perturbs(DelK1,_,Tprot1,_,_),
        sharedKinasetarget(DelK1,K2,Tprot1),
        direct_target(K2, Pst1, Tprot1),
        perturbs(DelK2,Pst1,Tprot1,up,_),
        (DelK2 \= K2, DelK2 \= DelK1).
