import sys, re, lxml, urllib.request
import nltk
from bs4 import BeautifulSoup

outputText = open("AllmwbText.txt", "w", encoding="utf-8")

i = 0
while i < 7:
    i += 1
    url = "http://diglib.hab.de/content.php?dir=edoc/ed000223&xml=tei-transcript-mwb"+str(i)+".xml&xsl=tei-transcript.xsl"
    print(url)
    try:
        u = urllib.request.urlopen(url) #reads the content of 'url' to the variable 'u'        
    except:
        print("Fehler")
        sys.exit(0)
    xmlFile = u.read()#.decode(u.headers.get_content_charset()) #uses the html-endcoding
    u.close()
    #print(url, file = outputText)
    soup = BeautifulSoup(xmlFile, "html")
    for x in soup.find_all('div', {"class" : "footnotes"}):
        x.replaceWith('')
    for x in soup.find_all('span'):
        x.replaceWith('')
    for x in soup.find_all('div', {"style" : "margin-top:2em;"}):
        x.replaceWith("###PAGEBREAK###")
    OCR = soup.find('div', { "class" : "content" })
    if not (OCR is None):
        text = str(OCR.text)
        text = re.sub("\n", " ", text)
        text = re.sub(" {2,}", " ", text)
        text = re.sub("^ ", "", text)
        text = re.sub("↑", "", text)
        text = re.sub("###PAGEBREAK###", "\n###PAGEBREAK###", text)
        text = re.sub("XML: http://diglib.hab.de/edoc/ed000223/tei-transcript-mwb7.xml", "", text)
        text = re.sub("XSLT: http://diglib.hab.de/edoc/ed000223/tei-transcript.xsl", "", text)
        
        print(text, file = outputText)
    else:
        print("Fehler im HTML", file = outputText)
        print("Fehler im HTML")
outputText.close()

d = open("AllmwbText.txt", "r", encoding="utf-8") 
text1 = d.read()
text1 = re.sub("\n###PAGEBREAK###"," ", text1)
outputList = open("AllmwbTextWordlist.txt", "w", encoding="utf-8")
tokens = nltk.word_tokenize(text1)
for x in tokens:
    #print(x)
    outputList.write(str(x)+"\n")
d.close()
outputList.close()
