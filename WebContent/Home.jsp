<%@page import="com.db.infra.SipAuthRequest"%>
<%@page import="com.db.infra.Circles"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.db.jdbc.DBManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.db.infra.BuildHomePage"%>
<%@ page import="com.db.infra.UserTuple"%>
<%@ page import="com.db.infra.Posts"%>
<%@ page import="com.db.infra.SIPEntry"%>
<%@ page import="com.db.infra.Circles"%>
<%@ page import="com.db.interfaces.Listable"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
</head>
<%@ include file="title.jsp"%>

<%
	String user = null;
	String curUser = null;
	String loggedInUser = null;
	Map<String, String> profile = null;
	
	ArrayList<Listable> friends = null;
	ArrayList<UserTuple> usrSearch = null;
	ArrayList<UserTuple> frnRequest = null;
	ArrayList<Posts> wall = null;
	ArrayList<SIPEntry> sips = null;
	ArrayList<Circles> circles = null;
	ArrayList<Listable> cirAddList = null;
	
	ArrayList<SipAuthRequest> sipReqs = null;
	
	BuildHomePage hmPg = null;
	BuildHomePage loggedInHmPg = null;
	UserTuple usrTplLoggedIn = null;
	UserTuple usrTplCurUsr = null;
	String authUrl=null;
	String activeDiv = "pubProfile";
	Cookie[] cookies = request.getCookies();
	
	if (request.getAttribute("userId") != null)
		curUser = loggedInUser = request.getAttribute("userId").toString();
	if (curUser == null)
		curUser = loggedInUser =request.getParameter("userId");
	
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().equals("userId")) {
			loggedInUser = cookies[i].getValue();
		}
	}

	if(curUser == null)
		user = curUser = loggedInUser;
	else
		user = curUser;
	
	if (request.getParameter("activeDiv") !=null)
		activeDiv = request.getParameter("activeDiv");
	else{
		if(request.getAttribute("activeDiv")!=null)
			activeDiv = request.getAttribute("activeDiv").toString();
	}
	response.getWriter().println(activeDiv);
	String postType = "requestId=wallpost&userid="+user;	
	if (user != null) {
		loggedInHmPg = new BuildHomePage(loggedInUser);
		loggedInHmPg.setLoggedInUser(loggedInUser);
		hmPg = new BuildHomePage(user);
		hmPg.setLoggedInUser(loggedInUser);
		profile = hmPg.buildPublicProfile();
		usrTplLoggedIn = loggedInHmPg.buildUserHome();
		usrTplCurUsr = hmPg.buildUserHome();
		if(activeDiv.equals("friends"))
			friends = hmPg.buildFriends();
		else if(activeDiv.equals("wall"))
			wall = hmPg.buildWall();
		else if (activeDiv.equals("usrSearch")) 
			usrSearch = hmPg.buildFriendSearch(request
					.getParameter("searchName"));
		
		else if(activeDiv.equals("frnAuthRequest"))
		{
			frnRequest = loggedInHmPg.buildFriendRequest();
			authUrl= "Login?requestId=acceptUser";
		}

		else if(activeDiv.equals("sipAuthRequest"))
		{
			sipReqs = loggedInHmPg.buildSipRequest();
			authUrl= "Login?requestId=acceptSipUser";
		}
		
		else if(activeDiv.equals("sipList"))
			sips = loggedInHmPg.buildSips();
		
		else if(activeDiv.equals("searchSip")){
			sips = loggedInHmPg.searchSip(request.getParameter("searchSipName"));
			activeDiv = "sipList";
		}
			
		else if(activeDiv.equals("sipLd"))
		{
			wall = hmPg.buildSipPage(request.getParameter("sipPageId"));
			activeDiv = "wall";
			postType = "requestId=sipPost&sipPageId="+request.getParameter("sipPageId");
		}
		else if(activeDiv.equals("circles")){
			circles = loggedInHmPg.buildCircles();
			cirAddList = loggedInHmPg.buildFriends();
		}

	} else {
		response.sendRedirect("index.jsp");
	}
