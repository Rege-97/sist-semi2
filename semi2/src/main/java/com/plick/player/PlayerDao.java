package com.plick.player;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.plick.search.SearchSongDto;

public class PlayerDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public PlayerDao() {

	}

	// 노래 정보 조회
	public PlayerDto showSongInfo(int songId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select rownum, so.* "
					+ "    from (select songs.id song_id,songs.name song_name,albums.id album_id,albums.created_at, "
					+ "            albums.name album_name,albums.member_id,members.nickname, songs.lyrics "
					+ "        from songs,albums,members  "
					+ "        where songs.album_id = albums.id and members.id=albums.member_id  "
					+ "        ) so where song_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, songId);
			rs = ps.executeQuery();
			PlayerDto dto = null;
			if (rs.next()) {
				
				String songName = rs.getString("song_name");
				int albumId = rs.getInt("album_id");
				Timestamp createdAt = rs.getTimestamp("created_at");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");
				String nickname = rs.getString("nickname");
				String lyrics = rs.getString("lyrics");

				dto = new PlayerDto(songId, songName, albumId, createdAt, albumName, memberId,
						nickname,lyrics);
				
			}
			return dto;
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
	
	public int findSongView(int songId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT VIEW_COUNT FROM SONGS WHERE id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, songId);
			rs = ps.executeQuery();
			int count=0;
			if (rs.next()) {
				count=rs.getInt("view_count");
			}
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;

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
	
	public int countSongView(int songId) {
		try {
			int count=findSongView(songId);
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE SONGS SET VIEW_COUNT=? WHERE id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, count+1);
			ps.setInt(2, songId);
			int result=ps.executeUpdate();

			return result;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;

		} finally {
			try {
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
