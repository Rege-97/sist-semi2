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
	public SongDto findSong(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select * from songs where id=?";

			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();

			SongDto dto = null;

			if (rs.next()) {
				int albumId = rs.getInt("album_id");
				String name = rs.getString("name");
				String composer = rs.getString("composer");
				String lyricist = rs.getString("lyricist");
				String lyrics = rs.getString("lyrics");
				int viewCount = rs.getInt("view_count");

				dto = new SongDto(id, albumId, name, composer, lyricist, lyrics, viewCount);
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
