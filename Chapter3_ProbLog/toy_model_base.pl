%%% Yuml representation http://yuml.me/preview/7533d25f

%%% Conrad Input
% % Experimental observations with beliefs:
% 0.6::down(s1).
% 0.3::down(s2).
% 0.1::down(s3).
%
% % Background information:
% phosphosite(s1).
% phosphosite(s2).
% phosphosite(s3).
%
% phosphorylates(k1,s1).
% phosphorylates(k1,s2).
% phosphorylates(k1,s3).
%
% % Rule to aggregate observations for given kinase:
% inhibited(K) :- phosphorylates(K,S), phosphosite(S), down(S).
%
% % Queries:
% query(inhibited(k1)).
%
%
%

%%%%%%%%%%%% Basic PROBLOG




% %%%% CONSISE FACTS RULES VERSION
% 1.0 :: kinase(k2).
% 1.0 :: kinase(k1).
% 1.0 :: kinase(k3).
%
% 1.0 :: phosphosite(s1).
% 1.0 :: phosphosite(s2).
% 1.0 :: phosphosite(s3).
%
% perturbation(delta1).
% perturbation(delta2).
% %% Known Target = The known target of k1 is s1
% 0.8 :: knowntarget(k1,s1).
% 0.7 :: knowntarget(k1,s2).
% 0.6 :: knowntarget(k2,s2).
% 0.3 :: knowntarget(k3,s3).
%
% %%% Known to affect activity of
% knowneffect(delta1,k1,inhibiton).
% knowneffect(delta1,k2,excitation).
% knowneffect(delta2,k2,inhibition).
%
%
%
% %%% δ = delta = perturbation. Observation/Experimental fact
% 0.5::perturbs(delta1,s3,down).
% 0.4::perturbs(delta2,s2,down).
% 0.3::perturbs(delta1,s1,down).
% %%% s(phosphosite) is on k(kinase) or p(protein
% ison(s1,k3).
% ison(s2,k3).
% ison(s3,p1).
% %
% %
% % %%%% 1st Iteration with relevant queries
% % doesDinhibitKinC(Perturbation, Kinase, Cell_Line) :-
% %   knowntarget(Kinase, Target),
% %   perturbs(Perturbagen, Target, Direction).
% % %
% %
% % query(doesDinhibitKinC(delta1,k3,c1)).
% % query(doesDinhibitKinC(delta1,k2,c1)).
% % query(doesDinhibitKinC(delta1,k3,c1)).
% %
% 2nd Iteration +colocalisation with relevant queries and additional Facts
%
%
% % colocalisation(k1,k2)
% % colocalisation(k2,k3)
% % colocalisation(k3,p1).
% %
% doesXinhibitAinC2(Perturbagen, Kinase, Cell_Line) :-
%  perturbs(Perturbagen, Target, down),
%  knowntarget(Kinase, Target),
%  ison(Target, Protein),
%  colocalisation(Protein, Kinase).
%
%
% 0.8 :: plocation(p1, loc1, c1).
% 0.4 :: klocation(k1, loc1, c1).
% 0.5 :: klocation(k2, loc1, c1).
% 0.6 :: klocation(k3, loc1, c1).
%
%
% %
% %
%  colocalisation(Protein, Kinase) :-
%   plocation(Protein, Location, Cell_Line),
%   klocation(Kinase, Location, Cell_Line).
%
% query(doesXinhibitAinC2(delta1,k1,c1)).
% query(doesXinhibitAinC2(delta1,k2,c1)).
% query(doesXinhibitAinC2(delta1,k3,c1)).
%
%
% query(doesXinhibitAinC2(delta2,k1,c1)).
% query(doesXinhibitAinC2(delta2,k2,c1)).
% query(doesXinhibitAinC2(delta2,k3,c1)).
% % %
% % %
% % %
%
% % %%% 3rd Iteration above + uniquness test
% %
% doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line) :-
%  perturbs(Perturbagen, Target, down),
%  knowntarget(Kinase1, Target),
%  ison(Target, Protein),
%  colocalisation(Protein, Kinase1),
%  uniqunessTest1(Target, Kinase1).
% %
% %
% %
% %
% %
% %
% uniqunessTest1(Target, Kinase1) :-
% \+(shared_kinase(Target, Kinase1, Kinase2)).
%
% shared_kinase(Target, Kinase1, Kinase2) :-
% (knowntarget(Kinase1, Target), knowntarget(Kinase2, Target), Kinase1 \= Kinase2).
%
% query(uniqunessTest1(s3,k1)).
% query(uniqunessTest1(s3,k2)).
% query(uniqunessTest1(s3,k3)).
%
%
% query(doesXinhibitAinC3(delta1,k1,c1)).
% query(doesXinhibitAinC3(delta1,k2,c1)).
% query(doesXinhibitAinC3(delta1,k3,c1)).
%
%
% query(doesXinhibitAinC3(delta2,k1,c1)).
% query(doesXinhibitAinC3(delta2,k2,c1)).
% query(doesXinhibitAinC3(delta2,k3,c1)).

