package com.plick.artist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.plick.db.DBConnector;
import com.plick.dto.PlaylistDto;
import com.plick.dto.SongDto;

public class ArtistDao {
	public ArtistDto findArtistDetailsByMemberId(int memberId) {
		try (Connection conn = DBConnector.getConn();) {

			ArtistMemberDto memberDto = findMemberDetailsByMemberId(memberId, conn);
			List<ArtistAlbumDto> albumDtos = findAlbumsByMemberId(memberId, conn);

			if (memberDto == null) {
				return null;
			}
			return new ArtistDto(memberDto, albumDtos);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private List<ArtistAlbumDto> findAlbumsByMemberId(int memberId, Connection conn) {
		String sql = "SELECT a.id AS album_id, a.member_id AS album_member_id, a.name AS album_name, "
				+ "a.description AS album_description, a.genre1 AS album_genre1, a.genre2 AS album_genre2, "
				+ "a.genre3 AS album_genre3, a.released_at AS album_released_at, a.created_at AS album_created_at, "
				+ "s.id AS song_id, s.album_id AS song_album_id, s.name AS song_name, s.composer AS song_composer, "
				+ "s.lyricist AS song_lyricist, s.lyrics AS song_lyrics, s.view_count AS song_view_count "
				+ "FROM albums a LEFT JOIN songs s ON a.id = s.album_id WHERE a.member_id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {

				if (!rs.next()) {
					return null;
				}
				Map<Integer, ArtistAlbumDto> albumMap = new HashMap<>();

				do {
					int albumId = rs.getInt("album_id");
					ArtistAlbumDto albumDto = albumMap.get(albumId);
					if (albumDto == null) {
						com.plick.dto.AlbumDto albumData = new com.plick.dto.AlbumDto(albumId,
								rs.getInt("album_member_id"), rs.getString("album_name"),
								rs.getString("album_description"), rs.getString("album_genre1"),
								rs.getString("album_genre2"), rs.getString("album_genre3"),
								rs.getTimestamp("album_released_at"), rs.getTimestamp("album_created_at"));

						albumDto = new ArtistAlbumDto(albumData, new ArrayList<>());
						albumMap.put(albumId, albumDto);
					}
					int songId = rs.getInt("song_id");
					if (!rs.wasNull()) {
						SongDto songDto = new SongDto(songId, rs.getInt("song_album_id"), rs.getString("song_name"),
								rs.getString("song_composer"), rs.getString("song_lyricist"),
								rs.getString("song_lyrics"), rs.getInt("song_view_count"));
						albumDto.getSongDtos().add(songDto);
					}
				} while (rs.next());
				return new ArrayList<>(albumMap.values());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private ArtistMemberDto findMemberDetailsByMemberId(int memberId, Connection conn) {
		String sql = "SELECT m.id, m.nickname, m.description, "
				+ "p.id AS playlist_id, p.member_id AS playlist_member_id, "
				+ "p.name AS playlist_name, p.created_at, p.mood1, p.mood2 FROM members m "
				+ "LEFT JOIN playlists p ON m.id = p.member_id WHERE m.id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {

				if (!rs.next()) {
					return null;
				}
				String nickname = rs.getString("nickname");
				String description = rs.getString("description");

				List<PlaylistDto> playlists = new ArrayList<>();
				do {
					int playlistId = rs.getInt("playlist_id");
					if (!rs.wasNull()) {
						playlists.add(new PlaylistDto(playlistId, rs.getInt("playlist_member_id"),
								rs.getString("playlist_name"), rs.getTimestamp("created_at"), rs.getString("mood1"),
								rs.getString("mood2")));
					}
				} while (rs.next());
				return new ArtistMemberDto(memberId, nickname, description, playlists);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
