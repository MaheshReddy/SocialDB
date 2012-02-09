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
<script type="text/javascript">

</script>
<body>
<br>
<br>
<br>
<h1>Login Page, Please enter your details to login.</h1>
<table>
<tr>
<td>
<form method="post" action="Login?pageid=1">
Email <input type="text" name="username"> &nbsp;&nbsp;&nbsp; Password
<input type="password" name="password"><br>
<p><input type="submit" name="Submit" value="Submit">
<input type="reset" value="Reset"></p> </form>
</td>
</tr>
</table>
</body>
</html>