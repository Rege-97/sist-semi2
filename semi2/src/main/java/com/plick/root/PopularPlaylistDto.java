package com.plick.root;

public class PopularPlaylistDto {
	int playlistId;
	String playlistName;
	String playlistMood1;
	String playlistMood2;
	
	
	
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



	public String getPlaylistMood1() {
		return playlistMood1;
	}



	public void setPlaylistMood1(String playlistMood1) {
		this.playlistMood1 = playlistMood1;
	}



	public String getPlaylistMood2() {
		return playlistMood2;
	}



	public void setPlaylistMood2(String playlistMood2) {
		this.playlistMood2 = playlistMood2;
	}



	//인기 플리 조회/분위기 플리 조회
	public PopularPlaylistDto(int playlistId, String playlistName, String playlistMood1, String playlistMood2) {
		super();
		this.playlistId = playlistId;
		this.playlistName = playlistName;
		this.playlistMood1 = playlistMood1;
		this.playlistMood2 = playlistMood2;
	}

}
