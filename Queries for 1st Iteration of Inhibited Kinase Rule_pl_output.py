import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Perturbagen;', conn)



with open("Queries for 1st Iteration of Inhibited Kinase rule.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "allKinasesInhibitedByXinC(Kinase, '{}', 'MCF7', KinasesList).".format(row["name"])
		file.write(var1 + "\n")