%>
<script type="text/javascript">
	var curLoaded = "home";
	
	function init() {
		curLoaded = "<%=activeDiv%>";
		var div1 = document.getElementById(curLoaded);
		div1.style.display = "block";
		
	}
	
	function toggle(toLoad) {
		var curDiv = document.getElementById(curLoaded);
		var toLoadDiv = document.getElementById(toLoad);
		curDiv.style.display = "none";
		toLoadDiv.style.display = "block";
		curLoaded = toLoad;
	}
	function post_to_url(path, params, method) {
	    method = method || "post"; // Set method to post by default, if not specified.

	    // The rest of this code assumes you are not using a library.
	    // It can be made less wordy if you use one.
	    var form = document.createElement("form");
	    form.setAttribute("method", method);
	    form.setAttribute("action", path);

	    for(var key in params) {
	        if(params.hasOwnProperty(key)) {
	            var hiddenField = document.createElement("input");
	            hiddenField.setAttribute("type", "hidden");
	            hiddenField.setAttribute("name", key);
	            hiddenField.setAttribute("value", params[key]);

	            form.appendChild(hiddenField);
	         }
	    }

	    document.body.appendChild(form);
	    form.submit();
	}

	
	function frnAction(action,Id){
		var param = new Array();
		param["requestId"]=action;
		param["rmUserId"]=Id;
		post_to_url("Login", param, "post");
	}
	
	function circleAction(action,usrId,cirId){
		var param = new Array();
		param['requestId'] = action;
		param['actUsrId'] = usrId;
		param['actCrcId'] = cirId;
		post_to_url("Login", param, "post");
	}
	
	function sipAction(action,sipId){
		var param = new Array();
		param['requestId'] = action;
		param['sipId'] = sipId;
		post_to_url("Login",param,"post");
	}
	
	function sipRmuser(action,sipId,userid){
		var param = new Array();
		param['requestId'] = action;
		param['sipId'] = sipId;
		param['sipRmUsrId'] = userid;
		post_to_url("Login",param,"post");
	}
</script>

