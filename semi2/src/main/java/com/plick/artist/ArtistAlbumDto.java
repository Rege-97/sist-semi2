package com.plick.artist;

import java.util.List;

import com.plick.dto.Song;

public class ArtistAlbumDto {
	private com.plick.dto.Album albumDto;
	private List<Song> songDtos;

	public ArtistAlbumDto(com.plick.dto.Album albumDto, List<Song> songDtos) {
		super();
		this.albumDto = albumDto;
		this.songDtos = songDtos;
	}

	public com.plick.dto.Album getAlbumDto() {
		return albumDto;
	}

	public List<Song> getSongDtos() {
		return songDtos;
	}

}
