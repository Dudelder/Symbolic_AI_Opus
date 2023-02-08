%%%% Does Silencing of K work?
%%%% 1s iteration


doesSilofKworkDU(DelK) :-
    knowntarget(DelK,Pst),
    (perturbs(DelK,Pst,_,down,_) ; perturbs(DelK,Pst,_,unaffected,_)).

% 2nd iteration
doesSilofKwork2DU(DelK) :-
        knowntarget(DelK,Pst),
        \+sharedtargetB(DelK,_K2,Pst),
        (perturbs(DelK,Pst,_,down,_) ; perturbs(DelK,Pst,_,unaffected,_)).


%
doesSilofKwork2aDU(DelK) :-
                          knowntarget(DelK,Pst,Tprot),
                          \+sharedKinasetargetB(DelK,_K2,Tprot),
                          (perturbs(DelK,Pst,_,down,_) ; perturbs(DelK,Pst,_,unaffected,_)).




%
%%%% Does Silencing of K work?
%%%% 1s iteration
doesSilofKwork(DelK) :-
    knowntarget(DelK,Pst),
    perturbs(DelK,Pst,_,down,_).




%%%% 2nd iteration Unique target check at phosphosite lvl with negation of sharedtargetB rule (found below)
doesSilofKwork2(DelK) :-
        knowntarget(DelK,Pst),
        \+sharedtargetB(DelK,_K2,Pst),
        perturbs(DelK,Pst,_,down,_).



sharedtargetB(Kin1,Kin2,Pst):-
                  (knowntarget(Kin1,Pst),
                  knowntarget(Kin2,Pst),
                  Kin1 \= Kin2).



%
doesSilofKwork3(DelK) :-
                          knowntarget(DelK,Pst),
                          \+sharedtargetB(DelK,_K2,Pst),
                          (findall(Pst,
                          (perturbs(DelK,Pst,_,up,_) ; perturbs(DelK,Pst,_,unaffected,_)),
                          L),
                          findall(Pst,
                          perturbs(DelK,Pst,_,down,_),
                          M)),
                          length(M, Length1), length(L, Length2),
                          compare('>', Length1, Length2).




%% Kinase compensation check rules

%
ykinasecompcheckTest(DelK1, K2):-
        (perturbs(DelK1,_,Tprot1,down,_) ; perturbs(DelK1,_,Tprot1,unaffected,_)),
        sharedKinasetarget(DelK1,K2,Tprot1),
        knowntarget(K2, Pst1, Tprot1),
        (perturbs(DelK2,Pst1,Tprot1,up,_),
        (DelK2 \= K2, DelK2 \= DelK1)).
%
ykinasecompcheckTestb(DelK1, K2):-
        (perturbs(DelK1,_,Tprot1,down,_) ; perturbs(DelK1,_,Tprot1,unaffected,_)),
        sharedKinasetarget(DelK1,K2,Tprot1),
        knowntarget(K2, Pst1),
        perturbs(DelK2,Pst1,Tprot1,up,_),
        (DelK2 \= K2, DelK2 \= DelK1).


%

ykinasecompcheckTest2(DelK1, K2):-
        knowntarget(DelK1, Pst1),
        (perturbs(DelK1,Pst1,Tprot1,up,_) ; perturbs(DelK1,Pst1,Tprot1,unaffected,_)),
        direct_target2(K2, Pst1, Tprot1).



doesSilofKworkProtlvl(Kin) :-
  knownkinasetarget(Kin,Tprot),
  perturbs(Kin,_,Tprot,down,_).

doesSilofKworkProtlvl2(Kin) :-
  knownkinasetarget(Kin,Tprot),
  perturbs(Kin,_,Tprot,down,_),
  \+sharedKinasetarget(Kin, _Kin2, Tprot).


sharedKinasetarget(K1,K2,Tprot):-
                knownkinasetarget(K1,Tprot),
                knownkinasetarget(K2,Tprot),
                K1 \= K2.



