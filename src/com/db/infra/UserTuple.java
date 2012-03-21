package com.db.infra;

import java.util.ArrayList;

import com.db.interfaces.Listable;

public class UserTuple implements Listable{
		private String id;
		String fname;
		String lname;
		String email;
		private String avatar;
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
		@Override
		public String getFieldOne() {
			return fname+" "+lname;
		}
		@Override
		public String getFieldTwo() {
			return email;
		}
		@Override
		public ArrayList<String> getActions() {
			// TODO Auto-generated method stub
			ArrayList<String> actions = new ArrayList<String>();
			actions.add("Add");
			actions.add("Accept");
			actions.add("Remove");
			return actions;
		}
		public void setAvatar(String avatar) {
			this.avatar = avatar;
		}
		public String getAvatar() {
			return avatar;
		}
}