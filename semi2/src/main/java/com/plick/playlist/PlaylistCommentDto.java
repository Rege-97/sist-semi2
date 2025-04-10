package com.plick.playlist;

import java.sql.Timestamp;

import com.plick.dto.PlaylistComment;

public class PlaylistCommentDto {
	private int memberId;
	private String nickname;
	private int commentId;
	private int playlistId;
	private String content;
	private Timestamp createdAt;
	private int parentId;

	public PlaylistCommentDto(int memberId, String nickname, int commentId, int playlistId, String content,
			Timestamp createdAt, int parentId) {
		super();
		this.memberId = memberId;
		this.nickname = nickname;
		this.commentId = commentId;
		this.playlistId = playlistId;
		this.content = content;
		this.createdAt = createdAt;
		this.parentId = parentId;
	}

	public int getMemberId() {
		return memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public int getCommentId() {
		return commentId;
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public String getContent() {
		return content;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public int getParentId() {
		return parentId;
	}

}
