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


    <xsl:template match="/cmde:CMD/cmde:Header">
    <!-- ignore header --> 
    </xsl:template>

    <xsl:template match="/cmde:CMD/cmde:Resources">
    <!-- ignore resources -->
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
              <td><b>PID: </b></td>
              <td><xsl:value-of select="./*:PID"/>
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
              <td><b>Publication Date: </b></td>
              <td><xsl:value-of select="./*:PublicationDate"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr>
              <td><b>Last Update: </b></td>
              <td><xsl:value-of select="./*:LastUpdate"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr id="timeCoverage">
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
              <td><b>Location: </b></td>
              <td><xsl:value-of select="./*:Location/Country/CountryName"/>
	      </td>	      	      	      	      
	    </tr>
	    <tr id="generalInfoDescription">
              <td><b>Description: </b></td>
              <td><xsl:value-of select="./*:Descriptions/Description"/>
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
              <td><b>Funder: </b></td>
              <td><xsl:value-of select="./*:Funder"/></td>
	    </tr>
	    <tr>
              <td><b>Url: </b></td>
              <td><xsl:value-of select="./*:Url"/></td>
	    </tr>
	    <tr>
              <td><b>Institution: </b></td>
              <td>
		<xsl:value-of select="./*:Institution/Department"/>,
		<xsl:value-of select="./*:Institution/Organisation"/>
	      </td>
	    </tr>
	    <tr id="cooperations">
              <td><b>Cooperations: </b></td>
              <td><xsl:value-of select="./*:Cooperation"/></td>	      
	    </tr>
	    <tr id="projectDescriptions">
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select="./*:Description"/></td>	      	      
	    </tr>
	    <tr>
              <td><b>Contact: </b></td>
              <td>
		<xsl:value-of select="./*:Contact/Department"/>,
                <xsl:value-of select="./*:Contact/Address"/>
	      </td>
	    </tr>

	    <tr>
              <td><b>Duration: </b></td>
	      <td>
		<xsl:value-of select="./*:Duration/StartYear"/>-,
		<xsl:value-of select="./*:Duration/EndYear"/>
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
	    <tr>
              <td><b>Publication: </b></td>
	      <td>	      
	      <xsl:for-each select="./*:Publication">
		<xsl:value-of select="./*:Author/*:firstName"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="./*:Author/*:lastName"/>
		<xsl:text>: </xsl:text>
		<em>
		  <xsl:value-of select="./*:PublicationTitle"/>
		</em>
		<xsl:text>PID: </xsl:text>
		<tt>
		  <xsl:value-of select="./*:Author/*:lastName"/>: <xsl:value-of select="./*:resolvablePID"/>
		</tt>
	      </xsl:for-each>
	      </td>
	    </tr>
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
              <td><b>Person(s): </b></td>
	      <td>	      
	      <xsl:for-each select="./*:Creators/*:Person">
		<xsl:value-of select="./*:firstName"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="./*:lastName"/> (<xsl:value-of select="./*:role"/>) 	      
	      </xsl:for-each>
	      </td>		
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
	    <tr>
              <td><b>Documentation Language(s): </b></td>
              <td><xsl:value-of select="./*:Documentation"/></td>	      	      
	    </tr>	    
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
              <td><b>Deployment Info: </b></td>
              <td>
		<xsl:value-of select="./*:DeploymentToolInfo/*:DeploymentTool"/>
		(
		<xsl:value-of select="./*:DeploymentToolInfo/*:Descriptions/*:Description"/>		
		)
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Contact: </b></td>
              <td>
		<xsl:value-of select="./*:Contact/*:firstname"/>
		<xsl:value-of select="./*:Contact/*:lastname"/>		
	      </td>	      
	    </tr>
	    <tr>
              <td><b>Descriptions: </b></td>
              <td><xsl:value-of select="./*:Description"/></td>	      
	    </tr>
	  </table>
	</p>
      </div>      
    </xsl:template>
    
    
    <xsl:template match="*:ResourceProxyListInfo">
      <!-- ignore content, generate About instead -->
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
		<th><h3>Resource-specific information</h3></th>
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
	      <td><b>Headword Type: </b></td>
              <td>
		<xsl:value-of select="./*:HeadwordType/*:LexicalUnit"/>
		(
		<xsl:value-of select="./*:HeadwordType/*:Descriptions/*:Description"/>		
		)
	      </td>	      	      	      
	    </tr> 	    
	  </table>
	</p>
      </div>            
    </xsl:template>
    
    <xsl:template match="*:TextCorpusContext">
    </xsl:template>

    <xsl:template match="*:ExperimentContext/*:ExperimentalStudy">
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
	      <xsl:for-each select="./*:Experiment">
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
		<tr>		
		  <td><b>Subject Language(s):</b></td>
		  <td><xsl:value-of select="./*:SubjectLanguages/*:SubjectLanguage/*:Language/*:LanguageName"/></td>
		</tr>
		<tr>		
		  <td><b>Documentation Language(s):</b></td>
		  <td><xsl:value-of select="./*:DocumentationLanguages/*:DocumentationLanguage/*:Language/*:LanguageName"/></td>
		</tr>
		<tr>		
		  <td><b>Material(s):</b></td>
		  <td>
		    <xsl:value-of select="./*:Materials/*:Material/*:Domain"/>:
		    <xsl:value-of select="./*:Materials/*:Material/*:Descriptions/*:Description"/>
		  </td>
		</tr>
		<tr>		
		  <td><b>Hypotheses:</b></td>
		  <td>
		    <xsl:value-of select="./*:Hypotheses/*:Hypothesis/*:Descriptions/*:Description"/>
		  </td>
		</tr>
		<tr>
		  <td><b>Method(s):</b></td>
		  <td>
		    <xsl:value-of select="./*:Method/*:Elicitation"/>
		  </td>
		</tr>		  
	      </xsl:for-each>
	    </tr> 	    
	  </table>
	</p>
      </div>            	      
    </xsl:template>
    
    <xsl:template match="*:ToolContext">
    </xsl:template>        
</xsl:stylesheet>
        
