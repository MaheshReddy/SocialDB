<%@page import="com.db.interfaces.SQLResult"%>
<%@page import="com.db.infra.Message"%>
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
	
	String msgSubject="Subject";
	String msgRecv="Receiver List";
	
	Map<String, String> profile = null;
	
	ArrayList<UserTuple> friends = null;
	ArrayList<UserTuple> usrSearch = null;
	ArrayList<UserTuple> frnRequest = null;
	ArrayList<Posts> wall = null;
	ArrayList<SIPEntry> sips = null;
	ArrayList<Circles> circles = null;
	ArrayList<UserTuple> cirAddList = null;
	ArrayList<Message> msgs  = null;
	SQLResult rsl = null;
	
	ArrayList<SipAuthRequest> sipReqs = null;
	
	BuildHomePage hmPg = null;
	BuildHomePage loggedInHmPg = null;
	UserTuple usrTplLoggedIn = null;
  	UserTuple usrTplCurUsr = null;
	String authUrl=null;
	String activeDiv = "home";
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
	//response.getWriter().println(activeDiv);
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
		else if(activeDiv.equals("msgList"))
			msgs = loggedInHmPg.buildMsgList();
		else if(activeDiv.equals("msgCompose")){
			if(request.getParameter("msgSub")!=null)
			msgSubject = "Re:"+request.getParameter("msgSub");
			if(request.getParameter("msgRecv")!=null)
			msgRecv = request.getParameter("msgRecv");
			
		}
		else if(activeDiv.equals("adminResult")){
			 rsl = loggedInHmPg.buildAdminReport(request);
			 activeDiv="adminResult";
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
		param['activeDiv'] = curLoaded;
		post_to_url("Login", param, "post");
	}
	
	function circleAction(action,usrId,cirId){
		var param = new Array();
		param['requestId'] = action;
		param['actUsrId'] = usrId;
		param['actCrcId'] = cirId;
		param['activeDiv'] = curLoaded;
		post_to_url("Login", param, "post");
	}
	
	function sipAction(action,sipId){
		var param = new Array();
		param['requestId'] = action;
		param['sipId'] = sipId;
		param['activeDiv'] = curLoaded;
		post_to_url("Login",param,"post");
	}
	
	function sipRmuser(action,sipId,userid){
		var param = new Array();
		param['requestId'] = action;
		param['sipId'] = sipId;
		param['sipRmUsrId'] = userid;
		param['activeDiv'] = curLoaded;
		post_to_url("Login?",param,"post");
	}
</script>

