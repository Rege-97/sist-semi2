package com.plick.dto;

public class PlaylistSongDto {
	private int songId;
	private int playlistId;

	public PlaylistSongDto() {
	}

	public PlaylistSongDto(int songId, int playlistId) {
		super();
		this.songId = songId;
		this.playlistId = playlistId;
	}

	public int getSongId() {
		return songId;
	}

	public void setSongId(int songId) {
		this.songId = songId;
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public void setPlaylistId(int playlistId) {
		this.playlistId = playlistId;
	}

}
