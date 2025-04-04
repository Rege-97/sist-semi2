package com.plick.playlist;

import com.plick.dto.PlaylistComment;

public class PlaylistCommentDto {
	private MemDto memberDto;
	private PlaylistComment playlistComment;
	
	public PlaylistCommentDto(MemDto memberDto, PlaylistComment playlistComment) {
		super();
		this.memberDto = memberDto;
		this.playlistComment = playlistComment;
	}

	public MemDto getMemberDto() {
		return memberDto;
	}

	public PlaylistComment getPlaylistComment() {
		return playlistComment;
	}

	
}
