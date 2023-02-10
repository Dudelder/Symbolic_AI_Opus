import pandas as pd

import sqlite3

# conn = sqlite3.connect("chemphopro.db")
#
# df = pd.read_sql_query('select * from KS_relationship where source = "UniProt";', conn)
#
# # df = pd.read_sql_query('select * from PK_relationship where kinase in ("MTOR","AKT1", "EGFR", "ERBB2", "MAP2K1", "MAPK3", "PDPK1", "RAF1", "RPS6KA1")', conn)
#
#
#
# df = df['kinase'].unique()
#
# df =  df.tolist()

df = pd.read_csv("omnipath_knowntarget_all.csv", usecols= ["KPa", "KPa_class"])
df = df.loc[df['KPa_class'] == "K"]


df = df['KPa'].unique()
df =  df.tolist()

print(df)



# df = df.loc[df['KPa_clas'] == K]





df3 = pd.read_csv("ctamdb_data_dpp_meansig_nans_MCF7.csv", usecols = ["pst", "perturbagen","fc","pval_eb","pval_meansig"])

# df = df[df["pval_eb"] <= 0.05]
searchfor = ['\\(S', '\\(T', '\\(Y']
df3 = df3[df3["pst"].str.contains('|'.join(searchfor))]
df3["tprotein"] = df3["pst"].str.replace(r'\(.*$', "", regex = True)


df2 = df3.loc[df3['tprotein'].isin(df)]





print(df2)




with open("queries_for_models_rule1.pl", "w") as file:
	for index, row in df2.iterrows():
		var1 = "query(doesDinhibitKinC(perturbation('{}'),kinase('{}'),cell_line(c1))).".format(row["perturbagen"], row["tprotein"])
		file.write(var1 + "\n")


# query(doesDinhibitKinC2(perturbation(D),kinase('AKT1'),cell_line(c1))).



lines = open('queries_for_models_rule1.pl', 'r').readlines()
lines_set = set(lines)
lines_sorted = sorted(lines_set)

out  = open('queries_for_models_rule1.pl', 'w')
for line in lines_sorted:
    out.write(line)
