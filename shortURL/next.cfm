<strong>Next Steps: Once ShortURL is Installed</strong><br /><br />
Most likely you will want to incorporate this code with your application although it is not required.  To integrate with your application take the following steps:

<ol>
	<li>Copy ShortURL.cfc from this directory into your application.</li>
	<li>Copy the onMissingTemplate function from the Application.cfc file in this directory to your base Application.cfc file.</li>
	<li>Modify the createObject line in the onMissingMethod function to point where you copied ShortURL.cfc in step 1</li>
	<li>For help on creating a ShortURL look at the createaURL.cfm file</li>
</ol>

Thats it!