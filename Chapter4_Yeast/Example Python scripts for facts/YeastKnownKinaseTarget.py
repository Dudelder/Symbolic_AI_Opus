import pandas as pd


df = pd.read_csv("YeastKinInteractionsDB.csv")


with open("KIDBstrict.pl", "w") as file:
    for index, row in df.iterrows():
        if row["Score"]>=6.73:
            var1 = "knownkinasetarget('{}', '{}').".format(row["Kinase Name"],row["Gene Name"])
            file.write(var1 + "\n")
