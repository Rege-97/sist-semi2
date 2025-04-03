package com.plick.artist;

import java.util.List;

public class ArtistDto extends com.plick.artist.MemberDto {
	private List<AlbumDto> albums;

	public ArtistDto(MemberDto memberDto, List<AlbumDto> albums) {
		super(memberDto);
		this.albums = albums;
	}

	public List<AlbumDto> getAlbums() {
		return albums;
	}

}
