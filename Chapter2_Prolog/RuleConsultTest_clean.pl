
%%% Inhibited Kinase rule %%%%
 inhibitedKinase(Kinase, Perturbagen,Target, Cell_Line) :-
 expressedin(Kinase, Cell_Line),
 (perturbs(Perturbagen, Target, down)).



%%% PDT rule with UNIPROT cross reference of target %%%
pDTCrossRef(Kinase, PDT, Perturbagen, Cell_Line) :-
perturbs(Perturbagen, PDT, down),
expressedin(Kinase, Cell_Line),
knownsubstrate(PDT, Kinase).


 %%% Unexpected Result Rule %%%

unexpected(PPT, Perturbagen, Kinase, Cell_Line, Source) :-
knowninhibitor(Perturbagen, Kinase, Source),
expressedin(Kinase, Cell_Line),
perturbs(Perturbagen, PPT, up).


%%% List created with inhibitedKInase rule identified "targets" %%%%

%% listinhibitedKinase(Kinase, Perturbagen, Cell_Line, PDTListS) :-
%% findall(TestTarget,
%%   (perturbs(Perturbagen, TestTarget, down),
%%   expressedin(Kinase, Cell_Line)),
%%   TestList), append([], TestList, PDTList),
%%   sort(PDTList, PDTListS).







%%% Inhibited Kinase rule tests for pOnProtein issue %%%

 targetsofAafterXtreatmentinC(Kinase, Perturbagen,Target, Cell_Line) :-
 expressedin(Kinase, Cell_Line),
 perturbs(Perturbagen, Target, down),
 ponProtein(Target, Protein),
 (plocation(Protein, Location1, Cell_Line) , klocation(Kinase, Location2, Cell_Line), Location1 = Location2).


checkedtargetsofAafterXtreatmentinC(Kinase, Perturbagen,Target, Cell_Line) :-
 expressedin(Kinase, Cell_Line),
 knownsubstrate(Target, Kinase),
 perturbs(Perturbagen, Target, down),
 ponProtein(Target, Protein),
 (plocation(Protein, Location1, Cell_Line) , klocation(Kinase, Location2, Cell_Line), Location1 = Location2).


%------------------------------------------------ Zero Iteration of "Inhibited Rule" -------------------------------------------------------%


%%%% "Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?"
%%%%
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein


doesXinhibitAinCzero(Perturbagen, Kinase, Cell_Line) :-
expressedin(Kinase, Cell_Line),
knownsubstrate(Target, Kinase),
perturbs(Perturbagen, Target, down).





%----------------------------------------------- Zero "known" Iteration of "Inhibited Rule" --------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Once above is confirmed, cross check with "knowinhibitor" list of Facts, with corresponding "Source"


doesXinhibitAinCzero_known(Perturbagen, Kinase, Cell_Line, Source) :-
doesXinhibitAinCzero(Perturbagen, Kinase, Cell_Line),
knowninhibitor(Perturbagen, Kinase, Source).

%-----------------------------------------------------------------------------------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------------------------------------%



%------------------------------------------------ 1st Iteration of "Inhibited Rule" -------------------------------------------------------%


%%%% "Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?"
%%%%
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated* with the Kinase on a subcellular level



doesXinhibitAinC(Perturbagen, Kinase, Cell_Line) :-
 expressedin(Kinase, Cell_Line),
 perturbs(Perturbagen, Target, down),
 knownsubstrate(Target, Kinase),
 ponProtein(Target, Protein),
 colocalisation(Protein, Kinase).




%------------------------------------------------ *Protein and Kinase coolcalisation rule -------------------------------------------------------%


%%%% The following rule which is invoked by the 1st Iteration of the "Inhibited Rule" states that:
%%%%
%%%% "Are a given Protein and  given Kinase subcellylarly collocated?"
%%%%
%%%% True if and only if 1) Location argument of predicates plocation and klocation, refering to subcellular location of a protein and a kinase,
%%%%                        respectively,  are identical




colocalisation(Protein, Kinase) :-
plocation(Protein, Location, Cell_Line),
klocation(Kinase, Location, Cell_Line).


%-----------------------------------------------------------------------------------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------------------------------------%






%----------------------------------------------- 1st "known" Iteration of "Inhibited Rule" --------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Once above is confirmed, cross check with "knowinhibitor" list of Facts, with corresponding "Source"


