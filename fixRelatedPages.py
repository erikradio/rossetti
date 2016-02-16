#!/usr/bin/python2

import sys
import copy
import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')



relatedPages=[]

records=root.findall('{http://www.lunaimaging.com/xsd}record')

for record in records:
    for fieldGroup in record:
        if fieldGroup.attrib['type'] == 'Related_Item':
            for child in fieldGroup:
                if child.attrib['type'] == 'Related_Pages':
                    relatedPages.append(child)

for relatedPage in relatedPages:
    startIndex=relatedPage.text.find('.tif')
    startIndex=startIndex-4
    print relatedPage.text
    print relatedPage.text[0:startIndex]
    print relatedPage.text[startIndex+8:]
    print relatedPage.text[0:startIndex]+relatedPage.text[startIndex+8:]
    print
    relatedPage.text=relatedPage.text[0:startIndex]+relatedPage.text[startIndex+8:]
		
tree.write('newOut.xml')
