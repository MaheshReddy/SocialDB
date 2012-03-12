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
    
	private DBManager dbmgr = new DBManager();
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
		String requestId = request.getParameter("requestId");
		System.out.println("Got request "+requestId);
		try{
		if(requestId.equals("login"))
			handleLogin(request, response);
		else if (requestId.equals("register"))
			handleRegistration(response, request);
		else if(requestId.equals("logoff"))
			handleLogOff(request,response);
		else if(requestId.equals("wallpost"))
			handleWallPost(request,response);
		else if(requestId.equals("profileLd"))
			handleProfileLoad(request,response);
		else if(requestId.equals("commPost"))
			handleCommentPost(request,response);
		else if(requestId.equals("addUser"))
			handleUserAdd(request,response);
		else if(requestId.equals("acceptUser"))
			handleAcceptFriendRequest(request,response);
		}catch (NullPointerException e) {
			redirect(request, response, "Error", "Home.jsp");
			// TODO: handle exception
		}
		// TODO Auto-generated method stub
	}
	
	private void handleAcceptFriendRequest(HttpServletRequest request,
			HttpServletResponse response) {
		String tarUsrId = request.getParameter("accpUserId");
		String curUsrId = getCurrentUser(request);
		try {
			dbmgr.executeQuery("insert into friend values ('"+tarUsrId+"','"+curUsrId+"')");
			dbmgr.executeQuery("insert into friend values ('"+curUsrId+"','"+tarUsrId+"')");
			dbmgr.executeQuery("delete from friendrequest where toUsrId='"+curUsrId+"' and " +
					"fromUsrId='"+tarUsrId+"'");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("activeDiv", "friends");
		try {
			redirect(request, response, "ok", "Home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void handleUserAdd(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		String tarUsrId = request.getParameter("addUserId");
		String curUsrId = getCurrentUser(request);
		try {
			dbmgr.connect();
			dbmgr.executeQuery("insert into friendRequest values ('"+curUsrId+"','"+tarUsrId+"')");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("activeDiv", "frndRequest");
		try {
			redirect(request, response, "ok", "Home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void handleCommentPost(HttpServletRequest request,HttpServletResponse response){
	
		System.out.println(request.getParameter("userId"));
		System.out.println(request.getParameter("postId"));
		String userId = request.getParameter("userId");
		String postId = request.getParameter("postId");
		Long commId = getNextId("comment", "commentId");
		String status = null;
		try {
			dbmgr.executeQuery("insert into cseteam51.comment " +
					"values ('"+commId+"','2012-10-10','17:01','EST','"+request.getParameter("commPost")
					+"','"+userId+"','"+postId+"')");
			status = "OK";
			dbmgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			status ="SQL Exception";
			e.printStackTrace();
		}
		try {
			request.setAttribute("activeDiv", "wall");
			redirect(request, response, status, "Home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	private void handleProfileLoad(HttpServletRequest request,HttpServletResponse response){
		System.out.println("mahesh"+request.getParameter("userId"));
		try {
			redirect(request, response, "ok", "Home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void handleWallPost(HttpServletRequest request,HttpServletResponse response){
		System.out.println("got a wall post");
		String userId = getCurrentUser(request);
		String targetUsrId = request.getParameter("userid");
		System.out.println(userId);
		System.out.println(targetUsrId);
		String pageId = null;
		String status=null;
		try {
			ResultSet rslSet = dbmgr.executeQuery("select pageId from userpage where userid='"+targetUsrId+"'");
			if(rslSet.next()){
				pageId = rslSet.getString("pageid");
				long postId = getNextId("post","postid");
				rslSet = dbmgr.executeQuery("insert into cseteam51.post " +
						"values ('"+Long.toString(postId)+"','2012-10-11','17:00','EST','"+request.getParameter("wallpost")+"','"+userId+"','"+pageId+"')");
				status="OK";
				dbmgr.disconnect();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			status ="DB Error";
			e.printStackTrace();
		}
		try {
			request.setAttribute("activeDiv", "wall");
			redirect(request, response, status, "Home.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private long getNextId(String table,String columm){
		String nextId = null;
		try {
			ResultSet rslSet = dbmgr.executeQuery("select max("+columm+") from "+table);
			if(rslSet.next())
				nextId = rslSet.getString(1);
			dbmgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(nextId!=null)
			return Long.parseLong(nextId) +1;
		else
		return 0;
	}
	private String getCurrentUser(HttpServletRequest request){
		String userId = null;
		Cookie [] cookie = request.getCookies();
		for(int i=0;i<cookie.length;i++){
			if(cookie[i].getName().equals("userId")){
				userId = new String(cookie[i].getValue());
			}
		}
		return userId;
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
		try {
		if(!request.getParameter("passwd").equals(request.getParameter("passwd2")))
			redirect(request,response,"Password Mismatch","index.jsp");
		
		
		
			String query = ("insert into cseteam51.userinfo" +
					"(id,fname,lname,sex,emailid,dob,address,city,state,zipcode,telephone)" +
					"values (");
			long userId = getNextId("userinfo","id");
			query = query +"'" +Long.toString(userId)+"',";
			query = query +"'"+ request.getParameter("fname")+"',";
			query = query +"'"+ request.getParameter("lname")+"',";
			query = query +"'"+ request.getParameter("sex")+"',";
			query = query +"'" +request.getParameter("emailid")+"',";
			query = query +"'" +java.sql.Date.valueOf(request.getParameter("dob"))+"',";
			query = query+"'" +request.getParameter("addr")+"',";
			query = query +"'" + request.getParameter("city")+"',";
			query = query +"'" + request.getParameter("state")+"',";
			query = query +"'" + request.getParameter("zip")+"',";
			query = query +"'" + request.getParameter("tele")+"')";
			dbmgr.executeQuery(query);
			dbmgr.disconnect();
			
			query = ("insert into cseteam51.userpasswd" +
					"(userid,passwd,email) values ('");
			query = query +Long.toString(userId)+"','";
			query = query + request.getParameter("passwd")+"','";
			query = query +  request.getParameter("emailid")+"')";
			dbmgr.executeQuery(query);
			dbmgr.disconnect();
			
			long wallId = getNextId("page", "pageid");
			dbmgr.executeQuery("insert into cseteam51.page values ('"+wallId+"')");
			dbmgr.executeQuery("insert into cseteam51.userpage values ('"+wallId+"','"+userId+"')");
			dbmgr.disconnect();
			System.out.println("Registratoin Done");
			redirect(request, response, "Registration Succesfull", "index.jsp");
			//response.sendRedirect("index.jsp");

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
		} catch (NullPointerException e) {
			e.printStackTrace();
			redirect(request,response,"SQL Exception: Please choose a different userid","register.jsp");
		}catch (Exception e)
		{
			e.printStackTrace();
			redirect(request,response,"SQL Exception: Please choose a different userid","register.jsp");
		} 
		
		//ID fname Last Name Sex EmailID DOB Address City State Zip Code Telephone Preferences
	}
}