doesXinhibitAinC_known(Perturbagen, Kinase, Cell_Line, Source) :-
doesXinhibitAinC(Perturbagen, Kinase, Cell_Line),
knowninhibitor(Perturbagen, Kinase, Source).

%-----------------------------------------------------------------------------------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------------------------------------%





%------------------------------------------------ 2nd Iteration of "Inhibited Rule" -------------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Given target is unique* to the Kinase
%%%%


doesXinhibitAinC2(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ponProtein(Target, Protein),
colocalisation(Protein,Kinase1),
ucheck1T(Target, Kinase1).



%------------------------------------------------ *1st Iteration of Target (phosphosite) uniqueness rule -------------------------------------------%


%%%% The following rule which is invoked by the 2nd Iteration of the "Inhibited Rule" states that:
%%%% Is a given Target (phosphosite) unique to a given Kinase?
%%%% True if and only if 1) There exists a list (TargetList) which is populated by elements (Target(s)), which, in turn satisfy the "goal" of
%%%%                        being a known substrate of a given Kinase
%%%%                     2) Said list is identical to list containing ONLY the element Target
%%%%
%%%%
%%%%        Note: AKT1(Y176) should be unique to TNK2
%%%%              AKT1(T308) not unique To check whether ucheck rule works.

%%%% SINGLETON ERROR %%%%

%%%% Redundant old rule %%%%%
/*ucheck1(Target, Kinase1) :-
findall(Target, (knownsubstrate(Target, Kinase1), knownsubstrate(Target, Kinase2)), TargetList),
(TargetList == [Target]).
*/

%%%% SINGLETON ERROR %%%%


ucheck1T(Target, Kinase1) :-
\+(shared_kinase(Target, Kinase1, Kinase2)).

shared_kinase(Target, Kinase1, Kinase2) :-
(knownsubstrate(Target, Kinase1), knownsubstrate(Target, Kinase2), Kinase1 \= Kinase2).






%-----------------------------------------------------------------------------------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------------------------------------%


%----------------------------------------------- 2nd "known" Iteration of "Inhibited Rule" --------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Given target is unique* to the Kinase
%%%%                     7) Once above is confirmed, cross check with "knowinhibitor" list of Facts, with corresponding "Source"


doesXinhibitAinC2_known(Perturbagen, Kinase1, Cell_Line, Source) :-
doesXinhibitAinC2(Perturbagen, Kinase1, Cell_Line),
knowninhibitor(Perturbagen, Kinase1, Source).

%-----------------------------------------------------------------------------------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------------------------------------%



%---------------------------------------------------- 3rd Iteration of "Inhibited Rule" -------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase1 is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase1 (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said Protein is colocated with the Kinase1 on a subcellular level
%%%%                     6) Given target is unique to the Kinase1 (ref bellow for 2nd Iteration of uniquness rule)
%%%%
%%%%
%%%%                      Try this with an elseif else if statement  ->/2 http://www.swi-prolog.org/pldoc/doc_for?object=(-%3E)/2
%%%%
%-----------------------------------------------------------------------------------------------------------------------------------%

doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ponProtein(Target, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target, Kinase1).



%------------------------------------------------ 2nd Iteration of Target (phosphosite) uniqueness rule -------------------------------------------%


%%%% The following rule which is invoked by the 2nd Iteration of the "Inhibited Rule" states that:
%%%% Is a given Target (phosphosite) unique to a given Kinase?
%%%% True if and only if 1) There exists a list (TargetList) which is populated by elements (Target(s)), which, in turn satisfy the "goal" of
%%%%                        being a known substrate of a given Kinase
%%%%                     2) Said list is identical to list containing ONLY the element Target
%%%%                     3) If true then GOAL succedds ELSE for negation of colocation
%%%%
%%%%
%%%%        Note: AKT1(Y176) should be unique to TNK2
%%%%              AKT1(T308) not unique To check whether ucheck rule works.


%%%% SINGLETON ERROR %%%%

ucheck2T(Target, Kinase1) :-
knownsubstrate(Target,Kinase1),
\+(shared_kinase2(Target, Kinase1, Kinase2)).

shared_kinase2(Target, Kinase1, Kinase2) :-
(knownsubstrate(Target, Kinase1), knownsubstrate(Target, Kinase2), Kinase1 \= Kinase2),
colocalisation2(Kinase1, Kinase2).


