package com.plick.support;

import java.sql.Timestamp;

public class FaqDto {
	private int id;
	private int memberId;
	private String title;
	private String content;
	private Timestamp createdAt;
	
	public FaqDto() {
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

	public FaqDto(int id, int memberId, String title, String content, Timestamp createdAt) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
	}
	

}
