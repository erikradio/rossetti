#!/usr/bin/python2

import sys, re
import copy
import xml.etree.ElementTree as ET
import lxml

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')


#p=re.compile('[\d]*-[1-9]-[1-9]')
records=root.findall('{http://www.loc.gov/mods/v3}mods')

for record in records:

    originInfo=record.findall('{http://www.loc.gov/mods/v3}originInfo')
    if len(originInfo) < 1:
  		continue
    date=originInfo[0].findall('{http://www.loc.gov/mods/v3}dateCreated')
    if len(date) < 1:
    	continue
    splitDate=date[0].text.split("-")
    if len(splitDate[1])==1:
    	splitDate[1]="0"+splitDate[1]
    if len(splitDate[2])==1:
    	splitDate[2]="0"+splitDate[2]
    #newdate=p.subn('[\d]*-0[1-9]-0[1-9]', date[0].text)
    newDate="-".join(splitDate)
    date[0].text=newDate
    print newDate
tree.write('newOut.xml')