colocalisation2(Kinase1, Kinase2) :-
klocation(Kinase1, Location1, Cell_Line),
klocation(Kinase2, Location1, Cell_Line).


%----------------------------------------------- 3rd "known" Iteration of "Inhibited Rule" --------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Given target is unique* to the Kinase
%%%%                     7) Once above is confirmed, cross check with "knowinhibitor" list of Facts, with corresponding "Source"


doesXinhibitAinC3_known(Perturbagen, Kinase1, Cell_Line, Source) :-
doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line),
knowninhibitor(Perturbagen, Kinase1, Source).


%---------------------------------------------------- 4th Iteration of "Inhibited Rule" -------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase1 is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase1 (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said Protein is colocated with the Kinase1 on a subcellular level
%%%%                     6) Given target is unique to the Kinase1 (ref above for 2nd Iteration of uniquness rule)
%%%%
%%%%
%%%%                      Try this with an elseif else if statement  ->/2 http://www.swi-prolog.org/pldoc/doc_for?object=(-%3E)/2
%%%%
%-----------------------------------------------------------------------------------------------------------------------------------%



doesXinhibitAinC3TEST(Perturbagen, Kinase1, Cell_Line, Target1) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target1, down),
knownsubstrate(Target1, Kinase1),
ponProtein(Target1, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target1, Kinase1).


doesXactivateAinC3(Perturbagen, Kinase1, Cell_Line, Target2) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target2, up),
knownsubstrate(Target2, Kinase1),
ponProtein(Target2, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target2,Kinase1).


majoritycheck(Perturbagen, Kinase1) :-
((findall(Target1, (doesXinhibitAinC3TEST(Perturbagen, Kinase1, Cell_Line, Target1)), TargetList1),
findall(Target2, (doesXactivateAinC3(Perturbagen, Kinase1, Cell_Line, Target2)), TargetList2)),
length(TargetList1, Length1), length(TargetList2, Length2)),
compare( > , Length1 , Length2).



doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target1, down),
knownsubstrate(Target1, Kinase1),
ponProtein(Target1, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target1, Kinase1),
majoritycheck(Perturbagen, Kinase1).

%----------------------------------------------- 4th "known" Iteration of "Inhibited Rule" --------------------------------------------------%
%%%%
%%%% Does a given Compound (X), perturb a given Kinase (A) when treating cell line C?
%%%% True if and only if 1) Kinase is expressed in the cell line.
%%%%                     2) There exists at least 1 target (phosphosite) that is significantly "down" after treatment with X
%%%%                     3) Said target is a known substrate of Kinase (A)
%%%%                     4) Said target exists on a Protein
%%%%                     5) Said protein is colocated with the Kinase on a subcellular level
%%%%                     6) Given target is unique* to the Kinase
%%%%                     7) Once above is confirmed, cross check with "knowinhibitor" list of Facts, with corresponding "Source"


doesXinhibitAinC4_known(Perturbagen, Kinase1, Cell_Line, Source) :-
doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line),
knowninhibitor(Perturbagen, Kinase1, Source).





%%%%%%%%%%%% RECURSION %%%%%%%%%%%%%%%

doesXinhibitAinC4TEST(Perturbagen, Kinase1, Cell_Line, Target1) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target1, down),
knownsubstrate(Target1, Kinase1),
ponProtein(Target1, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target1, Kinase1),
majoritycheck(Perturbagen,Kinase1).


doesXactivateAinC4(Perturbagen, Kinase1, Cell_Line, Target2) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target2, up),
knownsubstrate(Target2, Kinase1),
ponProtein(Target2, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target2,Kinase1),
majoritycheck2(Perturbagen, Kinase1).


majoritycheck2(Perturbagen, Kinase1) :-
((findall(Target1, (doesXinhibitAinC4TEST(Perturbagen, Kinase1, Cell_Line, Target1)), TargetList1),
findall(Target2, (doesXactivateAinC4(Perturbagen, Kinase1, Cell_Line, Target2)), TargetList2)),
length(TargetList1, Length1), length(TargetList2, Length2)),
compare( > , Length1 , Length2).

doesXinhibitAinC5(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target1, down),
knownsubstrate(Target1, Kinase1),
ponProtein(Target1, Protein),
colocalisation(Protein, Kinase1),
ucheck2T(Target1, Kinase1),
majoritycheck2(Perturbagen, Kinase1).