%% VERBOSE FACTS AND RULES VERSION
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

% %% Known Target = The known target of k1 is s1
0.8 :: knowntarget(kinase(k1), phosphosite(s1)).
0.3 :: knowntarget(kinase(k1), phosphosite(s3)).
0.7 :: knowntarget(kinase(k1), phosphosite(s2)).
0.6 :: knowntarget(kinase(k2), phosphosite(s2)).
0.6 :: knowntarget(kinase(k3), phosphosite(s3)).
0.3 :: knowntarget(kinase(k3), phosphosite(s4)).
0.6 :: knowntarget(kinase(k3), phosphosite(s5)).

%%%%
% %%% Assigining knowntarget score to all Kinase Phosphosite combinations. P = AveKnowntargets/TotPhosphosites
% %% Pythoning PROBLOG too much
%
% % P :: knowntarget(kinase(K), phosphosite(S)) :-
% %   findall(Q,phosphosite(Q),L1) , length(L1,L1b),
% %   findall(R,kinase(R),L2), length(L2,L2b),
%
% P :: totalphosphosites(T1) :- findall(Q,phosphosite(Q),L1) , length(L1,T1), P is 1.0/T1.
% P :: totalkinases(T1) :- findall(Q,kinase(Q),L1) , length(L1,T1), P is 1.0/T1.
% %
% % P :: knowntarget(kinase(K),phosphosite(S)) :- kinase(K), phosphosite(S), averageSubstrates(kinase(K), N), totalphosphosites(phosphosite(S), T1), P is N/T1.
% %
% query(totalphosphosites(T1)).
% query(totalkinases(_)).
% % query(knowntarget(kinase(K),phosphosite(S))).
%
% query(findall((K,S), knowntarget(kinase(K),phosphosite(S)),L)).
%
%
% % Hardcoded knowntarget. Assumption is knowntarget facts have lvl of belief 1.0. All others
% have P = AveKnowntargets/TotPhosphosites
%
% knowntarget(kinase(k1), phosphosite(s1)).
% knowntarget(kinase(k1), phosphosite(s2)).
% % knowntarget(kinase(k1), phosphosite(s3)).
% % 0.6 :: knowntarget(kinase(k1), phosphosite(s4)).
% % 0.6 :: knowntarget(kinase(k1), phosphosite(s5)).
%
% % 0.6 :: knowntarget(kinase(k2),phosphosite(s1)).
% knowntarget(kinase(k2), phosphosite(s2)).
% % 0.6 :: knowntarget(kinase(k2), phosphosite(s3)).
% % 0.6 :: knowntarget(kinase(k2), phosphosite(s4)).
% % 0.6 :: knowntarget(kinase(k2), phosphosite(s5)).
%
%
% 0.6 ::knowntarget(kinase(k3), phosphosite(s1)).
% 0.6 ::knowntarget(kinase(k3), phosphosite(s2)).
% knowntarget(kinase(k3),phosphosite(s3)).
% 0.6 :: knowntarget(kinase(k3),phosphosite(s3)).
%
% knowntarget(kinase(k3),phosphosite(s4)).
% knowntarget(kinase(k3),phosphosite(s5)).
%


%%% Subcellular location of proteins and Kinases

0.8 :: plocation(protein(p1), subclocation(loc1), cell_line(c1)).
0.4 :: klocation(kinase(k1), subclocation(loc1), cell_line(c1)).
0.5 :: klocation(kinase(k2), subclocation(loc1), cell_line(c1)).
0.6 :: klocation(kinase(k3), subclocation(loc1), cell_line(c1)).
0.5 :: plocation(protein(p2), subclocation(loc1), cell_line(c1)).


