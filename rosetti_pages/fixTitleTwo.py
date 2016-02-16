#!/usr/bin/python2

import sys
import copy
import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')



records=root.findall('{http://www.loc.gov/mods/v3}mods')

for record in records:
#    if record[0].tag != '{http://www.loc.gov/mods/v3}titleInfo':
#        print 'titleInfo wasnt first element, breaking'
#        exit()
#    if record[0][0].tag != '{http://www.loc.gov/mods/v3}title':
#        print 'title wasnt first element of titleInfo, breaking'
#        exit()
#    if record[6].tag != '{http://www.loc.gov/mods/v3}identifier':
#        print 'identifier was out of order, breaking'
#        exit()
#    record[0][0].text=record[0][0].text+record[6].text[-7:-4]
    titleInfo=record.findall('{http://www.loc.gov/mods/v3}titleInfo')
    if len(titleInfo) > 1:
        print "more than one titleInfo, breaking"
        exit()
    titleInfo=titleInfo[0]

    title=titleInfo.findall('{http://www.loc.gov/mods/v3}title')
    if len(title) > 1:
        print "more than one title, breaking"
        exit()
    title=title[0]

    identifier=record.findall('{http://www.loc.gov/mods/v3}identifier')
    if len(identifier) > 1:
        print "more than one identifier, breaking"
        exit()
    identifier=identifier[0]

    title.text=title.text+', pg. '+identifier.text[-6:-4]

tree.write('newOut.xml')
