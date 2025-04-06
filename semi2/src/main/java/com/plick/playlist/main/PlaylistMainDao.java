package com.plick.playlist.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.plick.db.DBConnector;

public class PlaylistMainDao {
	public Map<String, List<PlaylistPreviewDto>> findRecommendedPlaylistsByLimit(int limit) {
		Map<String, List<PlaylistPreviewDto>> result = new HashMap<>();

		try (Connection conn = DBConnector.getConn();) {
			result.put("latest", findPlaylistsLatestByLimit(limit, conn));
			result.put("popular", findPlaylistsPopularByLimit(limit, conn));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	private List<PlaylistPreviewDto> findPlaylistsLatestByLimit(int limit, Connection conn) {
		String sql = "SELECT * " + "FROM ( " + "    SELECT  " + "        p.id AS playlist_id, "
				+ "        m.id AS member_id, " + "        p.name AS playlist_name, "
				+ "        p.created_at AS created_at, " + "        COUNT(DISTINCT l.member_id) AS like_count, "
				+ "        COUNT(DISTINCT ps.song_id) AS song_count, " + "        m.nickname AS member_nickname "
				+ "    FROM  " + "        playlists p " + "    LEFT JOIN  " + "        playlist_songs ps  " + "    ON  "
				+ "        p.id = ps.playlist_id " + "    LEFT JOIN  " + "        likes l  " + "    ON  "
				+ "        p.id = l.playlist_id " + "    LEFT JOIN  " + "        members m  " + "    ON  "
				+ "        p.member_id = m.id " + "    GROUP BY  "
				+ "        p.id, p.name, p.created_at, m.id, m.nickname " + "    ORDER BY  "
				+ "        created_at DESC " + ") " + "WHERE ROWNUM <= ?";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, limit);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), rs.getInt("like_count"),
							rs.getInt("song_count"), rs.getString("member_nickname")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;
	}

	private List<PlaylistPreviewDto> findPlaylistsPopularByLimit(int limit, Connection conn) {
		String sql = "SELECT * " + "FROM ( " + "    SELECT  " + "        p.id AS playlist_id, "
				+ "        m.id AS member_id, " + "        p.name AS playlist_name, "
				+ "        p.created_at AS created_at, " + "        COUNT(DISTINCT l.member_id) AS like_count, "
				+ "        COUNT(DISTINCT ps.song_id) AS song_count, " + "        m.nickname AS member_nickname "
				+ "    FROM  " + "        playlists p " + "    LEFT JOIN  " + "        playlist_songs ps  " + "    ON  "
				+ "        p.id = ps.playlist_id " + "    LEFT JOIN  " + "        likes l  " + "    ON  "
				+ "        p.id = l.playlist_id " + "    LEFT JOIN  " + "        members m  " + "    ON  "
				+ "        p.member_id = m.id " + "    GROUP BY  "
				+ "        p.id, p.name, p.created_at, m.id, m.nickname " + "    ORDER BY  "
				+ "        like_count DESC " + ") " + "WHERE ROWNUM <= ?";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, limit);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), rs.getInt("like_count"),
							rs.getInt("song_count"), rs.getString("member_nickname")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;
	}

}
