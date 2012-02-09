<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.db.jdbc.DBManager" %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.Statement" %>
    <%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
</head>
<body>
<%@ include file="title.jsp"  %>
<br>
<br>
You Have successfully logged in. This is your home page.
<%String fname,lname,sex,addr,city,state,zip,pref,tele,dob,email;
fname=lname=sex=addr=city=state=zip=pref=tele=dob=email=null;
if(request.getAttribute("user")!=null)
{
{
   DBManager dbmgr = new DBManager();  
   dbmgr.connect();
   Connection con = dbmgr.getConnection();
   Statement stmt = con.createStatement();
   String user = request.getAttribute("user").toString();
   ResultSet rstset = dbmgr.executeQuery("select * from cseteam51.userinfo where emailid='"+user+"'");
   
   //rstset.next();
   if(rstset.next())
   {
	    fname = rstset.getString("firstname");
	    lname = rstset.getString("lastname");
	    sex = rstset.getString("sex");
	    addr = rstset.getString("address");
	    city = rstset.getString("city");
	    state = rstset.getString("state");
	    zip = rstset.getString("zipcode");
	    tele = rstset.getString("telephone");
	    pref = rstset.getString("preferences");
	    dob = rstset.getDate("dob").toString();
	    email = rstset.getString("emailid");
	    dbmgr.disconnect();
   }
   else
   {
	   PrintWriter wrt = response.getWriter();
	   wrt.print("Error retriving the value");
   }
}  
}
else
{
	response.sendRedirect("index.jsp");
}
%>
<br>
Name <%= fname+" "+lname %>
<br>
Sex: <%= sex %>
<br>
DOB: <%=dob %>
<br>
Email: <%=email %>
<br>
Telephone: <%= tele %>
<br>
Address: <%=  addr+" "+city+" "+ state +" "+ zip %>
</body>
</html>