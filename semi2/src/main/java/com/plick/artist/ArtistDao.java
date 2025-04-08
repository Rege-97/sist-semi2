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
import com.plick.dto.Playlist;
import com.plick.dto.Song;
import com.plick.playlist.PlaylistPreviewDto;

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
						com.plick.dto.Album albumData = new com.plick.dto.Album(albumId, rs.getInt("album_member_id"),
								rs.getString("album_name"), rs.getString("album_description"),
								rs.getString("album_genre1"), rs.getString("album_genre2"),
								rs.getString("album_genre3"), rs.getTimestamp("album_released_at"),
								rs.getTimestamp("album_created_at"));

						albumDto = new ArtistAlbumDto(albumData, new ArrayList<>());
						albumMap.put(albumId, albumDto);
					}
					int songId = rs.getInt("song_id");
					if (!rs.wasNull()) {
						Song songDto = new Song(songId, rs.getInt("song_album_id"), rs.getString("song_name"),
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
		String sql = "SELECT m.id, m.nickname, m.description, m.access_type " + " FROM members m " + " WHERE m.id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {
					return new ArtistMemberDto(memberId, rs.getString("nickname"), rs.getString("description"),
							rs.getString("access_type"),
							findPlaylistPreviewsOrderByCreatedAtByMemberId(memberId, conn));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private List<PlaylistPreviewDto> findPlaylistPreviewsOrderByCreatedAtByMemberId(int memberId, Connection conn) {
		String sql = "SELECT   " + "        p.id AS playlist_id, " + "        m.id AS member_id, "
				+ "        p.name AS playlist_name, " + "        p.created_at AS created_at, "
				+ "        COUNT(DISTINCT l.member_id) AS like_count, "
				+ "        COUNT(DISTINCT ps.song_id) AS song_count, " + "        m.nickname AS member_nickname, "
				+ "        ( " + "            SELECT s.album_id " + "            FROM playlist_songs ps2 "
				+ "            JOIN songs s ON ps2.song_id = s.id " + "            WHERE ps2.playlist_id = p.id "
				+ "              AND ps2.turn = 1 " + "        ) AS first_album_id " + "    FROM playlists p  "
				+ "    LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
				+ "    LEFT JOIN likes l ON p.id = l.playlist_id " + "    LEFT JOIN members m ON p.member_id = m.id "
				+ "    WHERE m.id = ? " + "    GROUP BY p.id, p.name, p.created_at, m.id, m.nickname "
				+ "    ORDER BY p.created_at DESC";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), rs.getInt("like_count"),
							rs.getInt("song_count"), rs.getString("member_nickname"), rs.getInt("first_album_id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;

	}
}
