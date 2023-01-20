import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Substrate;', conn)


with open("Phosphosite_List.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "phosphosite('{}').".format(row["substrate_id"])
		file.write(var1 + "\n")