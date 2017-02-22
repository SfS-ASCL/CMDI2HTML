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
		or contains(/cmd:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1485173990943')
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
		  - LexicalResourceProfile (clarin.eu:cr1:p_1445542587893), 
		  - SpeechCorpusProfile (clarin.eu:cr1:p_1485173990943), and
		  - ExperimentProfile (clarin.eu:cr1:p_1447674760337).
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
    
    <xsl:template match="/cmde:CMD/cmde:Resources">
    <!-- ignore resources -->
    </xsl:template>

    <xsl:template match="/cmd:CMD/cmd:Resources">
    <!-- ignore resources -->
    </xsl:template>

    <xsl:template match="/cmde:CMD/cmde:Components">
        <xsl:choose>
            <xsl:when test="contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1447674760338')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1442920133046')
                or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1445542587893')
		or contains(/cmde:CMD/@xsi:schemaLocation, 'clarin.eu:cr1:p_1485173990943')		
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
		- LexicalResourceProfile (clarin.eu:cr1:p_1445542587893), 
 		- SpeechCorpusProfile (clarin.eu:cr1:p_1485173990943), and		
		- ExperimentProfile (clarin.eu:cr1:p_1447674760337).</xsl:text>
                </error>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="mainProcessing">

      <html>
            <head>
	      <title>Resource: <xsl:value-of select="//*:GeneralInfo/*:ResourceName"/> </title>
	      
	      <link rel="stylesheet"
		    href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
	      
	      <script src="https://code.jquery.com/jquery-3.1.1.min.js"
		      integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
		      crossorigin="anonymous"></script>
	      
	      <script src="http://code.jquery.com/ui/1.12.0/jquery-ui.min.js"
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

    <h1>Resource: <xsl:value-of select="//*:GeneralInfo/*:ResourceName"/></h1>

    <div id="tabs">
      <ul>
	<li><a href="#tabs-1">General Info</a></li>
	<li><a href="#tabs-2">Project</a></li>
	<li><a href="#tabs-3">Publications</a></li>
	<li><a href="#tabs-4">Creation</a></li>
	<li><a href="#tabs-5">Documentations</a></li>
	<li><a href="#tabs-6">Access</a></li>
	<li><a href="#tabs-7">Resource-specific information</a></li>
	<li><a href="#tabs-8">About...</a></li>
      </ul>
	
      <xsl:apply-templates></xsl:apply-templates>
    </div>
  </body>
</html>
    
    </xsl:template>
    
    <xsl:template match="*:GeneralInfo">
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
              <td><xsl:value-of select="./*:ResourceName"/></td>
	    </tr>
	    <tr>
              <td><b>Resource Title: </b></td>
              <td><xsl:value-of select="./*:ResourceTitle"/>
	      </td>
	    </tr>
	    <tr>
              <td><b>Resource Class: </b></td>
              <td><xsl:value-of select="./*:ResourceClass"/>
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Version: </b></td>
              <td><xsl:value-of select="./*:Version"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Life Cycle Status: </b></td>
              <td><xsl:value-of select="./*:LifeCycleStatus"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Start Year: </b></td>
              <td><xsl:value-of select="./*:StartYear"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Completion Year: </b></td>
              <td><xsl:value-of select="./*:CompletionYear"/>
	      </td>	      	      	      	      
	    </tr>	    
	    <tr>
              <td><b>Publication Date: </b></td>
              <td><xsl:value-of select="./*:PublicationDate"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Last Update: </b></td>
              <td><xsl:value-of select="./*:LastUpdate"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Time Coverage: </b></td>
              <td><xsl:value-of select="./*:TimeCoverage"/>
	      </td>	      	      	      	      
            </tr>
	    <tr>
              <td><b>Legal Owner: </b></td>
              <td><xsl:value-of select="./*:LegalOwner"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Genre: </b></td>
              <td><xsl:value-of select="./*:Genre"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Field of Research: </b></td>
              <td><xsl:value-of select="./*:FieldOfResearch"/>
	      </td>	      	      	      	      
	    </tr>	    	    
	    <tr>
              <td><b>Location: </b></td>
              <td><xsl:value-of select="./*:Location/*:Country/*:CountryName"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Description: </b></td>
              <td><xsl:value-of select="./*:Descriptions/*:Description"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Tags: </b></td>
              <td><xsl:value-of select="./*:tags//*:tag"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Modality Info: </b></td>
              <td><xsl:value-of select="./*:ModalityInfo//*:Modalities"/>
	      </td>	      	      	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>
    </xsl:template>

    <xsl:template match="*:Project">
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
              <td><xsl:value-of select="./*:ProjectName"/></td>
	    </tr>
	    <tr>
              <td><b>Project Title: </b></td>
              <td><xsl:value-of select="./*:ProjectTitle"/></td>
	    </tr>
	    <tr>
              <td><b>Project ID: </b></td>
              <td><xsl:value-of select="./*:ProjectID"/></td>
	    </tr>
	    <tr>
              <td><b>Url: </b></td>
              <td><xsl:value-of select="./*:Url"/></td>
	    </tr>
	    <tr>
              <td><b>Funder: </b></td>
              <td>
		<xsl:value-of select="./*:Funder/*:fundingAgency"/>
		<xsl:if test="./*:Funder/*:fundingReferenceNumber != ''">
		  <xsl:text>, with reference: 
		  </xsl:text>
		</xsl:if>		
		<xsl:value-of select="./*:Funder/*:fundingReferenceNumber"/>		
	      </td>
	    </tr>
	    <tr>
              <td><b>Institution: </b></td>
              <td>
		<xsl:value-of select="./*:Institution/*:Department"/>
		<xsl:if test="./*:Institution/*:Organisation/*:name != ''">
		  <xsl:text>, 
		  </xsl:text>
		</xsl:if>		
		<xsl:value-of select="./*:Institution/*:Organisation/*:name"/>
	      </td>
	    </tr>
	    <tr>
              <td><b>Cooperations: </b></td>
              <td>
		<!-- omitted Cooperation dept., organisation, url, and descriptions -->
		<xsl:for-each select="./*:Cooperation">		
		  <xsl:value-of select="./*:CooperationPartner"/>
		  <xsl:if test="position()!=last()">, </xsl:if>				    
		</xsl:for-each>		  
	      </td>	      
	    </tr>	    
	    <tr>
              <td><b>Person(s): </b></td>
	      <td>
		<xsl:for-each select="./*:Person">
		  <xsl:choose>
		    <xsl:when test="./*:AuthoritativeIDs/*:AuthoritativeID/*:id != ''">
		      <xsl:element name="a">
			<xsl:attribute name="href">
			  <xsl:value-of select=".//*:AuthoritativeID[1]/*:id"/>
			</xsl:attribute>
			<xsl:value-of select="./*:firstName"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="./*:lastName"/>
		      </xsl:element>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:value-of select="./*:firstName"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of select="./*:lastName"/>			      
		    </xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="./*:Role != ''">
		    <xsl:text> (</xsl:text>
			<xsl:value-of select="./*:Role"/>		    
		    <xsl:text>)</xsl:text>		    
		</xsl:if>				  
		  <xsl:if test="position()!=last()">, </xsl:if>				    
		</xsl:for-each>
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select="./*:Descriptions/*:Description"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Duration: </b></td>
	      <td>
		<xsl:value-of select="./*:Duration/*:StartYear"/>
		<xsl:if test="./*:Duration/*:CompletionYear != ''">
		  <xsl:text>
		    --
		  </xsl:text>
		</xsl:if>
		<xsl:value-of select="./*:Duration/*:CompletionYear"/>
	      </td>
	    </tr>	    
	  </table>
	</p>
      </div>
    </xsl:template>
    
    <xsl:template match="*:Publications">
      <div id="tabs-3">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Publications</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <xsl:for-each select="./*:Publication">
	      <tr>
		<td>
		  <table  border="3" cellpadding="10" cellspacing="10">
		    <tr>
		      <td><b>Title:</b></td>
		      <td><xsl:value-of select="./*:PublicationTitle"/></td>
		    </tr>
		    <tr>
		      <td><b>Author(s):</b></td>
		      <td>
			<xsl:for-each select="./*:Author">
			  <xsl:choose>
			    <xsl:when test="./*:AuthoritativeIDs/*:AuthoritativeID/*:id != ''">
			      <xsl:element name="a">
				<xsl:attribute name="href">
				  <xsl:value-of select=".//*:AuthoritativeID[1]/*:id"/>
				</xsl:attribute>
				<xsl:value-of select="./*:firstName"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="./*:lastName"/>
			      </xsl:element>
			    </xsl:when>
			    <xsl:otherwise>
			      <xsl:value-of select="./*:firstName"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of select="./*:lastName"/>			      
			    </xsl:otherwise>
			  </xsl:choose>
			  <xsl:if test="position()!=last()">, </xsl:if>				    
			</xsl:for-each>
		      </td>
		    </tr>
		    <tr>
		      <td><b>Abstract:</b></td>
		      <td><xsl:value-of select="./*:Descriptions/*:Description"/></td>
		    </tr>
		    <tr>
		      <td><b>PID:</b></td>
		      <tt><xsl:value-of select="./*:resolvablePID"/></tt>
		    </tr>		      		      
		  </table>
		</td>
	      </tr>
	    </xsl:for-each>
	  </table>
	</p>
      </div>	    
    </xsl:template>
    
    <xsl:template match="*:Creation">
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
	      <td><xsl:value-of select="./*:Topic"/></td>
	    </tr>	    
	    <tr>
              <td><b>Creator(s): </b></td>
	      <td>	      
		<xsl:for-each select="./*:Creators/*:Person">
		  <xsl:choose>
		    <xsl:when test="./*:AuthoritativeIDs/*:AuthoritativeID/*:id != ''">
		      <xsl:element name="a">
			<xsl:attribute name="href">
			  <xsl:value-of select=".//*:AuthoritativeID[1]/*:id"/>
			</xsl:attribute>
			<xsl:value-of select="./*:firstName"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="./*:lastName"/>
		      </xsl:element>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:value-of select="./*:firstName"/>
		      <xsl:text> </xsl:text>
		      <xsl:value-of select="./*:lastName"/>			      
		    </xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="./*:role != ''">		
		    (<xsl:value-of select="./*:role"/>)
		  </xsl:if>
		  <xsl:if test="position()!=last()">, </xsl:if>
		</xsl:for-each>
	      </td>
	    </tr>
	    <xsl:for-each select="./*:CreationToolInfo">
	      <tr>
		<td><b>Creation Tool</b></td>
		<td>
		  <xsl:value-of select="./*:CreationTool"/>
		  <xsl:if test="./*:ToolType != ''">
		    <xsl:text> (</xsl:text>
		    <xsl:value-of select="./*:ToolType"/>
		    <xsl:text>)</xsl:text>		  
		  </xsl:if>
		</td>
	      </tr>
	    </xsl:for-each>
	    <tr>
	      <td><b>Annotation:</b></td>
	      <td><tt>not yet converted</tt></td>
	    </tr>
	    <tr>
	      <td><b>Source:</b></td>
	      <td><tt>not yet converted</tt></td>
	    </tr>	    	    	    
	    
	  </table>
	</p>
      </div>            
    </xsl:template>
    
    <xsl:template match="*:Documentations">
      <div id="tabs-5">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>Documentations</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <xsl:for-each select="./*:Documentation">	    
	      <tr>
		<table>
		  <tr>
		    <td><b>Documentation Type(s): </b></td>
		    <td>
		      <xsl:for-each select="./*:DocumentationType">
			<xsl:value-of select="."/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      
		  </tr>
		  <tr>
		    <td><b>File Name(s): </b></td>
		    <td>
		      <xsl:for-each select="./*:FileName">
			<xsl:value-of select="."/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      
		  </tr>
		  <tr>
		    <td><b>URL: </b></td>
		    <td><xsl:value-of select="./*:FileName"/></td>
		  </tr>	    	    	    	    
		  <tr>
		    <td><b>Documentation Language(s): </b></td>
		    <td>
		      <!-- omitted ISO639 code -->
		      <xsl:for-each select="./*:DocumentationLanguages">
			<xsl:value-of select="./*:DocumentationLanguage/*:Language//*:LanguageName"/>
			<xsl:if test="position()!=last()">, </xsl:if>
		      </xsl:for-each>
		    </td>	      	      	      
		  </tr>
		  <tr>
		    <td><b>Descriptions(s): </b></td>
		    <td>
		      <xsl:for-each select="./*:Description">
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

    <xsl:template match="*:Access">
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
              <td><xsl:value-of select="./*:Availability"/></td>
	    </tr>
	    <tr>
              <td><b>Distribution Medium: </b></td>
              <td><xsl:value-of select="./*:DistributionMedium"/></td>	      
	    </tr>
	    <tr>
              <td><b>Catalogue Link: </b></td>
              <td><xsl:value-of select="./*:CatalogueLink"/></td>	      
	    </tr>
	    <tr>
              <td><b>Price: </b></td>
              <td><xsl:value-of select="./*:Price"/></td>	      
	    </tr>
	    <tr>
              <td><b>Licence: </b></td>
              <td><xsl:value-of select="./*:Licence"/></td>	      
	    </tr>	    
	    <tr>
              <td><b>Contact: </b></td>
              <td>
		<xsl:value-of select="./*:Contact/*:firstname"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="./*:Contact/*:lastname"/>
		<xsl:if test="./*:Contact/*:role != ''">
		  (<xsl:value-of select="./*:Contact/*:role"/>)
		</xsl:if>		
		<xsl:if test="./*:Contact/*:email != ''">
		  <xsl:text>, e-mail:</xsl:text>
		  <xsl:value-of select="./*:Contact/*:email"/>
		</xsl:if>
		<xsl:if test="./*:Contact/*:telephoneNumber != ''">
		  <xsl:text>, telephone:</xsl:text>
		  <xsl:value-of select="./*:Contact/*:telephoneNumber"/>
		</xsl:if>		  		
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Deployment Tool Info: </b></td>
              <td>
		<xsl:value-of select="./*:DeploymentToolInfo/*:DeploymentTool"/>
		<xsl:if test="./*:DeploymentToolInfo/*:ToolType !=''">
		  (<xsl:value-of select="./*:DeploymentToolInfo/*:ToolType"/>)
		</xsl:if>
		<xsl:if test="./*:DeploymentToolInfo/*:Version !=''">
		  , Version: <xsl:value-of select="./*:DeploymentToolInfo/*:Version"/>.
		</xsl:if>		
	      </td>	      
	    </tr>	    
	    <tr>
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select=".//*:Description"/></td>	      
	    </tr>
	  </table>
	</p>
      </div>      
    </xsl:template>
    
    
    <xsl:template match="*:ResourceProxyListInfo">
      <!-- ignore content, generate About instead, still to do! -->
      <div id="tabs-8">
	<p>
	  <table>
	    <thead>
              <tr>
		<th><h3>About</h3></th>
                <th></th>
              </tr>
	    </thead>
	    <tr>
              <td><b>Generation: </b></td>
              <td>Automatically generated with an XSL stylesheet from the CMDI file, v.01</td>
	    </tr>
	    <tr>
              <td><b>Contact: </b></td>
              <td>Thorsten Trippel and Claus Zinn, SfS Tuebingen</td>	      
	    </tr>
	  </table>
	</p>
      </div>                  
      
    </xsl:template>
    
    <!-- Resource type specific templates -->
    
    <xsl:template match="*:LexicalResourceContext">
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
              <td><xsl:value-of select="./*:LexiconType"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select="./*:SubjectLanguages/*:SubjectLanguage/*:Language/*:LanguageName"/></td>
	    </tr>
	    <tr>
              <td><b>Auxiliary Language(s): </b></td>
              <td><xsl:value-of select="./*:AuxiliaryLanguages/*:Language/*:LanguageName"/></td>
	    </tr>	    
	    <tr>
	      <td><b>Headword Type: </b></td>
              <td>
		<xsl:value-of select="./*:HeadwordType/*:LexicalUnit"/>
		<xsl:if test="./*:HeadwordType/*:Descriptions/*:Description != ''">		
		  (<xsl:value-of select="./*:HeadwordType/*:Descriptions/*:Description"/>)		
		</xsl:if>		
	      </td>	      	      	      
	    </tr>
	    <tr>
              <td><b>Type-specific Size Info(s): </b></td>
              <td><xsl:value-of select="./*:TypeSpecificSizeInfo/*:TypeSpecificSize/*:Size"/></td>
	    </tr>
	    <tr>
              <td><b>Description: </b></td>
              <td><xsl:value-of select="./*:Descriptions/*:Description"/>
	      </td>	      	      	      	      
	    </tr>	    
	  </table>
	</p>
      </div>            
    </xsl:template>
    
    <xsl:template match="*:ExperimentContext">
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
	      <xsl:for-each select="./*:ExperimentalStudy/*:Experiment">
		<tr>
		  <td><b>Name:</b></td>
		  <td><xsl:value-of select="./*:ExperimentName"/></td>
		</tr>
		<tr>
		  <td><b>Title:</b></td>
		  <td><xsl:value-of select="./*:ExperimentTitle"/></td>
		</tr>
		<tr>
		  <td><b>Paradigm:</b></td>
		  <td><xsl:value-of select="./*:ExperimentalParadigm"/></td>
		</tr>
		<tr>		
		  <td><b>Description:</b></td>
		  <td><xsl:value-of select="./*:Descriptions/*:Description"/></td>
		</tr>
		<!-- more here -->
		<tr>		
		  <td><b>Experimental Quality:</b></td>
		  <td><xsl:value-of select="./*:ExperimentalQuality/*:QualityCriteria"/></td>
		</tr>		
		<tr>		
		  <td><b>Subject Language(s):</b></td>
		  <td><xsl:value-of select="./*:SubjectLanguages/*:SubjectLanguage/*:Language/*:LanguageName"/></td>
		</tr>
		<tr>		
		  <td><b>Material(s):</b></td>
		  <td>
		    <ul>
		      <xsl:for-each select="./*:Materials/*:Material">
			<li>
			  <xsl:value-of select="./*:Domain"/>
			  <xsl:if test="./*:Descriptions/*:Description != ''">
			    <xsl:text>
			      : 
			    </xsl:text>
			    <xsl:value-of select="./*:Descriptions/*:Description"/>
			  </xsl:if>
			</li>
		    </xsl:for-each>
		    </ul>
		  </td>
		</tr>
		<tr>		
		  <td><b>Hypotheses:</b></td>
		  <td>
		    <xsl:value-of select="./*:Hypotheses/*:Hypothesis/*:Descriptions/*:Description"/>
		  </td>
		</tr>
		<!-- much more here -->		
		<tr>
		  <td><b>Method(s):</b></td>
		  <td>
		    <table  border="3" cellpadding="10" cellspacing="10">
		      <tr>
			<td><b>Experiment type:</b></td>
			<td><xsl:value-of select="./*:Method/*:Elicitation//*:ExperimentType"/></td>
		      </tr>
		      <tr>
			<td><b>Elicitation instrument:</b></td>
			<td><xsl:value-of select="./*:Method/*:Elicitation//*:ElicitationInstrument"/></td>
		      </tr>
		      <tr>
			<td><b>Elicitation software:</b></td>
			<td><xsl:value-of select="./*:Method/*:Elicitation//*:ElicitationSoftware"/></td>
		      </tr>
		      <tr>
			<td><b>Variable(s)</b></td>
			<td>
			  <ul>
			    <xsl:for-each select="./*:Method/*:Elicitation/*:Variables/*:Variable">
			      <li>
				<xsl:value-of select="./*:VariableName"/>
				<xsl:if test="./*:VariableType != ''">
				  <xsl:text> (</xsl:text>
				  <xsl:value-of select="./*:VariableType"/>
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
			      <td><xsl:value-of select="./*:Method/*:Participants/*:AnonymizationFlag"/></td>
			    </tr>
			    <tr>
			      <td><b>Sampling method:</b></td>
			      <td><xsl:value-of select="./*:Method/*:Participants/*:SamplingMethod"/></td>
			    </tr>
			    <tr>
			      <td><b>Sampling size:</b></td>
			      <td>
				<xsl:value-of select="./*:Method/*:Participants/*:SampleSize/*:Size"/>
				<xsl:if test="./*:Method/*:Participants/*:SampleSize/*:SizeUnit !=''">
				  <xsl:text> </xsl:text>
				  <xsl:value-of select="./*:Method/*:Participants/*:SampleSize/*:SizeUnit"/>
				</xsl:if>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Sex distribution:</b></td>
			      <td>
				<ul>
				  <xsl:for-each select="./*:Method/*:Participants/*:SexDistribution/*:SexDistributionInfo">
				    <li>
				      <xsl:value-of select="./*:ParticipantSex"/>:<xsl:value-of select="./*:Size"/>
				    </li>
				  </xsl:for-each>
				</ul>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Age distribution:</b></td>
			      <td>
				<xsl:value-of select="./*:Method/*:Participants//*:ParticipantMeanAge"/>
			      </td>
			    </tr>
			    <tr>
			      <td><b>Language variety:</b></td>
			      <td>
				<xsl:value-of select="./*:Method/*:Participants//*:VarietyName"/>:<xsl:value-of select="./*:Method/*:Participants//*:NoParticipants"/>			  
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
		    <xsl:value-of select="./*:Results/*:Descriptions/*:Description"/>
		  </td>
		</tr>
		<tr>		
		  <td><b>Analysis Tool Info:</b></td>
		  <td>
		    <xsl:value-of select="./*:AnalysisToolInfo/*:AnalysisTool"/>
		    <xsl:if test="./*:AnalysisToolInfo/*:ToolType !=''">
		      (<xsl:value-of select="./*:AnalysisToolInfo/*:ToolType"/>)
		    </xsl:if>
		    <xsl:if test="./*:AnalysisToolInfo/*:Version !=''">
		      , Version: <xsl:value-of select="./*:AnalysisToolInfo/*:Version"/>.
		    </xsl:if>				    
		  </td>
		</tr>		
		<tr>
		  <td><b>Type-specific Size info: </b></td>
		  <td><xsl:value-of select="./*:TypeSpecificSizeInfo/*:TypeSpecificSize/*:Size"/></td>
		</tr>	    	    		
		<hr></hr>
	      </xsl:for-each>
	    </tr> 	    
	  </table>
	</p>
      </div>            	      
    </xsl:template>
    
    <xsl:template match="*:ToolContext">
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
              <td><xsl:value-of select="./*:ToolClassification/*:ToolType"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Distribution: </b></td>
              <td><xsl:value-of select="./*:Distribution/*:DistributionType"/></td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Size: </b></td>
              <td>
		<xsl:value-of select="./*:TotalSize/*:Size"/>
		<xsl:value-of select="./*:TotalSize/*:SizeUnit"/>		
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Input(s): </b></td>
              <td>
		<xsl:value-of select="./*:Inputs//*:Description"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Output(s): </b></td>
              <td>
		<xsl:value-of select="./*:Outputs//*:Description"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Implementatation(s): </b></td>
              <td>
		<xsl:value-of select="./*:Implementations//*:ImplementationLanguage"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Install Environment(s): </b></td>
              <td>
		<xsl:value-of select="./*:InstallEnv//*:OperatingSystem"/>
	      </td>	      	      	      
	    </tr>
	    <tr>
	      <td><b>Prerequisite(s): </b></td>
              <td>
		<xsl:value-of select="./*:Prerequisites//*:PrerequisiteName"/>
	      </td>	      	      	      
	    </tr>	    
	    <tr>
	      <td><b>Tech Environment(s): </b></td>
              <td>
		<xsl:value-of select="./*:TechEnv//*:ApplicationType"/>
	      </td>	      	      	      
	    </tr> 	    	    	    	    	    	    
	  </table>
	</p>
      </div>                  
    </xsl:template>

    <xsl:template match="*:SpeechCorpusContext">
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
              <td><xsl:value-of select="./*:Modalities"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Mediatype: </b></td>
              <td><xsl:value-of select="./*:Mediatype"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Speech Corpus: </b></td>
              <td>
		<table  border="3" cellpadding="10" cellspacing="10">
		  <tr>
		    <td><b>Duration (effective speech):</b></td>
		    <td><xsl:value-of select="./*:SpeechCorpus/*:DurationOfEffectiveSpeech"/></td>
		  </tr>
		  <tr>
		    <td><b>Duration (full database):</b></td>
		    <td><xsl:value-of select="./*:SpeechCorpus/*:DurationOfFullDatabase"/></td>
		  </tr>
		  <tr>
		    <td><b>Number of speakers:</b></td>
		    <td><xsl:value-of select="./*:SpeechCorpus/*:NumberOfSpeakers"/></td>
		  </tr>
		  <tr>
		    <td><b>Recording Environment:</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:RecordingEnvironment"/>			  
		    </td>
		  </tr>
		  <tr>
		    <td><b>Speaker demographics:</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:SpeakerDemographics"/>
		    </td>
		  </tr>
		  <tr>
		    <td><b>Quality:</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:Quality"/>			  
		    </td>
		  </tr>
		  <tr>		    
		    <td><b>Recording Platform (hardware):</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:RecordingPlatformHardware"/>			  
		    </td>		    
		  </tr>
		  <tr>		    
		    <td><b>Recording Platform (software):</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:RecordingPlatformSoftware"/>			  
		    </td>		    
		  </tr>
		  <tr>		    
		    <td><b>Speech-technical metadata:</b></td>
		    <td>
		      <xsl:value-of select="./*:SpeechCorpus/*:SpeechTechnicalMetadata"/>			  
		    </td>		    
		  </tr>		      		  
		</table>
	      </td>
	    </tr>
	    <tr>
              <td><b>Multilinguality: </b></td>
              <td><xsl:value-of select="./*:Multilinguality/*:Multilinguality"/></td>
	    </tr>
	    <tr>
              <td><b>Annotation Type(s): </b></td>
              <td><xsl:value-of select=".//*:AnnotationType"/></td>
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select=".//*:LanguageName"/></td>
	    </tr>
	    <tr>
              <td><b>Type-specific Size info: </b></td>
              <td><xsl:value-of select="./*:TypeSpecificSizeInfo//*:Size"/></td>	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>                  	    
    </xsl:template>

    <xsl:template match="*:TextCorpusContext">
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
              <td><xsl:value-of select="./*:CorpusType"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Temporal Classification: </b></td>
              <td><xsl:value-of select="./*:TemporalClassification"/></td>	      	      
	    </tr>	    
	    <tr>
              <td><b>Description(s): </b></td>
              <td><xsl:value-of select=".//*:Description"/></td>	      	      
	    </tr>	    
	    <tr>
              <td><b>Validation: </b></td>
              <td><xsl:value-of select="./*:ValidationGrp//*:Description"/></td>      	      
	    </tr>
	    <tr>
              <td><b>Subject Language(s): </b></td>
              <td><xsl:value-of select="./*:SubjectLanguages//*:LanguageName"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Type-specific Size Info: </b></td>
              <td><xsl:value-of select="./*:TypeSpecificSizeInfo//*:Size"/></td>	      	      
	    </tr>	    	    
	  </table>
	</p>
      </div>                  	          
    </xsl:template>
    
</xsl:stylesheet>
        
