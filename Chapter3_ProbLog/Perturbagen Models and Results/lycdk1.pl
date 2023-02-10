0.001317582882923::perturbs(perturbation('LY2835219'),phosphosite('PIK3C2A(S259)'),onprotein('PIK3C2A'),occupancy(up),direction(0.584081809191229)).
0.78478852::plocation(protein('PIK3C2A'),subclocation('Cytosol'),cell_line(c1)).
0.986829897::klocation(kinase('CDK1'),subclocation('Cytosol'),cell_line(c1)).
colocalisation(protein('PIK3C2A'),kinase('CDK1')) :- plocation(protein('PIK3C2A'),subclocation('Cytosol'),cell_line(c1)), klocation(kinase('CDK1'),subclocation('Cytosol'),cell_line(c1)).
0.012632876905047::perturbs(perturbation('LY2835219'),phosphosite('USP24(S2047)'),onprotein('USP24'),occupancy(up),direction(0.548329724675582)).
0.993191563::plocation(protein('USP24'),subclocation('Cytosol'),cell_line(c1)).
colocalisation(protein('USP24'),kinase('CDK1')) :- plocation(protein('USP24'),subclocation('Cytosol'),cell_line(c1)), klocation(kinase('CDK1'),subclocation('Cytosol'),cell_line(c1)).
doesDactivateKinC(perturbation('LY2835219'),kinase('CDK1'),cell_line(c1)) :- perturbs(perturbation('LY2835219'),phosphosite('PIK3C2A(S259)'),onprotein('PIK3C2A'),occupancy(up),direction(0.584081809191229)), colocalisation(protein('PIK3C2A'),kinase('CDK1')).
doesDactivateKinC(perturbation('LY2835219'),kinase('CDK1'),cell_line(c1)) :- perturbs(perturbation('LY2835219'),phosphosite('USP24(S2047)'),onprotein('USP24'),occupancy(up),direction(0.548329724675582)), colocalisation(protein('USP24'),kinase('CDK1')).
query(doesDactivateKinC(perturbation('LY2835219'),kinase('CDK1'),cell_line(c1))).
