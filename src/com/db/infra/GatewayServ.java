package com.db.infra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.jdbc.DBManager;

/**
 * Servlet implementation class Login
 */
@WebServlet(description = "Validates the user", urlPatterns = { "/Login" })
public class GatewayServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GatewayServ() {
        super();
        // TODO Auto-generated constructor stub
    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("requestId").equals("login"))
			handleLogin(request, response);
		else if (request.getParameter("requestId").equals("register"))
			handleRegistration(response, request);
		else if(request.getParameter("requestId").equals("logoff"))
			handleLogOff(request,response);
		// TODO Auto-generated method stub
	}
	
	private void handleLogOff(HttpServletRequest request,HttpServletResponse response){
		
		if(request.getParameter("isLoggedIn").equals("true")){
			Cookie [] cookie = request.getCookies();
			for(int i=0;i<cookie.length;i++){
				if(cookie[i].getName().equals("userId")){
					cookie[i].setMaxAge(0);
					response.addCookie(cookie[i]);
				}
			}
			//response.addCookie(new Cookie("userId",""));
			//TODO do the cleaning up operation on server side.
			try {
				redirect(request,response,"Logged Off","index.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else{
			try {
				redirect(request,response,"Log In","index.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	private void handleLogin(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		System.out.println("Username:"+ request.getParameter("username")
			+" Password:"+request.getParameter("password"));
		DBManager dbmgr = new DBManager();
		try {
			dbmgr.connect();
			//ResultSet resultSet = dbmgr.executeQuery("select passwd from cseteam51.userpasswd " +
												   //" where userid ="+request.getParameter("username")+"'");
				//									"where userid =?");
			PreparedStatement prpStmt = dbmgr.getConnection().prepareStatement("select passwd,userid from cseteam51.userpasswd " +
					   //" where userid ="+request.getParameter("username")+"'");
											"where email =?");
			prpStmt.setString(1, request.getParameter("username"));
			ResultSet resultSet = prpStmt.executeQuery();
			if(resultSet.next())
			{
			if(resultSet.getString(1).equals(request.getParameter("password")))
			{
				request.setAttribute("user", request.getParameter("username"));
				//Cookie user = new Cookie("user",request.getParameter("username"));
				Cookie user = new Cookie("userId",resultSet.getString(2));
				System.out.println(resultSet.getString(2));
				response.addCookie(user);
				request.setAttribute("userId", resultSet.getString(2));
				redirect(request,response,"OK","Home.jsp");
			}
			else
				redirect(request,response,"Wrong Username/Password please try again","index.jsp");
			}
			else
				redirect(request,response,"Wrong Username/Passwd please try again","index.jsp");
		dbmgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//response.sendRedirect("http://www.google.com");
		//response.
 catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	void redirect(HttpServletRequest request,HttpServletResponse response,String status,String url) throws IOException, ServletException
	{
		System.out.println(status);
		request.setAttribute("Status", status);
		RequestDispatcher reqDis = request.getRequestDispatcher(url);
		reqDis.forward(request, response);
	}
	
	private void handleRegistration(HttpServletResponse response,HttpServletRequest request) throws IOException, ServletException
	{
		if(!request.getParameter("passwd").equals(request.getParameter("passwd2")))
			redirect(request,response,"Password Mismatch","index.jsp");
		
		DBManager dbmgr = new DBManager();
		try {
			dbmgr.connect();
			PreparedStatement prpStmt = dbmgr.getConnection().prepareStatement("insert into cseteam51.userinfo" +
					"(id,fname,lname,sex,emailid,dob,address,city,state,zipcode,telephone)" +
					"values  (?,?,?,?,?,?,?,?,?,?,?)");
			prpStmt.setString(2,request.getParameter("fname"));
			prpStmt.setString(1,request.getParameter("userid"));
			prpStmt.setString(3,request.getParameter("lname"));
			//prpStmt.setString(, request.getParameter("passwd"));
			//prpStmt.setString(2,request.getParameter("passwd2"));
			prpStmt.setString(4,request.getParameter("sex"));
			prpStmt.setString(5, request.getParameter("emailid"));
			System.out.println(java.sql.Date.valueOf(request.getParameter("dob")));
			prpStmt.setDate(6,java.sql.Date.valueOf(request.getParameter("dob")));
			prpStmt.setString(7,request.getParameter("addr"));
			prpStmt.setString(8,request.getParameter("city"));
			prpStmt.setString(9,request.getParameter("state"));
			prpStmt.setString(10,request.getParameter("zip"));
			prpStmt.setString(11,request.getParameter("tele"));
			//System.out.println("Mahesh"+prpStmt.);
			prpStmt.execute();
			
			prpStmt = dbmgr.getConnection().prepareStatement("insert into cseteam51.userpasswd" +
					"(userid,passwd,email) values (?,?,?)");
			prpStmt.setString(1, request.getParameter("userid"));
			prpStmt.setString(2, request.getParameter("passwd"));
			prpStmt.setString(3, request.getParameter("emailid"));
			System.out.println(prpStmt.toString());
			prpStmt.execute();
			dbmgr.disconnect();
			System.out.println("Registratoin Done");
			redirect(request, response, "Registration Succesfull", "index.jsp");
			//response.sendRedirect("index.jsp");

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			redirect(request,response,"Class Not Found Error","register.jsp");
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			redirect(request,response,"SQLException: Use a different Userid or fill in all the fields","register.jsp");
		} catch (IllegalArgumentException e){
			e.printStackTrace();
			redirect(request,response,"Illegal Argument: Please check your date format","register.jsp");
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			redirect(request,response,"Servlet Exception","register.jsp");
		} catch (Exception e)
		{
			e.printStackTrace();
			redirect(request,response,"SQL Exception: Please choose a different userid","register.jsp");
		}
		
		//ID fname Last Name Sex EmailID DOB Address City State Zip Code Telephone Preferences
	}
}

