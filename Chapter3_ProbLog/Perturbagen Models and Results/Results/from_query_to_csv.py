import pandas as pd
import re



lines = open('KN62_rule1.pl', 'r').readlines()
lines = set(lines)



print(lines)

df1 = pd.DataFrame(lines,columns = ['query'])

df1.to_csv('KN62_rule1.csv', index=False)



print (df1)
# #
# # perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.
# #
def process(row):
	regex = re.compile(r"perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.")

	newRows = []
	for m in re.findall(regex, row["query"]):
		newRows.append({"Perturbagen": m[0], "Kinase": m[1], "DoB": float(m[2])})


	return pd.DataFrame(newRows)

#
df = pd.read_csv("KN62_rule1.csv", names = ["query"])


# df["tprotein"] = df["pst"].str.replace(r'\(.*$', "", regex = True)
#

## Usable dataframe
newRows = pd.concat(df.apply(process, axis=1).tolist())

print(newRows)
newRows.to_csv('KN62_rule1_clean.csv', index=False)


# perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.
#
# lines_set = set(lines)
#
# out  = open('AKT1_rule2_10q.pl', 'w')
# for line in lines_set:
#     out.write(line)


lines = open('KN62_rule2.pl', 'r').readlines()
lines = set(lines)



print(lines)

df1 = pd.DataFrame(lines,columns = ['query'])

df1.to_csv('KN62_rule2.csv', index=False)



print (df1)
# #
# # perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.
# #
def process(row):
	regex = re.compile(r"perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.")

	newRows = []
	for m in re.findall(regex, row["query"]):
		newRows.append({"Perturbagen": m[0], "Kinase": m[1], "DoB": float(m[2])})


	return pd.DataFrame(newRows)

#
df = pd.read_csv("KN62_rule2.csv", names = ["query"])


# df["tprotein"] = df["pst"].str.replace(r'\(.*$', "", regex = True)
#

## Usable dataframe
newRows = pd.concat(df.apply(process, axis=1).tolist())

print(newRows)
newRows.to_csv('KN62_rule2_clean.csv', index=False)


lines = open('KN62_rule3.pl', 'r').readlines()
lines = set(lines)



print(lines)

df1 = pd.DataFrame(lines,columns = ['query'])

df1.to_csv('KN62_rule3.csv', index=False)



print (df1)
# #
# # perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.
# #
def process(row):
	regex = re.compile(r"perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.")

	newRows = []
	for m in re.findall(regex, row["query"]):
		newRows.append({"Perturbagen": m[0], "Kinase": m[1], "DoB": float(m[2])})


	return pd.DataFrame(newRows)

#
df = pd.read_csv("KN62_rule3.csv", names = ["query"])


# df["tprotein"] = df["pst"].str.replace(r'\(.*$', "", regex = True)
#

## Usable dataframe
newRows = pd.concat(df.apply(process, axis=1).tolist())

print(newRows)
newRows.to_csv('KN62_rule3_clean.csv', index=False)

lines = open('KN62_rule4.pl', 'r').readlines()
lines = set(lines)



print(lines)

df1 = pd.DataFrame(lines,columns = ['query'])

df1.to_csv('KN62_rule4.csv', index=False)



print (df1)
# #
# # perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.
# #
def process(row):
	regex = re.compile(r"perturbation\('(.*)'\),kinase\('(.*)'\),cell_line\(c1\)\), (.*)\)\.")

	newRows = []
	for m in re.findall(regex, row["query"]):
		newRows.append({"Perturbagen": m[0], "Kinase": m[1], "DoB": float(m[2])})


	return pd.DataFrame(newRows)

#
df = pd.read_csv("KN62_rule4.csv", names = ["query"])


# df["tprotein"] = df["pst"].str.replace(r'\(.*$', "", regex = True)
#

## Usable dataframe
newRows = pd.concat(df.apply(process, axis=1).tolist())

print(newRows)
newRows.to_csv('KN62_rule4_clean.csv', index=False)
