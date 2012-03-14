package com.db.infra;

import java.util.ArrayList;

public class SIPEntry {

	private String sipName;
	private String sipId;
	private ArrayList<UserTuple> moderators;
	private ArrayList<UserTuple> members;
	private String sipPageid;
	public String getSipName() {
		return sipName;
	}
	public void setSipName(String sipName) {
		this.sipName = sipName;
	}
	public String getSipId() {
		return sipId;
	}
	public void setSipId(String sipId) {
		this.sipId = sipId;
	}
	public ArrayList<UserTuple> getModerators() {
		return moderators;
	}
	public void setModerators(ArrayList<UserTuple> moderators) {
		this.moderators = moderators;
	}
	public ArrayList<UserTuple> getMembers() {
		return members;
	}
	public void setMembers(ArrayList<UserTuple> members) {
		this.members = members;
	}
	public String getSipPageid() {
		return sipPageid;
	}
	public void setSipPageid(String sipPageid) {
		this.sipPageid = sipPageid;
	}
}
