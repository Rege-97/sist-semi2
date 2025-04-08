package com.plick.search;

import java.sql.Timestamp;

public class SearchArtistDto {
	private int memberId;
	private String name;
	private String nickname;
	private String email;
	private String accessType;

	public SearchArtistDto() {

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

	public String getAccessType() {
		return accessType;
	}

	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}

	public SearchArtistDto(int memberId, String name, String nickname, String email, String accessType) {
		super();
		this.memberId = memberId;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.accessType = accessType;
	}

}
