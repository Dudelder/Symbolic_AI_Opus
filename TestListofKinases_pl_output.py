import pandas as pd
import sqlite3

conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from KS_relationship where source = "UniProt";', conn)

df = df['kinase'].unique()


with open("TestListofKinases.pl", "w") as file:
	for x in df:
		y = "kinase(" + "'" + x + "'" + ")" + "."
		file.write(y + "\n")