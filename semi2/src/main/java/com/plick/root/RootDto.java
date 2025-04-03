package com.plick.root;

public class RootDto {
	//최근 앨범 조회를 위한 멤버변수들
	private int albumId;
	private String albumName;
	private int memberId;
	private String memberName;
	//인기 음악 조회를 위한 멤버변수들
	private int viewCount;
	private String songName;
	private int songId;
	//인기 플리 조회/분위기 플리 조회를 위한 멤버변수들
	private int playlistId;
	private String playlistName;
	private String playlistMood1;
	private String playlistMood2;
	
	public RootDto() {
		// TODO Auto-generated constructor stub
		System.out.println("RootDto객체 생성 성공");
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int id) {
		this.albumId = id;
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

	

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	

	public int getViewCount() {
		return viewCount;
	}
	
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}


	public String getSongName() {
		return songName;
	}

	public void setSongName(String songName) {
		this.songName = songName;
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
	//최근 앨범 조회 생성자
	public RootDto(int albumId, String albumName, int member_id, String memberName) {
		super();
		this.albumId = albumId;
		this.albumName = albumName;
		this.memberId = member_id;
		this.memberName = memberName;
	}

	//인기 음악 조회
	public RootDto(int albumId, int memberId, String memberName, String songName, int songId) {
		super();
		this.albumId = albumId;
		this.memberId = memberId;
		this.memberName = memberName;
		this.songName = songName;
		this.songId = songId;
	}
	//인기 플리 조회/분위기 플리 조회
	public RootDto(int playlistId, String playlistName, String playlistMood1, String playlistMood2) {
		super();
		this.playlistId = playlistId;
		this.playlistName = playlistName;
		this.playlistMood1 = playlistMood1;
		this.playlistMood2 = playlistMood2;
	}

	
	
	
	
	
}
