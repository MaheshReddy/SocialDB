<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Page</title>
</head>
<body>
<% String status = "Welcome to Registration Page";
   if (request.getAttribute("Status")!=null)
   		status = request.getAttribute("Status").toString();%>
 <%=status %>
 <br>
<body bgcolor="#58ACFA">

<form action="Login?pageid=2" method=post>

<table cellpadding=4 cellspacing=2 border=0>
<th bgcolor="#58ACFA" colspan=2>
<font size=5>REGISTRATION</font>
<br><font size=1><sup></sup></font><hr>
</th>
<tr bgcolor="#58ACFA"><td valign=top> 
<b>First Name<sup>*</sup></b> 
<br><input type="text" name="fname" value="" size=15 maxlength=20>
</td><td  valign=top><b>Last Name<sup>*</sup></b>
<br><input type="text" name="lname" value="" size=15 maxlength=20></td> <td><b>Sex<sup>*</sup></b><br><input type="text" name="sex" value="" size="3"></td>
</tr>
<tr bgcolor="#58ACFA">
<td valign=top><b>E-Mail<sup>*</sup></b> 
<br><input type="text" name="emailid" value="" size=25  
maxlength=125><br></td>

<td  valign=top>
<b>DOB<sup>*</sup></b> <br>
<input type="text" name="dob" value="yyyy-mm-dd" size=10 maxlength=10></td>
</tr>

<tr bgcolor="#58ACFA">
<td valign=top colspan=2>
<b>User Name<sup>*</sup></b><br>
<input type="text" name="userid" size=10 value=""  maxlength=10>
</td></tr>
<tr bgcolor="#58ACFA">
<td valign=top><b>Password<sup>*</sup></b> 
<br><input type="password" name="passwd" size=10 value=""  
maxlength=10></td>

<td  valign=top>
<b>Confirm Password<sup>*</sup></b>
<br><input type="password" name="passwd2" size=10 value=""  
maxlength=10></td></tr>

<tr bgcolor="#58ACFA"> 
<td valign=top><b>Address<sup>*</sup></b><br><input type="text" name="addr" size=30 value=""></td> </tr>
<tr>
<td  valign=top>
<b>State:<sup>*</sup></b>
<br><input type="text" name="state" size=10 value=""  
maxlength=10></td>
</tr>
<tr>
<td  valign=top>
<b>City:<sup>*</sup></b>
<br><input type="text" name="city" size=10 value=""  
maxlength=10></td>
<td valign=top><b>Zip Code:<sup>*</sup></b>
<br><input type="text" name="zip" value="" size=10 ></td>
</tr>

<tr bgcolor="#58ACFA"> 
<td valign=top><b>Telephone<sup>*</sup></b><br><input type="text" name="tele" size=10 value=""></td>
<td valign=top><b>Preferences<sup>*</sup></b><br><input type="text" name="pref" size=30 value=""></td>
 </tr>
 
<tr bgcolor="#58ACFA">
<td  align=center colspan=2><hr>
<input type="submit" value="Submit"></td></tr></table></center></form><p><font color = "#FF0000">* required fields</font></p>
</body>
</html>