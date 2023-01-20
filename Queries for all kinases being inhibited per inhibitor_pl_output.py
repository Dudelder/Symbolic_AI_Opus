import pandas as pd

import sqlite3

conn = sqlite3.connect("chemphopro.db")

df = pd.read_sql_query('select * from KS_relationship where source = "UniProt";', conn)

df = df['kinase'].unique()

df =  df.tolist()


df1 = pd.read_csv("MCF7_PROTEIN_LOCATIONS_SCBC.csv", usecols = ["Protein", "Neighborhood.Class"])

df2 = df1.loc[df1['Protein'].isin(df)]


with open("Queries for all kinases being inhibited per inhibitor.pl", "w") as file:
	for index, row in df2.iterrows():
		var1 = "allPerturbagensInhibitingKinC(Perturbagen, '{}', 'MCF7', PerturbagenList).".format(row["Protein"])
		file.write(var1 + "\n")