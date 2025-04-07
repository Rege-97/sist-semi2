package com.plick.root;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class RootDao {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public RootDao() {
		// TODO Auto-generated constructor stub
	}

	// 최신 앨범 보여주기
	public ArrayList<RecentAlbumDto> showRecentAlbums() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select alb.id, alb.name albname,alb.member_id, members.nickname memnickname, rownum "
					+ "from (select * from albums order by released_at desc) alb,members "
					+ "where alb.member_id = members.id and rownum <=10";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<RecentAlbumDto> arr = new ArrayList<RecentAlbumDto>();
			if (!rs.next()) {
				return null;
			}
			do {
				int albumId = rs.getInt("id");
				String albumName = rs.getString("albname");
				int memberId = rs.getInt("member_id");
				String memberNickname = rs.getString("memnickname");

				RecentAlbumDto dto = new RecentAlbumDto(albumId, albumName, memberId, memberNickname);
				arr.add(dto);
			} while (rs.next());
			return arr;
		} catch (Exception e) {
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

	// 인기 음악 보여주기
	public ArrayList<PopularSongDto> showPopularSongs() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select s.view_count,rownum,alb.id,s.name songname,s.id song_id,alb.memnickname,alb.member_id "
					+ "from (select *  " + "    from songs " + "    order by view_count desc) s, "
					+ "     (select albums.id,albums.member_id,members.name memnickname " + "     from albums,members "
					+ "     where albums.member_id = members.id) alb " + "where s.album_id = alb.id and rownum<=10 "
					+ "order by rownum ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<PopularSongDto> arr = new ArrayList<PopularSongDto>();
			if (!rs.next()) {
				return null;
			}
			do {
				int albumId = rs.getInt("id");// 앨범id
				int memberId = rs.getInt("member_id");
				String memberNickname = rs.getString("memnickname");
				String songName = rs.getString("songname");
				int songId = rs.getInt("song_id");
				PopularSongDto dto = new PopularSongDto(albumId, memberId, memberNickname, songName, songId);
				arr.add(dto);
			} while (rs.next());
			return arr;
		} catch (Exception e) {
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

	// 인기 플리 보여주기
	public ArrayList<PopularPlaylistDto> showPopularPlaylists() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * "
					+ "FROM ( "
					+ "    SELECT "
					+ "        p.id AS playlist_id, "
					+ "        m.id AS member_id, "
					+ "        p.name AS playlist_name, "
					+ "        p.created_at AS created_at, "
					+ "        COUNT(DISTINCT ps.song_id) AS song_count, "
					+ "        COUNT(DISTINCT l.member_id) AS like_count, "
					+ "        m.nickname AS member_nickname, "
					+ "        s.album_id AS first_album_id "
					+ "    FROM playlists p "
					+ "    LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
					+ "    LEFT JOIN likes l ON p.id = l.playlist_id "
					+ "    LEFT JOIN members m ON p.member_id = m.id "
					+ "    LEFT JOIN playlist_songs ps2 ON p.id = ps2.playlist_id AND ps2.turn = 1 "
					+ "    LEFT JOIN songs s ON ps2.song_id = s.id "
					+ "    GROUP BY "
					+ "        p.id, p.name, p.created_at, "
					+ "        m.id, m.nickname, "
					+ "        s.album_id "
					+ "    ORDER BY like_count DESC "
					+ ") "
					+ "WHERE ROWNUM <= 10;";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<PopularPlaylistDto> arr = new ArrayList<PopularPlaylistDto>();
			if (!rs.next()) {
				return null;
			}
			do {
				int playlistId = rs.getInt("id");
				int MemberId = rs.getInt("playlist_id");
				String playlistName = rs.getString("playlist_name");
				Timestamp createdAt = rs.getTimestamp("created_at");
				int songCount = rs.getInt("song_count");;
				int likeCount = rs.getInt("like_count");
				String memberNickname = rs.getString("member_nickname");
				int firstAlbumId = rs.getInt("first_album_id");
				
				PopularPlaylistDto dto 
					= new PopularPlaylistDto(playlistId, MemberId, playlistName, createdAt, songCount, likeCount, memberNickname, firstAlbumId);
				arr.add(dto);
			} while (rs.next());
			return arr;
		} catch (Exception e) {
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

}
