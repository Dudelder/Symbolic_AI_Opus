import pandas as pd


df = pd.read_csv("Phosphosites Rm QUERY.csv", usecols = ["KINASE", "phoshphosite", "Rm"])


with open("Phosphosites Rm QUERY.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "Rm('{}', '{}', {}).".format(row["KINASE"],row["phoshphosite"],row["Rm"])
		file.write(var1 + "\n")