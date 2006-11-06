<cfsetting enablecfoutputonly=true>
<!---
	Name         : pagination.cfm
	Author       : Raymond Camden 
	Created      : June 02, 2004
	Last Updated : November 3, 2006
	History      : New link for reply (rkc 3/28/05)
				   Updated link for reply (rkc 6/17/05)
				   Change rereplace to rereplace (rkc 7/12/05)
				   Change to show subscribe button (rkc 7/29/05)
				   Added & in variable being sent to ref (rkc 10/28/05)
				   alt fix (rkc 11/3/06)
	Purpose		 : 
--->

<!--- Number of items per page and tracker variable. --->

<!--- used to determine if we show thread buttons --->
<cfparam name="attributes.mode" default="na">

<!--- what page am I on? --->
<cfparam name="url.page" default=1>
<cfif not isNumeric(url.page) or url.page lte 0>
	<cfset url.page = 1>
</cfif>

<!--- how many pages do I have? --->
<cfparam name="attributes.pages">


<cfoutput>
<table width="100%">
	<!--- Initial row has buttons for new topic, reply, but only in thread mode --->
	<tr>
		<td>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr valign="top">
				<td>
				<cfif attributes.mode is "threads" or attributes.mode is "messages">
				<a href="newpost.cfm?forumid=#request.forum.id#"><img src="images/btn_new_topic.gif" width="71" height="19" alt="New Topic" title="New Topic" border="0"></a>
					<cfif attributes.mode is "messages">
						<cfif not request.udf.isLoggedOn()>
							<cfset thisPage = cgi.script_name & "?" & cgi.query_string & "&##newpost">
							<cfset link = "login.cfm?ref=#urlEncodedFormat(thisPage)#">
							<a href="#link#"><img src="images/btn_reply.gif" width="52" height="19" alt="Reply" title="Reply" border="0"></a>
						<cfelse>
							<a href="##newpost"><img src="images/btn_reply.gif" width="52" height="19" alt="Reply" title="Reply" border="0"></a>
						</cfif>
					</cfif>
				</cfif>
				<cfif request.udf.isLoggedOn() and attributes.mode is not "na">
					<a href="profile.cfm?#cgi.query_string#&s=1"><img src="images/btn_subscribe.gif" width="73" height="19" alt="Subscribe" title="Subscribe" border="0"></a>
				</cfif>
				&nbsp;
				</td>
				<td align="right">
				<cfset qs = reReplaceNoCase(cgi.query_string,"\&*page=[^&]*","")>
				<cfif url.page is 1>
				<img src="images/arrow_left_grey.gif" alt="Previous Page" width="17" height="17" align="absmiddle">
				<cfelse>
				<a href="#cgi.script_name#?#qs#&page=#url.page-1#"><img src="images/arrow_left_active.gif" alt="Previous Page" width="17" height="17" border="0" align="absmiddle"></a>
				</cfif>
				<span class="pageText">&nbsp;Page: 
				<cfloop index="x" from=1 to="#attributes.pages#">
					<cfif url.page is not x><a href="#cgi.script_name#?#qs#&page=#x#">#x#</a><cfelse>#x#</cfif>
				</cfloop>
				&nbsp;</span>
				<cfif url.page is attributes.pages>
				<img src="images/arrow_right_grey.gif" alt="Next Page" width="17" height="17" align="absmiddle">
				<cfelse>
				<a href="#cgi.script_name#?#qs#&page=#url.page+1#"><img src="images/arrow_right_active.gif" alt="Next Page" width="17" height="17" border="0" align="absmiddle"></a>
				</cfif>				
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly=false>

<cfexit method="EXITTAG">