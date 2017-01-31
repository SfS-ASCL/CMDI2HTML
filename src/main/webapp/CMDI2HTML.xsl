<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns="http://www.loc.gov/MARC21/slim"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:cmd="http://www.clarin.eu/cmd/"
    xmlns:cmde="http://www.clarin.eu/cmd/1"
    xmlns:functx="http://www.functx.com"
    xmlns:foo="foo.com"		
    exclude-result-prefixes="xs xd functx">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jan 24, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> ttrippel, czinn</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- <xsl:strip-space elements="cmd:Description"/> -->
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="stop-words-title" select="'Prof.', 'Prof', 'Dr.', 'Dr', 'PhD', 'PhD.'" />
    <xsl:variable name="regexTitle" 
        select="concat('(^|\W)(', string-join($stop-words-title, '|'), ')', '(\W(', string-join($stop-words-title, '|'), '))*($|\W)')" />
    
    <xsl:function name="foo:processPersonNames">
        <xsl:param name="input"/>
        <xsl:sequence select="replace(foo:rewritePersonName( replace( replace($input, $regexTitle, '$1$5'), '^ +','')), '\s+$', '', 'm')"/>
    </xsl:function>
    
    <xsl:function name="foo:rewritePersonName">
        <xsl:param name="input"/>
        <xsl:sequence select="concat( tokenize($input, ' ')[last()], ', ', substring-before( $input, tokenize($input, ' ')[last()])  )"/>
    </xsl:function>
    
  
    
    <!-- ToolProfile:            clarin.eu:cr1:p_1447674760338 
		 TextCorpusProfile:      clarin.eu:cr1:p_1442920133046
		 LexicalResourceProfile: clarin.eu:cr1:p_1445542587893
		 ExperimentProfile:      clarin.eu:cr1:p_1447674760337
    -->
    
    <!-- This need to be OR'ed for all valid NaLiDa-based profiles -->
    <xsl:template match="/cmd:CMD/cmd:Components">
        <xsl:choose>
            <xsl:when test="contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760338')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1442920133046')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1445542587893')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760337')">
                <!-- CMDI 1.1 -->
                <xsl:call-template name="mainProcessing"></xsl:call-template>	
            </xsl:when>
            <xsl:otherwise>
                <error>
                    <xsl:text>
		  Please use a valid CMDI schema v1.1 from the NaLiDa project.
		  Currently the following profiles are being supported:
		
		  - ToolProfile (clarin.eu:cr1:p_1447674760338),
		  - TextCorpusProfile ('clarin.eu:cr1:p_1442920133046),
		  - LexicalResourceProfile (clarin.eu:cr1:p_1445542587893), and
		  - ExperimentProfile (clarin.eu:cr1:p_1447674760337).
		</xsl:text>
                </error>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="/cmde:CMD/cmde:Components">
        <xsl:choose>
            <xsl:when test="contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760338')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1442920133046')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1445542587893')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760337')">
                <!-- CMDI 1.2 -->
                <xsl:call-template name="mainProcessing"></xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <error>
                    <xsl:text>
		Please use a valid CMDI v1.2 schema from the NaLiDa project.
		Currently the following profiles are being supported:
		
		- ToolProfile (clarin.eu:cr1:p_1447674760338),
		- TextCorpusProfile ('clarin.eu:cr1:p_1442920133046),
		- LexicalResourceProfile (clarin.eu:cr1:p_1445542587893), and
		- ExperimentProfile (clarin.eu:cr1:p_1447674760337).</xsl:text>
                </error>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="mainProcessing">
    <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*:GeneralInfo">
       <p><xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="*:Publications"></xsl:template>
    <xsl:template match="*:Project"></xsl:template>
    <xsl:template match="*:Access"></xsl:template>
    <xsl:template match="*:Creation"></xsl:template>
    <xsl:template match="*:Documentations"></xsl:template>
    <xsl:template match="*:ResourceProxyListInfo"></xsl:template>
    
    <!-- Resource type specific templates -->
    
    <xsl:template match="*:SpeechCorpusContext"></xsl:template>
    
    <xsl:template match="*:TextCorpusContext">
       <div align="right"> <xsl:value-of select="."/>
        </div>
    </xsl:template>
</xsl:stylesheet>
        