%%% δ = delta = perturbation. Observation/Experimental fact
1.0 :: perturbs(perturbation(delta1),phosphosite(s3),occupancy(down)).
0.4 :: perturbs(perturbation(delta2),phosphosite(s2),occupancy(down)).
0.3 :: perturbs(perturbation(delta1),phosphosite(s1),occupancy(down)).
0.3 :: perturbs(perturbation(delta1),phosphosite(s4),occupancy(up)).
0.3 :: perturbs(perturbation(delta1),phosphosite(s5),occupancy(down)).


%%% s(phosphosite) is on k(kinase) or p(protein
ison(phosphosite(s1),kinase(k3)).
ison(phosphosite(s2),kinase(k3)).
ison(phosphosite(s3),protein(p1)).
ison(phosphosite(s4),protein(p2)).
ison(phosphosite(s5),protein(p2)).








%%% Known to affect activity of
perturbationeffect(perturbation(delta1),kinase(k1),effect(inhibiton)).
perturbationeffect(perturbation(delta1),kinase(k2),effect(excitation)).
perturbationeffect(perturbation(delta2),kinase(k2),effect(inhibiton)).





%%%% 1st Iteration with relevant queries
doesDinhibitKinC(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)).


 % query(doesDinhibitKinC(perturbation(D),kinase(K),cell_line(c1))).



% 2nd Iteration +colocalisation with relevant queries and additional Facts



doesDinhibitKinC2(perturbation(D), kinase(K), cell_line(C)) :-
  knowntarget(kinase(K), phosphosite(S)),
  perturbs(perturbation(D), phosphosite(S), occupancy(down)),
  (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
  colocalisation(protein(P),kinase(K)).


colocalisation(protein(P), kinase(K)) :-
  plocation(protein(P), subclocation(L), cell_line(c1)),
  klocation(kinase(K), subclocation(L), cell_line(c1)).


% query(doesDinhibitKinC2(perturbation(D),kinase(K),cell_line(c1))).


%%%% 3rd Iteration above + uniquness test

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



  %%% 4th Iteration = above + majority rule


  doesDactivateKinC(perturbation(D), kinase(K), cell_line(C)) :-
    knowntarget(kinase(K), phosphosite(S)),
    perturbs(perturbation(D), phosphosite(S), occupancy(up)),
    (ison(phosphosite(S),protein(P)) ; ison(phosphosite(S), kinase(K))),
    colocalisation(protein(P),kinase(K)).
    % uniquelytargeted(phosphosite(S), kinase(K)).


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
    % uniquelytargeted(phosphosite(S), kinase(K)),
    majoritycheck(perturbation(D), kinase(K)).





%
% query(doesDinhibitKinC(perturbation(delta1),kinase(K),cell_line(c1))).
%
query(doesDinhibitKinC2(perturbation(D),kinase(K),cell_line(c1))).
% query(doesDinhibitKinC2(perturbation(D),kinase(k3),cell_line(c1))).

%
% query(doesDinhibitKinC3(perturbation(D), kinase(K), cell_line(c1))).
% %
% query(doesDinhibitKinC4(perturbation(D),kinase(K),cell_line(c1))).
%
% query(doesDinhibitKinC(perturbation(delta1),kinase(kinase1),cell_line(c1))).
% query(doesDinhibitKinC(perturbation(delta1),kinase(kinase3),cell_line(c1))).


% query(doesDinhibitKinC4(perturbation(delta1),kinase(k3),cell_line(c1))).

% problog ground toy_model_base.pl --output ground_1st_2nd_iteration.txt --format dot -v

% problog sample toy_model_base.pl -n 100 --with-facts --with-probability --dont-propagate-evidence --estimate -v --progress
% problog sample toy_model_base.pl -n 50 --dont-propagate-evidence --progress --with-facts --with-probability



% query(doesDinhibitKinC3(perturbation(D), kinase(K), cell_line(c1))).



% query(uniquetarget(phosphosite(S))).

%
% query(doesDinhibitKinC2(perturbation(D),kinase(k3),cell_line(c1))).
% query(doesDinhibitKinC(perturbation(D),kinase(k3),cell_line(c1))).
% query(doesDinhibitKinC3(perturbation(D), kinase(k3), cell_line(c1))).
% %


%% new YUML diagram  http://yuml.me/preview/3d2b5500





%
%
% query(doesDinhibitKinC4(perturbation(D),kinase(K),cell_line(c1))).

% query(doesDinhibitKinC4(perturbation(delta1),kinase(k3),cell_line(c1))).

%
% majoritycheck(Perturbagen, Kinase1) :-
% ((findall(Target1, (doesXinhibitAinC3TEST(Perturbagen, Kinase1, Cell_Line, Target1)), TargetList1),
% findall(Target2, (doesXactivateAinC3(Perturbagen, Kinase1, Cell_Line, Target2)), TargetList2)),
% length(TargetList1, Length1), length(TargetList2, Length2)),
% compare( > , Length1 , Length2).
%
% query(majoritycheck(perturbation(delta1), kinase(k3))).
%
%
%
% doesXinhibitAinC3TEST(Perturbagen, Kinase1, Cell_Line, Target1) :-
% expressedin(Kinase1, Cell_Line),
% perturbs(Perturbagen, Target1, down),
% knownsubstrate(Target1, Kinase1),
% ponProtein(Target1, Protein),
% colocalisation(Protein, Kinase1),
% ucheck2T(Target1, Kinase1).
%
%
%
%
%
%
% doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line) :-
% expressedin(Kinase1, Cell_Line),
% perturbs(Perturbagen, Target1, down),
% knownsubstrate(Target1, Kinase1),
% ponProtein(Target1, Protein),
% colocalisation(Protein, Kinase1),
% ucheck2T(Target1, Kinase1),
% majoritycheck(Perturbagen, Kinase1).
%
%










