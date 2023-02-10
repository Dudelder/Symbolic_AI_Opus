import pandas as pd

knowntarget = pd.read_csv("omnipath_knowntarget_all.csv")

### write Prolog file
with open("knowntargets_omnipath2.pl", "w") as file:
    for index, row in knowntarget.iterrows():
        var1 = "knowntarget('{}', '{}').".format(row["KPa"], row["PsT"])
        file.write(var1 + "\n")
