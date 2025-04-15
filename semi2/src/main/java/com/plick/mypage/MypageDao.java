package com.plick.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.HashMap;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class MypageDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	static final int DUPLICATE = 1;
	static final int UNDUPLICATE = 0;

	public int checkNicknameDuplicate(String nickname) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM members WHERE nickname = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1;
			} else {
				return 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int updateMemberNickname(String nickname, int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET nickname = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setInt(2, id);
			int result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public HashMap<String, Timestamp> getMembershipName(int memberId, Calendar now) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT name, stopped_at FROM membership_members mm LEFT JOIN memberships m ON mm.membership_id = m.id WHERE mm.membership_id IN (SELECT membership_id FROM membership_members WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();
			HashMap<String, Timestamp> map = new HashMap<String, Timestamp>();
			if (rs.next()) {
				do {
					if (rs.getTimestamp("stopped_at").getTime() > now.getTimeInMillis()) {
						map.put(rs.getString("name"), rs.getTimestamp("stopped_at"));
					}
				} while (rs.next());
			}
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public ArrayList<String> getMembershipType() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT name FROM memberships";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<String> list = new ArrayList<String>();
			if (rs.next()) {
				do {
					list.add(rs.getString("name"));
				} while (rs.next());
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int changeMemberAccessType(int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'applicant' WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			int result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public ArrayList<MypageDto> getapplicantInfo(int firstNum, int lastNum) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id, name, rnum FROM (SELECT id, name, rnum FROM (SELECT rownum AS rnum, id, name FROM members WHERE access_type = 'applicant') ORDER BY rnum DESC)WHERE rnum BETWEEN ?+1 AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, firstNum);
			pstmt.setInt(2, lastNum);
			rs = pstmt.executeQuery();
			ArrayList<MypageDto> list = new ArrayList<MypageDto>();
			if (rs.next()) {
				do {
					MypageDto dto = new MypageDto();
					dto.setRnum(rs.getInt("rnum"));
					dto.setId(rs.getInt("id"));
					dto.setName(rs.getString("name"));
					list.add(dto);
				} while (rs.next());
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int getMaxRow() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT MAX(rnum) AS maxrow FROM (SELECT id, name, rnum FROM (SELECT rownum AS rnum, id, name FROM members WHERE access_type = 'applicant') ORDER BY rnum DESC)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<MypageDto> list = new ArrayList<MypageDto>();
			if (rs.next()) {
				do {
					return rs.getInt("maxrow");
				} while (rs.next());
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int requestYes(String[] yp) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'artist' WHERE id in (";
			for (int i = 0; i < yp.length; i++) {
				sql += "?";
				if (i != yp.length - 1)
					sql += ", ";
			}
			sql += ")";
			pstmt = conn.prepareStatement(sql);
			for (int i = 1; i <= yp.length; i++) {
				pstmt.setString(i, yp[i - 1]);
			}
			int result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int requestNo(String[] np) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'listener' WHERE id in (";
			for (int i = 0; i < np.length; i++) {
				sql += "?";
				if (i != np.length - 1)
					sql += ", ";
			}
			sql += ")";
			pstmt = conn.prepareStatement(sql);
			for (int i = 1; i <= np.length; i++) {
				pstmt.setString(i, np[i - 1]);
			}
			int result = pstmt.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public boolean renameFile(String path, String oldname, String newname) {
		File oldFile = new File(path+"/"+oldname);
		File newFile = new File(path+"/"+newname);
		return oldFile.renameTo(newFile);
	}

	public String fileExportBase64(String path) {
		try {
			File f1 = new File(path);
			FileInputStream Fis = new FileInputStream(f1);
			byte[] fileData = new byte[(int) f1.length()];
			Fis.read(fileData);
			Fis.close();

			String fileBase64 = Base64.getEncoder().encodeToString(fileData);
			return "data:image/jpeg;base64," + fileBase64;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean addFileToBase64(String base64, String path) {
		try {
			base64 = base64.replace("data:image/jpeg;base64,", "");
			File newFile = new File(path);
			byte[] filedata = Base64.getDecoder().decode(base64);
			try (FileOutputStream Fos = new FileOutputStream(newFile)) {
				Fos.write(filedata);
				Fos.close();
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ArrayList<AlbumDto> findMeberAlbums(int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM albums WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();
			ArrayList<AlbumDto> albums = new ArrayList<AlbumDto>();
			if (rs.next()) {
				do {
					albums.add(new AlbumDto(rs.getInt("id"),
							rs.getInt("member_id"),
							rs.getString("name"),
							rs.getString("description"),
							rs.getString("genre1"),
							rs.getString("genre2"),
							rs.getString("genre3"),
							rs.getTimestamp("released_at"),
							null));
				} while (rs.next());
			}
			return albums;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public AlbumDto findInfoAlbums(int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM albums WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, albumId);
			rs = pstmt.executeQuery();
			AlbumDto album = new AlbumDto();
			if (rs.next()) {
				do {
					album.setId(rs.getInt("id"));
					album.setMember_id(rs.getInt("member_id"));
					album.setName(rs.getString("name"));
					album.setDiscription(rs.getString("description"));
					album.setGenre1(rs.getString("genre1"));
					album.setGenre2(rs.getString("genre2"));
					album.setGenre3(rs.getString("genre3"));
					album.setCreated_at(rs.getTimestamp("created_at"));
					album.setReleased_at(rs.getTimestamp("released_at"));
				} while (rs.next());
			}
			return album;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public ArrayList<SongDto> findAlbumSongs(int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM songs WHERE album_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, albumId);
			rs = pstmt.executeQuery();
			ArrayList<SongDto> songs = new ArrayList<SongDto>();
			if (rs.next()) {
				do {
					songs.add(new SongDto(rs.getInt("id"),
							rs.getInt("album_id"),
							rs.getString("name"),
							rs.getString("composer"),
							rs.getString("lyricist"),
							rs.getString("lyrics"),
							rs.getInt("view_count")
							));
				} while (rs.next());
			}
			return songs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}
	
	public SongDto findSong(int songId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM songs WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, songId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					return new SongDto(rs.getInt("id"),
							rs.getInt("album_id"),
							rs.getString("name"),
							rs.getString("composer"),
							rs.getString("lyricist"),
							rs.getString("lyrics"),
							rs.getInt("view_count"));
				} while (rs.next());
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
