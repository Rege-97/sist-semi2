package com.plick.dto;

import java.sql.Timestamp;

public class Like {
	private int memberId;
	private int playlistId;
	private Timestamp createdAt;

	public Like() {
	}

	public Like(int memberId, int playlistId, Timestamp createdAt) {
		super();
		this.memberId = memberId;
		this.playlistId = playlistId;
		this.createdAt = createdAt;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public void setPlaylistId(int playlistId) {
		this.playlistId = playlistId;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

}
