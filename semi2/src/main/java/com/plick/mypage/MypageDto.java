package com.plick.mypage;

public class MypageDto {
	private int rnum;
	private int id;
	private String name;
	
	public MypageDto() {
		
	}

	public MypageDto(int rnum, int id, String name) {
		super();
		this.rnum = rnum;
		this.id = id;
		this.name = name;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
