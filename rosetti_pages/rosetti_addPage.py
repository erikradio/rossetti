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
   
   for identifier in record.findall('{http://www.loc.gov/mods/v3}identifier'):
      print identifier
   root.remove(record)

tree.write('newOut.xml')
