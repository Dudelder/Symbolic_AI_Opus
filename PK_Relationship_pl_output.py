import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from PK_relationship;', conn)
df = df[df["score"] <= 0.5]

print(df)
with open("PK_Relationship with Source.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "knowninhibitor('{}', '{}', '{}').".format(row["perturbagen"],row["kinase"],row["source"])
		file.write(var1 + "\n")