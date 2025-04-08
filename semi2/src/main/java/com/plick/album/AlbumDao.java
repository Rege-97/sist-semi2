package com.plick.album;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AlbumDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	
	public int addAlbum(AlbumDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			// 장르 추가시 컬럼 추가 생성 해야 함!
			String sql = "INSERT INTO albums VALUES (seq_albums_id.nextval, ?, ?, ?, ?, ?, ?, ?, systimestamp)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMemberId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getDescription());
			pstmt.setString(4, dto.getGenre1());
			pstmt.setString(5, dto.getGenre2());
			pstmt.setString(6, dto.getGenre3());
			pstmt.setTimestamp(7, dto.getReleasedAt());
			int result = pstmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int addSongs(SongsDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT INTO songs VALUES (seq_songs_id.nextval, ?, ?, ?, ?, ?, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getAlbum_id());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getComposer());
			pstmt.setString(4, dto.getLyricist());
			pstmt.setString(5, dto.getLyrics());
			int result = pstmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public int findAlbumId(String albumname) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM albums WHERE name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, albumname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("id");
			}
			return 0;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
