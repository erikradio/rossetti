import csv,re, sys, string, xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement, Comment, tostring
from xml.dom import minidom



# xmlData = open(xmlFile, 'w')

# xmlData.write('<?xml version="1.0" encoding="UTF-8"?>' + "\n")

tree = ET.parse('rossetti_mods_20150804.xml')

root = tree.getroot()
records = root.findall('{http://www.loc.gov/mods/v3}mods')

def prettify(elem):
    """Return a pretty-printed XML string for the Element.
    """
    rough_string = ET.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ")


with open('completehandles.csv', 'rU') as csvfile:
    reader = csv.DictReader(csvfile)
    handlesDict = {}
    for row in reader:
        handlesDict.update({row['filename']: row['handle']})
        

    
    for record in records:

        newURI = SubElement(record, '{http://www.loc.gov/mods/v3}identifier')
        newURI.set('type','uri')
        newHandle=SubElement(record, '{http://www.loc.gov/mods/v3}identifier')
        newHandle.set('type','hdl')
        
    
        
        
        for identifier in record.findall('{http://www.loc.gov/mods/v3}identifier[@type="local"][1]'):
            # newid=identifier.text[-4:-8]
            oldid=identifier.text
            newid=oldid.replace('_001','')
            # identifier.insert(-1,newURI)
            # identifier.insert(0,newHandle)
            
           

            for handle in handlesDict:
               
                
                if newid == handle:
                    
                    # print newid +' is ' +handle
                    newURI.text=handlesDict.get(handle)
                    newHandle.text=handlesDict.get(handle).replace('http://hdl.handle.net/','hdl:')
                    
            
       
         # problem files: ksrl_sc_ms23_D.6.5a_001.tif, ksrl_sc_ms23_D.6.2_002.tif, ksrl_sc_ms23_D.6.1_003.tif
         # change England-London to England--London
           


    


# print tostring(record)
tree.write('newOut.xml', encoding="UTF-8",xml_declaration=True)
        

                

                    
