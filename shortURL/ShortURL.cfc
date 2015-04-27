<cfcomponent output="false">
<!--- ShortURL
Author: Sam Farmer, Late 2007
URLs: http://shorturl.riaforge.org/
	http://samfarmer.com
 --->
<cffunction name="init" access="public" output="false" hint="">
	<cfargument name="dsn" required="true" hint="">
	<cfset variables.dsn = arguments.dsn>
	<cfreturn this>
</cffunction>

<cffunction name="make" access="public" output="false" hint="I make a short URL">
	<cfargument name="theURL" required="true" hint="I am a full URL">
	<cfset var arLetNum = ["0","1","2","3","4","5","6","7","8","9","q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"]>
	<cfset var i = 0>
	<cfset var gotUnique = false>
	<cfset var shortString = "">
	<cfloop condition="gotUnique neq true">
		<cfloop from="1" to="6" index="i">
			<cfset shortString &= arLetNum[RandRange(1,36)]>
		</cfloop>
		<cfquery name="UniqueSelect" datasource="#variables.dsn#">
		SELECT shortString
		FROM shortURL
		WHERE shortString = <cfqueryparam value="#shortString#">
		</cfquery>
		<cfif UniqueSelect.recordCount eq 0>
			<cfset gotUnique = true>
			<cfquery name="URLInsert" datasource="#variables.dsn#">
			INSERT INTO shortURL
			(shortString,
			theURL,
			createDate)
			VALUES
			(<cfqueryparam value="#shortString#">,
			<cfqueryparam value="#arguments.theURL#">,
			now())
			</cfquery>
		</cfif>
	</cfloop>
	<cfreturn shortString>
</cffunction>

<cffunction name="getFullURL" access="public" output="false" hint="I return the full URL">
	<cfargument name="shortString" required="true" hint="I am a short string">
	<cfquery name="URLSelect" datasource="#variables.dsn#">
	SELECT theURL
	FROM shortURL
	WHERE shortString = <cfqueryparam value="#arguments.shortString#">
	</cfquery>
	<cfreturn URLSelect.theURL> 
</cffunction>

</cfcomponent>