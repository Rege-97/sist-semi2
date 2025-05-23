package com.plick.album;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.plick.mypage.SongDto;

public class AlbumDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	
	public int addAlbum(AlbumDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT INTO albums VALUES (?, ?, ?, ?, ?, ?, ?, ?, systimestamp)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getId());
			pstmt.setInt(2, dto.getMemberId());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getDescription());
			pstmt.setString(5, dto.getGenre1());
			pstmt.setString(6, dto.getGenre2());
			pstmt.setString(7, dto.getGenre3());
			pstmt.setTimestamp(8, dto.getReleasedAt());
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
	
	public int modifyAlbum(AlbumDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE albums SET name = ?, description = ?, genre1 = ?, genre2 = ?, genre3 = ?, released_at = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getDescription());
			pstmt.setString(3, dto.getGenre1());
			pstmt.setString(4, dto.getGenre2());
			pstmt.setString(5, dto.getGenre3());
			pstmt.setTimestamp(6, dto.getReleasedAt());
			pstmt.setInt(7, dto.getId());
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
	
	public int modifySong(SongsDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE Songs SET name = ?, composer = ?, lyricist = ?, lyrics = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getComposer());
			pstmt.setString(3, dto.getLyricist());
			pstmt.setString(4, dto.getLyrics());
			pstmt.setInt(5, dto.getId());
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
	
	public int addSong(SongsDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT INTO songs VALUES (?, ?, ?, ?, ?, ?, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getId());
			pstmt.setInt(2, dto.getAlbum_id());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getComposer());
			pstmt.setString(5, dto.getLyricist());
			pstmt.setString(6, dto.getLyrics());
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
	public int findAlbumId(String albumName) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM albums WHERE name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, albumName);
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
	public int findMaxAlbumId() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT seq_albums_id.NEXTVAL as maxid FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("maxid");
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
	
	public int findSongId(String songname) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM songs WHERE name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, songname);
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
	public int findMaxSongId() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT seq_songs_id.NEXTVAL as maxid FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("maxid");
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
	
	
	public int checkAlbumDuplicate(int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM albums WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, albumId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1;
			}else {
				return 0;
			}
			
		}catch(Exception e){
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
