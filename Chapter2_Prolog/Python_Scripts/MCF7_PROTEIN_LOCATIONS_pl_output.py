import pandas as pd


df = pd.read_csv("MCF7_PROTEIN_LOCATIONS_SCBC.csv", usecols = ["Protein", "Neighborhood.Class"])


with open("MCF7_PROTEIN_LOCATIONS.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "plocation('{}', '{}', '{}').".format(row["Protein"],row["Neighborhood.Class"], "MCF7")
		file.write(var1 + "\n")