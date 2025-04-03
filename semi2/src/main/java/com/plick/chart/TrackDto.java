package com.plick.chart;

public class TrackDto {
	private int rnum;
	private int id;
	private int albumId;
	private String name;
	private String artist;
	private String albumName;
	
	public TrackDto() {

	}

	public TrackDto(int rnum, int id, int albumId, String name, String artist, String albumName) {
		super();
		this.rnum = rnum;
		this.id = id;
		this.albumId = albumId;
		this.name = name;
		this.artist = artist;
		this.albumName = albumName;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
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

	
}