% problog sample toy_model_base.pl -N 10 -v --with-probability --as-evidence --with-facts --progress --oneline












%%%%%%%%%%%%% Weights / Structure Learning PROBLOG

% %%% LEARNING FROM INTERPRETATIONS VERSION
%
% %% Base Facts
% kinase(k1).
% kinase(k2).
% kinase(k3).
%
% phosphosite(s1).
% phosphosite(s2).
% phosphosite(s3).
%
% perturbation(delta1).
% perturbation(delta2).
%
% protein(p1).
%
%
% %% Known Target = The known target of k1 is s1
% knowntarget(k1,s1).
% knowntarget(k1,s2).
% knowntarget(k2,s2).
% knowntarget(k3,s3).
%
% %%% Known to affect activity of
% knowneffect(delta1,k1,inhibiton).
% knowneffect(delta1,k2,excitation).
% knowneffect(delta2,k2,inhibition).
%
%
%
% %%% δ = delta = perturbation. Observation/Experimental fact
% 0.5::perturbs(delta1,s3,down,0.5).
% 0.4::perturbs(delta2,s2,down,0.5).
%
% %%% s(phosphosite) is on k(kinase) or p(protein
% ison(s1,k3).
% ison(s2,k3).
% ison(s3,p1).
%
%
% %%% parameters to be learned
% t(_) :: inhibits(delta1,Y) :- perturbs(delta1,X,down,_), knowntarget(Y,X).
% t(0.5) :: inhibits(delta1,k2) :- perturbs(delta1,X,down,_), knowntarget(k2,X).
% t(0.5) :: inhibits(delta1,k3) :- perturbs(delta1,X,down,_), knowntarget(k3,X).
% t(0.5) :: inhibits(delta2,k1) :- perturbs(delta2,X,down,_), knowntarget(k1,X).
% t(0.5) :: inhibits(delta2,k2) :- perturbs(delta2,X,down,_), knowntarget(k2,X).
% t(0.5) :: inhibits(delta2,k3) :- perturbs(delta2,X,down,_), knowntarget(k3,X).



% % DT PROBLOG VERSION
% ?::inhibits(delta1,K,Z) :- kinase(K).
%
%
% % Probabilistic facts
%
% 0.5 :: perturbs(delta1,s3,down).
% 0.4 :: perturbs(delta2,s2,down).
%
% % Background knowledge
% kinase(k1).
% kinase(k2).
% kinase(k3).
%
% phosphosite(s1).
% phosphosite(s2).
% phosphosite(s3).
%
% perturbation(delta1).
% perturbation(delta2).
%
% protein(p1).
%
% knowntarget(k1,s1).
% knowntarget(k1,s2).
% knowntarget(k2,s2).
% knowntarget(k3,s3).
%
% knowneffect(delta1,k1,inhibition).
%
% utility(knowneffect(X,Y,inhibition), -1).
%
% inhibits(X,Y,Z) :-
%     perturbs(X,Z,down),
%     knowntarget(Y,Z).