%------------------------------------------------ SETOF and FINDALL iterations of above rules  -------------------------------------------%


allKinasesInhibitedByXinCzero(Kinase, Perturbagen, Cell_Line, KinasesList) :-
findall(Kinase, (doesXinhibitAinCzero(Perturbagen, Kinase, Cell_Line)), KinasesList).


allKinasesInhibitedByXinC(Kinase, Perturbagen, Cell_Line, KinasesList) :-
findall(Kinase, (doesXinhibitAinC(Perturbagen, Kinase, Cell_Line)), KinasesList).


allKinasesInhibitedByXinC2(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
findall(Kinase1, (doesXinhibitAinC2(Perturbagen, Kinase1, Cell_Line)), KinasesList).


allKinasesInhibitedByXinC3(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
findall(Kinase1, (doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line)), KinasesList).

allKinasesInhibitedByXinC4(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
findall(Kinase1, (doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line)), KinasesList).



%%%% Setof removes duplicates from above lists %%%%

sortedallKinasesInhibitedByXinCzero(Kinase, Perturbagen, Cell_Line, KinasesList) :-
setof((Perturbagen,Kinase), (doesXinhibitAinCzero(Perturbagen, Kinase, Cell_Line)), KinasesList).


sortedallKinasesInhibitedByXinC(Kinase, Perturbagen, Cell_Line, KinasesList) :-
setof((Perturbagen,Kinase), (doesXinhibitAinC(Perturbagen, Kinase, Cell_Line)), KinasesList).


sortedallKinasesInhibitedByXinC2(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
setof((Perturbagen, Kinase1), (doesXinhibitAinC2(Perturbagen, Kinase1, Cell_Line)), KinasesList).


sortedallKinasesInhibitedByXinC3(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
setof((Perturbagen, Kinase1), (doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line)), KinasesList).

sortedallKinasesInhibitedByXinC4(Kinase1, Perturbagen, Cell_Line, KinasesList) :-
setof((Perturbagen, Kinase1), (doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line)), KinasesList).



%%%% Returns lists of Perturbagens based on itterations of "INHIBITED RULE"

allPerturbagensInhibitingKinCzero(Perturbagen, Kinase, Cell_Line, PerturbagenList) :-
setof((Kinase,Perturbagen), (doesXinhibitAinCzero(Perturbagen, Kinase, Cell_Line)), PerturbagenList).

allPerturbagensInhibitingKinC(Perturbagen, Kinase, Cell_Line, PerturbagenList) :-
setof((Kinase,Perturbagen), (doesXinhibitAinC(Perturbagen, Kinase, Cell_Line)), PerturbagenList).

allPerturbagensInhibitingKinC2(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC2(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).

allPerturbagensInhibitingKinC3(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC3(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).

allPerturbagensInhibitingKinC4(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC4(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).


%%%% Returns lists of Kinases perturbed by compound and crosschecks with known inhibitory compound
allKinasesInhibitedByXinCzero_known(Kinase, Perturbagen, Cell_Line, KnownList) :-
setof((Kinase, Perturbagen, Source), (doesXinhibitAinCzero_known(Perturbagen,Kinase, Cell_Line, Source)), KnownList).

allKinasesInhibitedByXinC_known(Kinase, Perturbagen, Cell_Line, KnownList) :-
setof((Kinase, Perturbagen, Source), (doesXinhibitAinC_known(Perturbagen, Kinase, Cell_Line, Source)), KnownList).


allKinasesInhibitedByXinC2_known(Kinase1, Perturbagen, Cell_Line, KnownList) :-
setof((Kinase1, Perturbagen, Source), (doesXinhibitAinC2_known(Perturbagen, Kinase1, Cell_Line,Source)), KnownList).

allKinasesInhibitedByXinC3_known(Kinase1, Perturbagen, Cell_Line, KnownList) :-
setof((Kinase1, Perturbagen, Source), (doesXinhibitAinC3_known(Perturbagen, Kinase1, Cell_Line,Source)), KnownList).

allKinasesInhibitedByXinC4_known(Kinase1, Perturbagen, Cell_Line, KnownList) :-
setof((Kinase1, Perturbagen, Source), (doesXinhibitAinC4_known(Perturbagen, Kinase1, Cell_Line,Source)), KnownList).

%%%% COUNT %%%%%

countoflistzero(Perturbagen, Kinase, Cell_Line, PerturbagenList, Length) :-
allPerturbagensInhibitingKinCzero(Perturbagen, Kinase, Cell_Line, PerturbagenList),
length(PerturbagenList, Length).

countoflistzeroknown(Perturbagen, Kinase, Cell_Line, KnownList, Length) :-
allKinasesInhibitedByXinCzero_known(Kinase, Perturbagen, Cell_Line, KnownList),
length(KnownList, Length).



countoflist1(Perturbagen, Kinase, Cell_Line, PerturbagenList, Length) :-
allPerturbagensInhibitingKinC(Perturbagen, Kinase, Cell_Line, PerturbagenList),
length(PerturbagenList, Length).

countoflist1known(Perturbagen, Kinase, Cell_Line, KnownList, Length) :-
allKinasesInhibitedByXinC_known(Kinase, Perturbagen, Cell_Line, KnownList),
length(KnownList, Length).



countoflist2(Perturbagen, Kinase1, Cell_Line, PerturbagenList, Length) :-
allPerturbagensInhibitingKinC2(Perturbagen, Kinase1, Cell_Line, PerturbagenList),
length(PerturbagenList, Length).

countoflist2known(Perturbagen, Kinase1, Cell_Line, KnownList, Length) :-
allKinasesInhibitedByXinC2_known(Kinase1, Perturbagen, Cell_Line, KnownList),
length(KnownList, Length).


countoflist3(Perturbagen, Kinase1, Cell_Line, PerturbagenList, Length) :-
allPerturbagensInhibitingKinC3(Perturbagen, Kinase1, Cell_Line, PerturbagenList),
length(PerturbagenList, Length).

countoflist3known(Perturbagen, Kinase1, Cell_Line, KnownList, Length) :-
allKinasesInhibitedByXinC3_known(Kinase1, Perturbagen, Cell_Line, KnownList),
length(KnownList, Length).

countoflist4(Perturbagen, Kinase1, Cell_Line, PerturbagenList, Length) :-
allPerturbagensInhibitingKinC4(Perturbagen, Kinase1, Cell_Line, PerturbagenList),
length(PerturbagenList, Length).




%%%%%%%%%%%%% Combinations of subgoals %%%%%%%%

%%%% Colocalisation + Majority %%%%%

doesXinhibitAinC_COL_M(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ponProtein(Target, Protein),
colocalisation(Protein, Kinase1),
majoritycheck(Perturbagen,Kinase1).


allPerturbagensInhibitingKinC_COL_M(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC_COL_M(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).

%%%% Only Ucheck1 %%%%

doesXinhibitAinC_U1(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ucheck1T(Target, Kinase1).

allPerturbagensInhibitingKinC_U1(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC_U1(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).


%%%% U1 + M %%%%

doesXinhibitAinC_U1_M(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ucheck1T(Target, Kinase1),
majoritycheck(Perturbagen,Kinase1).

allPerturbagensInhibitingKinC_U1_M(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC_U1_M(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).



%%%% Only Ucheck2 %%%%

doesXinhibitAinC_U2(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ucheck2T(Target, Kinase1).

allPerturbagensInhibitingKinC_U2(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC_U2(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).

%%%% U2 + M %%%%

doesXinhibitAinC_U2_M(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target, down),
knownsubstrate(Target, Kinase1),
ucheck2T(Target, Kinase1),
majoritycheck(Perturbagen,Kinase1).

allPerturbagensInhibitingKinC_U2_M(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC_U2_M(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).


%%%% 4th iter (b) U1 instead of U2 %%%

doesXinhibitAinC4_U1(Perturbagen, Kinase1, Cell_Line) :-
expressedin(Kinase1, Cell_Line),
perturbs(Perturbagen, Target1, down),
knownsubstrate(Target1, Kinase1),
ponProtein(Target1, Protein),
colocalisation(Protein, Kinase1),
ucheck1T(Target1, Kinase1),
majoritycheck(Perturbagen, Kinase1).


allPerturbagensInhibitingKinC4_U1(Perturbagen, Kinase1, Cell_Line, PerturbagenList) :-
setof((Kinase1,Perturbagen), (doesXinhibitAinC4_U1(Perturbagen, Kinase1, Cell_Line)), PerturbagenList).
