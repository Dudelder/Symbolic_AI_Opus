
import pandas as pd

file = open("All Kinase pDTS known no stats.txt", "r")
content = file.read().replace("\n", "")
contentSplit = content.split(",")

df = []

for i in range(0, len(contentSplit), 3):
	df.append({"KINASE": contentSplit[i][1:], "phosphosite": contentSplit[i+1],"Prob": contentSplit[i+2].replace(")", "")})

pd.DataFrame(df).to_csv("All Kinase pDTS known no stats.csv", index = False)