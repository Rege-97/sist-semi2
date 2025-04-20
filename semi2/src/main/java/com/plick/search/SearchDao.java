package com.plick.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

public class SearchDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	// 앨범 검색 최신순
	public ArrayList<SearchAlbumDto> searchAlbums(String search, int currentPage, int pageSize) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage - 1) * pageSize + 1;
			int end = currentPage * pageSize;
			String sql = "select *  " + "from (select rownum rn, alb.*,members.nickname "
					+ "    from (select * from albums where lower(name) like lower(?) order by released_at desc) alb "
					+ "        left join members " + "        on alb.member_id = members.id ) "
					+ "where rn >=? and rn <=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<SearchAlbumDto> arr = new ArrayList<SearchAlbumDto>();
			while (rs.next()) {
				int albumId = rs.getInt("id");
				int memberId = rs.getInt("member_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String genre1 = rs.getString("genre1");
				String genre2 = rs.getString("genre2");
				String genre3 = rs.getString("genre3");
				Timestamp releasedAt = rs.getTimestamp("released_at");
				Timestamp createdAt = rs.getTimestamp("created_at");
				String nickname = rs.getString("nickname");
				SearchAlbumDto dto = new SearchAlbumDto(albumId, memberId, name, description, genre1, genre2, genre3,
						releasedAt, createdAt, nickname);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	// 아티스트 검색
	public ArrayList<SearchArtistDto> searchAritists(String search, int currentPage, int pageSize) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage - 1) * pageSize + 1;
			int end = currentPage * pageSize;
			String sql = "select * from (select rownum rn, mem.id member_id, mem.name, mem.nickname memnickname, mem.email, mem.access_type  "
					+ "    from (select * from members where lower(members.nickname) like lower(?)) mem) "
					+ "where rn >=? and rn <=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<SearchArtistDto> arr = new ArrayList<SearchArtistDto>();
			while (rs.next()) {
				int memberId = rs.getInt("member_id");
				String name = rs.getString("name");
				String nickname = rs.getString("memnickname");
				String email = rs.getString("email");
				String accessType = rs.getString("access_type");

				SearchArtistDto dto = new SearchArtistDto(memberId, name, nickname, email, accessType);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	// 노래 검색 최신순
	public ArrayList<SearchSongDto> searchSongs(String search, int currentPage, int pageSize) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage - 1) * pageSize + 1;
			int end = currentPage * pageSize;
			String sql = "select * from (select rownum rn, so.* "
					+ "    from (select songs.id song_id,songs.name song_name,albums.id album_id,albums.created_at, "
					+ "            albums.name album_name,albums.member_id,members.nickname "
					+ "        from songs,albums,members  "
					+ "        where songs.album_id = albums.id and members.id=albums.member_id  "
					+ "        and lower(songs.name) like lower(?) "
					+ "        order by created_at desc) so) where rn >=? and rn <=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<SearchSongDto> arr = new ArrayList<SearchSongDto>();
			while (rs.next()) {
				int songId = rs.getInt("song_id");
				String songName = rs.getString("song_name");
				int albumId = rs.getInt("album_id");
				Timestamp createdAt = rs.getTimestamp("created_at");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");
				String nickname = rs.getString("nickname");

				SearchSongDto dto = new SearchSongDto(songId, songName, albumId, createdAt, albumName, memberId,
						nickname);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	// 플리 검색 최신순
	public ArrayList<SearchPlaylistDto> searchPlaylists(String search, int currentPage, int pageSize) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage - 1) * pageSize + 1;
			int end = currentPage * pageSize;
			String sql = "SELECT * FROM (" + "    SELECT rownum rn, pl.* FROM (" + "        SELECT "
					+ "            p.id AS playlist_id, " + "            m.id AS member_id, "
					+ "            p.name AS playlist_name, " + "            p.created_at AS created_at, "
					+ "            COUNT(DISTINCT ps.song_id) AS song_count, "
					+ "            NVL(plc.like_count, 0) AS like_count, "
					+ "            m.nickname AS member_nickname, " + "            s.album_id AS first_album_id "
					+ "        FROM playlists p " + "        LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
					+ "        LEFT JOIN playlist_like_count plc ON p.id = plc.playlist_id "
					+ "        LEFT JOIN members m ON p.member_id = m.id "
					+ "        LEFT JOIN playlist_songs ps2 ON p.id = ps2.playlist_id AND ps2.turn = 1 "
					+ "        LEFT JOIN songs s ON ps2.song_id = s.id " + "        WHERE LOWER(p.name) LIKE LOWER(?) " // 여기!
					+ "        GROUP BY p.id, p.name, p.created_at, m.id, m.nickname, plc.like_count, s.album_id "
					+ "        ORDER BY p.created_at DESC " + "    ) pl " + ") " + "WHERE rn >= ? AND rn <= ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<SearchPlaylistDto> arr = new ArrayList<SearchPlaylistDto>();
			while (rs.next()) {
				int playlistId = rs.getInt("playlist_id");
				int memberId = rs.getInt("member_id");
				String playlistName = rs.getString("playlist_name");
				Timestamp createdAt = rs.getTimestamp("created_at");
				int songCount = rs.getInt("song_count");
				int likeCount = rs.getInt("like_count");
				String nickname = rs.getString("member_nickname");
				;
				int firstAlbumId = rs.getInt("first_album_id");

				SearchPlaylistDto dto = new SearchPlaylistDto(playlistId, memberId, playlistName, createdAt, songCount,
						likeCount, nickname, firstAlbumId);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	// 무드 검색 인기순
	public ArrayList<SearchMoodDto> searchMood(String search, int currentPage, int pageSize) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage - 1) * pageSize + 1;
			int end = currentPage * pageSize;
			String sql = "SELECT * FROM (" + "    SELECT rownum rn, pl.* FROM (" + "        SELECT "
					+ "            p.id AS playlist_id, " + "            p.mood1, " + "            p.mood2, "
					+ "            m.id AS member_id, " + "            p.name AS playlist_name, "
					+ "            p.created_at AS created_at, "
					+ "            COUNT(DISTINCT ps.song_id) AS song_count, "
					+ "            NVL(plc.like_count, 0) AS like_count, "
					+ "            m.nickname AS member_nickname, " + "            s.album_id AS first_album_id "
					+ "        FROM playlists p " + "        LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
					+ "        LEFT JOIN playlist_like_count plc ON p.id = plc.playlist_id "
					+ "        LEFT JOIN members m ON p.member_id = m.id "
					+ "        LEFT JOIN playlist_songs ps2 ON p.id = ps2.playlist_id AND ps2.turn = 1 "
					+ "        LEFT JOIN songs s ON ps2.song_id = s.id "
					+ "        GROUP BY p.id, p.name, p.created_at, p.mood1, p.mood2, m.id, m.nickname, plc.like_count, s.album_id "
					+ "        ORDER BY like_count DESC " + "    ) pl " + ") "
					+ "WHERE rn >= ? AND rn <= ? AND (mood1 LIKE ? OR mood2 LIKE ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			ps.setString(3, "%" + search + "%");
			ps.setString(4, "%" + search + "%");
			rs = ps.executeQuery();
			ArrayList<SearchMoodDto> arr = new ArrayList<SearchMoodDto>();
			while (rs.next()) {
				int playlistId = rs.getInt("playlist_id");
				String mood1 = rs.getString("mood1");
				String mood2 = rs.getString("mood2");
				int memberId = rs.getInt("member_id");
				String playlistName = rs.getString("playlist_name");
				Timestamp createdAt = rs.getTimestamp("created_at");
				int songCount = rs.getInt("song_count");
				int likeCount = rs.getInt("like_count");
				String nickname = rs.getString("member_nickname");
				;
				int firstAlbumId = rs.getInt("first_album_id");

				SearchMoodDto dto = new SearchMoodDto(playlistId, mood1, mood2, memberId, playlistName, createdAt,
						songCount, likeCount, nickname, firstAlbumId);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	// 앨범 검색 전체 데이터 수
	// "select count(*) from albums where name like ?"
	// 노래 검색 전체 데이터 수
	// select count(*) from songs where name like '%스%'
	// 플리 검색 전체 데이터 수
	// select count(*) from playlists where name like '%스%'
	// 아티스트 검색 전체 데이터 수
	// select count(*) from members where nickname like '%스%'
	public int showTotalResults(String table, String column, String search) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select count(*) from " + table + " where lower(" + column + ") like lower(?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			rs = ps.executeQuery();
			if (!rs.next())
				return -1;
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

}
