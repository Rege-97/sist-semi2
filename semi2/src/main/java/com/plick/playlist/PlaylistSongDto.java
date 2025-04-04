package com.plick.playlist;

import com.plick.dto.Song;

public class PlaylistSongDto {
	private int id;
	private Song song;
	private int playlistId;
	private int turn;
	
	public PlaylistSongDto(int id, Song song, int playlistId, int turn) {
		super();
		this.id = id;
		this.song = song;
		this.playlistId = playlistId;
		this.turn = turn;
	}
	public int getId() {
		return id;
	}
	public Song getSong() {
		return song;
	}
	public int getPlaylistId() {
		return playlistId;
	}
	public int getTurn() {
		return turn;
	}

}
