package com.plick.album;

public class SongsDto {
	private int id;
	private int album_id;
	private String name;
	private String composer;
	private String lyricist;
	private String lyrics;
	private int view_count;
	
	public SongsDto() {
	}

	public SongsDto(int id, int album_id, String name, String composer, String lyricist, String lyrics,
			int view_count) {
		super();
		this.id = id;
		this.album_id = album_id;
		this.name = name;
		this.composer = composer;
		this.lyricist = lyricist;
		this.lyrics = lyrics;
		this.view_count = view_count;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAlbum_id() {
		return album_id;
	}

	public void setAlbum_id(int album_id) {
		this.album_id = album_id;
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

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
}
