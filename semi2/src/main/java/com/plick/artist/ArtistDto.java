package com.plick.artist;

import java.util.List;

import com.plick.dto.PlaylistDto;

public class ArtistDto extends com.plick.artist.MemberDto {
	private List<AlbumDto> albums;

	public ArtistDto(int id, String nickname, String description, List<PlaylistDto> playlistDtos,
			List<AlbumDto> albums) {
		super(id, nickname, description, playlistDtos);
		this.albums = albums;
	}

	public List<AlbumDto> getAlbums() {
		return albums;
	}

}
