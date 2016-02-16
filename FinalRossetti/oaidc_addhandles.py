import csv, sys, xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement, Comment, tostring


# xmlData = open(xmlFile, 'w')

# xmlData.write('<?xml version="1.0" encoding="UTF-8"?>' + "\n")

tree = ET.parse('Rossetti_oaiDC_20150702.xml')

root = tree.getroot()
records = root.findall('{http://www.openarchives.org/OAI/2.0/oai_dc/}dc')


    

with open('completehandles.csv', 'rU') as csvfile:
    reader = csv.DictReader(csvfile)
    handlesDict = {}
    for row in reader:
        handlesDict.update({row['filename']: row['handle']})
        

    
    for record in records:
        newIdentifier = SubElement(record, '{http://purl.org/dc/elements/1.1/}identifier')
        # rights=SubElement(record,'{http://purl.org/dc/elements/1.1/}rights')
        # rights.text='This work is in the public domain and is available for users to copy, use, and redistribute in part or in whole. No known restrictions apply to the work.'
        # record.append(rights)
    
        
        
        for identifier in record.findall('{http://purl.org/dc/elements/1.1/}identifier'):
            

            for handle in handlesDict:
                
                if identifier.text == handle:
                    #print identifier.text +'is' +handle
                    newIdentifier.text=handlesDict.get(handle)
        
                    
        for thing in record.findall('{http://purl.org/dc/elements/1.1/}identifier'):

            if thing.text.startswith('ksrl'):
                
            
                record.remove(thing)
           
       
            
           

    record.append(newIdentifier)

        
    
    print tostring(record)
    tree.write('newOut.xml', encoding="UTF-8",xml_declaration=True)
        

                

                    
