<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<script type="text/javascript" src="js/bootstrap.js">
    var externalScriptLoaded = false;
</script> 
<script type="text/javascript" src="js/bootstrap.min.js">
    var externalScriptLoaded = false;
</script> 
<STYLE TYPE="text/css" MEDIA="screen, projection">
<!--
  @import url(css/bootstrap.css);
  @import url(css/bootstrap.min.css);
  @import url(css/bootstrap-responsive.css);
  @import url(css/bootstrap-responsive.min.css);
  DT { background: yellow; color: black }
-->
</STYLE>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Title Page</title>
</head>

<body onload="setLoggedIn(), logOffButton()">
<script type="text/javascript">
<!-- Function to get the parameter value -->
var isLoggedIn;

function setLoggedIn(){
	var str =  readCookie("userId");
	//document.writeln(str);
	if(str == null){
	isLoggedIn = false;
	}
	else{
	isLoggedIn=true;
	}
}

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


function logAction(){
	var form = document.createElement("form");
	hiddenForm = document.createElement("input");
	hiddenForm.setAttribute("name", "isLoggedIn");
	hiddenForm.setAttribute("value", isLoggedIn);
	hiddenForm.setAttribute("type", "hidden");
	
	hiddenForm1 = document.createElement("input");
	hiddenForm1.setAttribute("name", "requestId");
	hiddenForm1.setAttribute("value", "logoff");
	hiddenForm1.setAttribute("type", "hidden");
	
	form.setAttribute("action", "Login");
	form.appendChild(hiddenForm);
	form.appendChild(hiddenForm1);
	document.body.appendChild(form);
	form.submit();
}
function logOffButton(){
	//document.write(isLoggedIn);	
	myPara = document.getElementById("paraID");
	myButton = document.createElement("BUTTON");
	var str =  readCookie("userId");
	//document.writeln(str);
	if(str == null){
	text = document.createTextNode("LogIn");
	isLoggedIn = false;
	}
	else{
	text = document.createTextNode("LogOff");
	isLoggedIn=true;
	}
	myButton.appendChild(text);
	//myButton.onclick = logAction(isLoggedIn);
	myPara.appendChild(myButton);
}


function register(){
	window.location = "register.jsp";
}
</script>

<% String status = "Welcome To DB Project";
		%>
<table>
<tr >
<td align="left" width="1000000000"></td>
<td> &nbsp;</td>
<td align="justify"><button class="btn" id="logOffBtn" name="logOff" onclick="logAction()">LogOff</button></td>
</tr>
</table>
</body>
</html>