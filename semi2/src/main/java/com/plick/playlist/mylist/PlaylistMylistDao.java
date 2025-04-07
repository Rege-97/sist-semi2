package com.plick.playlist.mylist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.plick.db.DBConnector;
import com.plick.playlist.PlaylistPreviewDto;

public class PlaylistMylistDao {
	public List<PlaylistPreviewDto> findPlaylistPreviewsOrderByCreatedAtByMemberId(int memberId) {
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
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
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

	public boolean addPlaylistByMemberId(int memberId) {
		String sql = "INSERT INTO playlists (id, member_id, name, created_at, mood1, mood2) "
				+ "VALUES (seq_playlists_id.NEXTVAL, ?, ?, SYSTIMESTAMP, ?, ?)";

		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			int playlistCount = findCountPlaylistByMemberId(memberId, conn);
			pstmt.setString(2, playlistCount + 1 + "번 플레이리스트");
			pstmt.setString(3, null);
			pstmt.setString(4, null);

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private int findCountPlaylistByMemberId(int memberId, Connection conn) {
		String sql = "SELECT COUNT(*) AS playlist_count " + "FROM playlists p " + "WHERE p.member_id = ? ";

		int playlistCount = -1;
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					playlistCount = rs.getInt("playlist_count");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistCount;
	}

}
