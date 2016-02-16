#!/usr/bin/python2

import sys 
import copy
import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]



tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')

def copyRecordFunction(activeIdentifier,activeRecord):
   tmpRecord=copy.deepcopy(activeRecord)
   for identifier in tmpRecord.findall('{http://www.loc.gov/mods/v3}identifier'):
      if identifier.text != activeIdentifier.text:
         print identifier.text+" isnt "+activeIdentifier.text
         tmpRecord.remove(identifier)
      else:
         print identifier.text+" is "+activeIdentifier.text
   if len(tmpRecord.findall('{http://www.loc.gov/mods/v3}identifier')) is 0:
      print "broke"
      exit()
   print "loop"
   return tmpRecord

records=root.findall('{http://www.loc.gov/mods/v3}mods')

for record in records:
   if len(record.findall('{http://www.loc.gov/mods/v3}identifier')) > 1:
      for identifier in record.findall('{http://www.loc.gov/mods/v3}identifier'):
         root.append(copyRecordFunction(identifier,record))
      root.remove(record)

tree.write('newOut.xml')
