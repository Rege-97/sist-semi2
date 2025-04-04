package com.plick.playlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.plick.db.DBConnector;
import com.plick.dto.Album;
import com.plick.dto.Playlist;
import com.plick.dto.PlaylistComment;
import com.plick.dto.Song;

public class PlaylistDao {

	public PlaylistDetailDto findPlaylistDetailByPlaylistId(int playlistId) {
		try (Connection conn = DBConnector.getConn();) {
			PlaylistDto playlistDto = findPlaylistByPlaylistId(playlistId, conn);
			if (playlistDto == null) {
				return null;
			}
			List<PlaylistCommentDto> playlistCommentDtos = findPlaylistCommentDtosByPlaylistId(playlistId, conn);
			if (playlistCommentDtos == null) {
				playlistCommentDtos = new ArrayList<PlaylistCommentDto>();
			}
			return new PlaylistDetailDto(playlistDto, playlistCommentDtos);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private PlaylistDto findPlaylistByPlaylistId(int playlistId, Connection conn) {
		String sql = "SELECT  " + "    p.id AS playlist_id, " + "    p.member_id AS playlist_member_id, "
				+ "    p.name AS playlist_name, " + "    p.created_at AS playlist_created_at, "
				+ "    p.mood1 AS playlist_mood1, " + "    p.mood2 AS playlist_mood2, "
				+ "    m.nickname AS member_nickname, " + "    m.id AS member_id, "
				+ "    m.access_type AS member_access_type, " + "    ps.id AS playlist_song_id, "
				+ "    ps.song_id AS playlist_song_song_id, " + "    ps.playlist_id AS playlist_song_playlist_id, "
				+ "    ps.turn AS playlist_song_turn, " + "    s.id AS song_id, " + "    s.album_id AS song_album_id, "
				+ "    s.name AS song_name, " + "    s.view_count AS song_view_count, " + "    a.id AS album_id, "
				+ "    a.name AS album_name, " + "    m2.nickname AS album_member_nickname, " 
				+ "    m2.id AS album_member_id "
				+ "    FROM  "
				+ "    playlists p " + "LEFT JOIN members m ON p.member_id = m.id "
				+ "LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id " + "LEFT JOIN songs s ON ps.song_id = s.id "
				+ "LEFT JOIN albums a ON a.id = s.album_id " + " LEFT JOIN members m2 ON m2.id = a.member_id "
				+ "WHERE  " + "    p.id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				if (!rs.next()) {
					return null;
				}
				long likeCount = findLikeCountByPlaylistId(playlistId, conn);

				MemDto memberDto = new MemDto(rs.getInt("member_id"), rs.getString("member_nickname"),
						rs.getString("member_access_type"));

				Playlist playlist = new Playlist(rs.getInt("playlist_id"), rs.getInt("playlist_member_id"),
						rs.getString("playlist_name"), rs.getTimestamp("playlist_created_at"),
						rs.getString("playlist_mood1"), rs.getString("playlist_mood2"));

				List<PlaylistSongDto> playlistSongDtos = new ArrayList<PlaylistSongDto>();
				do {
					int playlistSongId = rs.getInt("playlist_song_id");
					if (!rs.wasNull()) {
						playlistSongDtos.add(new PlaylistSongDto(playlistSongId,
								new Song(rs.getInt("song_id"), rs.getInt("song_album_id"), rs.getString("song_name"),
										"", "", "", rs.getInt("song_view_count")),
								rs.getInt("playlist_song_playlist_id"), rs.getInt("playlist_song_turn"),
								rs.getInt("album_id"), rs.getString("album_name"),
								rs.getString("album_member_nickname"), rs.getInt("album_member_id")));
					}
				} while (rs.next());

				return new PlaylistDto(memberDto, playlist, playlistSongDtos, likeCount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private long findLikeCountByPlaylistId(int playlistId, Connection conn) {
		String sql = "SELECT COUNT(*) AS total_count " + "FROM likes WHERE playlist_id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				return rs.next() ? rs.getInt("total_count") : -1L;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1L;
	}

	private List<PlaylistCommentDto> findPlaylistCommentDtosByPlaylistId(int playlistId, Connection conn) {
		String sql = "SELECT  " + "    pc.id AS playlist_comment_id, "
				+ "    pc.member_id AS playlist_comment_member_id, "
				+ "    pc.playlist_id AS playlist_comment_playlist_id, "
				+ "    pc.content AS playlist_comment_content, " + "    pc.created_at AS playlist_comment_created_at, "
				+ "    pc.parent_id AS playlist_comment_parent_id, " + "    m.id AS member_id, "
				+ "    m.nickname AS member_nickname, " + "    m.access_type AS member_access_type " + "FROM "
				+ "    playlist_comments pc " + "LEFT JOIN  " + "    members m ON pc.member_id = m.id " + "WHERE  "
				+ "    pc.playlist_id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				if (!rs.next()) {
					return null;
				}
				List<PlaylistCommentDto> playlistCommentDtos = new ArrayList<PlaylistCommentDto>();
				MemDto memberDto = new MemDto(rs.getInt("member_id"), rs.getString("member_nickname"),
						rs.getString("member_access_type"));
				do {
					playlistCommentDtos.add(new PlaylistCommentDto(memberDto, new PlaylistComment(
							rs.getInt("playlist_comment_id"), rs.getInt("playlist_comment_member_id"),
							rs.getInt("playlist_comment_playlist_id"), rs.getString("playlist_comment_content"),
							rs.getTimestamp("playlist_comment_created_at"), rs.getInt("playlist_comment_parent_id"))));
				} while (rs.next());
				return playlistCommentDtos;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
