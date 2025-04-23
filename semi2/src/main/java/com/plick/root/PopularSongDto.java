package com.plick.root;

public class PopularSongDto {
	int albumId;
	int memberId;
	String memberNickname;
	String songName;
	int songId;

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
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

	// 인기 음악 조회
	public PopularSongDto(int albumId, int memberId, String memberNickname, String songName, int songId) {
		super();
		this.albumId = albumId;
		this.memberId = memberId;
		this.memberNickname = memberNickname;
		this.songName = songName;
		this.songId = songId;
	}

}
