<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
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
    
    <xsl:output method="html" indent="yes"/>
    
    <!-- <xsl:strip-space elements="cmd:Description"/> -->
    <xsl:strip-space elements="*"/>
    
    <!--         ToolProfile:            clarin.eu:cr1:p_1447674760338 
		 TextCorpusProfile:      clarin.eu:cr1:p_1442920133046
		 LexicalResourceProfile: clarin.eu:cr1:p_1445542587893
		 ExperimentProfile:      clarin.eu:cr1:p_1447674760337
		 

new ExperimentProfile: clarin.eu:cr1:p_1524652309872 
new TextCorpusProfile: clarin.eu:cr1:p_1524652309874
new ToolProfile: clarin.eu:cr1:p_1524652309875
new LexicalResourceProfile: clarin.eu:cr1:p_1524652309876
new CourseProfile: clarin.eu:cr1:p_1524652309877
new SpeechCorpusProfile: clarin.eu:cr1:p_1524652309878 
		 
    -->
    
    <!-- This need to be OR'ed for all valid NaLiDa-based profiles -->
    <xsl:template match="/cmd:CMD">
        <xsl:choose>
            <xsl:when test="contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760338')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1442920133046')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1445542587893')
		or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1485173990943')
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760337') 
                or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1505397653792')">
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
		  - LexicalResourceProfile (clarin.eu:cr1:p_1445542587893), 
		  - SpeechCorpusProfile (clarin.eu:cr1:p_1485173990943), and
		  - ExperimentProfile (clarin.eu:cr1:p_1447674760337)
		  - CourseProfile (clarin.eu:cr1:p_1505397653792).
		  
		  Additional we suppor the following profiles, which are utilized by the CLARIN-D-Centre in Tübingen
		  - OLAC-DcmiTerms: clarin.eu:cr1:p_1288172614026
		  - DcmiTerms: clarin.eu:cr1:p_1288172614023
		  
		  Older version of the profiles are partly supported, currently only if used  in CMDI 1.2 files: 
		  - ExperimentProfile: clarin.eu:cr1:p_1302702320451
		  - LexicalResourceProfile: clarin.eu:cr1:p_1290431694579
		  - TextCorpusProfile: clarin.eu:cr1:p_1290431694580
		  - ToolProfile: clarin.eu:cr1:p_1290431694581
		  - WebLichtWebService: clarin.eu:cr1:p_1320657629644
		  - Resource Bundle: clarin.eu:cr1:p_1320657629649
		  
		  Newer version of the profiles are partly, currently only if used  in CMDI 1.2 files: 
		  - ExperimentProfile: clarin.eu:cr1:p_1524652309872 
		  - TextCorpusProfile: clarin.eu:cr1:p_1524652309874
		  - ToolProfile: clarin.eu:cr1:p_1524652309875
		  - LexicalResourceProfile: clarin.eu:cr1:p_1524652309876
		  - CourseProfile: clarin.eu:cr1:p_1524652309877
		  - SpeechCorpusProfile: clarin.eu:cr1:p_1524652309878 
		  
	  
		</xsl:text>
                </error>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/cmde:CMD/cmde:Header">
    <!-- ignore header --> 
    </xsl:template>

    
    <xsl:template match="/cmd:CMD/cmd:Header">
    <!-- ignore header --> 
    </xsl:template>

    <xsl:template match="/cmde:CMD">
        <xsl:choose>
            <xsl:when test="contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760338')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1442920133046')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1445542587893')
		or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1485173990943')		
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760337')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1505397653792')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1288172614026')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1288172614023')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1302702320451')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1290431694579')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1290431694580')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1320657629644')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1320657629649')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309872') 
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309874')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309875')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309876')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309877')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1524652309878')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176122')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176123')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176124')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176125')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176126')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176127')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1527668176128')
                ">
                <!-- CMDI 1.2 -->
                <xsl:call-template name="mainProcessing"></xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <error>
                    <xsl:text>
		Please use a valid CMDI v1.2 schema from the NaLiDa project.
		Currently the following profiles are being supported:
		
		- ToolProfile (clarin.eu:cr1:p_1447674760338),
		- TextCorpusProfile ('clarin.eu:cr1:p_1442920133046)
		- LexicalResourceProfile (clarin.eu:cr1:p_1445542587893) 
 		- SpeechCorpusProfile (clarin.eu:cr1:p_1485173990943)		
		- ExperimentProfile (clarin.eu:cr1:p_1447674760337)
		- CourseProfile (clarin.eu:cr1:p_1505397653792)

		  - ExperimentProfile: clarin.eu:cr1:p_1524652309872 
		  - TextCorpusProfile: clarin.eu:cr1:p_1524652309874
		  - ToolProfile: clarin.eu:cr1:p_1524652309875
		  - LexicalResourceProfile: clarin.eu:cr1:p_1524652309876
		  - CourseProfile: clarin.eu:cr1:p_1524652309877
		  - SpeechCorpusProfile: clarin.eu:cr1:p_1524652309878 
		  
		    - TextCorpusProfile: clarin.eu:cr1:p_1527668176122
		    - LexicalResourceProfile: clarin.eu:cr1:p_1527668176123
		    - ToolProfile: clarin.eu:cr1:p_1527668176124
		    - CourseProfile: clarin.eu:cr1:p_1527668176125
		    - ExperimentProfile: clarin.eu:cr1:p_1527668176126
		    - ResourceBundle: clarin.eu:cr1:p_1527668176127
		    - SpeechCorpusProfile: clarin.eu:cr1:p_1527668176128
		
    Additionally we support the following profiles, which are utilized by the CLARIN-D-Centre in Tübingen
		  - OLAC-DcmiTerms: clarin.eu:cr1:p_1288172614026
		  - DcmiTerms: clarin.eu:cr1:p_1288172614023
		  
		  Older versions of the profiles are partly supported, currently only if used in CMDI 1.2 files: 
		  - ExperimentProfile: clarin.eu:cr1:p_1302702320451
		  - LexicalResourceProfile: clarin.eu:cr1:p_1290431694579
		  - TextCorpusProfile: clarin.eu:cr1:p_1290431694580
		  - ToolProfile: clarin.eu:cr1:p_1290431694581
		  - WebLichtWebService: clarin.eu:cr1:p_1320657629644
		  - Resource Bundle: clarin.eu:cr1:p_1320657629649
		  
                    
                    </xsl:text>
                </error>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="mainProcessing">
      <html>
        <head>
	  <title>Resource: <xsl:value-of select="//*[local-name() = 'ResourceName']"/> </title>	      
	  
	  <link rel="stylesheet"
		href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
	  
	  <script src="https://code.jquery.com/jquery-3.1.1.min.js"
		  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
		  crossorigin="anonymous"></script>
	  
	  <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"
		  integrity="sha256-eGE6blurk5sHj+rmkfsGYeKyZx3M4bG+ZlFyA7Kns7E="
		  crossorigin="anonymous"></script>
	</head>
        
	
	<body>
	  <script>
    	    $(function() {
    	    $( "#tabs" ).tabs({
            event: "mouseover"
    	    //event: "click"
    	    });
    	    });
	  </script>

	  <h1>Resource: <xsl:value-of select="//*[local-name() = 'GeneralInfo']/*[local-name() = 'ResourceName']"/></h1>
	  
	  <div id="tabs">
	    <ul>
	      <li><a href="#tabs-1">General Info</a></li>
	      <xsl:if test="//*[local-name() = 'Project']"><li><a href="#tabs-2">Project</a></li></xsl:if>
	      <xsl:if test="//*[local-name() = 'Publications']"><li><a href="#tabs-3">Publications</a></li></xsl:if>
	      <xsl:if test="//*[local-name() = 'Creation']"><li><a href="#tabs-4">Creation</a></li></xsl:if>
	      <xsl:if test="//*[local-name() = 'Documentations']"><li><a href="#tabs-5">Documentation</a></li></xsl:if>
	      <xsl:if test="//*[local-name() = 'Access']"><li><a href="#tabs-6">Access</a></li></xsl:if>
<!--      <xsl:if test="not(contains(//*:Components/*/local-name(), 'DcmiTerms'))"><li><a href="#tabs-7">Resource-specific information</a></li></xsl:if> -->
	      <li><a href="#tabs-7">Resource-specific information</a></li>
	      <li><a href="#tabs-8">Data files</a></li>    
	      <li><a href="#tabs-9">About...</a></li>
	    </ul>
	    
	    <xsl:apply-templates></xsl:apply-templates>
	  </div>
	</body>
      </html>
    </xsl:template>
    
    <xsl:template match="*[local-name()='GeneralInfo']">
      <div id="tabs-1">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>General Information</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Resource Name: </b></td>
              <td><xsl:value-of select="./*[local-name()='ResourceName']"/></td>
	    </tr>
	    <tr>
              <td><b>Resource Title: </b></td>
              <td><xsl:value-of select="./*[local-name()='ResourceTitle']"/>
	      </td>
	    </tr>
	    <tr>
              <td><b>Resource Class: </b></td>
              <td><xsl:value-of select="./*[local-name()='ResourceClass']"/>
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Version: </b></td>
              <td><xsl:value-of select="./*[local-name()='Version']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Life Cycle Status: </b></td>
              <td><xsl:value-of select="./*[local-name()='LifeCycleStatus']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Start Year: </b></td>
              <td><xsl:value-of select="./*[local-name()='StartYear']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Completion Year: </b></td>
              <td><xsl:value-of select="./*[local-name()='CompletionYear']"/>
	      </td>	      	      	      	      
	    </tr>	    
	    <tr>
              <td><b>Publication Date: </b></td>
              <td><xsl:value-of select="./*[local-name()='PublicationDate']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Last Update: </b></td>
              <td><xsl:value-of select="./*[local-name()='LastUpdate']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Time Coverage: </b></td>
              <td><xsl:value-of select="./*[local-name()='TimeCoverage']"/>
	      </td>	      	      	      	      
            </tr>
	    <tr>
              <td><b>Legal Owner: </b></td>
              <td><xsl:value-of select="./*[local-name()='LegalOwner']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Genre: </b></td>
              <td><xsl:value-of select="./*[local-name()='Genre']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Field of Research: </b></td>
              <td><xsl:value-of select="./*[local-name()='FieldOfResearch']"/>
	      </td>	      	      	      	      
	    </tr>	    	    
	    <tr>
              <td><b>Location: </b></td>
              <td><xsl:value-of select="./*[local-name()='Location']/*[local-name()='Country']/*[local-name()='CountryName']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Description: </b></td>
              <td><xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Tags: </b></td>
              <td><xsl:value-of select="./*[local-name()='tags']//*[local-name()='tag']"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Modality Info: </b></td>
              <td><xsl:value-of select="./*[local-name()='ModalityInfo']//*[local-name()='Modalities']"/>
	      </td>	      	      	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>
    </xsl:template>

    <xsl:template match="*[local-name()='Project']">
      <div id="tabs-2">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Project</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Project Name: </b></td>
              <td><xsl:value-of select="./*[local-name()='ProjectName']"/></td>
	    </tr>
	    <tr>
              <td><b>Project Title: </b></td>
              <td><xsl:value-of select="./*[local-name()='ProjectTitle']"/></td>
	    </tr>
	    <tr>
              <td><b>Project ID: </b></td>
              <td><xsl:value-of select="./*[local-name()='ProjectID']"/></td>
	    </tr>
	    <tr>
              <td><b>Url: </b></td>
              <td><xsl:value-of select="./*[local-name()='Url']"/></td>
	    </tr>
	    <tr>
              <td><b>Funder: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Funder']/*[local-name()='fundingAgency']"/>
		<xsl:if test="./*[local-name()='Funder']/*[local-name()='fundingReferenceNumber'] != ''">
		  <xsl:text>, with reference: 
		  </xsl:text>
		</xsl:if>		
		<xsl:value-of select="./*[local-name()='Funder']/*[local-name()='fundingReferenceNumber']"/>		
	      </td>
	    </tr>
	    <tr>
              <td><b>Institution: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Institution']/*[local-name()='Department']"/>
		<xsl:if test="./*[local-name()='Institution']/*[local-name()='Organisation']/*[local-name()='name'] != ''">
		  <xsl:text>, 
		  </xsl:text>
		</xsl:if>		
		<xsl:value-of select="./*[local-name()='Institution']/*[local-name()='Organisation']/*[local-name()='name']"/>
	      </td>
	    </tr>
	    <tr>
              <td><b>Cooperations: </b></td>
              <td>
		<!-- omitted Cooperation dept., organisation, url, and descriptions -->
		<xsl:for-each select="./*[local-name()='Cooperation']">		
		  <xsl:value-of select="./*[local-name()='CooperationPartner']"/>
		  <xsl:if test="position()!=last()">, </xsl:if>				    
		</xsl:for-each>		  
	      </td>	      
	    </tr>	    
	    <tr>
              <td><b>Person(s): </b></td>
	      <td>
		<xsl:for-each select="./*[local-name()='Person']">
		  <xsl:choose>
		    <xsl:when test="./*[local-name()='AuthoritativeIDs']/*[local-name()='AuthoritativeID']/*[local-name()='id'] != ''">
		      <xsl:element name="a">
			<xsl:attribute name="href">
			  <xsl:value-of select=".//*[local-name()='AuthoritativeID'][1]/*[local-name()='id']"/>
			</xsl:attribute>
			<xsl:value-of select="./*[local-name()='firstName']"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="./*[local-name()='lastName']"/>
		      </xsl:element>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:value-of select="./*[local-name()='firstName']"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of select="./*[local-name()='lastName']"/>			      
		    </xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="./*[local-name()='Role'] != ''">
		    <xsl:text> (</xsl:text>
			<xsl:value-of select="./*[local-name()='Role']"/>		    
		    <xsl:text>)</xsl:text>		    
		</xsl:if>				  
		  <xsl:if test="position()!=last()">, </xsl:if>				    
		</xsl:for-each>
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Duration: </b></td>
	      <td>
		<xsl:value-of select="./*[local-name()='Duration']/*[local-name()='StartYear']"/>
		<xsl:if test="./*[local-name()='Duration']/*[local-name()='CompletionYear'] != ''">
		  <xsl:text>
		    --
		  </xsl:text>
		</xsl:if>
		<xsl:value-of select="./*[local-name()='Duration']/*[local-name()='CompletionYear']"/>
	      </td>
	    </tr>	    
	  </table>
	</p>
      </div>
    </xsl:template>
    
    <xsl:template match="*[local-name()='Publications']">
      <div id="tabs-3">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Publications</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <xsl:for-each select="./*[local-name()='Publication']">
	      <tr>
		<td>
		  <table  border="3" cellpadding="10" cellspacing="10">
		    <tr>
		      <td><b>Title:</b></td>
		      <td><xsl:value-of select="./*[local-name()='PublicationTitle']"/></td>
		    </tr>
		    <tr>
		      <td><b>Author(s):</b></td>
		      <td>
			<xsl:for-each select="./*[local-name()='Author']">
			  <xsl:choose>
			    <xsl:when test="./*[local-name()='AuthoritativeIDs']/*[local-name()='AuthoritativeID']/*[local-name()='id'] != ''">
			      <xsl:element name="a">
				<xsl:attribute name="href">
				  <xsl:value-of select=".//*[local-name()='AuthoritativeID'][1]/*[local-name()='id']"/>
				</xsl:attribute>
				<xsl:value-of select="./*[local-name()='firstName']"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="./*[local-name()='lastName']"/>
			      </xsl:element>
			    </xsl:when>
			    <xsl:otherwise>
			      <xsl:value-of select="./*[local-name()='firstName']"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of select="./*[local-name()='lastName']"/>			      
			    </xsl:otherwise>
			  </xsl:choose>
			  <xsl:if test="position()!=last()">, </xsl:if>				    
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Abstract:</b></td>
		      <td><xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/></td>
		    </tr>
		    <tr>
		      <td><b>Link:</b></td>
		      <td>
			<xsl:element name="a">
			  <xsl:attribute name="href">
			    <xsl:value-of select="./*[local-name()='resolvablePID']"/>			  
			    <xsl:value-of select=".//*[local-name()='AuthoritativeID'][1]/*[local-name()='id']"/>
			  </xsl:attribute>
			  <xsl:value-of select="./*[local-name()='resolvablePID']"/>			
			</xsl:element>			
		      </td>
		    </tr>		      		      
		  </table>
		</td>
	      </tr>
	    </xsl:for-each>
	  </table>
	</p>
      </div>	    
    </xsl:template>
    
    <xsl:template match="*[local-name()='Creation']">
      <div id="tabs-4">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Creation</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
	      <td><b>Topic:</b></td>
	      <td><xsl:value-of select="./*[local-name()='Topic']"/></td>
	    </tr>	    
	    <tr>
              <td><b>Creator(s): </b></td>
	      <td>	      
		<xsl:for-each select="./*[local-name()='Creators']/*[local-name()='Person']">
		  <xsl:choose>
		    <xsl:when test="./*[local-name()='AuthoritativeIDs']/*[local-name()='AuthoritativeID']/*[local-name()='id'] != ''">
		      <xsl:element name="a">
			<xsl:attribute name="href">
			  <xsl:value-of select=".//*[local-name()='AuthoritativeID'][1]/*[local-name()='id']"/>
			</xsl:attribute>
			<xsl:value-of select="./*[local-name()='firstName']"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="./*[local-name()='lastName']"/>
		      </xsl:element>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:value-of select="./*[local-name()='firstName']"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of select="./*[local-name()='lastName']"/>			      
		    </xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="./*[local-name()='role'] != ''">		
		    (<xsl:value-of select="./*[local-name()='role']"/>)
		  </xsl:if>
		  <xsl:if test="position()!=last()">, </xsl:if>
		</xsl:for-each>
	      </td>
	    </tr>
	    <xsl:for-each select="./*[local-name()='CreationToolInfo']">
	      <tr>
		<td><b>Creation Tool</b></td>
		<td>
		  <xsl:value-of select="./*[local-name()='CreationTool']"/>
		  <xsl:if test="./*[local-name()='ToolType'] != ''">
		    <xsl:text> (</xsl:text>
		    <xsl:value-of select="./*[local-name()='ToolType']"/>
		    <xsl:text>)</xsl:text>		  
		  </xsl:if>
		</td>
	      </tr>
	    </xsl:for-each>
	    <xsl:if test="//*[local-name()='AnnotationMode']">
	    <tr>
	      <td><b>Annotation:</b></td>
	      <td>
		<table  border="3" cellpadding="10" cellspacing="10">
		  <tr>
		    <td><b>Annotation Mode:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='AnnotationMode']"/></td>
		  </tr>
		  <tr>
		    <td><b>Annotation Standoff:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='AnnotationStandoff']"/></td>
		  </tr>
		  <tr>
		    <td><b>Interannotator Agreement:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='InterannotatorAgreement']"/></td>
		  </tr>
		  <tr>
		    <td><b>Annotation Format:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='AnnotationFormat']"/></td>
		  </tr>
		  <tr>
		    <td><b>Segmentation Units:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='SegmentationUnits']"/></td>
		  </tr>
		  <xsl:for-each select=".//*[local-name()='AnnotationType']">
		    <tr>
		      <td><b>Annotation Type:</b></td>
		      <td>
			<table>
			  <tr>
			    <td><b>Annotation Level Type(s): </b></td>
			    <td>
		     	      <xsl:for-each select="./*[local-name()='AnnotationLevelType']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Annotation Mode(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='AnnotationMode']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Tagset(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='TagsetInfo']">
				<xsl:value-of select="./*[local-name()='Tagset']"/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			
			  <tr>
			    <td><b>Descriptions(s): </b></td>
			    <td><xsl:value-of select=".//*[local-name()='Description']"/></td>			    
			  </tr>
			</table>
		      </td>			
		    </tr>
		  </xsl:for-each>
		  <xsl:for-each select=".//*[local-name()='AnnotationToolInfo']">		  
		    <tr>
		      <td><b>Annotation Tool Info:</b></td>
		      <td>
			<table>
			  <tr>
			    <td><b>Annotation Tool(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='AnnotationTool']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Tool Type(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='ToolType']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Versions(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='Version']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Url(s): </b></td>
			    <td>
			      <xsl:for-each select="./*[local-name()='Url']">
				<xsl:value-of select="."/>
				<xsl:if test="position()!=last()">, </xsl:if>
			      </xsl:for-each>
			    </td>
			  </tr>
			  <tr>
			    <td><b>Description(s):</b></td>
			    <td><xsl:value-of select=".//*[local-name()='Description']"/></td>
			  </tr>		  			  
			</table>
		      </td>
		    </tr>
		  </xsl:for-each>
		  <tr>
		    <td><b>Annotation Descriptions:</b></td>
		    <td><xsl:value-of select=".//*[local-name()='Description']"/></td>
		  </tr>		  
		</table>
	      </td>
	    </tr>
	    </xsl:if>
	    <xsl:for-each select="./*[local-name()='Source']">
	      <tr>
		<td><b>Source:</b></td>
		<td>
		  <table  border="3" cellpadding="10" cellspacing="10">
		    <tr>
		      <td><b>Original Source</b></td>
		      <td>
			<xsl:value-of select="./*[local-name()='OriginalSource']"/>
			<xsl:if test="./*[local-name()='SourceType'] != ''">
			  <xsl:text> (</xsl:text>
			  <xsl:value-of select="./*[local-name()='SourceType']"/>
			  <xsl:text>)</xsl:text>		  
			</xsl:if>
		      </td>
		    </tr>
		    <tr>
		      <xsl:for-each select="./*[local-name()='MediaFiles']">
			<tr>
			  <td><b>Catalogue Link:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='CatalogueLink']"/></td>
			</tr>
			<tr>
			  <td><b>Type:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='Type']"/></td>
			</tr>
			<tr>
			  <td><b>Format:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='Format']"/></td>
			</tr>
			<tr>
			  <td><b>Size:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='Size']"/></td>
			</tr>
			<tr>
			  <td><b>Quality:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='Quality']"/></td>
			</tr>
			<tr>
			  <td><b>Description:</b></td>		  
			  <td><xsl:value-of select="./*[local-name()='Description']"/></td>
			</tr>
		      </xsl:for-each>		
		    </tr>
		  </table>
		</td>
	      </tr>
	      <tr>
		<td><b>Derivation:</b></td>
		<td>
		  <table border="3" cellpadding="10" cellspacing="10">
		    <tr>
		      <td><b>Organisation(s)</b></td>
		      <td>		    
			<xsl:for-each select=".//*[local-name()='Organisation']">
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Derivation Date</b></td>
		      <td>		    
			<xsl:value-of select=".//*[local-name()='DerivationDate']"/>
		      </td>
		    </tr>		    
		    <tr>
		      <td><b>Derivation Mode(s)</b></td>
		      <td>		    
			<xsl:for-each select=".//*[local-name()='DerivationMode']">
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Derivation Type(s)</b></td>
		      <td>		    
			<xsl:for-each select=".//*[local-name()='DerivationType']">
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Derivation Workflow(s)</b></td>
		      <td>		    
			<xsl:for-each select=".//*[local-name()='DerivationWorkflow']">
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Derivation Tool Info</b></td>
		      <td>		    
			<xsl:for-each select=".//*[local-name()='DerivationToolInfo']">
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">, </xsl:if>
			</xsl:for-each>
		      </td>
		    </tr>
		  </table>
		</td>
	      </tr>
	    </xsl:for-each>
	  </table>
	</p>
      </div>            
    </xsl:template>
    
    <xsl:template match="*[local-name()='Documentations']">
      <div id="tabs-5">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Documentations</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <xsl:for-each select="./*[local-name()='Documentation']">	    
	      <tr>
		<table>
		  <tr>
		    <td><b>Documentation Type(s): </b></td>
		    <td>
		      <xsl:for-each select="./*[local-name()='DocumentationType']">
			<xsl:value-of select="."/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      
		  </tr>
		  <tr>
		    <td><b>File Name(s): </b></td>
		    <td>
		      <xsl:for-each select="./*[local-name()='FileName']">
			<xsl:value-of select="."/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      
		  </tr>
		  <tr>
		    <td><b>URL: </b></td>
		    <td><xsl:value-of select="./*[local-name()='FileName']"/></td>
		  </tr>	    	    	    	    
		  <tr>
		    <td><b>Documentation Language(s): </b></td>
		    <td>
		      <!-- omitted ISO639 code -->
		      <xsl:for-each select="./*[local-name()='DocumentationLanguages']">
			<xsl:value-of select="./*[local-name()='DocumentationLanguage']/*[local-name()='Language']//*[local-name()='LanguageName']"/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      	      
		  </tr>
		  <tr>
		    <td><b>Descriptions(s): </b></td>
		    <td>
		      <xsl:for-each select="./*[local-name()='Description']">
			<xsl:value-of select="."/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      
		  </tr>
		</table>
	      </tr>
	    </xsl:for-each>
	  </table>
	</p>
      </div>            
    </xsl:template>

    <xsl:template match="*[local-name()='Access']">
      <div id="tabs-6">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Access</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <!-- assuming single occurrence of sub-node -->
	    <tr>
              <td><b>Availability: </b></td>
              <td><xsl:value-of select="./*[local-name()='Availability']"/></td>
	    </tr>
	    <tr>
              <td><b>Distribution Medium: </b></td>
              <td><xsl:value-of select="./*[local-name()='DistributionMedium']"/></td>	      
	    </tr>
	    <tr>
              <td><b>Catalogue Link: </b></td>
              <td><xsl:value-of select="./*[local-name()='CatalogueLink']"/></td>	      
	    </tr>
	    <tr>
              <td><b>Price: </b></td>
              <td><xsl:value-of select="./*[local-name()='Price']"/></td>	      
	    </tr>
	    <tr>
              <td><b>Licence: </b></td>
              <td><xsl:value-of select="./*[local-name()='Licence']"/></td>	      
	    </tr>	    
	    <tr>
              <td><b>Contact: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Contact']/*[local-name()='firstname']"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="./*[local-name()='Contact']/*[local-name()='lastname']"/>
		<xsl:if test="./*[local-name()='Contact']/*[local-name()='role'] != ''">
		  (<xsl:value-of select="./*[local-name()='Contact']/*[local-name()='role']"/>)
		</xsl:if>		
		<xsl:if test="./*[local-name()='Contact']/*[local-name()='email'] != ''">
		  <xsl:text>, e-mail:</xsl:text>
		  <xsl:value-of select="./*[local-name()='Contact']/*[local-name()='email']"/>
		</xsl:if>
		<xsl:if test="./*[local-name()='Contact']/*[local-name()='telephoneNumber'] != ''">
		  <xsl:text>, telephone:</xsl:text>
		  <xsl:value-of select="./*[local-name()='Contact']/*[local-name()='telephoneNumber']"/>
		</xsl:if>		  		
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Deployment Tool Info: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='DeploymentToolInfo']/*[local-name()='DeploymentTool']"/>
		<xsl:if test="./*[local-name()='DeploymentToolInfo']/*[local-name()='ToolType'] !=''">
		  (<xsl:value-of select="./*[local-name()='DeploymentToolInfo']/*[local-name()='ToolType']"/>)
		</xsl:if>
		<xsl:if test="./*[local-name()='DeploymentToolInfo']/*[local-name()='Version'] !=''">
		  , Version: <xsl:value-of select="./*[local-name()='DeploymentToolInfo']/*[local-name()='Version']"/>.
		</xsl:if>		
	      </td>	      
	    </tr>	    
	    <tr>
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select=".//*[local-name()='Description']"/></td>	      
	    </tr>
	  </table>
	</p>
      </div>      
    </xsl:template>
    
    
    <xsl:template match="*[local-name()='ResourceProxyListInfo']">
      <!-- ignore content, generate About instead, still to do, especially enhancing! -->
    
      <div id="tabs-9">
	<p>
	  This digital object contains:
	  <table>
	    <tr><th>Original File Name</th><th>Size</th><th>Checksums</th></tr>
	    <xsl:apply-templates select="*[local-name()='ResourceProxyInfo']"/>
	  </table>
	  <table>
	    <thead>
              <tr>
		<th><h3>About</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Generation: </b></td>
              <td>Automatically generated with an XSL stylesheet from the CMDI file, v.02</td>
	    </tr>
	    <tr>
              <td><b>Contact: </b></td>
              <td>Thorsten Trippel and Claus Zinn, SfS Tuebingen</td>	      
	    </tr>
	  </table>
	</p>
      </div>                  
      
    </xsl:template>
  <xsl:template match="//*[local-name()='ResourceProxyInfo']">
  <tr>
    <td><xsl:value-of select="*[local-name()='ResProxFileName']"/></td>
    <td><xsl:for-each select="*[local-name()='SizeInfo']/*[local-name()='TotalSize']">
      <xsl:value-of select="*[local-name()='Size']"/><xsl:value-of select="*[local-name()='SizeUnit']"/>
    </xsl:for-each>
    </td>
    <td>
      <ul>
      <li><xsl:value-of select="*[local-name()='Checksums']/*[local-name()='md5']"/> (MD5)</li>
      <li><xsl:value-of select="*[local-name()='Checksums']/*[local-name()='sha1']"/> (SHA1)</li>  
    </ul>
    </td>
    
  </tr>
  </xsl:template>

    <xsl:template match="//*[local-name()='ResourceProxyList']">
      <div id="tabs-8">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Data Files</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Persistent Identifier (PID) of this digital object: </b></td>
              <td>
		<xsl:element name="a">
		  <xsl:attribute name="href">		
		    <xsl:value-of select="//*[local-name()='MdSelfLink']"/>
		  </xsl:attribute>
		  <xsl:value-of select="//*[local-name()='MdSelfLink']"/>
		</xsl:element>
	      </td>	      	      
	    </tr>
	    <tr>
              <td><b>Complete set of this data (as zip file): </b></td>
              <td>
		<xsl:for-each select="./*">
		  <xsl:if test="./*[local-name()='ResourceType'] = 'LandingPage'">
		    <xsl:element name="a">
		      <xsl:attribute name="href">				    
			<xsl:value-of select="./*[local-name()='ResourceRef']"/>
		      </xsl:attribute>
		      <xsl:value-of select="./*[local-name()='ResourceRef']"/>
		    </xsl:element>
		  </xsl:if>
		</xsl:for-each>
	      </td>	      	      
	    </tr>
	  </table>
	</p>

	This data set contains the following data streams:
	<ul>
	  <xsl:for-each select="./*">
	    <xsl:choose>
	      <xsl:when test="./*[local-name()='ResourceType'] = 'Resource'">	    
		<li>
		  <xsl:element name="a">
		    <xsl:attribute name="href">
		      <xsl:value-of select="./*[local-name()='ResourceRef']"/>
		    </xsl:attribute>
		    <xsl:value-of select="./*[local-name()='ResourceRef']"/>
		  </xsl:element>
		   <xsl:if test="./*[local-name()='ResourceType']/@*[local-name()='mimetype']">
		     <xsl:text> </xsl:text>
		     (<xsl:value-of select="./*[local-name()='ResourceType']/@*[local-name()='mimetype']"/>)
		   </xsl:if>
		</li>
	      </xsl:when>
	    </xsl:choose>	      
	  </xsl:for-each>
	</ul>
      </div>                  
    </xsl:template>  
    
    <!-- Resource type specific templates -->
    
    <xsl:template match="*[local-name()='LexicalResourceContext']">
      <div id="tabs-7">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Lexical Resource</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Lexicon Type: </b></td>
              <td><xsl:value-of select="./*[local-name()='LexiconType']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select="./*[local-name()='SubjectLanguages']/*[local-name()='SubjectLanguage']/*[local-name()='Language']/*[local-name()='LanguageName']"/></td>
	    </tr>
	    <tr>
              <td><b>Auxiliary Language(s): </b></td>
              <td><xsl:value-of select="./*[local-name()='AuxiliaryLanguages']/*[local-name()='Language']/*[local-name()='LanguageName']"/></td>
	    </tr>	    
	    <tr>
	      <td><b>Headword Type: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='HeadwordType']/*[local-name()='LexicalUnit']"/>
		<xsl:if test="./*[local-name()='HeadwordType']/*[local-name()='Descriptions']/*[local-name()='Description'] != ''">		
		  (<xsl:value-of select="./*[local-name()='HeadwordType']/*[local-name()='Descriptions']/*[local-name()='Description']"/>)		
		</xsl:if>		
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Type-specific Size Info(s): </b></td>
              <td><xsl:value-of select="./*[local-name()='TypeSpecificSizeInfo']/*[local-name()='TypeSpecificSize']/*[local-name()='Size']"/></td>
	    </tr>
	    <tr>
              <td><b>Description: </b></td>
              <td><xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/>
	      </td>	      	      	      	      
	    </tr>	    
	  </table>
	</p>
      </div>            
    </xsl:template>
    
    <xsl:template match="*[local-name()='ExperimentContext']">
        <div id="tabs-7">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Experiment(s)</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
	      <xsl:for-each select="./*[local-name()='ExperimentalStudy']/*[local-name()='Experiment']">
		<tr>
		  <td><b>Name:</b></td>
		  <td><xsl:value-of select="./*[local-name()='ExperimentName']"/></td>
		</tr>
		<tr>
		  <td><b>Title:</b></td>
		  <td><xsl:value-of select="./*[local-name()='ExperimentTitle']"/></td>
		</tr>
		<tr>
		  <td><b>Paradigm:</b></td>
		  <td><xsl:value-of select="./*[local-name()='ExperimentalParadigm']"/></td>
		</tr>
		<tr>		
		  <td><b>Description:</b></td>
		  <td><xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/></td>
		</tr>
		<!-- more here -->
		<tr>		
		  <td><b>Experimental Quality:</b></td>
		  <td><xsl:value-of select="./*[local-name()='ExperimentalQuality']/*[local-name()='QualityCriteria']"/></td>
		</tr>		
		<tr>		
		  <td><b>Subject Language(s):</b></td>
		  <td><xsl:value-of select="./*[local-name()='SubjectLanguages']/*[local-name()='SubjectLanguage']/*[local-name()='Language']/*[local-name()='LanguageName']"/></td>
		</tr>
		<tr>		
		  <td><b>Material(s):</b></td>
		  <td>
		    <ul>
		      <xsl:for-each select="./*[local-name()='Materials']/*[local-name()='Material']">
			<li>
			  <xsl:value-of select="./*[local-name()='Domain']"/>
			  <xsl:if test="./*[local-name()='Descriptions']/*[local-name()='Description'] != ''">
			    <xsl:text>
			      : 
			    </xsl:text>
			    <xsl:value-of select="./*[local-name()='Descriptions']/*[local-name()='Description']"/>
			  </xsl:if>
			</li>
		    </xsl:for-each>
		    </ul>
		  </td>
		</tr>
		<tr>		
		  <td><b>Hypotheses:</b></td>
		  <td>
		    <xsl:value-of select="./*[local-name()='Hypotheses']/*[local-name()='Hypothesis']/*[local-name()='Descriptions']/*[local-name()='Description']"/>
		  </td>
		</tr>
		<!-- much more here -->		
		<tr>
		  <td><b>Method(s):</b></td>
		  <td>
		    <table  border="3" cellpadding="10" cellspacing="10">
		      <tr>
			<td><b>Experiment type:</b></td>
			<td><xsl:value-of select="./*[local-name()='Method']/*[local-name()='Elicitation']//*[local-name()='ExperimentType']"/></td>
		      </tr>
		      <tr>
			<td><b>Elicitation instrument:</b></td>
			<td><xsl:value-of select="./*[local-name()='Method']/*[local-name()='Elicitation']//*[local-name()='ElicitationInstrument']"/></td>
		      </tr>
		      <tr>
			<td><b>Elicitation software:</b></td>
			<td><xsl:value-of select="./*[local-name()='Method']/*[local-name()='Elicitation']//*[local-name()='ElicitationSoftware']"/></td>
		      </tr>
		      <tr>
			<td><b>Variable(s)</b></td>
			<td>
			  <ul>
			    <xsl:for-each select="./*[local-name()='Method']/*[local-name()='Elicitation']/*[local-name()='Variables']/*[local-name()='Variable']">
			      <li>
				<xsl:value-of select="./*[local-name()='VariableName']"/>
				<xsl:if test="./*[local-name()='VariableType'] != ''">
				  <xsl:text> (</xsl:text>
				  <xsl:value-of select="./*[local-name()='VariableType']"/>
				  <xsl:text>)</xsl:text>
				</xsl:if>
			      </li>
			    </xsl:for-each>
			  </ul>
			</td>
		      </tr>
		      <tr>
			<td><b>Participant(s)</b></td>
			<td>
			  <table  border="3" cellpadding="10" cellspacing="10">
			    <tr>
			      <td><b>Anonymization flag:</b></td>
			      <td><xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='AnonymizationFlag']"/></td>
			    </tr>
			    <tr>
			      <td><b>Sampling method:</b></td>
			      <td><xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='SamplingMethod']"/></td>
			    </tr>
			    <tr>
			      <td><b>Sampling size:</b></td>
			      <td>
				<xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='SampleSize']/*[local-name()='Size']"/>
				<xsl:if test="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='SampleSize']/*[local-name()='SizeUnit'] !=''">
				  <xsl:text> </xsl:text>
				  <xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='SampleSize']/*[local-name()='SizeUnit']"/>
				</xsl:if>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Sex distribution:</b></td>
			      <td>
				<ul>
				  <xsl:for-each select="./*[local-name()='Method']/*[local-name()='Participants']/*[local-name()='SexDistribution']/*[local-name()='SexDistributionInfo']">
				    <li>
				      <xsl:value-of select="./*[local-name()='ParticipantSex']"/>:<xsl:value-of select="./*[local-name()='Size']"/>
				    </li>
				  </xsl:for-each>
				</ul>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Age distribution:</b></td>
			      <td>
				<xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']//*[local-name()='ParticipantMeanAge']"/>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Language variety:</b></td>
			      <td>
				<xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']//*[local-name()='VarietyName']"/>:<xsl:value-of select="./*[local-name()='Method']/*[local-name()='Participants']//*[local-name()='NoParticipants']"/>			  
			      </td>
			    </tr>		      
			  </table>
			</td>
		      </tr>		      
		    </table>
		  </td>
		</tr>
		<tr>		
		  <td><b>Results:</b></td>
		  <td>
		    <xsl:value-of select="./*[local-name()='Results']/*[local-name()='Descriptions']/*[local-name()='Description']"/>
		  </td>
		</tr>
		<tr>		
		  <td><b>Analysis Tool Info:</b></td>
		  <td>
		    <xsl:value-of select="./*[local-name()='AnalysisToolInfo']/*[local-name()='AnalysisTool']"/>
		    <xsl:if test="./*[local-name()='AnalysisToolInfo']/*[local-name()='ToolType'] !=''">
		      (<xsl:value-of select="./*[local-name()='AnalysisToolInfo']/*[local-name()='ToolType']"/>)
		    </xsl:if>
		    <xsl:if test="./*[local-name()='AnalysisToolInfo']/*[local-name()='Version'] !=''">
		      , Version: <xsl:value-of select="./*[local-name()='AnalysisToolInfo']/*[local-name()='Version']"/>.
		    </xsl:if>				    
		  </td>
		</tr>		
		<tr>
		  <td><b>Type-specific Size info: </b></td>
		  <td><xsl:value-of select="./*[local-name()='TypeSpecificSizeInfo']/*[local-name()='TypeSpecificSize']/*[local-name()='Size']"/></td>
		</tr>	    	    		
		<hr></hr>
	      </xsl:for-each>
	    </tr> 	    
	  </table>
	</p>
      </div>            	      
    </xsl:template>
    
    <xsl:template match="*[local-name()='ToolContext']">
      <div id="tabs-7">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Tool(s)</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Tool Classification: </b></td>
              <td><xsl:value-of select="./*[local-name()='ToolClassification']/*[local-name()='ToolType']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Distribution: </b></td>
              <td><xsl:value-of select="./*[local-name()='Distribution']/*[local-name()='DistributionType']"/></td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Size: </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='TotalSize']/*[local-name()='Size']"/>
		<xsl:value-of select="./*[local-name()='TotalSize']/*[local-name()='SizeUnit']"/>		
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Input(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Inputs']//*[local-name()='Description']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Output(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Outputs']//*[local-name()='Description']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Implementatation(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Implementations']//*[local-name()='ImplementationLanguage']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Install Environment(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='InstallEnv']//*[local-name()='OperatingSystem']"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Prerequisite(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='Prerequisites']//*[local-name()='PrerequisiteName']"/>
	      </td>	      	      	      
	    </tr>	    
	    <tr>
	      <td><b>Tech Environment(s): </b></td>
              <td>
		<xsl:value-of select="./*[local-name()='TechEnv']//*[local-name()='ApplicationType']"/>
	      </td>	      	      	      
	    </tr> 	    	    	    	    	    	    
	  </table>
	</p>
      </div>                  
    </xsl:template>

    <xsl:template match="*[local-name()='SpeechCorpusContext']">
      <div id="tabs-7">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Speech Corpus</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Modalities: </b></td>
              <td><xsl:value-of select="./*[local-name()='Modalities']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Mediatype: </b></td>
              <td><xsl:value-of select="./*[local-name()='Mediatype']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Speech Corpus: </b></td>
              <td>
		<table  border="3" cellpadding="10" cellspacing="10">
		  <tr>
		    <td><b>Duration (effective speech):</b></td>
		    <td><xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='DurationOfEffectiveSpeech']"/></td>
		  </tr>
		  <tr>
		    <td><b>Duration (full database):</b></td>
		    <td><xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='DurationOfFullDatabase']"/></td>
		  </tr>
		  <tr>
		    <td><b>Number of speakers:</b></td>
		    <td><xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='NumberOfSpeakers']"/></td>
		  </tr>
		  <tr>
		    <td><b>Recording Environment:</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='RecordingEnvironment']"/>			  
		    </td>
		  </tr>
		  <tr>
		    <td><b>Speaker demographics:</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='SpeakerDemographics']"/>
		    </td>
		  </tr>
		  <tr>
		    <td><b>Quality:</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='Quality']"/>			  
		    </td>
		  </tr>
		  <tr>		    
		    <td><b>Recording Platform (hardware):</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='RecordingPlatformHardware']"/>			  
		    </td>		    
		  </tr>
		  <tr>		    
		    <td><b>Recording Platform (software):</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='RecordingPlatformSoftware']"/>			  
		    </td>		    
		  </tr>
		  <tr>		    
		    <td><b>Speech-technical metadata:</b></td>
		    <td>
		      <xsl:value-of select="./*[local-name()='SpeechCorpus']/*[local-name()='SpeechTechnicalMetadata']"/>			  
		    </td>		    
		  </tr>		      		  
		</table>
	      </td>
	    </tr>
	    <tr>
              <td><b>Multilinguality: </b></td>
              <td><xsl:value-of select="./*[local-name()='Multilinguality']/*[local-name()='Multilinguality']"/></td>
	    </tr>
	    <tr>
              <td><b>Annotation Type(s): </b></td>
              <td><xsl:value-of select=".//*[local-name()='AnnotationType']"/></td>
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select=".//*[local-name()='LanguageName']"/></td>
	    </tr>
	    <tr>
              <td><b>Type-specific Size info: </b></td>
              <td><xsl:value-of select="./*[local-name()='TypeSpecificSizeInfo']//*[local-name()='Size']"/></td>	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>                  	    
    </xsl:template>

    <xsl:template match="*[local-name()='TextCorpusContext']">
      <div id="tabs-7">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Text Corpus</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Corpus Type: </b></td>
              <td><xsl:value-of select="./*[local-name()='CorpusType']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Temporal Classification: </b></td>
              <td><xsl:value-of select="./*[local-name()='TemporalClassification']"/></td>	      	      
	    </tr>	    
	    <tr>
              <td><b>Description(s): </b></td>
              <td><xsl:value-of select=".//*[local-name()='Description']"/></td>	      	      
	    </tr>	    
	    <tr>
              <td><b>Validation: </b></td>
              <td><xsl:value-of select="./*[local-name()='ValidationGrp']//*[local-name()='Description']"/></td>      	      
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select="./*[local-name()='SubjectLanguages']//*[local-name()='LanguageName']"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Type-specific Size Info: </b></td>
              <td><xsl:value-of select="./*[local-name()='TypeSpecificSizeInfo']//*[local-name()='Size']"/></td>	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>                  	          
    </xsl:template>
  <xsl:template match="*[local-name()='CourseProfileSpecific']">
    <div id="tabs-7">
      <p>
        <table>
          <thead>
            <tr>
              <th><h3>Course information</h3></th>
              <th></th>
            </tr>
          </thead>
          <tr>
            <td><b>Course Targeted at: </b></td>
            <td><ul><xsl:apply-templates select="*[local-name()='CourseTargetedAt']"></xsl:apply-templates></ul></td>	      	      
          </tr>
          <tr>
            <td><b>First held: </b></td>
            <td><xsl:value-of select="./*[local-name()='FirstHeldAt']"/><xsl:value-of select="./*[local-name()='FirstHeldOn']"/></td>	      	      
          </tr>	    
            
        </table>
      </p>
    </div>             
    
  </xsl:template>
  <xsl:template match="*[local-name()='CourseTargetedAt']">
    <li><xsl:value-of select="."/></li>
      
  </xsl:template>
    
</xsl:stylesheet>
        
