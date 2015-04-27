<cfparam name="url.dsn" default="">

<cfif len(url.dsn)>
	<!--- install time --->
	<cfdbinfo datasource="#url.dsn#" type="tables" pattern="shortURL" name="checkInstall">
	<cfif checkInstall.recordCount>
		<cfoutput>shortURL has already been installed for datasource #url.dsn#!</cfoutput>
	<cfelse>
		<cfquery name="createTable" datasource="#url.dsn#" result="variables.res">
		CREATE TABLE shortURL
		(shortString CHAR(6),
			theURL VARCHAR(250),
			createDate DATETIME)
		</cfquery>
		<cfset variables.directory = getDirectoryFromPath(getCurrentTemplatePath())>
		<cfset variables.appCFC = variables.directory & "Application.cfc">
		<cfset variables.content = FileRead(variables.appCFC)>
		<cfset variables.content = ReReplace(variables.content,'<cffunction name="onApplicationStart"><cfset application.dsn = "','<cffunction name="onApplicationStart"><cfset application.dsn = "#url.dsn#')>
		<cfset FileWrite(variables.appCFC,variables.content)>
		<cfset variables.appObj = createObject("component","Application")>
		<cfset variables.appObj.onApplicationStart()>
		<cfoutput><strong>Install successful!</strong><br /><br /><a href="createaURL.cfm">Create a Short URL</a><br /><br /></cfoutput>
		<cfdump var="#variables.res#" label="Create Statement">
	</cfif>
<cfelse>
	<cfoutput><html>
	<head>
		<title>Short URL: Install</title>
	</head>
	<body>
	<strong>Install Short URL</strong>
	<cfform method="get" action="#cgi.SCRIPT_NAME#">
	Datasource: <cfinput type="text" name="dsn" required="true" message="Please enter datasource"><br />
	(Supporting table will be created in this datasource)<br />
	<cfinput type="submit" name="sub" id="sub" validate="submitOnce" value="Install">
	</cfform>
	</body>
	</html></cfoutput>
</cfif>
