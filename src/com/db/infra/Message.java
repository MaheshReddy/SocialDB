package com.db.infra;

import java.util.ArrayList;

public class Message {
private String msgId;
private UserTuple sender;
private ArrayList<UserTuple> receivers;
private String subject;
private String content;
private String date;
private String time;
public UserTuple getSender() {
	return sender;
}
public void setSender(UserTuple sender) {
	this.sender = sender;
}
public ArrayList<UserTuple> getReceivers() {
	return receivers;
}
public void setReceivers(ArrayList<UserTuple> receivers) {
	this.receivers = receivers;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getTime() {
	return time;
}
public void setTime(String time) {
	this.time = time;
}
public void setMsgId(String msgId) {
	this.msgId = msgId;
}
public String getMsgId() {
	return msgId;
}
}
