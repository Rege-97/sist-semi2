package com.plick.playlist;

import java.sql.Timestamp;
import java.util.List;

public class PlaylistDetailDto {
	private int memberId;
	private String nickname;
	private String accessType;
	private int playlistId;
	private String playlistName;
	private Timestamp createdAt;
	private String mood1;
	private String mood2;
	private long likeCount;
	private List<PlaylistSongDto> playlistSongDtos;
	private List<PlaylistCommentDto> playlistCommentDtos;
	private boolean isLiked;
	private int commentCount;

	public PlaylistDetailDto(int memberId, String nickname, String accessType, int playlistId, String playlistName,
			Timestamp createdAt, String mood1, String mood2, long likeCount, List<PlaylistSongDto> playlistSongDtos,
			List<PlaylistCommentDto> playlistCommentDtos) {
		super();
		this.memberId = memberId;
		this.nickname = nickname;
		this.accessType = accessType;
		this.playlistId = playlistId;
		this.playlistName = playlistName;
		this.createdAt = createdAt;
		this.mood1 = mood1;
		this.mood2 = mood2;
		this.likeCount = likeCount;
		this.playlistSongDtos = playlistSongDtos;
		this.playlistCommentDtos = playlistCommentDtos;
	}

	public int getMemberId() {
		return memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public String getAccessType() {
		return accessType;
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public String getPlaylistName() {
		return playlistName;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public String getMood1() {
		return mood1;
	}

	public String getMood2() {
		return mood2;
	}

	public long getLikeCount() {
		return likeCount;
	}

	public List<PlaylistSongDto> getPlaylistSongDtos() {
		return playlistSongDtos;
	}

	public List<PlaylistCommentDto> getPlaylistCommentDtos() {
		return playlistCommentDtos;
	}

	public void setIsLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}

	public boolean getIsLiked() {
		return isLiked;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

}
