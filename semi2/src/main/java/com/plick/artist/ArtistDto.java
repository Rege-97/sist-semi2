package com.plick.artist;

import java.util.List;

public class ArtistDto extends com.plick.artist.ArtistMemberDto {

	private List<ArtistAlbumDto> albums;

	public ArtistDto(ArtistMemberDto memberDto, List<ArtistAlbumDto> albums) {
		super(memberDto);
		this.albums = albums;

	}

	public List<ArtistAlbumDto> getAlbums() {
		return albums;
	}
}
