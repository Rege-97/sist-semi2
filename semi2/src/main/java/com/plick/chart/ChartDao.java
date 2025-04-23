package com.plick.chart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

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
			String sql = "SELECT s.*, m.NICKNAME AS \"artist\", a.NAME AS \"album_name\", a.MEMBER_ID "
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
				int memberId = rs.getInt("member_id");

				dto = new SongDetailDto(id, albumId, name, composer, lyricist, lyrics, viewCount, artist, albumName,
						memberId);

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
				e2.printStackTrace();
			}
		}
	}

	public ArrayList<SongDetailDto> playerListing(ArrayList<String> songs) {
		try {
			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < songs.size(); i++) {
				if (i != songs.size() - 1) {
					sb.append("?,");
				} else {
					sb.append("?");
				}
			}
			
			StringBuilder sb2 = new StringBuilder();
			
			if(songs.size()>1) {
				sb2.append("ORDER BY CASE s.ID ");
				
				for (int i = 0; i < songs.size()-1; i++) {
					sb2.append("WHEN " + songs.get(i) + " THEN " + (i + 1) + " ");
				}
				
				sb2.append("END");
			}
			
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT s.*, m.NICKNAME AS \"artist\", a.NAME AS \"album_name\", a.MEMBER_ID "
					+ "FROM MEMBERS m, ALBUMS a, SONGS s "
					+ "WHERE m.ID = a.MEMBER_ID AND a.ID = s.ALBUM_ID AND s.ID in (" + sb + ") "+sb2;

			ps = conn.prepareStatement(sql);
			for (int i = 0; i < songs.size(); i++) {
				ps.setInt(i + 1, Integer.parseInt(songs.get(i)));
			}

			rs = ps.executeQuery();

			ArrayList<SongDetailDto> arr = new ArrayList<SongDetailDto>();
			
			while (rs.next()) {
				int id = rs.getInt("id");
				int albumId = rs.getInt("album_id");
				String name = rs.getString("name");
				String composer = rs.getString("composer");
				String lyricist = rs.getString("lyricist");
				String lyrics = rs.getString("lyrics");
				int viewCount = rs.getInt("view_count");
				String artist = rs.getString("artist");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");

				SongDetailDto dto = new SongDetailDto(id, albumId, name, composer, lyricist, lyrics, viewCount, artist,
						albumName, memberId);
				arr.add(dto);
			}

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

	// 앨범 정보 조회 메서드
	public AlbumDetailDto findAlbum(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT a.*, m.NICKNAME AS \"artist\",r.RATING "
					+ "FROM MEMBERS m, ALBUMS a,(SELECT avg(score) AS rating FROM RATINGS WHERE album_id=?)r "
					+ "WHERE m.ID = a.MEMBER_ID AND a.ID = ?";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setInt(2, id);

			rs = ps.executeQuery();

			AlbumDetailDto dto = null;

			if (rs.next()) {
				int memberId = rs.getInt("member_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String genre1 = rs.getString("genre1");
				String genre2 = rs.getString("genre2");
				String genre3 = rs.getString("genre3");
				Timestamp releasedAt = rs.getTimestamp("released_at");
				Timestamp createdAt = rs.getTimestamp("created_at");
				String artist = rs.getString("artist");
				double rating = rs.getDouble("rating");

				dto = new AlbumDetailDto(id, memberId, name, description, genre1, genre2, genre3, releasedAt, createdAt,
						artist, rating);

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
				e2.printStackTrace();
			}
		}
	}

	// 앨범 트랙 조회 메서드
	public ArrayList<TrackDto> trackList(int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT rownum AS \"rnum\",s.*, m.NICKNAME AS \"artist\", a.NAME AS \"album_name\" ,a.MEMBER_ID "
					+ "FROM MEMBERS m, ALBUMS a, SONGS s "
					+ "WHERE m.ID = a.MEMBER_ID AND a.ID = s.ALBUM_ID AND a.ID = ? " + "ORDER BY s.ID";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, albumId);

			rs = ps.executeQuery();

			ArrayList<TrackDto> arr = new ArrayList<TrackDto>();

			while (rs.next()) {
				int rnum = rs.getInt("rnum");
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String artist = rs.getString("artist");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");

				TrackDto dto = new TrackDto(rnum, id, albumId, name, artist, albumName, memberId);

				arr.add(dto);
			}

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

	// 전체 차트 조회 메서드
	public ArrayList<TrackDto> allChartList() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT rownum AS rnum,a.* " + "FROM (SELECT * from( "
					+ "SELECT s.*, m.NICKNAME AS \"artist\", a.NAME AS \"album_name\",a.MEMBER_ID "
					+ "FROM MEMBERS m, ALBUMS a, SONGS s " + "WHERE m.ID = a.MEMBER_ID AND a.ID = s.ALBUM_ID  "
					+ "ORDER BY s.VIEW_COUNT DESC) " + "WHERE rownum<=100)a " + "ORDER BY RNUM";

			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();

			ArrayList<TrackDto> arr = new ArrayList<TrackDto>();

			while (rs.next()) {
				int rnum = rs.getInt("rnum");
				int id = rs.getInt("id");
				int albumId = rs.getInt("album_id");
				String name = rs.getString("name");
				String artist = rs.getString("artist");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");

				TrackDto dto = new TrackDto(rnum, id, albumId, name, artist, albumName, memberId);

				arr.add(dto);
			}

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

	// 장르 차트 조회 메서드
	public ArrayList<TrackDto> genreChartList(String genre) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT rownum as rnum , a.* " + "FROM ( "
					+ "    SELECT s.*, m.NICKNAME AS artist, a.NAME AS album_name, a.MEMBER_ID "
					+ "    FROM MEMBERS m, ALBUMS a, SONGS s " + "    WHERE m.ID = a.MEMBER_ID "
					+ "      AND a.ID = s.ALBUM_ID " + "      AND (a.GENRE1 = ? OR a.GENRE2 = ? OR a.GENRE3 = ?) "
					+ "    ORDER BY s.VIEW_COUNT DESC" + ") a " + "WHERE rownum <= 30 ";

			ps = conn.prepareStatement(sql);
			ps.setString(1, genre);
			ps.setString(2, genre);
			ps.setString(3, genre);

			rs = ps.executeQuery();

			ArrayList<TrackDto> arr = new ArrayList<TrackDto>();

			while (rs.next()) {
				int rnum = rs.getInt("rnum");
				int id = rs.getInt("id");
				int albumId = rs.getInt("album_id");
				String name = rs.getString("name");
				String artist = rs.getString("artist");
				String albumName = rs.getString("album_name");
				int memberId = rs.getInt("member_id");

				TrackDto dto = new TrackDto(rnum, id, albumId, name, artist, albumName, memberId);

				arr.add(dto);
			}

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

	// 최대 parent_id가져오기
	public int getMaxParentId() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select max(parent_id) from ALBUM_COMMENTS";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int parentId = -1;

			if (!rs.next()) {
				return -1;
			} else {
				parentId = rs.getInt(1);
			}

			return parentId;

		} catch (Exception e) {
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

	// 댓글 등록 메서드
	public int addComment(int memberId, int albumId, String content) {
		try {
			int parentId = getMaxParentId();
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT " + "INTO ALBUM_COMMENTS "
					+ "values(seq_album_comments_id.nextval,?,?,?,systimestamp,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
			ps.setInt(2, albumId);
			ps.setString(3, content);
			ps.setInt(4, parentId + 1);
			int count = ps.executeUpdate();

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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

	// 답글 등록 메서드
	public int addCommentAnswer(int memberId, int albumId, String content, int parentId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT " + "INTO ALBUM_COMMENTS "
					+ "values(seq_album_comments_id.nextval,?,?,?,systimestamp,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
			ps.setInt(2, albumId);
			ps.setString(3, content);
			ps.setInt(4, parentId);

			int count = ps.executeUpdate();

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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

	// 총 댓글 수 구하기
	public int getTotalCnt(int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select count(*) from ALBUM_COMMENTS WHERE ALBUM_ID=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, albumId);
			rs = ps.executeQuery();

			rs.next();

			int count = rs.getInt(1);

			return count == 0 ? 0 : count;

		} catch (Exception e) {
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

			}
		}
	}

	// 댓글 리스트 조회
	public ArrayList<CommentDto> commentList(int cp, int listSize, int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (cp - 1) * listSize + 1;
			int end = cp * listSize;
			String sql = "SELECT b.*,m.NICKNAME FROM (SELECT rownum AS rnum,a.* from  "
		               + "               (SELECT a.*,ROW_NUMBER() OVER (PARTITION BY PARENT_ID ORDER BY id ASC) AS \"answer_check\"  "
		               + "               FROM ALBUM_COMMENTS a WHERE a.ALBUM_ID=? ORDER BY PARENT_ID DESC,id asc)a)b,MEMBERS m "
		               + "               WHERE b.MEMBER_ID=m.ID AND rnum >=? AND rnum<=? ORDER BY b.PARENT_ID DESC, b.\"answer_check\" asc";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, albumId);
			ps.setInt(2, start);
			ps.setInt(3, end);

			rs = ps.executeQuery();
			ArrayList<CommentDto> arr = new ArrayList<CommentDto>();

			while (rs.next()) {
				int id = rs.getInt("id");
				int memberId = rs.getInt("member_id");
				String content = rs.getString("content");
				Timestamp createdAt = rs.getTimestamp("created_at");
				int parentId = rs.getInt("parent_id");
				int answerCheck = rs.getInt("answer_check");
				String nickname = rs.getString("nickname");

				CommentDto dto = new CommentDto(id, memberId, albumId, content, createdAt, parentId, answerCheck,
						nickname);
				arr.add(dto);
			}

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

			}
		}
	}

	// 현재 나의 앨범 평점
	public int getMyRating(int memberId, int albumId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select score from ratings where member_id=? and album_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
			ps.setInt(2, albumId);
			rs = ps.executeQuery();

			int score = 0;

			if (rs.next()) {
				score = rs.getInt(1);
			}

			return score;

		} catch (Exception e) {
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

			}
		}
	}

	// 앨범 평점 등록
	public int insertRating(int memberId, int albumId, int score) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "insert into ratings values(?,?,?,systimestamp)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
			ps.setInt(2, albumId);
			ps.setInt(3, score);

			int count = ps.executeUpdate();

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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

	// 앨범 평점 수정
	public int updateRating(int memberId, int albumId, int score) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "update ratings set score=? where member_id=? and album_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, score);
			ps.setInt(2, memberId);
			ps.setInt(3, albumId);

			int count = ps.executeUpdate();

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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
