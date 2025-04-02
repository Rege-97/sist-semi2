package com.plick.chart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.plick.dto.SongDto;

public class ChartDao {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public ChartDao() {

	}

	// 곡 정보 조회 메서드
	public SongDetailDto findSong(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT s.*, m.NICKNAME AS \"artist\", a.NAME AS \"album_name\" "
					+ "FROM MEMBERS m, ALBUMS a, SONGS s "
					+ "WHERE m.ID = a.MEMBER_ID AND a.ID = s.ALBUM_ID AND s.ID = ?";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);

			rs = ps.executeQuery();

			SongDetailDto dto = null;

			if (rs.next()) {
				int albumId = rs.getInt("album_id");
				String name = rs.getString("name");
				String composer = rs.getString("composer");
				String lyricist = rs.getString("lyricist");
				String lyrics = rs.getString("lyrics");
				int viewCount = rs.getInt("view_count");
				String artist = rs.getString("artist");
				String albumName = rs.getString("album_name");

				dto = new SongDetailDto(id, albumId, name, composer, lyricist, lyrics, viewCount, artist,
						albumName);

			}

			return dto;

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

			}
		}
	}
}
