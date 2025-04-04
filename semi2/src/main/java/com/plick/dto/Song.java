package com.plick.dto;

public class Song {
	private int id;
	private int albumId;
	private String name;
	private String composer;
	private String lyricist;
	private String lyrics;
	private int viewCount;

	public Song() {
	}

	public Song(int id, int albumId, String name, String composer, String lyricist, String lyrics, int viewCount) {
		super();
		this.id = id;
		this.albumId = albumId;
		this.name = name;
		this.composer = composer;
		this.lyricist = lyricist;
		this.lyrics = lyrics;
		this.viewCount = viewCount;
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

}
