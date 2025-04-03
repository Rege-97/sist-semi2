package com.plick.artist;

import java.util.List;

import com.plick.dto.PlaylistDto;

public class ArtistMemberDto {
	private int id;
	private String nickname;
	private String description;
	private List<PlaylistDto> playlistDtos;

	public ArtistMemberDto(int id, String nickname, String description, List<PlaylistDto> playlistDtos) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.description = description;
		this.playlistDtos = playlistDtos;
	}

	public ArtistMemberDto(ArtistMemberDto memberDto) {
		this.id = memberDto.getId();
		this.nickname = memberDto.getNickname();
		this.description = memberDto.getDescription();
		this.playlistDtos = memberDto.getPlaylistDtos();
	}

	public int getId() {
		return id;
	}

	public String getNickname() {
		return nickname;
	}

	public String getDescription() {
		return description;
	}

	public List<PlaylistDto> getPlaylistDtos() {
		return playlistDtos;
	}

}
