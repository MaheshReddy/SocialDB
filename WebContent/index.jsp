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
    <div class="navbar">
    <div class="navbar-inner">
    <div class="container">
    
  <form class="navbar-form pull-right" id="login-form" action="Login?requestId=login" method="post" >
    <input type="text" id="login" name="username" class="input-small" >
    <input type="password" id="password" name="password"  class="input-small">
    <input type="submit"  class="btn" name="commit" value="Log in"/>
    </form>
    
    </div>
    </div>
    </div>
    <!--   <button class="btn" onclick="window.open('register.jsp')" class="btn">Register</button> -->
   
   
   <h1 align="center"> Registration Page</h1>
    
   <form action="Login?requestId=register" method=post>

<table cellpadding=4 cellspacing=2 border=0>

<tr ><td valign=top> 
<b>First Name<sup>*</sup></b> 
<br><input type="text" name="fname" value="" size=15 maxlength=20>
</td><td  valign=top><b>Last Name<sup>*</sup></b>
<br><input type="text" name="lname" value="" size=15 maxlength=20></td> <td><b>Sex<sup>*</sup></b><br><input type="text" name="sex" value="" size="3"></td>
</tr>
<tr>
<td valign=top><b>E-Mail<sup>*</sup></b> 
<br><input type="text" name="emailid" value="" size=25  
maxlength=125><br></td>

<td  valign=top>
<b>DOB<sup>*</sup></b> <br>
<input type="text" name="dob" value="yyyy-mm-dd" size=10 maxlength=10></td>
</tr>

<tr >
<td valign=top><b>Password<sup>*</sup></b> 
<br><input type="password" name="passwd" size=10 value=""  
maxlength=10></td>

<td  valign=top>
<b>Confirm Password<sup>*</sup></b>
<br><input type="password" name="passwd2" size=10 value=""  
maxlength=10></td></tr>

<tr > 
<td valign=top><b>Address<sup>*</sup></b><br><input type="text" name="addr" size=30 value=""></td> </tr>
<tr>
<td  valign=top>
<b>State:<sup>*</sup></b>
<br><input type="text" name="state" size=10 value=""  
maxlength=10></td>
</tr>
<tr >
<td  valign=top>
<b>City:<sup>*</sup></b>
<br><input type="text" name="city" size=10 value=""  
maxlength=10></td>
<td valign=top><b>Zip Code:<sup>*</sup></b>
<br><input type="text" name="zip" value="" size=10 ></td>
</tr>

<tr > 
<td valign=top><b>Telephone<sup>*</sup></b><br><input type="text" name="tele" size=10 value=""></td>
<td valign=top><b>Preferences<sup>*</sup></b><br><input type="text" name="pref" size=30 value=""></td>
 </tr>
 
<tr>
<td  align=center colspan=2><hr>
<input type="submit" value="Submit"></td></tr></table>
</form>

<p><font color = "#FF0000">* required fields</font></p>
    	
	
</body>
</html>