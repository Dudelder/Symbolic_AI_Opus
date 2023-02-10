file = open("np_4th_t.pl", "r")

contentSplit = file.read().split("\n")
newList = []
for line in contentSplit:
	if "(M" not in line:
		newList.append(line)


newFile = open("np_4th_025.pl", "w")
for line in newList:
	newFile.write(line + "\n")

newFile.close()