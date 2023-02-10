import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from KS_relationship where source = "UniProt";', conn)


with open("knowntargets_uniprot.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "knowntarget(kinase('{}'), phosphosite('{}'))..".format(row["kinase"],row["substrate"])
		file.write(var1 + "\n")
