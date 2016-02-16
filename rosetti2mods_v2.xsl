<xsl:stylesheet xmlns="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="//csv_data">
                <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-2.xsd">
                    <xsl:for-each select="//row">
                        
                            <xsl:call-template name="letters"/>
                        
                    </xsl:for-each>
                </modsCollection>
            </xsl:when>
            <!--<xsl:otherwise>
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.2" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-2.xsd">
                    <xsl:for-each select="//marc:record">
                        <xsl:call-template name="letters"/>
                    </xsl:for-each>
                </mods>
            </xsl:otherwise>-->
        </xsl:choose>
    </xsl:template>
    <xsl:template name="letters" match="//row">
        
        <mods:mods
            
            xmlns:mods="http://www.loc.gov/mods/v3" 
            
            xmlns:rts="http://www.loc.gov/standards/rights/"
            xmlns:xlink="http://www.w3.org/1999/xlink" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xmlns:xs="http://www.w3.org/2001/XMLSchema" 
            
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-2.xsd">
            
            
            
            <xsl:variable name="lang" select="Language1"/>
            <xsl:variable name="eng">eng</xsl:variable>
            <xsl:variable name="fre">fre</xsl:variable>
            <xsl:variable name="ita">ita</xsl:variable>
            <xsl:variable name="name" select="Main_Entry1"></xsl:variable>
            <xsl:variable name="recpt" select="recpt1"/>
            
            
            <mods:titleInfo>
                <mods:title><xsl:value-of select="Item_Title1"/></mods:title>
            </mods:titleInfo>
            
            <mods:language>
                <xsl:choose>
                    <xsl:when test="$lang[contains(.,',')]">
                        
                        <mods:languageTerm type="text"><xsl:value-of select="substring-before($lang,',')"/></mods:languageTerm>
                        <mods:languageTerm type="code"><xsl:value-of select="$eng"/></mods:languageTerm>
                        <mods:languageTerm type="text"><xsl:value-of select="substring-after($lang,', ')"></xsl:value-of></mods:languageTerm>
                        <mods:languageTerm type="code"><xsl:value-of select="$fre"/></mods:languageTerm>
                    </xsl:when>
                    <xsl:otherwise>
                        <mods:languageTerm type="text"><xsl:value-of select="$lang"/></mods:languageTerm>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    
                    <xsl:when test="$lang='French'"><mods:languageTerm type="code"><xsl:value-of select="$fre"/></mods:languageTerm></xsl:when>
                    <xsl:when test="$lang='English'"><mods:languageTerm type="code"><xsl:value-of select="$eng"/></mods:languageTerm></xsl:when>
                    <xsl:when test="$lang='Italian'"><mods:languageTerm type="code"><xsl:value-of select="$ita"/></mods:languageTerm></xsl:when>
                </xsl:choose>
            </mods:language>
            
            <mods:abstract>
                <xsl:value-of select="Abstract_Summary_of_item1"/>
            </mods:abstract>
            <mods:name>
                <xsl:variable name="name" select="Main_Entry1"></xsl:variable>
                <mods:namePart><xsl:value-of select="$name"/></mods:namePart>
                <!--<mods:namePart type="given"><xsl:value-of select="tokenize($name,', ')[2]"/></mods:namePart>
                <mods:namePart type="family"><xsl:value-of select="tokenize($name,', ')[1]"/></mods:namePart>
                <mods:namePart type="date"><xsl:value-of select="tokenize($name,', ')[3]"/></mods:namePart>
                <mods:namePart type="given"><xsl:value-of select="substring-before(substring-after(Main_Entry1,', '),',')"/></mods:namePart>
                <mods:namePart type="family"><xsl:value-of select="substring-before(Main_Entry1,',')"/></mods:namePart>
                <mods:namePart type="date"><xsl:value-of select="tokenize($name,', ')[3]"/></mods:namePart>-->
                <xsl:if test="string-length(.) > 0">
                <mods:role>
                    <mods:roleTerm authority="marcrelator" type="code">aut</mods:roleTerm>
                    <mods:roleTerm authority="marcrelator" type="text">author</mods:roleTerm>
                </mods:role>
                </xsl:if>
            </mods:name>
            <xsl:if test="string-length($recpt) > 0">
            <mods:name>
                <mods:namePart>
                <xsl:value-of select="recpt1"/>
                </mods:namePart>
                
                <mods:role>
                    <mods:roleTerm authority="marcrelator" type="code">rcp</mods:roleTerm>
                    <mods:roleTerm authority="marcrelator" type="text">recipient</mods:roleTerm>
                </mods:role>
                
            
            </mods:name>
            </xsl:if>
            
            
            
            
            <xsl:variable name="place" select="tokenize(Places1,';')"></xsl:variable>
            <mods:originInfo>
                <mods:dateCreated>
                    <xsl:choose>
                        <xsl:when test="string-length(Day1)>0">
                            <xsl:value-of select="concat(Item_dateYear1,'-',Month1,'-',Day1)"></xsl:value-of>
                        </xsl:when>
                        <xsl:when test="string-length(Month_1)>0">
                            <xsl:value-of select="concat(Item_date_Year1,'-',Month1)"></xsl:value-of>
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <xsl:value-of select="Item_date_Year1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </mods:dateCreated>
                <xsl:if test="string-length(placeTerm1) > 0">
                <mods:place>
                    <mods:placeTerm type='text'><xsl:value-of select="placeTerm1"/></mods:placeTerm>
                </mods:place>
                </xsl:if>
            </mods:originInfo>
            
            <mods:genre authority="marcgt">letter</mods:genre>
            
            
            <xsl:for-each select="tokenize(File_Name1,' amp; ')">
                <mods:identifier type="local">
                    <xsl:value-of select="."/>
                </mods:identifier>
            </xsl:for-each>
            
            
            <mods:location>
                <mods:physicalLocation>University of Kansas, Lawrence, KS. Kenneth Spencer Research Library, Special Collections</mods:physicalLocation>
                <!--<mods:shelfLocator>
                    <xsl:value-of select="concat(Base_Call_no1,Call_no_letter1,'.',Call_no_number1)"/>
                </mods:shelfLocator>-->
            </mods:location>
            
            <mods:physicalDescription>
                <mods:extent><xsl:value-of select="concat(no_pages1,' pg.')"/></mods:extent>
                <mods:digitalOrigin>reformatted digital</mods:digitalOrigin>
                <mods:internetMediaType>image/tif</mods:internetMediaType>
                <mods:reformattingQuality>preservation</mods:reformattingQuality>
            </mods:physicalDescription>
            <mods:typeOfResource>text</mods:typeOfResource>
            <mods:relatedItem type="host">
                <mods:titleInfo>
                    <mods:title><xsl:value-of select="concat('Letters: ',Series1)"/></mods:title>
                    
                    
                </mods:titleInfo>
                <mods:originInfo>
                    <!--<mods:place>
                        
                        <xsl:for-each select="tokenize(Places1,'; ')">
                            <mods:placeTerm>
                                <xsl:value-of select="substring-after(.,': ')"/>
                            </mods:placeTerm>
                        </xsl:for-each>
                        
                    </mods:place>-->
                    
                    <mods:dateIssued><xsl:value-of select="concat('between ',Dates_Written1)"/></mods:dateIssued>
                </mods:originInfo>
                <mods:abstract><xsl:value-of select="Summary_Notes1"/></mods:abstract>
            </mods:relatedItem>
            
            <mods:recordInfo>
                <mods:recordContentSource>University of Kansas Libraries</mods:recordContentSource>
                <mods:recordCreationDate encoding='w3cdtf'><xsl:value-of  select="current-dateTime()"/></mods:recordCreationDate>
                <mods:languageOfCataloging>
                    <mods:languageTerm authority='iso639-2b'>eng</mods:languageTerm>
                </mods:languageOfCataloging>
                <mods:recordIdentifier><xsl:value-of select="concat('ksrl_sc_ms23_',Call_no_letter1,'.',Call_no_number1,'.',Item_number1)"/></mods:recordIdentifier>
            </mods:recordInfo>
        </mods:mods>
        
    </xsl:template>
</xsl:stylesheet>