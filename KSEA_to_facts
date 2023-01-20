import pandas as pd


df1 = pd.read_csv("ksea_MCF7.csv", usecols = ["kpa", "Pert","mlog2fc","p_val","z_score","status"])




with open("KSEA_MCF7.pl", "w") as file:
	for index, row in df1.iterrows():
		var1 = "ksea('{}', '{}').".format(row["kpa"],row["Pert",row["status"],row[""])
		file.write(var1 + "\n")
