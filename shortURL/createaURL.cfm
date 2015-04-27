<cfsetting enablecfoutputonly="true">
<cfoutput><html>
<head>
<title>Short URL</title>
</head>
<body>
</cfoutput>
<cfif structKeyExists(url,"makeURL") && isValid("URL",url.makeURL)>
	<cfset variables.shortObj = createObject("component","ShortURL").init(application.dsn)>
	<cfset variables.shortString = variables.shortObj.make(url.makeURL)>
	<cfoutput><strong>Short URL Made!</strong><br />
	Test: <a href="http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)##variables.shortString#.cfm">http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)##variables.shortString#.cfm</a><br /><br />
	<cfinclude template="next.cfm"></cfoutput>
<cfelse>
	<cfoutput><strong>Create Short URL</strong><br />
	<cfform action="#cgi.SCRIPT_NAME#" method="get" name="createForm">
	URL: <cfinput type="text" validate="URL" validateat="onSubmit" required="true" message="Enter a valid URL" name="makeURL" size="40" value="http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)#target.cfm"><br />
	<cfinput type="submit" name="subURL" id="subURL" value="Make URL">
	</cfform>
	</cfoutput>
</cfif>

<cfoutput>
</body>
</html></cfoutput>