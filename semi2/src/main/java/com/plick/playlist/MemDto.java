package com.plick.playlist;

public class MemDto {
	private int id;
	private String nickname;
	private String accessType;

	public MemDto(int id, String nickname, String accessType) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.accessType = accessType;
	}

	public int getId() {
		return id;
	}

	public String getNickname() {
		return nickname;
	}

	public String getAccessType() {
		return accessType;
	}

}
