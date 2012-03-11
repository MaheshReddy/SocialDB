package com.db.infra;

public class UserTuple {
		private String id;
		String fname;
		String lname;
		String email;
		public UserTuple(String id,String fname,String lname,String email){
			this.id=id;
			this.fname=fname;
			this.lname=lname;
			this.email=email;
		}
		public UserTuple() {
			// TODO Auto-generated constructor stub
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getFname() {
			return fname;
		}
		public void setFname(String fname) {
			this.fname = fname;
		}
		public String getLname() {
			return lname;
		}
		public void setLname(String lname) {
			this.lname = lname;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
}