package com.plick.search;

import java.sql.Timestamp;

public class SearchSongDto {
	private int songId;
	private String songName;
	private int albumId;
	private Timestamp createdAt;
	private String albumName;
	private int memberId;
	private String nickname;
	
	public SearchSongDto() {
		
	}

	public int getSongId() {
		return songId;
	}

	public void setSongId(int songId) {
		this.songId = songId;
	}

	public String getSongName() {
		return songName;
	}

	public void setSongName(String songName) {
		this.songName = songName;
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getAlbumName() {
		return albumName;
	}

	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public SearchSongDto(int songId, String songName, int albumId, Timestamp createdAt, String albumName, int memberId,
			String nickname) {
		super();
		this.songId = songId;
		this.songName = songName;
		this.albumId = albumId;
		this.createdAt = createdAt;
		this.albumName = albumName;
		this.memberId = memberId;
		this.nickname = nickname;
	}
	
	

}
