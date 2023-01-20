import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Observation where cell_line = "MCF-7";', conn)

#### removing rows which have "-888.0000" values for fold change etc ####
df = df[df["p_value"] > -700]
df = df[df["p_value"] <= 0.05]

with open("ObservationsMCF7.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "perturbs('{}', '{}', {}).".format(row["perturbagen"],row["substrate"], "down" if row["fold_change"] < 0 else "up")
		file.write(var1 + "\n")