package com.plick.chart;

import java.sql.Timestamp;

public class AlbumDetailDTO {
	int id;
	int memberId;
	String name;
	String description;
	String genre1;
	String genre2;
	String genre3;
	Timestamp releasedAt;
	Timestamp createdAt;
	String artist;
	
	public AlbumDetailDTO() {

	}

	public AlbumDetailDTO(int id, int memberId, String name, String description, String genre1, String genre2,
			String genre3, Timestamp releasedAt, Timestamp createdAt, String artist) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.name = name;
		this.description = description;
		this.genre1 = genre1;
		this.genre2 = genre2;
		this.genre3 = genre3;
		this.releasedAt = releasedAt;
		this.createdAt = createdAt;
		this.artist = artist;
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

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}
	
	
}
