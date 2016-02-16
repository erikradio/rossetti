###Rossetti Luna Processing 

Initial file is rosetti_metadata.csv

2. rossetti_metadata.csv with csv2xml.py --> raw_rossetti.xml 

3. raw_rossetti.xml + rossetti2mods.xsl -->rossettiModsComplete.xml

4. rossettiModsComplete.xml + deleteEmpy.xsl

5. rossettiModsComplete.xml + isoDateFormatMods.py = rossettiModsComplete.xml with dates in ISO format.

6. rossettiModsComplete.xml +  rossettiSplit2Luna.py = rossetti_splitPreLuna.xml which is one record for each file (not just for each letter)

7. rossetti_splitPreLuna.xml + fixTitleTwo.py = inserts page number into each title

8. rossetti_splitPreluna + rossettiMODS2Luna.xsl = lunaCompleteRossetti.xml + deleteEmpty.xsl