doesSilofKworkProtlvl3(DelK) :-
          knownkinasetarget(DelK,Tprot),
          \+sharedKinasetarget(DelK, _Kin2, Tprot),
          (findall(Tprot,
          (perturbs(DelK,Pst,Tprot,up,_) ; perturbs(DelK,Pst,Tprot,unaffected,_)),
          L),
          findall(Tprot,
          perturbs(DelK,Pst,Tprot,down,_),
          M)),
          length(M, Length1), length(L, Length2),
          compare('>', Length1, Length2).


%
doesSilofPworkProtlvl(Kin) :-
  knownphosphatasetarget(Kin,Tprot),
  perturbs(Kin,_,Tprot,up,_).

doesSilofPworkProtlvl2(Kin) :-
  knownphosphatasetarget(Kin,Tprot),
  perturbs(Kin,_,Tprot,up,_),
  \+sharedphosphatasetarget(Kin, _Kin2, Tprot).


sharedphosphatasetarget(K1,K2,Tprot):-
                knownphosphatasetarget(K1,Tprot),
                knownphosphatasetarget(K2,Tprot),
                K1 \= K2.



doesSilofPworkProtlvl3(DelK) :-
          knownphosphatasetarget(DelK,Tprot),
          \+sharedphosphatasetarget(DelK, _Kin2, Tprot),
          (findall(Tprot,
          (perturbs(DelK,Pst,Tprot,down,_) ; perturbs(DelK,Pst,Tprot,unaffected,_)),
          L),
          findall(Tprot,
          perturbs(DelK,Pst,Tprot,up,_),
          M)),
          length(M, Length1), length(L, Length2),
          compare('>', Length1, Length2).

%zero phosphatase below
yphosphatasecompcheckTestb(DelK1, K2):-
        (perturbs(DelK1,_,Tprot1,up,_) ; perturbs(DelK1,_,Tprot1,unaffected,_)),
        sharedphosphatasetarget(DelK1,K2,Tprot1),
        knowntarget(K2, Pst1),
        perturbs(DelK2,Pst1,Tprot1,down,_),
        (DelK2 \= K2, DelK2 \= DelK1).





%%% Queries for results collection.


% %
% findall(A,(yeastkinase(A), doesSilofKworkProtlvl(A)),L),sort(L,N), findall(B, (yeastkinase(B), doesSilofKwork(B)), Q), sort(Q,T), append(T,N,W),
% findall((R), (yeastkinase(R), perturbs(R,_,_,_,_)), H), sort(H,J), subtract(J,W,G),
% select(Y,G,O),(findall((Y,V), (yeastkinase(V), ykinasecompcheckTest(Y,V)), D), sort(D,X)).
%
% findall(B, doesSilofKworkProtlvl(B), Q), sort(Q,T),
% findall((R), (knowntarget(R,_), perturbs(R,_,_,_,_)), H), sort(H,J), subtract(J,T,G),
% select(Y,G,O),(findall((Y,V), (ykinasecompcheckTest(Y,V)), D), sort(D,X)).
%
%
% findall(A, doesSilofKwork(A), L), sort(L,N),  findall(B, doesSilofKworkProtlvl(B), Q), sort(Q,T), append(T,N,W),
% findall((R), (knowntarget(R,_), perturbs(R,_,_,_,_)), H), sort(H,J), subtract(J,W,G),
% select(Y,G,O),(findall((Y,V), (ykinasecompcheckTest(Y,V)), D), sort(D,X)).
%
% findall(A,(yeastkinase(A), doesSilofKworkprotlvl3(A)),L),sort(L,N), findall(B, (yeastkinase(B), doesSilofKwork3(B)), Q), sort(Q,T), append(T,N,W),
%
% % findall(A, doesSilofKwork(A), L), sort(L,N),  findall(B, doesSilofKworkProtlvl(B), Q), sort(Q,T), append(T,N,W).
%
%
%
% "BUD32","CMK1","DUN1","ELM1","HAL5","IKS1","IME2","KIN4","KIN82","KSP1","MEK1","PKP2","PRR2","SAT4","SCH9","SKM1","SKS1","SSK22","TDA1","TOS3","YCK1",""YGK3""
%
%
%
%
%
%



















