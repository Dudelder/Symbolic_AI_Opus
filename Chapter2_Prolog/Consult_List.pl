set_prolog_flag(answer_write_options,[max_depth(0)]).



consult('MCF7_KINASE_LOCATIONS_test.pl').

consult('MCF7_PROTEIN_LOCATIONS.pl').

consult('MCF7_proteinexpression.pl').

consult('PonProtein_From_MCF7_obs_table.pl').

consult('KS_relationshipUNIPROT.pl').

consult('Perturbagen_List.pl').

consult('PK_Relationship with Source.pl').

consult('RuleConsultTest.pl').


%%%% all observations with log fold change < -1 and up and X0 removed

consult('ObservationsMCF7g.pl').
