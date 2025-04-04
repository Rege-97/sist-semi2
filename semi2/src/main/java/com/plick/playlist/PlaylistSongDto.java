package com.plick.playlist;

import com.plick.dto.Song;

public class PlaylistSongDto {
	private int id;
	private Song song;
	private int playlistId;
	private int turn;
	private int albumId;
	private String albumName;
	private String memberNickname;
	private int memberId;

	public PlaylistSongDto(int id, Song song, int playlistId, int turn, int albumId, String albumName,
			String memberNickname, int memberId) {
		super();
		this.id = id;
		this.song = song;
		this.playlistId = playlistId;
		this.turn = turn;
		this.albumId = albumId;
		this.albumName = albumName;
		this.memberNickname = memberNickname;
		this.memberId = memberId;
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

	public int getAlbumId() {
		return albumId;
	}

	public String getAlbumName() {
		return albumName;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public int getMemberId() {
		return memberId;
	}

}
