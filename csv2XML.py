import csv,sys
 
csvFile = sys.argv[1]
xmlFile = sys.argv[2]
 
csvData = csv.reader(open(csvFile, 'rU'))
xmlData = open(xmlFile, 'w')
xmlData.write('<?xml version="1.0"?>' + "\n")
# there must be only one top-level tag
xmlData.write('<csv_data>' + "\n")
 
# We need the current logNo, the last one processed, and we keep track of times around to mark the tags
rowNum = 0
logNo=None
lastLogNo=None
timesAround=0

for row in csvData:
        for rowIndex in range(len(row)):
            row[rowIndex]=row[rowIndex].replace('&','amp;')

	if rowNum == 0:
            tags = row
# replace spaces w/ underscores in tag names
            for i in range(len(tags)):
                tags[i] = tags[i].replace(' ', '_')
                tags[i]=tags[i].replace('[en_US]','')
            tagsCopy=tags
       	else:
        # Set the logNo of the current record
            logNo=row[0]

        #This fixes the first row printing a closing tag first
            if rowNum==1:
                lastLogNo=logNo
                xmlData.write('<row>'+'\n')

                # If the current LogNo Doesn't match the last one close the current row and start a new one and reset timesAround
            if logNo != lastLogNo:
                xmlData.write('</row>'+'\n'+'<row>' + "\n")
                timesAround=1
                tagsCopy=tags
            # Otherwise just increment times around, they have the same logNo
            else:
                timesAround=timesAround+1


            #for author in row[2].split('||'):
                #row.append(author)
                #tagsCopy.append('dc.contributor.author1')


            #This is where I append timesAround to the tag
            for i in range(len(tagsCopy)):
                xmlData.write(' ' + '<' + tagsCopy[i]+str(timesAround) + '>' + row[i] + '</' + tagsCopy[i]+str(timesAround) + '>' + "\n")
                    

                # We're done processing this record, set it as the last one and let the loop begin again
            lastLogNo=logNo



    






	rowNum +=1
 
# Nothing else fires out closing tag for rows when we run out of them in the CSV, so we jam that in manually
xmlData.write(' </row>' + "\n")
xmlData.write('</csv_data>' + "\n")
xmlData.close()
