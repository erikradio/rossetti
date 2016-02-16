#!/usr/bin/python2

import xml.etree.ElementTree as etree
import csv


tree = etree.parse('lunaRossettiComplete_final.xml')
root=tree.getroot()

records=root.findall('{http://www.lunaimaging.com/xsd}record')

listofLists=[]

for record in records:
    loopList=[]
    title=""
    relatedPages=""
    for child in record:
    #Go down two levels through titleInfo and Title and save that to the title variable, if those don't exist it will be blank, append it to loopList. Doing this with loops, so it could probably be more effecient but it works
        if child.attrib['type'] == "titleInfo":
            for nextChild in child:
                if nextChild.attrib['type'] == "Title":
                    title=nextChild.text.encode("utf-8")
    #Go down two levels through Related_Item and Related_Pages and save that to the relatedPages variable, if those don't exist it will be blank, append it to loopList. Doing this with loops, so it could probably be more effecient but it works
        if child.attrib['type'] == "Related_Item":
            for nextChild in child:
                if nextChild.attrib['type'] == "Related_Pages":
                    relatedPages=nextChild.text.encode("utf-8")
    loopList.append(title)
    loopList.append(relatedPages)
    #Append the 1 dimensional array to another array, giving us a two dimensional array, aka csv
    listofLists.append(loopList)

with open("out.csv","wb") as f:
    writer=csv.writer(f)
    writer.writerows(listofLists)
