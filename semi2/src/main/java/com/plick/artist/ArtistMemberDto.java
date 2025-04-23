package com.plick.artist;

import java.util.List;

import com.plick.playlist.PlaylistPreviewDto;

public class ArtistMemberDto {
	private int id;
	private String nickname;
	private String description;
	private String accessType;
	private List<PlaylistPreviewDto> playlists;

	public ArtistMemberDto(ArtistMemberDto memberDto) {
		this.id = memberDto.getId();
		this.nickname = memberDto.getNickname();
		this.description = memberDto.getDescription();
		this.accessType = memberDto.getAccessType();
		this.playlists = memberDto.getPlaylists();
	}

	public ArtistMemberDto(int id, String nickname, String description, String accessType,
			List<PlaylistPreviewDto> playlists) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.description = description;
		this.accessType = accessType;
		this.playlists = playlists;
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

	public String getAccessType() {
		return accessType;
	}

	public List<PlaylistPreviewDto> getPlaylists() {
		return playlists;
	}

}
