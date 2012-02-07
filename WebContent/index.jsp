<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Social</title>
</head>
<body>
<% String status = "Welcome To DB Project";
	if(request.getAttribute("Status") != null)
		status = request.getAttribute("Status").toString();%>
<%=status%>
<br>
Login Page, Please enter your details to login.
<form method="post" action="Login?pageid=1"> 
<p>Username <input type="text" name="username">
<br>Password
<input type="password" name="password"><br>
<p><input type="submit" name="Submit" value="Submit">
<input type="reset" value="Reset"></p> </form>
<br>
<form method="post" action="register.jsp">
<p>New user please register<input type="submit" name="Register" value="Register"></p></form>>
</body>
</html>