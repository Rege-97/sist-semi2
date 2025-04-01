package com.plick.dto;

import java.sql.Timestamp;

public class RatingDto {
	private int memberId;
	private int albumId;
	private int score;
	private Timestamp ratedAt;

	public RatingDto() {
	}

	public RatingDto(int memberId, int albumId, int score, Timestamp ratedAt) {
		super();
		this.memberId = memberId;
		this.albumId = albumId;
		this.score = score;
		this.ratedAt = ratedAt;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public Timestamp getRatedAt() {
		return ratedAt;
	}

	public void setRatedAt(Timestamp ratedAt) {
		this.ratedAt = ratedAt;
	}

}