<body onload="init()">

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
			
			
				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="friendsLink" href="javascript:toggle('friends');">Friends</a> --> 
						<a id="friendsLink" href="Home.jsp?activeDiv=home">Home</a>
					</div>
				</div>
			
			
				<div class="row-fluid">
					<div class="span4">
						<a id="home" href="Home.jsp?activeDiv=pubProfile">Profile</a>
					</div>
				</div>

				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="friendsLink" href="javascript:toggle('friends');">Friends</a> --> 
						<a id="friendsLink" href="Home.jsp?activeDiv=friends&userId=<%= user %>">Friends</a>
					</div>
				</div>

				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="walllink" href="javascript:toggle('wall');">Wall</a> -->
						<a id="walllink" href="Home.jsp?activeDiv=wall&userId=<%= user %>">Wall</a>
					</div>
				</div>
				
				
				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="frdLink" href="javascript:ajaxpage('friendSearch.jsp','frdSearch');">FriendFinder</a> -->
						<a id="sipListlink" href="Home.jsp?activeDiv=sipList">Sips</a>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="frdLink" href="javascript:ajaxpage('friendSearch.jsp','frdSearch');">FriendFinder</a> -->
						<a id="sipListlink" href="Home.jsp?activeDiv=circles">Circles</a>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="frdLink" href="javascript:ajaxpage('friendSearch.jsp','frdSearch');">FriendFinder</a> -->
						<a id="frnReqLink" href="Home.jsp?activeDiv=frnAuthRequest">FriendRequests</a>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="span2">
						<!-- <a id="frdLink" href="javascript:ajaxpage('friendSearch.jsp','frdSearch');">FriendFinder</a> -->
						<a id="sipAuthLink" href="Home.jsp?activeDiv=sipAuthRequest">SipRequests</a>
					</div>
				</div>
				
				
			</div>
			<div class="span10" id="frdSearch" style="display: none" align="justify">

				<form class="well form-search" action="Home.jsp" method="post">
					<input name="searchName" id="name" type="text" class="input-medium search-query"/>
						<input name="activeDiv" type="hidden" value="usrSearch"/>
						<input name="requestId" type="hidden" value="searchPpl"/>
					<button class="btn" type="submit">Search</button>
				</form>
			</div>


			<div class="span10" id="home" style="display: block" align="justify">

				<h3> Welcome <%= usrTplLoggedIn.getFname() + " "+usrTplLoggedIn.getLname() %>.
				Showing profile of <%= usrTplCurUsr.getFname()+" "+usrTplCurUsr.getLname() %></h1>
			</div>


			
			<div class="span10" id="pubProfile" style="display: none"
				align="justify">
				<!--Body content-->
				<table class="table table-striped">
					<tr>
						<td>Name<br> <%=profile.get("fname") + " " + profile.get("lname")%>
						</td>
						<td>Sex:<br> <%=profile.get("sex")%></td>
						<td>DOB:<br> <%=profile.get("dob")%></td>
						<td>Email:<br> <%=profile.get("email")%></td>
						<td>Telephone:<br> <%=profile.get("tele")%></td>
						<td>Address:<br> <%=profile.get("addr") + " " + profile.get("city") + " "
					+ profile.get("state") + " " + profile.get("zip")%>
						</td>
					</tr>
				</table>
			</div>

			<div class="span10" id="friends" style="display: none">
				<table class="table table-striped">
					<%
						if(friends!=null){
						Iterator<Listable> frnItr = friends.iterator();
						while (frnItr.hasNext()) {
							Listable frn = frnItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=frn.getId()%>"> <%=frn.getFieldOne()%>
						</a></td>
						<td><%=frn.getFieldTwo()%></td>
						<% if (curUser.equals(loggedInUser)){ %>
						<td>
						<select>
						<option onclick="javaScript:frnAction('unfriend','<%=frn.getId()%>')">UnFriend</option>
						</select>
						</td>
						<%} %>
					</tr>
					<%
						}}
					%>
					<tr>
					<td>
				<form  action="Home.jsp" method="post">
					<input name="searchName" id="name" type="text" class="input-medium search-query"/>
						<input name="activeDiv" type="hidden" value="usrSearch"/>
						<input name="requestId" type="hidden" value="searchPpl"/>
					<button class="btn" type="submit">Search</button>
				</form>
					
					</td>
					</tr>
				</table>
			</div>



			<div class="span10" id="circles" style="display: none">
				<table class="table table-striped">
				<tr>
					<td> 
					<form action="Login?requestId=createCircle" method="post">
					<input type="text" id="cirName" name="circleName" value="newCircle"/>
					<input type="submit" value="create"/>
					</form>
					</td>
					</tr>
					<%
						if(circles!=null){
						Iterator<Circles> crcItr = circles.iterator();
						while (crcItr.hasNext()) {
							Circles crc = crcItr.next();
					%>
					<tr>
					<td>
					<h4> <%=crc.getCircleName() %></h4>
					</td>
					<td> Add:
					<% if(cirAddList!=null){
						Iterator<Listable> cirListIter = cirAddList.iterator();
						%>
						<select>
						<% while(cirListIter.hasNext()){
							Listable cirListUsr = cirListIter.next(); %>
						
						<option onclick="javascript:circleAction('addToCircle','<%=cirListUsr.getId()%>','<%=crc.getCircleId()%>')"><%=cirListUsr.getFieldOne()%></option>
						
					
					<%}%>
					</select>
					<%} %>
						
					</td>
					</tr>
					<%if (crc.getCirMembers()!=null){  
					Iterator<Listable> memItr = crc.getCirMembers().iterator();
					while(memItr.hasNext()){
					   Listable mem = memItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=mem.getId()%>"> <%=mem.getFieldOne()%>
						</a></td>
						<td><%=mem.getFieldTwo()%></td>
						<td>
						<select>
						<option onclick="javascript:circleAction('removeFromCircle','<%=mem.getId()%>','<%=crc.getCircleId()%>')">Remove</option>
						</select>
						</td>
					</tr>
					<%
						}}}}
					%>
					
			</table>
			</div>



			<div class="span10" id="sipList" style="display: none">
				<table class="table table-striped">
									<tr>
						<td>
							<form action="Home.jsp" method="post">
								<input name="searchSipName" id="sipName" type="text"
									class="input-medium search-query" />
								<input name="activeDiv"
									type="hidden" value="searchSip" /> 
								<button class="btn" type="submit">Search</button>
							</form>
							</td>
					<td>
							<form action="Login" method="post">
								<input name="newSip" id="newSipName" type="text"
									class="input-medium search-query" />
								<input name="requestId"
									type="hidden" value="newSIP" />
								<button class="btn" type="submit">New</button>
							</form>
							</td>
					</tr>
				
					<%
						if (sips != null) {
							Iterator<SIPEntry> sipItr = sips.iterator();
							while (sipItr.hasNext()) {
								SIPEntry sip = sipItr.next();
					%>
					<tr>
						<% if(sip.isMember()){%>
						<td>
						<a href="Home.jsp?activeDiv=sipLd&sipPageId=<%=sip.getSipPageid()%>"> <%=sip.getSipName()%></a>
						</td>
							<%}else{ %>
							<td>
							<%=sip.getSipName()%>
							</td>
							<td>
							<select>
							<option onclick="javascript:sipAction('joinSIP','<%=sip.getSipId()%>')">Join</option>
							</select>
							</td>
							<%} %>
						<% if(sip.isModerator())
						{
							%>
							<td>
							<select>
							<option onclick="javascript:sipAction('deleteSIP','<%=sip.getSipId()%>')">Delete</option>
							</select>
							</td>
							<td>
							<select>
							<%
							if(sip.getMembers()!=null){
							Iterator<UserTuple> memItr = sip.getMembers().iterator();
							while(memItr.hasNext())
							{
								UserTuple mem = memItr.next();
						%>
						<option onclick="javascript:sipRmuser('sipRmUsr','<%=sip.getSipId()%>','<%=mem.getId()%>')">'<%=mem.getFieldOne()%>'</option>
						<%}} %>
						</select>
						</td>
						<%} %>
					</tr>
					<%
						}
						}
					%>
				</table>
			</div>





			<div class="span10" id="usrSearch" style="display: none">
				<table class="table table-striped">
					<%
						if(usrSearch!=null){
						Iterator<UserTuple> usrItr = usrSearch.iterator();
						while (usrItr.hasNext()) {
							UserTuple usr = usrItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=usr.getId()%>"> <%=usr.getFname() + " " + usr.getLname()%>
						</a></td>
						<td><%=usr.getEmail()%></td>
						<td><a href="Login?requestId=addUser&addUserId=<%=usr.getId()%>">Add</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>



			<div class="span10" id="frnAuthRequest" style="display: none">
				<table class="table table-striped">
					<%
						if(frnRequest!=null){
						Iterator<UserTuple> reqItr = frnRequest.iterator();
						while (reqItr.hasNext()) {
							UserTuple usr = reqItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=usr.getId()%>"> <%=usr.getFname() + " " + usr.getLname()%>
						</a></td>
						<td><%=usr.getEmail()%></td>
						<td><a href="<%=authUrl%>&accpUserId=<%=usr.getId()%>">Accept</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>

			<div class="span10" id="sipAuthRequest" style="display: none">
				<table class="table table-striped">
					<%
						if(sipReqs!=null){
						Iterator<SipAuthRequest> reqItr = sipReqs.iterator();
						while (reqItr.hasNext()) {
							SipAuthRequest req = reqItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=req.getUser().getId()%>"> <%=req.getUser().getFname() + " " + req.getUser().getLname()%>
						</a></td>
						<td><%=req.getUser().getEmail()%></td>
						<td><a href="<%=authUrl%>&accpUserId=<%=req.getUser().getId()%>&sipId=<%=req.getSip().getSipId()%>">Accept</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>




			<div class="span10" id="wall" style="display: none">
				<table class="table table-striped table-bordered table-condensed">
				<tr>
						<td><form action="Login?<%=postType%>"
								method="post">
								<input name="wallpost" type="text" /> <input name="submit"
									type="submit" value="post">
							</form>
						</td>
					</tr>
					<%
					if(wall!=null){
						Iterator<Posts> itrPosts = wall.iterator();
						while (itrPosts.hasNext()) {
							Posts post = itrPosts.next();
							ArrayList<Posts> comments = hmPg
									.buildComments(post.getPostid());
							Iterator<Posts> itrComm = comments.iterator();
					%>
					<tr>
						<td><%=post.getContent()%></td>
						<td><a
							href="Login?requestId=profileLd&userId=<%=post.getAuthor()%>">
								<%=post.getAuthorFname() + "\t" + post.getAuthorLname()%></a>
						</td>
						<td><%=post.getPostDate()%></td>
						<td><%=post.getPostTime()%></td>
						<% 
							if(post.getModifiable())
							{
						%>
						<td>
						    <a class="close" href="Login?requestId=deletePost&postId=<%=post.getPostid()%>">&times;</a>
						</td>
						<%} %>
					</tr>
					<tr>
						<td align="right">
							<table class="table table-condensed">
								<tr>
									<td align="right">Comments:</td>
									<td>
										<%
											while (itrComm.hasNext()) {
													Posts comm = itrComm.next();
										%>
									
								<tr>
								<td><%=comm.getContent()%></td>
									<td><a
										href="Login?requestId=profileLd&userId=<%=comm.getAuthor()%>">
											<%=comm.getAuthorFname() + "\t"
							+ comm.getAuthorLname()%></a>
									</td>
									<td><%=comm.getPostDate()%></td>
									<td><%=comm.getPostTime()%></td>
								</tr>
								<%
									}
								%>

								</td>
								</tr>
								<td align="right"><form action="Login?requestId=commPost&userId=<%=user%>&postId=<%=post.getPostid()%>"
										method="post">
										<input name="commPost" type="text" align="right" /> <input
											name="submit" align="right" type="submit" value="post">
									</form>
								</td>
								</tr>
							</table></td>
					</tr>
					<%
						}}
					%>
					
				</table>
			
			</div>
			
		</div>
	</div>
	<script type="text/javascript">
	init();
</script>
</body>
</html>