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


  <form class="well form-inline" id="login-form" action="Login?requestId=login" method="post" >
    <input type="text" id="login" name="username" class="input-small" placeholder="Email">
    <input type="password" id="password" name="password"  class="input-small" placeholder="Password">
    <input type="submit"  class="btn" name="commit" value="Log in"/>
    </form>
    <!--   <button class="btn" onclick="window.open('register.jsp')" class="btn">Register</button> -->
	
</body>
</html>