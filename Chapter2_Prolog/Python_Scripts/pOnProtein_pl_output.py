import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Substrate;', conn)


with open("P_on_Protein_List.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "ponProtein('{}', '{}').".format(row["substrate_id"], row["uniprot_name"])
		file.write(var1 + "\n")