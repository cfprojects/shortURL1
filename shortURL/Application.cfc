<cfcomponent output="false">
<cfset this.name = "ShortURLInstall">
<cfset this.ApplicationTimeOut = createTimeSpan(0,2,0,0)>

<cffunction name="onApplicationStart"><cfset application.dsn = "blogcfc"></cffunction>

<cffunction name="onMissingTemplate" returnType="boolean" output="true">
	<cfargument name="targetPage" default="" hint="">
	<!--- ShortURL Code --->
	<cfset var shortObj = createObject("component","ShortURL").init(application.dsn)>
	<cfset var theURL = "">
	<cfset var shortString = ReReplace(arguments.targetPage,"\..*","","all")>
	<cfset shortString = ReReplace(shortString,".*/","","all")>
	<cfset theURL = shortObj.getFullURL(shortString=shortString)>
	<cfif len(theURL)>
		<cfoutput><html><head>
		<meta http-equiv="refresh" content="0;url=#theURL#"> 
		</head></html>
		</cfoutput>
	<cfelse>
		<cfoutput>Page #arguments.targetPage# Not Found</cfoutput>
	</cfif>
	<cfreturn true>
	<!--- End ShortURL code --->
</cffunction>
</cfcomponent>