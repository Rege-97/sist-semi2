package com.plick.playlist;

public class PlaylistSongDto {
	private int id;
	private int songId;
	private String songName;
	private int playlistId;
	private int turn;
	private int albumId;
	private String albumName;
	private String artistNickname;
	private int artistId;

	public PlaylistSongDto(int id, int songId, String songName, int playlistId, int turn, int albumId, String albumName,
			String artistNickname, int artistId) {
		super();
		this.id = id;
		this.songId = songId;
		this.songName = songName;
		this.playlistId = playlistId;
		this.turn = turn;
		this.albumId = albumId;
		this.albumName = albumName;
		this.artistNickname = artistNickname;
		this.artistId = artistId;
	}

	public int getId() {
		return id;
	}

	public int getSongId() {
		return songId;
	}

	public String getSongName() {
		return songName;
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

	public String getArtistNickname() {
		return artistNickname;
	}

	public int getArtistId() {
		return artistId;
	}

}
