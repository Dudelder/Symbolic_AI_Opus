import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")
df = pd.read_sql_query("select * from Protein where kinase_name IS NOT NULL and expressed_in IS NOT NULL;", conn)


with open("Cell_line_proteinexpression.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "expressedin('{}', '{}').".format(row["kinase_name"],row["expressed_in"])
		file.write(var1 + "\n")