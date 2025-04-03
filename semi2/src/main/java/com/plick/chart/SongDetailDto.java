package com.plick.chart;

public class SongDetailDto {
	private int id;
	private int albumId;
	private String name;
	private String composer;
	private String lyricist;
	private String lyrics;
	private int viewCount;
	private String artist;
	private String albumName;
	private int memberId;
	
	public SongDetailDto() {

	}
	
	public SongDetailDto(int id, int albumId, String name, String composer, String lyricist, String lyrics,
			int viewCount, String artist, String albumName, int memberId) {
		super();
		this.id = id;
		this.albumId = albumId;
		this.name = name;
		this.composer = composer;
		this.lyricist = lyricist;
		this.lyrics = lyrics;
		this.viewCount = viewCount;
		this.artist = artist;
		this.albumName = albumName;
		this.memberId = memberId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComposer() {
		return composer;
	}

	public void setComposer(String composer) {
		this.composer = composer;
	}

	public String getLyricist() {
		return lyricist;
	}

	public void setLyricist(String lyricist) {
		this.lyricist = lyricist;
	}

	public String getLyrics() {
		return lyrics;
	}

	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
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
	
	
	
}