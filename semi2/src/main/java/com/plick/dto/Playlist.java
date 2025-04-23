package com.plick.dto;

import java.sql.Timestamp;

public class Playlist {
	private int id;
	private int memberId;
	private String name;
	private Timestamp createdAt;
	private String mood1;
	private String mood2;

	public Playlist() {
	}

	public Playlist(int id, int memberId, String name, Timestamp createdAt, String mood1, String mood2) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.name = name;
		this.createdAt = createdAt;
		this.mood1 = mood1;
		this.mood2 = mood2;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getMood1() {
		return mood1;
	}

	public void setMood1(String mood1) {
		this.mood1 = mood1;
	}

	public String getMood2() {
		return mood2;
	}

	public void setMood2(String mood2) {
		this.mood2 = mood2;
	}

}
