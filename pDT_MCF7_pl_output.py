import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from KS_relationship where cell_line ="MCF-7";', conn)


with open("pDT_MCF7.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "pDT('{}', '{}', '{}').".format(row["substrate"],row["kinase"], row["cell_line"])
		file.write(var1 + "\n")