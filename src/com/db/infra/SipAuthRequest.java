package com.db.infra;

public class SipAuthRequest {
	private UserTuple user;
	private SIPEntry sip;
	public void setUser(UserTuple user) {
		this.user = user;
	}
	public UserTuple getUser() {
		return user;
	}
	public void setSip(SIPEntry sip) {
		this.sip = sip;
	}
	public SIPEntry getSip() {
		return sip;
	}
}
