import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from KS_relationship where source = "PDT" and cell_line = "MCF-7";', conn)
df = df[df["confidence"] >= 0.5]

with open("MCF7_pDTs_05_conf.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "pDT('{}', '{}').".format(row["substrate"],row["kinase"])
		file.write(var1 + "\n")