package com.plick.player;

import java.sql.Timestamp;

public class PlayerDto {
	private int songId;
	private String songName;
	private int albumId;
	private Timestamp createdAt;
	private String albumName;
	private int memberId;
	private String nickname;
	private String lyrics;
	
	public PlayerDto() {
		
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
	public String getLyrics() {
		return lyrics;
	}
	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}

	public PlayerDto(int songId, String songName, int albumId, Timestamp createdAt, String albumName, int memberId,
			String nickname, String lyrics) {
		super();
		this.songId = songId;
		this.songName = songName;
		this.albumId = albumId;
		this.createdAt = createdAt;
		this.albumName = albumName;
		this.memberId = memberId;
		this.nickname = nickname;
		this.lyrics = lyrics;
	}
	
	

}
