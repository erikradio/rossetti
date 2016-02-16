import sys
import copy
import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')



for elem in tree.getiterator():
    elem.tag = 'mods:' + elem.tag




tree.write('newOut.xml')