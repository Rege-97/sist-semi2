package com.plick.root;

public class RecentAlbumDto {
	private int albumId;
	private String albumName;
	private int memberId;
	private String memberNickname;

	public RecentAlbumDto() {
		
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
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

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	// 최근 앨범 조회 생성자
	public RecentAlbumDto(int albumId, String albumName, int memberId, String memberNickname) {
		super();
		this.albumId = albumId;
		this.albumName = albumName;
		this.memberId = memberId;
		this.memberNickname = memberNickname;
	}

}
