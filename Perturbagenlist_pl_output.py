import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Perturbagen;', conn)



with open("Perturbagen.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "perturbagen('{}').".format(row["name"])
		file.write(var1 + "\n")