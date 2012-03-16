package com.db.infra;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.db.interfaces.Listable;
import com.db.jdbc.DBManager;
import com.sun.org.apache.bcel.internal.generic.NEW;


public class BuildHomePage {

	private String userId;
	private String loggedInUser;
	private DBManager dbMgr = new DBManager();
	
	public BuildHomePage(String userId){
		this.userId = userId;
	}
	public BuildHomePage(){}
	
	public ArrayList<Listable> buildFriends(){
		
		ArrayList<Listable> friendList = new ArrayList<Listable>();;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select usrid1 from friend where usrid2='"+userId+"'");
			if(rslSet !=null)
			{
				while(rslSet.next()){
					ResultSet rslSet1 = dbMgr.executeQuery("select id,fname,lname,emailid from userinfo where id='"+rslSet.getString("usrid1")+"'");
					if(rslSet1.next())
						//friendList.add(new UserTuple(rslSet1.getString("id"), rslSet1.getString("fname") , rslSet1.getString("lname"), rslSet1.getString("emailid")));
						friendList.add(buildUserTuple(rslSet1));
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
			ResultSet rslSet = dbMgr.executeQuery("select wallid from userinfo where id='"+userId+"'");
			posts = new ArrayList<Posts>();
			rslSet.next();
			String pageId = rslSet.getString("wallid");
			rslSet = dbMgr.executeQuery("select * from post where pageid='"+pageId+"'");
			while(rslSet.next()){
				Posts post = buildPost(rslSet);
				if(userId.equals(loggedInUser))
					post.setModifiable(true);
				posts.add(post);
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return posts;
	}
	
	public ArrayList<Posts> buildComments(String postId){
		ArrayList<Posts> comments = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select * from comment where postid='"+postId+"'");
			comments = new ArrayList<Posts>();
			while(rslSet.next()){
				Posts comment = new Posts();
				comment.setAuthor(rslSet.getString("authorId"));
				comment.setContent(rslSet.getString("content"));
				comment.setPostid(rslSet.getString("commentId"));
				comment.setPostDate(rslSet.getString("commentdate"));
				comment.setPostTime(rslSet.getString("commentTime"));
				UserTuple usr = findUser(comment.getAuthor());
				comment.setAuthorFname(usr.getFname());
				comment.setAuthorLname(usr.getLname());
				comments.add(comment);
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comments;
	}
	
	public ArrayList<UserTuple> buildFriendSearch(String name){
			ArrayList<UserTuple> searchRslt = null;
			try {
				ResultSet rslSet = dbMgr.executeQuery("select * from userInfo where fname='"+name.toUpperCase()+"' or lname='"+name.toUpperCase()+"'");
				searchRslt = new ArrayList<UserTuple>();
				while(rslSet.next()){
					searchRslt.add(buildUserTuple(rslSet));
				}
				dbMgr.disconnect();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return searchRslt;
	}
	
	public UserTuple buildUserHome(){
		return findUser(userId);
	}
	public ArrayList<UserTuple> buildFriendRequest(){
		ArrayList<UserTuple> frndRequest = null;
		
		try {
			ResultSet rslSet = dbMgr.executeQuery("select fromUsrId from friendRequest where toUsrId='"+userId+"'");
			frndRequest = new ArrayList<UserTuple>();
			while(rslSet.next()){
				frndRequest.add(findUser(rslSet.getString("fromUsrId")));
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return frndRequest;
	}
	public ArrayList<SIPEntry> buildSips(){
		ArrayList<SIPEntry> sips = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select sipid,moderator from sipMember where memberId='"+userId+"'");
			sips = new ArrayList<SIPEntry>();
			while(rslSet.next()){
				ResultSet rslSet1 = dbMgr.executeQuery("select * from sip where sipid='"
						+rslSet.getString("sipid")+"'");
				if(rslSet1.next()){
					SIPEntry sip = buildSIPEntry(rslSet1);
					sips.add(sip);
				}
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sips;
	}
	
	public ArrayList<SipAuthRequest> buildSipRequest(){
		ArrayList<SipAuthRequest> sipReqs = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select * from SIPPENDING where moderator='"+userId+"'");
			sipReqs = new ArrayList<SipAuthRequest>();
			while(rslSet.next()){
				SipAuthRequest sipReq= new SipAuthRequest();
				SIPEntry sip = new SIPEntry();
				sip.setSipId(rslSet.getString("sipid"));
				sipReq.setSip(sip);
				sipReq.setUser(findUser(rslSet.getString("memberid")));
				sipReqs.add(sipReq);
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sipReqs;
	}
	
	public ArrayList<SIPEntry> searchSip(String sipName){
		ArrayList<SIPEntry> sipList = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select * from sip where sipName ='"+sipName.toUpperCase()+"'");
			sipList = new ArrayList<SIPEntry>();
			if(rslSet.next())
				sipList.add(buildSIPEntry(rslSet));
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sipList;
	}
	
	public ArrayList<Posts> buildSipPage(String sipPageId){
		ArrayList<Posts> sipPosts = null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select * from post where pageid='"+sipPageId+"'");
			sipPosts = new ArrayList<Posts>();
			while(rslSet.next())
				sipPosts.add(buildPost(rslSet));
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sipPosts;
		
	}
	public ArrayList<Circles> buildCircles() {
		ArrayList<Circles> circles = null;
		ResultSet rslSet;
		try {
			rslSet = dbMgr.executeQuery("select * from circle where ownerId='"+userId+"'");
			circles = new ArrayList<Circles>();
			while(rslSet.next()){
				String circleId = rslSet.getString("circleId");
				Circles crc = new Circles();
				crc.setCircleId(circleId);
				crc.setCircleName(rslSet.getString("circlename"));
				ResultSet rslSet1 = dbMgr.executeQuery("select * from circleMember where circleId='"+circleId+"'");
				crc.setCirMembers(new ArrayList<Listable>());
				while (rslSet1.next())
					crc.getCirMembers().add(findUser(rslSet1.getString("memberId")));
				circles.add(crc);
			}
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return circles;
		
	}
	
	public SIPEntry buildSIPEntry(ResultSet rslSet) {
		SIPEntry sip = new SIPEntry();
		try {
			sip.setSipId(rslSet.getString("sipId"));
		
		sip.setSipName(rslSet.getString("sipName"));
		sip.setSipPageid(rslSet.getString("sippageid"));
		ResultSet rslSet1 = dbMgr.executeQuery("select memberId,moderator from sipMember where sipid='"+rslSet.getString("sipId")+"'");
		
		sip.setMembers(new ArrayList<UserTuple>());
		sip.setModerators(new ArrayList<UserTuple>());
		while(rslSet1.next()){
			UserTuple sipusr = (findUser(rslSet1.getString("memberId")));
			if(sipusr.getId().equals(userId))
				sip.setMember(true);
			sip.getMembers().add(sipusr);
			if(rslSet1.getString("moderator").equals("1"))
			{
				if(sipusr.getId().equals(userId))
					sip.setModerator(true);
				sip.getModerators().add(sipusr);
			}
		}
		dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		return sip;
	}
	
	
	public UserTuple buildUserTuple(ResultSet rslSet) throws SQLException{
		UserTuple usr = new UserTuple();
		usr.setFname(rslSet.getString("fname"));
		usr.setLname(rslSet.getString("lname"));
		usr.setEmail(rslSet.getString("emailid"));
		usr.setId(rslSet.getString("id"));
		return usr;
	}
	public UserTuple findUser(String userId){
		UserTuple usr =null;
		try {
			ResultSet rslSet = dbMgr.executeQuery("select fname,lname,emailId,id from userinfo where id='"+userId+"'");
			rslSet.next();
			usr = buildUserTuple(rslSet);
			dbMgr.disconnect();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usr;
	}
	
	public Posts buildPost(ResultSet rslSet) throws SQLException{
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
		/**
		 * TODO need to change this logic
		 */
		if(post.getAuthor().equals(loggedInUser))
			post.setModifiable(true);
		else
			post.setModifiable(false);
		return post;
	}
	public void setLoggedInUser(String loggedInUser) {
		this.loggedInUser = loggedInUser;
	}
	public String getLoggedInUser() {
		return loggedInUser;
	}

}
