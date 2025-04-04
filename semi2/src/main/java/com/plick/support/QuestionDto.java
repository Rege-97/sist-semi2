package com.plick.support;

import java.sql.Timestamp;

public class QuestionDto {
	private int id;
	private int memberId;
	private String title;
	private String content;
	private Timestamp createdAt;
	private int parentId;
	private String nickname;
	private String email;
	
	public QuestionDto() {
		// TODO Auto-generated constructor stub
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public QuestionDto(int id, int memberId, String title, String content, Timestamp createdAt, int parentId,
			String nickname, String email) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
		this.parentId = parentId;
		this.nickname = nickname;
		this.email = email;
	}
	
	

}
