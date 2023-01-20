import pandas as pd
import sqlite3
import re
conn = sqlite3.connect("chemphopro.db")


### Data frame with "where...." adding SQL Query parameters #####
df = pd.read_sql_query('select * from Observation where cell_line = "MCF-7";', conn)

#### removing rows which have "-888.0000" values for fold change etc ####
df = df[df["p_value"] > -700]
df = df[df["p_value"] <= 0.05]
df = df['substrate'].unique()


#### regular expression used to find and remove anything that is within parentheses ex. (S345) etc

df1 = [re.sub(r"(.*)\(.*\)", r"\1", x) for x in df]

with open("PonProtein_From_MCF7_obs_table.pl", "w") as file:
	for x in range(len(df)):
		y = "ponProtein(" + "'" + df[x] + "'" +","+ "'"+ df1[x] + "'" +")" + "."
		file.write(y + "\n")