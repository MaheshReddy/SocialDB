package com.db.infra;

import java.util.ArrayList;

public class Circles {

	private String circleId;
	private String ownerId;
	private String circleName;
	private ArrayList<UserTuple> cirMembers;
	public String getCircleId() {
		return circleId;
	}
	public void setCircleId(String ciricleId) {
		this.circleId = ciricleId;
	}
	public String getOwnerId() {
		return ownerId;
	}
	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}
	public String getCircleName() {
		return circleName;
	}
	public void setCircleName(String ciricleName) {
		this.circleName = ciricleName;
	}
	public ArrayList<UserTuple> getCirMembers() {
		return cirMembers;
	}
	public void setCirMembers(ArrayList<UserTuple> cirMembers) {
		this.cirMembers = cirMembers;
	}
}
