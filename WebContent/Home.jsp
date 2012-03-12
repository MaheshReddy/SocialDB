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
	
	ArrayList<UserTuple> friends = null;
	ArrayList<UserTuple> usrSearch = null;
	ArrayList<UserTuple> frnRequest = null;
	ArrayList<Posts> wall = null;
	BuildHomePage hmPg = null;
	BuildHomePage loggedInHmPg = null;
	UserTuple usrTplLoggedIn = null;
	UserTuple usrTplCurUsr = null;
	String activeDiv = "pubProfile";
	Cookie[] cookies = request.getCookies();
	
	if (request.getAttribute("userId") != null)
		curUser = request.getAttribute("userId").toString();
	if (curUser == null)
		curUser = request.getParameter("userId");
	
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
	
	if (user != null) {
		loggedInHmPg = new BuildHomePage(loggedInUser);
		hmPg = new BuildHomePage(user);
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
		else if(activeDiv.equals("frndRequest"))
			frnRequest = hmPg.buildFriendRequest();
		
		if (profile != null) {

		} else {
			PrintWriter wrt = response.getWriter();
			wrt.print("Error retriving the value");
			response.sendRedirect("index.jsp");
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
						<a id="frnReqLink" href="Home.jsp?activeDiv=frndRequest">FriendRequests</a>
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
						Iterator<UserTuple> frnItr = friends.iterator();
						while (frnItr.hasNext()) {
							UserTuple frn = frnItr.next();
					%>
					<tr>
						<td><a
							href="Login?requestId=profileLd&userId=<%=frn.getId()%>"> <%=frn.getFname() + " " + frn.getLname()%>
						</a></td>
						<td><%=frn.getEmail()%></td>
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



			<div class="span10" id="frndRequest" style="display: none">
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
						<td><a href="Login?requestId=acceptUser&accpUserId=<%=usr.getId()%>">Accept</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>




			<div class="span10" id="wall" style="display: none">
				<table class="table table-striped table-bordered table-condensed">
				<tr>
						<td><form action="Login?requestId=wallpost&userid=<%=user%>"
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