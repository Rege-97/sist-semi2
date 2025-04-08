package com.plick.search;

import java.sql.Timestamp;

public class SearchMoodDto {
	private int playlistId;
	private String mood1;
	private String mood2;
	private int memberId;
	private String playlistName;
	private Timestamp createdAt;
	private int songCount;
	private int likeCount;
	private String nickname;
	private int firstAlbumId;
	
	public SearchMoodDto() {
		
	}
	
	public int getPlaylistId() {
		return playlistId;
	}
	public void setPlaylistId(int playlistId) {
		this.playlistId = playlistId;
	}
	public String getMood1() {
		return mood1;
	}
	public void setMood1(String mood1) {
		this.mood1 = mood1;
	}
	public String getMood2() {
		return mood2;
	}
	public void setMood2(String mood2) {
		this.mood2 = mood2;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public String getPlaylistName() {
		return playlistName;
	}
	public void setPlaylistName(String playlistName) {
		this.playlistName = playlistName;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public int getSongCount() {
		return songCount;
	}
	public void setSongCount(int songCount) {
		this.songCount = songCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getFirstAlbumId() {
		return firstAlbumId;
	}
	public void setFirstAlbumId(int firstAlbumId) {
		this.firstAlbumId = firstAlbumId;
	}
	public SearchMoodDto(int playlistId, String mood1, String mood2, int memberId, String playlistName,
			Timestamp createdAt, int songCount, int likeCount, String nickname, int firstAlbumId) {
		super();
		this.playlistId = playlistId;
		this.mood1 = mood1;
		this.mood2 = mood2;
		this.memberId = memberId;
		this.playlistName = playlistName;
		this.createdAt = createdAt;
		this.songCount = songCount;
		this.likeCount = likeCount;
		this.nickname = nickname;
		this.firstAlbumId = firstAlbumId;
	}
	
	

}