ykinasecompcheck(DelK1, K2):-
        perturbs(DelK1,_,Tprot1,_,_),
        sharedKinasetarget(DelK1,K2,Tprot1),
        knowntarget(K2, Pst1, Tprot1),
        perturbs(DelK2,Pst1,Tprot1,up,_),
        (DelK2 \= K2, DelK2 \= DelK1).


ykinasecompcheckb(DelK1, K2):-
                perturbs(DelK1,_,Tprot1,_,_),
                sharedKinasetarget(DelK1,K2,Tprot1),
                knowntarget(K2, Pst1),
                perturbs(DelK2,Pst1,Tprot1,up,_),
                (DelK2 \= K2, DelK2 \= DelK1).

%


ykinasecompcheck3a(DelK1, K2):-
                perturbs(DelK1,_,Tprot1,_,_),
                sharedKinasetarget(DelK1,K2,Tprot1),
                direct_target(K2, Pst1, Tprot1),
                perturbs(DelK2,Pst1,Tprot1,up,_),
                (DelK2 \= K2, DelK2 \= DelK1).










ykinasecompcheck2(DelK1, K2):-
                perturbs(DelK1,_,Tprot1,_,_),
                sharedtarget(DelK1, K2, Pst1),
                perturbs(DelK1,Pst1,Tprot1,up,_),
                (DelK2 \= K2, DelK2 \= DelK1).


sharedtarget(Kin1,Kin2,Pst):-
          (knowntarget(Kin1,Pst),
          knowntarget(Kin2,Pst),
          Kin1 \= Kin2).




ykinasecompcheck3b(K, X, M):-
                perturbs(K, Pst, Tprot, down,_),
                findall(X,
                (sharedtarget(X,K,Pst),
                X \= K,
                X \= Tprot,
                perturbs(K,Pst,Tprot,up,_)), L),
                append(L,[K],M),
                (length(M,Q), Q \= 1).




%%%% 2nd Iteration Unique target check at Protein lvl knowntarget from K-P-S triple ()
doesSilofKwork2a(DelK) :-
                          knowntarget(DelK,Pst,Tprot),
                          \+sharedKinasetargetB(DelK,_K2,Tprot),
                          perturbs(DelK,Pst,_,down,_).




sharedKinasetargetB(K1,K2,Tprot):-
              knowntarget(K1,Pst, Tprot),
              knowntarget(K2,Pst, Tprot),
              K1 \= K2.


%%%% 2nd Iteration Unique target check at Protein lvl knowntarget from K-Protein pair (can use KIDBl/s and Kinome sources)
doesSilofKwork2b(DelK) :-
                          knowntarget(DelK,Pst,Tprot),
                          \+sharedKinasetarget(DelK,_K2,Tprot),
                          perturbs(DelK,Pst,_,down,_).



%%%%% 3rd iteration majorit check

doesSilofKwork2up(DelK) :-
        knowntarget(DelK,Pst),
        \+sharedtargetB(DelK,_K2,Pst),
        perturbs(DelK,Pst,_,up,_).






pdtK(Kinase,Pst,Tprot):-
  findall(Kinase,perturbs(Kinase,_,_,_,_),List),
  select(Kinase,List,_),
  perturbs(Kinase, Pst, Tprot, down,_),
  Tprot \= Kinase.

pdtP(Phosphatase,Pst,Tprot):-
  findall(Phosphatase,perturbs(Phosphatase,_,_,_,_),List),
  select(Phosphatase,List,_),
  perturbs(Phosphatase, Pst, Tprot, up,_),
  Tprot \= Phosphatase.
