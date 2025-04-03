package com.plick.root;

public class RootDto {
	private int id;
	private String albumName;
	private int member_id;
	private String memberName;
	
	public RootDto() {
		// TODO Auto-generated constructor stub
		System.out.println("RootDto객체 생성 성공");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAlbumName() {
		return albumName;
	}

	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}

	public int getMember_id() {
		return member_id;
	}

	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public RootDto(int id, String albumName, int member_id, String memberName) {
		super();
		this.id = id;
		this.albumName = albumName;
		this.member_id = member_id;
		this.memberName = memberName;
	}
	
	
	
	
}
