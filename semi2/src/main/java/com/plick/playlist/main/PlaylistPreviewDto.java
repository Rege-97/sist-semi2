package com.plick.playlist.main;

import java.sql.Timestamp;

public class PlaylistPreviewDto {
	private int playlistId;
	private int memberId;
	private String playlistName;
	private Timestamp createdAt;
	private int likeCount;
	private int songCount;
	private String memberNickname;

	public PlaylistPreviewDto(int playlistId, int memberId, String playlistName, Timestamp createdAt, int likeCount,
			int songCount, String memberNickname) {
		super();
		this.playlistId = playlistId;
		this.memberId = memberId;
		this.playlistName = playlistName;
		this.createdAt = createdAt;
		this.likeCount = likeCount;
		this.songCount = songCount;
		this.memberNickname = memberNickname;
	}

	public int getPlaylistId() {
		return playlistId;
	}

	public int getMemberId() {
		return memberId;
	}

	public String getPlaylistName() {
		return playlistName;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public int getSongCount() {
		return songCount;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

}
