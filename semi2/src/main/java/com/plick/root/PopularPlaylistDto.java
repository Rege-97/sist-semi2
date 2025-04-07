package com.plick.root;

import java.sql.*;

public class PopularPlaylistDto {
	private int playlistId;
	private int MemberId;
	private String playlistName;
	private Timestamp createdAt;
	private int songCount;
	private int likeCount;
	private String memberNickname;
	private int firstAlbumId;
	
	
	
	
	public int getPlaylistId() {
		return playlistId;
	}



	public void setPlaylistId(int playlistId) {
		this.playlistId = playlistId;
	}



	public String getPlaylistName() {
		return playlistName;
	}



	public void setPlaylistName(String playlistName) {
		this.playlistName = playlistName;
	}

	


	



	public int getMemberId() {
		return MemberId;
	}



	public void setMemberId(int memberId) {
		MemberId = memberId;
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



	public String getMemberNickname() {
		return memberNickname;
	}



	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}



	public int getFirstAlbumId() {
		return firstAlbumId;
	}



	public void setFirstAlbumId(int firstAlbumId) {
		this.firstAlbumId = firstAlbumId;
	}



	//인기 플리 조회
	public PopularPlaylistDto(int playlistId, int memberId, String playlistName, Timestamp createdAt, int songCount,
			int likeCount, String memberNickname, int firstAlbumId) {
		super();
		this.playlistId = playlistId;
		MemberId = memberId;
		this.playlistName = playlistName;
		this.createdAt = createdAt;
		this.songCount = songCount;
		this.likeCount = likeCount;
		this.memberNickname = memberNickname;
		this.firstAlbumId = firstAlbumId;
	}
	
	
	

}
