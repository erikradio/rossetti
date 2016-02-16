<?xml version="1.0" encoding="UTF-8"?>
<!-- This stylesheet transforms data from a previous process, luna2xml.py, and puts it into the format required by Luna. the stylesheet deleteEmpty.xsl must be run over the output of this transformation 
before the files can be properly uploaded.
Created by Erik Radio, KU Libraries, 10/14-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:mods="http://www.loc.gov/mods/v3">
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <recordList xmlns="http://www.lunaimaging.com/xsd">
            
            <xsl:apply-templates select="@*|node()"/>
            
        </recordList>
    </xsl:template>
    
    <xsl:template match="mods:mods">
        <xsl:for-each select=".">
            <xsl:variable name="baseCallNo" select="mods:identifier"/>
            
            
        <record type="MODS" xmlns="http://www.lunaimaging.com/xsd">
            
            
            
            <field xmlns="http://www.lunaimaging.com/xsd" type="Record ID">
                
                <xsl:value-of select="mods:identifier"/>
                
            </field>
            
                        
            <fieldGroup type="titleInfo">
                <field xmlns="http://www.lunaimaging.com/xsd" type="Title">
                    <xsl:value-of select="mods:titleInfo/mods:title"/>
                </field>
            </fieldGroup>
            
            
            
           <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="name">
               <xsl:for-each select="mods:name">
                   
                       <xsl:if test=".//mods:role/mods:roleTerm[@type='code']='aut'">
                <field type="Author">
                    <xsl:value-of select=".//mods:namePart"/>
                </field>
                       </xsl:if>
                   <xsl:if test=".//mods:role/mods:roleTerm[@type='code']='rcp'">
                   
               <field type="Recipient">
                   <xsl:value-of select=".//mods:namePart"/>
               </field>
                   </xsl:if>
               </xsl:for-each>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Abstract_Description">
                <field type="Abstract">
                    <xsl:value-of select="mods:abstract"/>
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Language">
                <xsl:for-each select="mods:language/mods:languageTerm[@type='text']">
                <field type="Language">
                    
                    <xsl:value-of select="."/>
                    
                </field>
                </xsl:for-each>
                
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Genre">
                <field type="Genre">
                    <xsl:value-of select="mods:genre"/>
                </field>
            </fieldGroup>
            
            
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="originInfo">
                <field type="Date_Created">
                    <xsl:value-of select="mods:originInfo/mods:dateCreated"/>
                    
                </field>
                <field type="Place"><xsl:value-of select="mods:originInfo/mods:place"/></field>
                    
                
            </fieldGroup>
            
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Physical_Description">
                <field type="Extent">
                    <xsl:value-of select="mods:physicalDescription/mods:extent"/>
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Misc_Note">
                <field type="Note">
                    <xsl:value-of select="mods:note"/>
                </field>
            </fieldGroup>
            
           <!-- <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Related_Items">
                <field type="Related_Item_Title">
                    <xsl:value-of select="mods:relatedItem/mods:titleInfo/mods:title"/>
                </field>
            </fieldGroup>-->
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="ID">
                <field type="Identifier">
                    <xsl:value-of select="mods:identifier"/>
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Related_Item">
                <field type="Related_Title">
                    <xsl:value-of select="mods:relatedItem/mods:titleInfo/mods:title"/>
                </field>
                <xsl:for-each select="mods:relatedItem/mods:originInfo/mods:place/mods:placeTerm">
                <field type="Related_Place">
                    
                    <xsl:value-of select="."/>
                </field>
                </xsl:for-each>
                
                <xsl:variable name="firstHTML">http://luna.ku.edu:8180/luna/servlet/view/search?q=Related_Pages=%22</xsl:variable>
                <xsl:variable name="secondHTML">%22&amp;sort=Record_ID,Note,Title,Date_Created&quot;target=&quot;_blank&quot;&gt;</xsl:variable>
                <xsl:variable name="callno"><xsl:value-of select="replace($baseCallNo,'(_[0-9]{3}.TIF)','')"/></xsl:variable>
                <xsl:variable name="comepleteRelatedPagesLink" select="concat($firstHTML,$callno,$secondHTML)"/>
                
                <!--<a target="_blank" href="http://spencer.lib.ku.edu/collections/university-archives/">University Archives, Kenneth Spencer Research Library, University of Kansas</a>-->
                
                
                <!--<field type="Related_Pages"><a><xsl:attribute name="href"><xsl:value-of select="$comepleteRelatedPagesLink"/></xsl:attribute>View all</a></field>-->
                
                <field type="Related_Pages"><xsl:value-of select="concat('&lt;a href=&quot;http://luna.ku.edu:8180/luna/servlet/view/search?q=Related_Pages=%22',$callno,'%22&amp;sort=Record_ID,Note,Title,Date_Created&quot;&gt;')"/><xsl:value-of select="$callno"/></field>
                
                
                <!--http://luna.ku.edu:8180/luna/servlet/view/search?q=Related_Pages=%22ksrl_sc_ms23_C.2.10%22&sort=Record_ID,Note,Title,Date_Created-->
                    
                   <!-- <xsl:value-of select="substring-before($baseCallNo,substring($baseCallNo,19))"/>-->
                    
                    
                
                <field type="Related_Abstract">
                    <xsl:value-of select="mods:relatedItem/mods:abstract"/>
                </field>
            </fieldGroup>
            
            <!--<fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Work Type">
                <field type="Type">
                    <xsl:value-of select="ImageType1"/>
                </field>
            </fieldGroup>
            
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Work Creator">
                <field type="Creator">
                    
                    <xsl:value-of select="Creator1"/>
                    
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Work Location">
                <field type="Location">
                    <xsl:value-of select="Location1"/>
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Work Source">
                <field type="Source">
                    <xsl:value-of select="Source1"/>
                </field>
            </fieldGroup>
            
            <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Work Rights">
                <field type="Rights Statement">&lt;a href=&quot;http://spencer.lib.ku.edu/using-the-library/library-use-and-policies/&quot; target=&quot;_blank&quot;&gt;Acceptable use Policy&lt;/a&gt;</field>
                
            </fieldGroup>-->
            
            
        </record>
        </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>
