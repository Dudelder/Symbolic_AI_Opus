import pandas as pd
import sqlite3
import numpy as np

conn = sqlite3.connect("chemphopro.db")


# ## Data frame with "where...." adding SQL Query parameters #####
# df = pd.read_sql_query('select * from KS_relationship where source = "PDT" and cell_line = "MCF-7" ;', conn)
#
# df = df[df["confidence"] >= 0.75]
#
# with open("KS_relationship_PDT_MCF7.pl", "w") as file:
# 	for index, row in df.iterrows():
# 		var1 = "knowntarget(kinase('{}'), phosphosite('{}'), source('PDT')).".format(row["kinase"],row["substrate"])
# 		file.write(var1 + "\n")
#
#
#
# knowntarget = pd.read_csv("omnipath_knowntarget_all.csv")
#
# ### write Prolog file
# with open("knowntargets_omnipath.pl", "w") as file:
#     for index, row in knowntarget.iterrows():
#         var1 = "knowntarget(kinase('{}'), phosphosite('{}'), source('OMNI')).".format(row["KPa"], row["PsT"])
#         file.write(var1 + "\n")
#
#
#
#
#




 # #
# #
# #
# # df1 = pd.read_csv("omnipath_knowntarget_all.csv")
# #
# # # df = df[['KPa', 'PsT']].unique()
# # df2 = pd.unique(df1[['KPa','PsT']].values.ravel())
# # df2 =  df2.tolist()
# #
# # df3 = pd.unique(df[['kinase','substrate']].values.ravel())
# # # df3 = df3.tolist()
# #
# #
# # print(df2)
# #
# # # df2 = df3.loc[df3['tprotein'].isin(df)]
# #
# # df4 = df.loc[df3.in1d(df2)]
# #
# # print(df4)
#
#
#
# #
df = pd.read_sql_query('select * from KS_relationship where source = "PDT" and cell_line = "MCF-7" ;', conn)

df = df[df["confidence"] >= 0.75]

df = df.rename({"kinase" : "KPa", "substrate" : "PsT"}, axis=1)
print(df)


df1 = pd.read_csv("omnipath_knowntarget_all.csv", usecols = ["KPa", "PsT", "KPa_class"])
# df1 = df1.loc[df1["KPa_class"] == "K"]

#
print(df)
print(df1)

s1 = pd.merge(df, df1, how = 'outer')
print(s1)

#
# s1.to_csv("testmerge2.csv", index=False)
#
# s2 = s1.drop_duplicates(subset=['KPa', 'PsT'], keep='last')
# s2.to_csv("testmergeL.csv", index=False)
#
#
#
# s3 = s1.drop_duplicates(subset=['KPa', 'PsT'], keep='first')
#
# s3.to_csv("testmergeF.csv", index=False)
# print(s2)
# print(s3)






with open("KS_relationship_PDT_Omni_merge4_MCF7.pl", "w") as file:
    for index, row in s1.iterrows():
        if row["KPa_class"] in ["K"]:
            var1 = "knowntarget(kinase('{}'), phosphosite('{}')).".format(row["KPa"], row["PsT"])

        elif float(row["confidence"]) >= 0.75 and float(row["confidence"]) < 1.0:
            var1 ="{} :: knowntarget(kinase('{}'), phosphosite('{}')).".format(row["confidence"],row["KPa"],row["PsT"])

        else:
            var1 = ""
        file.write(var1 + "\n")


#
#



#
# with open("KS_relationship_PDT_Omni_merge_MCF7.pl", "w") as file:
# 	for index, row in s2.iterrows():
# 		var1 = "{} :: knowntarget(kinase('{}'), phosphosite('{}')).".format(row["confidence"],row["kinase"],row["substrate"])
# 		file.write(var1 + "\n")



#
# s1.to_csv("testmerge.csv", index=False)
#
#
# #
# # df = df['kinase'].unique()
# #
# # df =  df.tolist()
#
# # df = pd.read_csv("omnipath_knowntarget_all.csv", usecols= ["KPa", "KPa_class"])
# # df = df.loc[df['KPa_class'] == "K"]
#
#
# # df = df['KPa'].unique()
# # df =  df.tolist()
#
# # print(df)
# # print(df2)
# #
# # s1 = pd.merge(df, df2, how= "left")
# #
# # print(s1)
# #
# # s1.to_csv("rule1_known_overlap2.csv", index=False)
# #
# # # df = df.loc[df['KPa_clas'] == K]
#
#
#
#






# df = pd.read_csv("omnipath_knowntarget_all.csv", usecols= ["KPa", "KPa_class"])
# df = df.loc[df['KPa_class'] == "K"]
