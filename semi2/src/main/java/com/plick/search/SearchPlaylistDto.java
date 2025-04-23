package com.plick.search;

import java.sql.Timestamp;

public class SearchPlaylistDto {
	private int playlistId;
	private int memberId;
	private String playlistName;
	private Timestamp createdAt;
	private int songCount;
	private int likeCount;
	private String nickname;
	private int firstAlbumId;
	
	public SearchPlaylistDto() {
		
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public void setPlaylistId(int playlistId) {
		this.playlistId = playlistId;
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

	public SearchPlaylistDto(int playlistId, int memberId, String playlistName, Timestamp createdAt,
			int songCount, int likeCount, String nickname, int firstAlbumId) {
		super();
		this.playlistId = playlistId;
		this.memberId = memberId;
		this.playlistName = playlistName;
		this.createdAt = createdAt;
		this.songCount = songCount;
		this.likeCount = likeCount;
		this.nickname = nickname;
		this.firstAlbumId = firstAlbumId;
	}
	
	
}
