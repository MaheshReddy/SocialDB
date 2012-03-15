package com.db.infra;

import java.util.ArrayList;

import com.db.interfaces.Listable;

public class Circles implements Listable{

	private String circleId;
	private String ownerId;
	private String circleName;
	private ArrayList<Listable> cirMembers;
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
	public ArrayList<Listable> getCirMembers() {
		return cirMembers;
	}
	public void setCirMembers(ArrayList<Listable> cirMembers) {
		this.cirMembers = cirMembers;
	}
	@Override
	public String getFieldOne() {
		// TODO Auto-generated method stub
		return circleName;
	}
	@Override
	public String getFieldTwo() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ArrayList<String> getActions() {
		// TODO Auto-generated method stub
		ArrayList<String> actions = new ArrayList<String>();
		actions.add("AddToCricle");
		return null;
	}
	@Override
	public String getId() {
		return getCircleId();
	}
}
