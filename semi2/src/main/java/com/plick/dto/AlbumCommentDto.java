package com.plick.dto;

import java.sql.Timestamp;

public class AlbumCommentDto {
	private int id;
	private int memberId;
	private int albumId;
	private String content;
	private Timestamp createdAt;
	private int parentId;

	public AlbumCommentDto() {
	}

	public AlbumCommentDto(int id, int memberId, int albumId, String content, Timestamp createdAt, int parentId) {
		super();
		this.id = id;
		this.memberId = memberId;
		this.albumId = albumId;
		this.content = content;
		this.createdAt = createdAt;
		this.parentId = parentId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getAlbumId() {
		return albumId;
	}

	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

}
