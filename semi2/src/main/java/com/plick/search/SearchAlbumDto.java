package com.plick.search;

import java.sql.Timestamp;

public class SearchAlbumDto {
	private int albumId;
	private int memberId;
	private String name;
	private String description;
	private String genre1;
	private String genre2;
	private String genre3;
	private Timestamp releasedAt;
	private Timestamp createdAt;
	private String nickname;

	public SearchAlbumDto() {

	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getGenre1() {
		return genre1;
	}

	public void setGenre1(String genre1) {
		this.genre1 = genre1;
	}

	public String getGenre2() {
		return genre2;
	}

	public void setGenre2(String genre2) {
		this.genre2 = genre2;
	}

	public String getGenre3() {
		return genre3;
	}

	public void setGenre3(String genre3) {
		this.genre3 = genre3;
	}

	public Timestamp getReleasedAt() {
		return releasedAt;
	}

	public void setReleasedAt(Timestamp releasedAt) {
		this.releasedAt = releasedAt;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public SearchAlbumDto(int albumId, int memberId, String name, String description, String genre1, String genre2,
			String genre3, Timestamp releasedAt, Timestamp createdAt, String nickname) {
		super();
		this.albumId = albumId;
		this.memberId = memberId;
		this.name = name;
		this.description = description;
		this.genre1 = genre1;
		this.genre2 = genre2;
		this.genre3 = genre3;
		this.releasedAt = releasedAt;
		this.createdAt = createdAt;
		this.nickname = nickname;
	}

}
