import pandas as pd

import sqlite3

conn = sqlite3.connect("chemphopro.db")



df = pd.read_sql_query('select * from KS_relationship where source = "UniProt";', conn)

df = df['kinase'].unique()

df =  df.tolist()


df1 = pd.read_csv("MCF7_PROTEIN_LOCATIONS_SCBC.csv", usecols = ["Protein", "Neighborhood.Class"])

df2 = df1.loc[df1['Protein'].isin(df)]

found = df2["Protein"]

KLISTDIF = set(df)- set(found)



with open("List of missing Kinases.pl", "w") as file:
	for x in KLISTDIF:
		y = "KinaseMissing(" + "'" + x + "'" + ")" + "."
		file.write(y + "\n")