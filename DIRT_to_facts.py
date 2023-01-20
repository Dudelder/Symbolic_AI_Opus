import pandas as pd


df1 = pd.read_csv("dirts_MCF7.csv", usecols = ["K", "Pst"])




with open("KS_relationship_DIRT_MCF7.pl", "w") as file:
	for index, row in df1.iterrows():
		var1 = "knowntarget('{}', '{}').".format(row["K"],row["Pst"])
		file.write(var1 + "\n")
