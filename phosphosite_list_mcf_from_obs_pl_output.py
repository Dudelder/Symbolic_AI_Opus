import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Observation where cell_line = "MCF-7";', conn)

#### removing rows which have "-888.0000" values for fold change etc ####
df = df[df["p_value"] > -700]
df = df[df["p_value"] <= 0.05]
df = df['substrate'].unique()


with open("Phosphosite_List_MCF7_from_Observation_table.pl", "w") as file:
	for x in df:
		y = "phosphosite(" + "'" + x + "'" + ")" + "."
		file.write(y + "\n")