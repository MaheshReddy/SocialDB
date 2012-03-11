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
<br>
<br>
<%
	String user =null;
		Map<String,String> profile=null;
		ArrayList<UserTuple> friends = null;
		ArrayList<Posts> wall = null;
		BuildHomePage hmPg = null;
		Cookie []cookies = request.getCookies();
		if(request.getAttribute("userId")!=null)
	user = request.getAttribute("userId").toString();
		if(user == null)
	user = request.getParameter("userId");
		if(user==null){
	for(int i=0 ; i<cookies.length;i++){
		if(cookies[i].getName().equals("userId"))
		{
			user = cookies[i].getValue();
		break;
		}
	}
		}
		if (user != null) {
	 hmPg = new BuildHomePage(user);
	profile = hmPg.buildPublicProfile();
	friends = hmPg.buildFriends();
	wall = hmPg.buildWall();
	if(profile!=null){
		
	}
	else{
	PrintWriter wrt = response.getWriter();
	wrt.print("Error retriving the value");
	response.sendRedirect("index.jsp");
	}
		} 
		else {
	response.sendRedirect("index.jsp");
		}
%>
<body onload="init()">
	<script type="text/javascript">
		var curLoaded = "pubProfile";
		function toggle(toLoad) {
			var curDiv = document.getElementById(curLoaded);
			var toLoadDiv = document.getElementById(toLoad);
			curDiv.style.display = "none";
			toLoadDiv.style.display = "block";
			curLoaded = toLoad;
		}
	</script>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<div class="row-fluid">
					<div class="span4">
						<a id="home" href="javascript:toggle('pubProfile')">Home</a>
					</div>
				</div>

				<div class="row-fluid">
					<div class="span2">
						<a id="friendsLink" href="javascript:toggle('friends');">Friends</a>
					</div>
				</div>

				<div class="row-fluid">
					<div class="span2">
						<a id="walllink" href="javascript:toggle('wall');">Wall</a>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="span2">
						<a id="frdSearch" href="javascript:toggle('frdSearch');">Friend Finder</a>
					</div>
				</div>
				
				
				
			</div>

			<div class="span10" id="pubProfile" style="display: block"
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
						Iterator<UserTuple> frnItr = friends.iterator();
						PrintWriter wrt = response.getWriter();
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
						}
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
								<td align="right"><form class=""
										action="Login?requestId=commPost&userid=<%=user%>&postid=<%=post.getPostid()%>"
										method="post">
										<input name="commPost" type="text" align="right" /> <input
											name="submit" align="right" type="submit" value="post">
									</form>
								</td>
								</tr>
							</table></td>
					</tr>
					<%
						}
					%>
					
				</table>
			</div>
		</div>
	</div>
</body>
</html>