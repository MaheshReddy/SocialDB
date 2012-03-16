package com.db.infra;

public class Posts {
	String postid; 
	String postDate;
	String postTime ;
	String timeZone ;
	String content ;
	String author;
	String pageid;
	String authorFname;
	String authorLname;
	private Boolean modifiable;
	
	public Posts(){}


	public String getPostid() {
		return postid;
	}


	public void setPostid(String postid) {
		this.postid = postid;
	}


	public String getPostDate() {
		return postDate;
	}


	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}


	public String getPostTime() {
		return postTime;
	}


	public void setPostTime(String postTime) {
		this.postTime = postTime;
	}


	public String getTimeZone() {
		return timeZone;
	}


	public void setTimeZone(String timeZone) {
		this.timeZone = timeZone;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getPageid() {
		return pageid;
	}


	public void setPageid(String pageid) {
		this.pageid = pageid;
	}


	public String getAuthorFname() {
		return authorFname;
	}


	public void setAuthorFname(String authorFname) {
		this.authorFname = authorFname;
	}


	public String getAuthorLname() {
		return authorLname;
	}


	public void setAuthorLname(String authorLname) {
		this.authorLname = authorLname;
	}


	public void setModifiable(Boolean modifiable) {
		this.modifiable = modifiable;
	}


	public Boolean getModifiable() {
		return modifiable;
	}
}
