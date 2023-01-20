import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from PK_relationship;', conn)

df = df[df["score"] <= 0.5].groupby("kinase").size().to_frame('size')
print(df)

with open("nk_known.pl", "w") as file:
	for index, row in df.iterrows():
		print(row)
		print(index)
		var1 = "nk('{}', {}).".format(index, row["size"])
		file.write(var1 + "\n")