<body onload="init()">

    <div class="navbar ">
    <div class="navbar-inner">
    <div class="container-fluid">
    <a class="brand" href="Home.jsp?Home">Social DB</a>
    <div class="nav-collapse">
    <ul class="nav">
    <li><a href="Home.jsp?activeDiv=msgList">Mail</a>
    <li><a href="Home.jsp?activeDiv=sipList">Sip</a></li>
    <li><a href="Home.jsp?activeDiv=circles">Circles</a></li>
    <li>
    <a   href="Home.jsp?activeDiv=frnAuthRequest">Friend Requests</a>
    </li>
    <li><a href="Home.jsp?activeDiv=sipAuthRequest">SIP Requests</a></li>
    <li><a href="Home.jsp?activeDiv=admin">Admin</a></li>
    </ul>
    <p class="navbar-text pull-right"><a href="Login?requestId=logout">Logout</a></p>
    </div>
    </div>
    </div>
    </div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
			 <div class="well sidebar-nav">
			<ul class="nav nav-pills nav-stacked" >
			<li><a href="Home.jsp?activeDiv=pubProfile&userId=<%=curUser%>">Profile</a></li>
			<li>
			<a id="friendsLink" href="Home.jsp?activeDiv=friends&userId=<%= user %>">Friends</a></li>
			<li><a id="walllink" href="Home.jsp?activeDiv=wall&userId=<%= user %>">Wall</a></li>
			<li><a>Ads</a></li>
			</ul>
			<ul class="thumbnails">
					<li class="span2"><a href="Login?requestId=buyAd&item=33331" class="thumbnail"> <img
							src="http://www.mbusa.com/vcm/MB/DigitalAssets/CurrentOffers/Redesign_UXP2/2012-C250-Sport-Sedan.jpg" alt=""> </a></li>
							<li class="span2"><a href="Login?requestId=buyAd&item=33332" class="thumbnail"> <img
							src="http://www.hillcity-comics.com/tshirts/Superman_symbol.jpg" alt=""> </a></li>
							<li class="span2"><a href="#" class="thumbnail"> <img
							src="https://netflix.hs.llnwd.net/e1/us/layout/headers/logos/nf_logo.png" alt=""> </a></li>
							<li class="span2"><a href="#" class="thumbnail"> <img
							src="https://www.google.com/images/srpr/logo3w.png" alt=""> </a></li>
							<li class="span2"><a href="#" class="thumbnail"> <img
							src="http://placehold.it/180x100" alt=""> </a></li>
							<li class="span2"><a href="#" class="thumbnail"> <img
							src="http://placehold.it/180x100" alt=""> </a></li>
				</ul>

			</div>
			</div>
			
			<div class="span9" id="home" style="display: none" align="justify">
				<div class="hero-unit">
				<table>
				<tr>
				<td>
				<ul class="thumbnails">
					<li class="span3"><a href="#" class="thumbnail"> <img
							src="<%=profile.get("avatar") %>" alt=""> </a></li>
				</ul>
				</td>
				<td>
				<table class="table table-striped">
					<tr>
						<td><%=profile.get("fname") +" "+ profile.get("lname")%>
						</td>
						</tr>
						<tr>
						<td>DOB:<%=profile.get("dob")%></td>
						</tr>
						<tr>
						<td>Email:<br> <%=profile.get("email")%></td>
						</tr>
						<tr>
						<td>Telephone:<br> <%=profile.get("tele")%></td>
						</tr>
						<tr>
						<td>Address:<br> <%=profile.get("addr") + " " + profile.get("city") + " "
					+ profile.get("state") + " " + profile.get("zip")%>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				</table>
			</div>
			</div>


			
			<div class="span9" id="pubProfile" style="display: none"
				align="justify">
				<!--Body content-->
				<table>
				<tr>
				<td>
				<ul class="thumbnails">
					<li class="span3"><a href="#" class="thumbnail"> <img
							src="<%=profile.get("avatar") %>" alt=""> </a></li>
				</ul>
				</td>
				<td>
				<table class="table table-striped">
					<tr>
						<td><%=profile.get("fname") +" "+ profile.get("lname")%>
						</td>
						</tr>
						<tr>
						<td>DOB:<%=profile.get("dob")%></td>
						</tr>
						<tr>
						<td>Email:<br> <%=profile.get("email")%></td>
						</tr>
						<tr>
						<td>Telephone:<br> <%=profile.get("tele")%></td>
						</tr>
						<tr>
						<td>Address:<br> <%=profile.get("addr") + " " + profile.get("city") + " "
					+ profile.get("state") + " " + profile.get("zip")%>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				</table>
			</div>

			<div class="span9" id="friends" style="display: none">
				<table class="table table-striped">
					<%
						if(friends!=null){
						Iterator<UserTuple> frnItr = friends.iterator();
						while (frnItr.hasNext()) {
							UserTuple frn = frnItr.next();
					%>
					<tr>
					<td>
					<ul class="thumbnails">
					<li class="span1"><a href="#" class="thumbnail"> <img
							src="<%=frn.getAvatar()%>" alt=""> </a></li>
				</ul>
					</td>
						<td><a
							href="Home.jsp?activeDiv=pubProfile&userId=<%=frn.getId()%>"> <%=frn.getFieldOne()%>
						</a></td>
						<td><%=frn.getFieldTwo()%></td>
						<% if (curUser.equals(loggedInUser)){ %>
						<td>
						<button class="btn btn-danger" onclick="javaScript:frnAction('unfriend','<%=frn.getId()%>')">UnFriend</button>
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




			<div class="span9" id="msgList" style="display: none">
				<table class="table table-striped">
				<tr>
				<td><h3>Inbox</h3></td>
				<td><a class="btn" href="Home.jsp?activeDiv=msgCompose">Compose</a></td>
				</tr>
					<%
						if(msgs!=null){
						Iterator<Message> msgItr = msgs.iterator();
						while (msgItr.hasNext()) {
							Message msg = msgItr.next();
					%>
					<tr>
						<td><a
							href="Home.jsp?activeDiv=pubProfile&userId=<%=msg.getSender().getId()%>"> <%=msg.getSender().getFname()+" "+msg.getSender().getLname()%>
						</a></td>
						<td><%=msg.getSubject()%></td>
						<td><%=msg.getDate() %></td>
						<td>
						<a class="btn" href="Home.jsp?activeDiv=msgCompose&msgSub=<%=msg.getSubject()%>&msgRecv=<%=msg.getSender().getEmail()%>">Reply</a>
						</td>
						<td>
						<a class="close" href="Login?requestId=deleteMsg&msgId=<%=msg.getMsgId()%>&usrEmail=<%=loggedInHmPg.getUserTuple().getEmail()%>">&times;</a>
						</td>
					</tr>
					<tr>
					<td><%=msg.getContent() %></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>

			<div class="span9" id="msgCompose" style="display:none">
			<form class="well" action="Login" method="post">
			<input name="requestId" value="composeMsg" type="hidden">
			<input name="senderEmail" value="<%=loggedInHmPg.getUserTuple().getEmail() %>" type="hidden">
			<table>
			<tr>
			<td>
			 	<label>To:</label>
			 	<input class="span3" type="text" name="receiverList" value="<%= msgRecv%>"/>
			 	</tr>
			 	<tr>
			 	<td>
			 	<label>Subject:</label>
			 	<input type="text" name="subject" value="<%=msgSubject%>"/></td>
			 	</tr>
			 	<tr>
			 	<td>
			 	<label>Message:</label>
			 	<input class="span4" type="text" class="input-xlarge" name= "content" /></td>
			 	</tr>
			 	<tr>
			 	<td>
			 	<input type="submit" value="send">
			 	</td>
			 	</tr>
			 	</table> 
			</form>
			</div>

			<div class="span9" id="circles" style="display: none">
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
						Iterator<UserTuple> cirListIter = cirAddList.iterator();
						%>
						<select>
						<% while(cirListIter.hasNext()){
							UserTuple cirListUsr = cirListIter.next(); %>
						
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
							href="Home.jsp?activeDiv=pubProfile&userId=<%=mem.getId()%>"> <%=mem.getFieldOne()%>
						</a></td>
						<td><%=mem.getFieldTwo()%></td>
						<td>
						<button class="btn btn-danger" onclick="javascript:circleAction('removeFromCircle','<%=mem.getId()%>','<%=crc.getCircleId()%>')">Remove</button>
						</td>
					</tr>
					<%
						}}}}
					%>
					
			</table>
			</div>



			<div class="span9" id="sipList" style="display: none">
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





			<div class="span9" id="usrSearch" style="display: none">
				<table class="table table-striped">
					<%
						if(usrSearch!=null){
						Iterator<UserTuple> usrItr = usrSearch.iterator();
						while (usrItr.hasNext()) {
							UserTuple usr = usrItr.next();
					%>
					<tr>
					<td>
					<ul class="thumbnails">
					<li class="span1"><a href="#" class="thumbnail"> <img
							src="<%=usr.getAvatar()%>" alt=""> </a></li>
				</ul>
				</td>
						<td><a
							href="Home.jsp?activeDiv=pubProfile&userId=<%=usr.getId()%>"> <%=usr.getFname() + " " + usr.getLname()%>
						</a></td>
						<td><%=usr.getEmail()%></td>
						<td><a href="Login?requestId=addUser&addUserId=<%=usr.getId()%>">Add</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>



			<div class="span9" id="frnAuthRequest" style="display: none">
				<table class="table table-striped">
					<%
						if(frnRequest!=null){
						Iterator<UserTuple> reqItr = frnRequest.iterator();
						while (reqItr.hasNext()) {
							UserTuple usr = reqItr.next();
					%>
					<tr>
						<td><a
							href="Home.jsp?activeDiv=pubProfile&userId=<%=usr.getId()%>"> <%=usr.getFname() + " " + usr.getLname()%>
						</a></td>
						<td><%=usr.getEmail()%></td>
						<td><a href="<%=authUrl%>&activeDiv=<%=activeDiv%>&accpUserId=<%=usr.getId()%>">Accept</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>

			<div class="span9" id="sipAuthRequest" style="display: none">
				<table class="table table-striped">
					<%
						if(sipReqs!=null){
						Iterator<SipAuthRequest> reqItr = sipReqs.iterator();
						while (reqItr.hasNext()) {
							SipAuthRequest req = reqItr.next();
					%>
					<tr>
						<td><a
							href="Home.jsp?activeDiv=pubProfile&userId=<%=req.getUser().getId()%>"> <%=req.getUser().getFname() + " " + req.getUser().getLname()%>
						</a></td>
						<td><%=req.getUser().getEmail()%></td>
						<td><a href="<%=authUrl%>&activeDiv=<%=activeDiv%>&accpUserId=<%=req.getUser().getId()%>&sipId=<%=req.getSip().getSipId()%>">Accept</a></td>
					</tr>
					<%
						}}
					%>
				</table>
			</div>

			<div class="span9" id="adminResult" style="display: none">
				<% if(rsl!=null){ 
					ResultSet rslSet = rsl.getRslSet();
					int cols = rsl.getCols();
				%>
				<table class="table table-bordered">
					<% while(rslSet.next()){
					%>
					<tr>
						<% for(int i=1;i<cols+1;i++){ %>
						<td>
						<%=rslSet.getString(i) %>
						</td>
						<%} %>
					</tr>
					
					<%						
					}
					%>
				
				</table>
				
				<% rsl.getDbMgr().disconnect();} %>
			</div>
			
		<div class="span9" id="admin" style="display: none">
			<form class="well form-inline" action="Login?requestId=addAdv" method="post">
			<input class="span2" type="text" name="advName" placeholder="AdvName">
			<input class="span2" type="text" name="advComp" placeholder="Company">
			<input class="span2" type="text" name="advPrice" placeholder="Price">
			<input class="span2" placeholder="Units" type="text" name="advUnits">
			<input class="btn" type="submit" value="CreateAd"> 
			</form>
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="saleMonthlyRept">
			<input class="span2" type="text" name="month" placeholder="Month">
			<input class="span2" type="submit" value="GenerateReport">
			</form>
			
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="transList">
			<input class="span2" type="text" name="name" placeholder="Item/User Name">
			<label class="radio">Item<input name="transType" value="Item" type="radio"></label>
			<label class="radio">User<input name="transType" value="User" type="radio"></label>
			<input class="span2" type="submit" value="Transaction List">
			</form>
			
			
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="revenueGen">
			<input class="span2" type="text" name="name" placeholder="Item/ItemType/User Name">
			<label class="radio">Item<input name="transType" value="Item" type="radio"></label>
			<label class="radio">ItemType<input name="transType" value="ItemType" type="radio"></label>
			<label class="radio">User<input name="transType" value="User" type="radio"></label>
			<input class="span2" type="submit" value="Revenue">
			</form>
			
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="highestRev">
			<label class="radio">Item<input name="transType" value="Item" type="radio"></label>
			<label class="radio">User<input name="transType" value="User" type="radio"></label>
			<input class="span2" type="submit" value="Highest Revenue">
			</form>
			

			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="companyItemsSold">
			<input class="span2" type="text" name="name" placeholder="companyName">
			<input class="span2" type="submit" value="Items Sold">
			</form>
			
	
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="getCustomers">
			<input class="span2" type="text" name="name" placeholder="ItemName">
			<input class="span2" type="submit" value="Get Customers">
			</form>	
			
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="customerMailingList">
			<input class="span2" type="text" name="name" placeholder="ItemName">
			<input class="span2" type="submit" value="Mailing List">
			</form>	
			
			<form class="well form-inline" action="Home.jsp?activeDiv=adminResult" method="post">
			<input type="hidden" name="action" value="itemSuggestions">
			<input class="span2" type="text" name="name" placeholder="Customer Name">
			<input class="span2" type="submit" value="Suggestions">
			</form>	
											
		</div>


			<div class="span9" id="wall" style="display: none">
				<table class="table   table-condensed">
				<tr>
						<td><form action="Login?<%=postType%>"
								method="post">
								<input name="wallpost" type="text" /> <input name="submit"
									type="submit" value="post">
								<input name="userId" type="hidden" value="<%=curUser%>"/>
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
							href="Home.jsp?activeDiv=pubProfile&userId=<%=post.getAuthor()%>">
								<%=post.getAuthorFname() + "\t" + post.getAuthorLname()%></a>
						</td>
						<td><%=post.getPostDate()%></td>
						<td><%=post.getPostTime()%></td>
						<% 
							if(post.getModifiable())
							{
						%>
						<td>
						    <a class="close" href="Login?requestId=deletePost&activeDiv=<%=activeDiv%>&postId=<%=post.getPostid()%>">&times;</a>
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
										href="Home.jsp?activeDiv=pubProfile&userId=<%=comm.getAuthor()%>">
											<%=comm.getAuthorFname() + "\t"
							+ comm.getAuthorLname()%></a>
									</td>
									<td><%=comm.getPostDate()%></td>
									<td><%=comm.getPostTime()%></td>
									<% 
							if(comm.getModifiable())
							{
						%>
						<td>
						    <a class="close" href="Login?requestId=deleteComment&activeDiv=<%=activeDiv%>&commentId=<%=comm.getPostid()%>">&times;</a>
						</td>
						<%} %>
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