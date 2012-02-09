<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Title Page</title>
</head>
<body onload="logOffButton()">
<script type="text/javascript">
<!-- Function to get the parameter value -->
var isLoggedIn;
function getQueryParameter ( parameterName ) {
	  var queryString = window.top.location.search.substring(1);
	  var parameterName = parameterName + "=";
	  if ( queryString.length > 0 ) {
	    begin = queryString.indexOf ( parameterName );
	    if ( begin != -1 ) {
	      begin += parameterName.length;
	      end = queryString.indexOf ( "&" , begin );
	        if ( end == -1 ) {
	        end = queryString.length
	      }
	      return unescape ( queryString.substring ( begin, end ) );
	    }
	  }
	  return "null";
	} 

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}


function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}


function logAction(isLoggedIn){
	if(isLoggedIn == "true")
	{
		//eraseCookie("loggedIn");
	document.cookie = "loggedIn=false;;";
	window.location="index.jsp";
	}
	else{
	var url = document.URL;
	var isIndex = url.match("index.jsp");
	if(isIndex == null )
		window.location="index.jsp";
	}
	return
}
function logOffButton(){
	myPara = document.getElementById("paraID");
	myButton = document.createElement("BUTTON");
	//var isLoggedIn =  getQueryParameter("loggedIn");
	isLoggedIn = readCookie("loggedIn");
	if(isLoggedIn == "true"){
	text = document.createTextNode("LogOff");
	}
	else{
	text = document.createTextNode("LogIn");
	}
	myButton.appendChild(text);
	//myButton.onclick = logAction(isLoggedIn);
	myPara.appendChild(myButton);
}

</script>

<% String status = "Welcome To DB Project";
		%>
<table>
<tr >
<td align="left" width="1000000000"> <%=status %></td>
<td> &nbsp;</td>
<td align="left"><br>
<form method="post" action="register.jsp">
<input type="submit" name="Register" value="Register"></p></form> </td>
<td align="justify"> <p id="paraID" onclick="logAction(isLoggedIn)"> &nbsp; </p> </td>
</tr>
</table>
</body>
</html>