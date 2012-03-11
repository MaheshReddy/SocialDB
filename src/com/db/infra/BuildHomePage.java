package com.db.infra;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.db.jdbc.DBManager;


public class BuildHomePage {

	private String userId;
	private DBManager dbMgr = new DBManager();
	
	public BuildHomePage(String userId){
		this.userId = userId;
	}
	public BuildHomePage(){}
	
	public ArrayList<UserTuple> buildFriends(){
		
		ArrayList<UserTuple> friendList = new ArrayList<UserTuple>();;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select usrid1 from friend where usrid2='"+userId+"'");
			if(rslSet !=null)
			{
				while(rslSet.next()){
					ResultSet rslSet1 = dbMgr.executeQuery("select id,fname,lname,emailid from userinfo where id='"+rslSet.getString("usrid1")+"'");
					if(rslSet1.next())
						friendList.add(new UserTuple(rslSet1.getString("id"), rslSet1.getString("fname") , rslSet1.getString("lname"), rslSet1.getString("emailid")));
				}
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return friendList;
	}
	
	public Map<String,String> buildPublicProfile(){
		Map<String,String> profile = null;
		try {
			ResultSet rstset = dbMgr.executeQuery("select * from cseteam51.userinfo where id='"+ userId + "'");
			if(rstset.next())
			{
				profile = new HashMap<String, String>();
				profile.put("fname",rstset.getString("fname"));
				profile.put("lname",rstset.getString("lname"));
				profile.put("sex",rstset.getString("sex"));
				profile.put("addr",rstset.getString("address"));
				profile.put("city",rstset.getString("city"));
				profile.put("state",rstset.getString("state"));
				profile.put("zip",rstset.getString("zipcode"));
				profile.put("tele",rstset.getString("telephone"));
				profile.put("dob",rstset.getDate("dob").toString());
				profile.put("email",rstset.getString("emailid"));
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return profile;
	}
	public ArrayList<Posts> buildWall(){
		ArrayList<Posts> posts = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select pageId from userpage where userid='"+userId+"'");
			posts = new ArrayList<Posts>();
			rslSet.next();
			String pageId = rslSet.getString("pageId");
			rslSet = dbMgr.executeQuery("select * from post where pageid='"+pageId+"'");
			while(rslSet.next()){
				Posts post = new Posts();
				post.setAuthor(rslSet.getString("author"));
				post.setContent(rslSet.getString("content"));
				post.setPageid(rslSet.getString("pageid"));
				post.setPostDate(rslSet.getString("postdate"));
				post.setPostid(rslSet.getString("postid"));
				post.setPostTime(rslSet.getString("posttime"));
				post.setTimeZone(rslSet.getString("timezone"));
				UserTuple usr = findUser(post.getAuthor());
				post.setAuthorFname(usr.getFname());
				post.setAuthorLname(usr.getLname());
				posts.add(post);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return posts;
	}
	
	public UserTuple findUser(String userId){
		UserTuple usr =null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select fname,lname,emailId from userinfo where id='"+userId+"'");
			usr =  new UserTuple();
			rslSet.next();
			usr.setFname(rslSet.getString("fname"));
			usr.setLname(rslSet.getString("lname"));
			usr.setEmail(rslSet.getString("emailid"));
			usr.setId(userId);
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usr;
	}
}
