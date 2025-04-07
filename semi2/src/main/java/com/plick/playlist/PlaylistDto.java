package com.plick.playlist;

import java.util.List;

import com.plick.dto.Playlist;

public class PlaylistDto {
	private MemDto memberDto;
	private Playlist playlist;
	private List<PlaylistSongDto> playlistSongDtos;
	private long likeCount;

	public PlaylistDto(MemDto memberDto, Playlist playlist, List<PlaylistSongDto> playlistSongDtos, long likeCount) {
		super();
		this.memberDto = memberDto;
		this.playlist = playlist;
		this.playlistSongDtos = playlistSongDtos;
		this.likeCount = likeCount;
	}

	public MemDto getMemberDto() {
		return memberDto;
	}

	public Playlist getPlaylist() {
		return playlist;
	}

	public List<PlaylistSongDto> getPlaylistSongDtos() {
		return playlistSongDtos;
	}

	public long getLikeCount() {
		return likeCount;
	}

}
