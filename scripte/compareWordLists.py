import re, sys, urllib.request

d = open("AllmwbTextWordlist.txt", "r", encoding="utf-8") # import the wordlist of the first text, which has to be txt-file, where every word is written on a new line
text1 = d.read()
text1 = text1.lower()
d.close()

d = open("judasWordlist.txt", "r") # imports the wordlist of the second text, which has to be txt-file, where every word is written on a new line
text2 = d.read()
text2 = text2.lower()
d.close()

d = open("placeList.txt", "r", encoding="utf-8") # imports the wordlist of the third text, which has to be txt-file, where every word is written on a new line. Due to its big amount of data this file has to be read line by line.
text3 = d.readlines()
d.close()
newList = []
for y in text3:
    place = str(y).lower()
    place = re.sub("\n", "", place)
    newList.append(place)

newList = set(newList)
outputList = open("sharedWords.txt", "w", encoding="utf-8")

set1 = set(text1.split("\n"))
set2 = set(text2.split("\n"))
set4 = set1 & set2 & newList
for x in set4:
    if len(x)>3:
        #print(x)
        outputList.write(str(x)+"\n")
outputList.close()
