package com.plick.playlist;

import java.util.List;

public class PlaylistDetailDto {
	private PlaylistDto playlistDto;
	private List<PlaylistCommentDto> playlistCommentDtos;

	public PlaylistDetailDto(PlaylistDto playlistDto, List<PlaylistCommentDto> playlistCommentDtos) {
		super();
		this.playlistDto = playlistDto;
		this.playlistCommentDtos = playlistCommentDtos;
	}

	public PlaylistDto getPlaylistDto() {
		return playlistDto;
	}

	public List<PlaylistCommentDto> getPlaylistCommentDtos() {
		return playlistCommentDtos;
	}

}
