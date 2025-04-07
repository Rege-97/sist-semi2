package com.plick.album;

import java.sql.Timestamp;
import java.util.ArrayList;

public class AlbumDto {
	private int id;
	private int memberId;
	private String memberName;
	private String name;
	private String description;
	private String genre1;
	private String genre2;
	private String genre3;
	private Timestamp releasedAt;
	private Timestamp createdAt;
	private ArrayList<SongsDto> songsDtos = new ArrayList<SongsDto>();

	public AlbumDto() {
	}

	public AlbumDto(int id, int memberId, String name, String memberName, String description, String genre1, String genre2, String genre3,
			Timestamp releasedAt, Timestamp createdAt, ArrayList<SongsDto> songsDtos) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.memberName = memberName;
		this.name = name;
		this.description = description;
		this.genre1 = genre1;
		this.genre2 = genre2;
		this.genre3 = genre3;
		this.releasedAt = releasedAt;
		this.createdAt = createdAt;
		this.songsDtos = songsDtos;
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

	public String getMemberName() {
		return memberName;
	}
	
	public void setMemberName(String memberName) {
		this.memberName = memberName;
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

	public ArrayList<SongsDto> getSongsdto() {
		return songsDtos;
	}

	public void setSongsdto(SongsDto songsDtos) {
		this.songsDtos.add(songsDtos);
	}
	
}
