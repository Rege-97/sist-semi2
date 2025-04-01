package com.plick.dto;

import java.sql.Timestamp;

public class MemberDto {
	private int id;
	private String name;
	private String nickname;
	private String tel;
	private String email;
	private String password;
	private String accessType;
	private Timestamp createdAt;
	private String description;

	public MemberDto() {
	}

	public MemberDto(int id, String name, String nickname, String tel, String email, String password, String accessType,
			Timestamp createdAt, String description) {
		super();
		this.id = id;
		this.name = name;
		this.nickname = nickname;
		this.tel = tel;
		this.email = email;
		this.password = password;
		this.accessType = accessType;
		this.createdAt = createdAt;
		this.description = description;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAccessType() {
		return accessType;
	}

	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
