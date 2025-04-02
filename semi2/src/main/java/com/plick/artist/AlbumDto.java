package com.plick.artist;

import java.util.List;

import com.plick.dto.SongDto;

public class AlbumDto {
	private com.plick.dto.AlbumDto albumDto;
	private List<SongDto> songDtos;

	public AlbumDto(com.plick.dto.AlbumDto albumDto, List<SongDto> songDtos) {
		super();
		this.albumDto = albumDto;
		this.songDtos = songDtos;
	}

	public com.plick.dto.AlbumDto getAlbumDto() {
		return albumDto;
	}

	public List<SongDto> getSongDtos() {
		return songDtos;
	}

}
