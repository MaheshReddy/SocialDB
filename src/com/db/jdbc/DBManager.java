package com.db.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager {
	private Connection connection = null;
	private String url = "db2serv01.cs.stonybrook.edu";
	private String port = "50000";
	private String db = "teamdb51";
	private String userId =  "cseteam51";
	private String passwd = "Spring2012";
	private String dbType = "db2";
	
	public DBManager()
	{
		
	}
	public void connect () throws SQLException, ClassNotFoundException {
	Class.forName("com.ibm.db2.jcc.DB2Driver"); 
	System.out.println("Driver loaded");
	// Establish a connection 
	 //setConnection(DriverManager.getConnection("jdbc:db2://db2serv01.cs.stonybrook.edu:50000/teamdb51","cseteam51","Spring2012"));
	setConnection(DriverManager.getConnection(buildDBUrl(),getUserId(),getPasswd()));
	System.out.println("Database connected");
	// Close the connection connection.close();
	}
	public void disconnect () throws SQLException
	{
		getConnection().close();
		System.out.println("Database Disconnected");
	}
	public String buildDBUrl()
	{
		StringBuilder dburl = new StringBuilder();
		dburl.append("jdbc:"+getDbType()+"://"+getUrl()+":"+getPort()+"/"+getDb());
		return dburl.toString();
	}
	public ResultSet executeQuery(String query) throws SQLException
	{
		// Create a statement
		ResultSet resultSet = null;
		try {
			connect();
			System.out.println("Executing query:"+query);
			Statement statement = getConnection().createStatement();
			// Execute a statement
			if(query.contains("insert") || query.contains("update") || query.contains("delete"))
				statement.executeUpdate(query);
			else
				resultSet = statement.executeQuery(query);
			// Iterate through the result and print the student names
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
	}
	public Connection getConnection() {
		return connection;
	}
	public void setConnection(Connection connection) {
		this.connection = connection;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}
}
