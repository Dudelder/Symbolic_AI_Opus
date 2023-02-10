import pandas as pd


df = pd.read_csv("MCF7_KINASE_LOCATIONS_SCBC.csv")


with open("MCF7_KINASE_LOCATIONS.pl", "w") as file:
	for index, row in df.iterrows():
		var1 = "klocation('{}', '{}', '{}').".format(row["Protein"],row["Neighborhood.Class"], "MCF7")
		file.write(var1 + "\n")