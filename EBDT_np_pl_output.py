import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Observation where cell_line = "MCF-7";', conn)

#### removing rows which have "-888.0000" values for fold change etc ####
df = df[df["p_value"] > -700]
df = df[df["p_value"] <= 0.05]

df = df[df["fold_change"] <= - 1].groupby("substrate").size().to_frame('size')


with open("np_4th.pl", "w") as file:
	for index, row in df.iterrows():
		print(row)
		print(index)
		var1 = "np('{}', {}).".format(index, row["size"])
		file.write(var1 + "\n")