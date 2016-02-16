import sys 
import copy
import xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement, Comment, tostring

xmlFile = sys.argv[1]



tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')

records=root.findall('{http://www.loc.gov/mods/v3}mods')

for record in records:
	accessCondition=SubElement(record,'{http://www.loc.gov/mods/v3}accessCondition')
	accessCondition.text='This work is in the public domain and is available for users to copy, use, and redistribute in part or in whole. No known restrictions apply to the work.'
records.append(accessCondition)

	

tree.write('newOut.xml', encoding='UTF-8',xml_declaration=True)