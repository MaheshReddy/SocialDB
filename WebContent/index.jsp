<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Social</title>
<%@ include file="title.jsp"  %>
<%@ page import="javax.servlet.RequestDispatcher" %>
</head>
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript">

</script>
<body>

<form id="login-form" action="Login?requestId=login" method="post">
		<fieldset>
		
			<legend>Log in</legend>
			
			<label for="login">Email</label>
			<input type="text" id="login" name="username"/>
			<div class="clear"></div>
			
			<label for="password">Password</label>
			<input type="password" id="password" name="password"/>
			<div class="clear"></div>
			
			<label for="remember_me" style="padding: 0;">Remember me?</label>
			<input type="checkbox" id="remember_me" style="position: relative; top: 3px; margin: 0; " name="remember_me"/>
			<div class="clear"></div>
			
			<br />
			
			<input type="submit" style="margin: -30px 0 0 187px;" class="button" name="commit" value="Log in"/>
			<button class="btn" onclick="window.open('register.jsp')" style="margin: -50px 0 0 277px;">
			<a href="register.jsp">Register</button>	
		</fieldset>
	</form>
	
</body>
</html>