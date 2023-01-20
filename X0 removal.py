file = open("np_4th.pl", "r")

contentSplit = file.read().split("\n")
newList = []
for line in contentSplit:
	if "(X0" not in line:
		newList.append(line)


newFile = open("np_4th_t.pl", "w")
for line in newList:
	newFile.write(line + "\n")

newFile.close()