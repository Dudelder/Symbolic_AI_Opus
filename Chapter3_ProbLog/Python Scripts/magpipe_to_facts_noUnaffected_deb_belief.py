import pandas as pd


df = pd.read_csv("ctamdb_data_dpp_meansig_nans_MCF7.csv", usecols = ["pst", "perturbagen","fc","pval_eb","pval_meansig"])

# df = df[df["pval_eb"] <= 0.05]
searchfor = ['\\(S', '\\(T', '\\(Y']
df = df[df["pst"].str.contains('|'.join(searchfor))]
df["tprotein"] = df["pst"].str.replace(r'\(.*$', "", regex = True)

# with open("MCF_magpipe_Observations.pl", "w") as file:
# 	for index, row in df1.iterrows():
# 		var1 = "perturbs('{}', '{}').".format(row["K"],row["Pst"])
# 		file.write(var1 + "\n")

with open("MCF7_magpipe_Observations_deg_belief_test2.pl", "w") as file:
    for index, row in df.iterrows():
        if row["fc"] in ["down", "up"] and float(row["pval_meansig"]) < 0.75:
            var1 = "{} :: perturbs('{}', '{}', '{}', {}, {}).".format(row["pval_meansig"], row["perturbagen"], row["pst"],
                                                                    row["tprotein"], row["fc"],
                                                                    row["fc"])
        elif float(row["pval_eb"]) <= 0.05 and float(row["fc"]) < 0:
            var1 = "{} :: perturbs('{}', '{}', '{}', {}, {}).".format(row["pval_eb"],row["perturbagen"], row["pst"],
                                                                    row["tprotein"], "down",
                                                                    row["fc"])
        elif float(row["pval_eb"]) <= 0.05 and float(row["fc"]) > 0:
            var1 = "{} :: perturbs('{}', '{}', '{}', {}, {}).".format(row["pval_eb"], row["perturbagen"], row["pst"],
                                                                    row["tprotein"], "up",
                                                                    row["fc"])
        else:
            var1 = ""
        file.write(var1 + "\n")
