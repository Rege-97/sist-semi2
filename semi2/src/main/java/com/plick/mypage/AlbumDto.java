package com.plick.mypage;

import java.sql.Timestamp;

public class AlbumDto {

	private int id;
	private int member_id;
	private String name;
	private String discription;
	private String genre1;
	private String genre2;
	private String genre3;
	private Timestamp released_at;
	private Timestamp created_at;
	
	public AlbumDto() {
	}
	
	public AlbumDto(int id, int member_id, String name, String discription, String genre1, String genre2, String genre3,
			Timestamp released_at, Timestamp created_at) {
		super();
		this.id = id;
		this.member_id = member_id;
		this.name = name;
		this.discription = discription;
		this.genre1 = genre1;
		this.genre2 = genre2;
		this.genre3 = genre3;
		this.released_at = released_at;
		this.created_at = created_at;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public String getGenre1() {
		return genre1;
	}
	public void setGenre1(String genre1) {
		this.genre1 = genre1;
	}
	public String getGenre2() {
		return genre2;
	}
	public void setGenre2(String genre2) {
		this.genre2 = genre2;
	}
	public String getGenre3() {
		return genre3;
	}
	public void setGenre3(String genre3) {
		this.genre3 = genre3;
	}
	public Timestamp getReleased_at() {
		return released_at;
	}
	public void setReleased_at(Timestamp released_at) {
		this.released_at = released_at;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
}
