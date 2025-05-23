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
import com.plick.playlist.PlaylistPreviewDto;

public class PlaylistMainDao {
	/**
	 * @param limit 몇개를 가져올지 설정함
	 * @return 예외 발생시 빈 map 객체를 반환할 수 있음. 정상작동시 "latest" 키에는 limit 만큼 최신순
	 *         PlaylistPreviewDto가 List 에 들어있음. 정상작동시 "popular" 키에는 limit 만큼 좋아요순
	 *         PlaylistPreviewDto가 List 에 들어있음.
	 */
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
				+ "        p.created_at AS created_at, " + "        NVL(song_counts.song_count, 0) AS song_count, "
				+ "        m.nickname AS member_nickname, " + "        s.album_id AS first_album_id "
				+ "    FROM playlists p " + "    LEFT JOIN members m ON p.member_id = m.id " + "    LEFT JOIN ( "
				+ "        SELECT playlist_id, COUNT(DISTINCT song_id) AS song_count " + "        FROM playlist_songs "
				+ "        GROUP BY playlist_id " + "    ) song_counts ON p.id = song_counts.playlist_id "
				+ "    LEFT JOIN ( " + "        SELECT playlist_id, song_id " + "        FROM playlist_songs "
				+ "        WHERE turn = 1 " + "    ) ps2 ON p.id = ps2.playlist_id "
				+ "    LEFT JOIN songs s ON ps2.song_id = s.id " + "    ORDER BY p.created_at DESC " + ") "
				+ "WHERE ROWNUM <= ?";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, limit);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), -1, rs.getInt("song_count"),
							rs.getString("member_nickname"), rs.getInt("first_album_id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;
	}

	private List<PlaylistPreviewDto> findPlaylistsPopularByLimit(int limit, Connection conn) {
		String sql = "SELECT *  " + "FROM (  " + "    SELECT inner_.*, ROWNUM rn  " + "    FROM (  "
				+ "        SELECT  " + "            p.id AS playlist_id,  " + "            m.id AS member_id,  "
				+ "            p.name AS playlist_name,  " + "            p.created_at AS created_at,  "
				+ "            sc.song_count,  " + "            NVL(plc.like_count, 0) AS like_count,  "
				+ "            m.nickname AS member_nickname,  " + "            s.album_id AS first_album_id  "
				+ "        FROM playlists p  " + "        LEFT JOIN members m ON p.member_id = m.id  "
				+ "        LEFT JOIN (  " + "            SELECT playlist_id, COUNT(*) AS song_count  "
				+ "            FROM playlist_songs  " + "            GROUP BY playlist_id  "
				+ "        ) sc ON p.id = sc.playlist_id  "
				+ "        LEFT JOIN playlist_like_count plc ON p.id = plc.playlist_id  " + "        LEFT JOIN (  "
				+ "            SELECT playlist_id, song_id  " + "            FROM playlist_songs  "
				+ "            WHERE turn = 1  " + "        ) ps2 ON p.id = ps2.playlist_id  "
				+ "        LEFT JOIN songs s ON ps2.song_id = s.id  "
				+ "        ORDER BY NVL(plc.like_count, 0) DESC NULLS LAST  " + "    ) inner_  "
				+ "    WHERE ROWNUM <= ?  " + ")";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, limit);
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
