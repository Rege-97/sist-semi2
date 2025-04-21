package com.plick.playlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.plick.db.DBConnector;

public class PlaylistDao {

	public PlaylistDetailDto findPlaylistDetailByPlaylistId(int playlistId, int loggedInUserId, int commentLimit) {
		try (Connection conn = DBConnector.getConn();) {
			PlaylistDetailDto playlistDetailDto = findPlaylistDetail(playlistId, conn, commentLimit);
			if (playlistDetailDto != null && loggedInUserId > 0) {
				playlistDetailDto.setIsLiked(hasLikeFromLikesByPlaylistIdAndMemberId(playlistId, loggedInUserId, conn));
			}
			playlistDetailDto.setCommentCount(findCommentCountByPlaylistId(playlistId, conn));
			return playlistDetailDto;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public PlaylistDetailDto findPlaylistDetailByPlaylistId(int playlistId, int commentLimit) {
		return findPlaylistDetailByPlaylistId(playlistId, -1, commentLimit);
	}

	private PlaylistDetailDto findPlaylistDetail(int playlistId, Connection conn, int commentLimit) {
		String sql = "SELECT  " + "    p.id AS playlist_id, " + "    p.member_id AS playlist_member_id, "
				+ "    p.name AS playlist_name, " + "    p.created_at AS playlist_created_at, "
				+ "    p.mood1 AS playlist_mood1, " + "    p.mood2 AS playlist_mood2, "
				+ "    m.nickname AS member_nickname, " + "    m.id AS member_id, "
				+ "    m.access_type AS member_access_type, " + "    ps.id AS playlist_song_id, "
				+ "    ps.song_id AS playlist_song_song_id, " + "    ps.playlist_id AS playlist_song_playlist_id, "
				+ "    ps.turn AS playlist_song_turn, " + "    s.id AS song_id, " + "    s.album_id AS song_album_id, "
				+ "    s.name AS song_name, " + "    s.view_count AS song_view_count, " + "    a.id AS album_id, "
				+ "    a.name AS album_name, " + "    m2.nickname AS album_member_nickname, "
				+ "    m2.id AS album_member_id " + "    FROM  " + "    playlists p "
				+ "LEFT JOIN members m ON p.member_id = m.id " + "LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
				+ "LEFT JOIN songs s ON ps.song_id = s.id " + "LEFT JOIN albums a ON a.id = s.album_id "
				+ " LEFT JOIN members m2 ON m2.id = a.member_id " + "WHERE  " + "    p.id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {
				if (!rs.next()) {
					return null;
				}

				int memberId = rs.getInt("member_id");
				String nickname = rs.getString("member_nickname");
				String accessType = rs.getString("member_access_type");
				String playlistName = rs.getString("playlist_name");
				Timestamp createdAt = rs.getTimestamp("playlist_created_at");
				String mood1 = rs.getString("playlist_mood1");
				String mood2 = rs.getString("playlist_mood2");
				long likeCount = findLikeCountByPlaylistId(playlistId, conn);

				List<PlaylistSongDto> playlistSongDtos = new ArrayList<PlaylistSongDto>();
				do {
					int playlistSongId = rs.getInt("playlist_song_id");
					if (!rs.wasNull()) {
						playlistSongDtos.add(new PlaylistSongDto(playlistSongId, rs.getInt("song_id"),
								rs.getString("song_name"), playlistId, rs.getInt("playlist_song_turn"),
								rs.getInt("album_id"), rs.getString("album_name"),
								rs.getString("album_member_nickname"), rs.getInt("album_member_id")));
					}
				} while (rs.next());
				List<PlaylistCommentDto> playlistCommentDtos = findPlaylistCommentDtosByPlaylistId(playlistId, conn,
						commentLimit);

				return new PlaylistDetailDto(memberId, nickname, accessType, playlistId, playlistName, createdAt, mood1,
						mood2, likeCount, playlistSongDtos, playlistCommentDtos);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private boolean hasLikeFromLikesByPlaylistIdAndMemberId(int playlistId, int memberId, Connection conn) {
		String sql = "SELECT * FROM likes WHERE playlist_id = ? AND member_id = ? ";
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			pstmt.setInt(2, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private long findLikeCountByPlaylistId(int playlistId, Connection conn) {
		String sql = "SELECT * " + "FROM playlist_like_count WHERE playlist_id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				return rs.next() ? rs.getInt("like_count") : -1L;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1L;
	}

	private int findCommentCountByPlaylistId(int playlistId, Connection conn) {
		String sql = "SELECT COUNT(*) AS total_count " + "FROM playlist_comments WHERE playlist_id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				return rs.next() ? rs.getInt("total_count") : -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	private List<PlaylistCommentDto> findPlaylistCommentDtosByPlaylistId(int playlistId, Connection conn,
			int commentLimit) {
		String sql = "SELECT * " + "FROM ( " + "  SELECT  " + "    c.id             AS comment_id, "
				+ "    c.member_id      AS member_id, " + "    c.playlist_id    AS playlist_id, "
				+ "    c.content        AS content, " + "    c.created_at     AS created_at, "
				+ "    c.parent_id      AS parent_id, " + "    m.nickname       AS member_nickname "
				+ "  FROM playlist_COMMENTS c " + "  JOIN MEMBERS m  " + "    ON c.MEMBER_ID = m.ID "
				+ "  WHERE c.PLAYLIST_ID = ? " + "  ORDER BY " + "    NVL(NULLIF(c.parent_id, 0), c.id) DESC, "
				+ "    CASE WHEN c.parent_id IS NULL OR c.parent_id = 0 THEN 0 ELSE 1 END ASC, " + "    c.id ASC "
				+ ") " + "WHERE ROWNUM <= ?";

		List<PlaylistCommentDto> playlistCommentDtos = new ArrayList<PlaylistCommentDto>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			pstmt.setInt(2, commentLimit);

			try (ResultSet rs = pstmt.executeQuery();) {

				while (rs.next()) {
					playlistCommentDtos.add(new PlaylistCommentDto(rs.getInt("member_id"),
							rs.getString("member_nickname"), rs.getInt("comment_id"), rs.getInt("playlist_id"),
							rs.getString("content"), rs.getTimestamp("created_at"), rs.getInt("parent_id")));
				}

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistCommentDtos;
	}

	public boolean updatePlaylistNameByPlaylistId(int playlistId, String playlistName, int memberId) {
		String sql = "UPDATE playlists SET name = ? WHERE id = ? AND member_id = ? ";

		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, playlistName);
			pstmt.setInt(2, playlistId);
			pstmt.setInt(3, memberId);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * mood1 mood2 에는 null이 들어갈 수 있음.
	 */
	public boolean updatePlaylistMoodsByPlaylistId(int playlistId, String mood1, String mood2, int memberId) {
		String sql = "UPDATE playlists SET mood1 = ?, mood2 = ? WHERE id = ? AND member_id = ? ";

		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, mood1);
			pstmt.setString(2, mood2);
			pstmt.setInt(3, playlistId);
			pstmt.setInt(4, memberId);
			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateLikeByPlaylistIdAndMemberId(int playlistId, int memberId) {
		try (Connection conn = DBConnector.getConn();) {
			return hasLikeFromLikesByPlaylistIdAndMemberId(playlistId, memberId, conn)
					? deleteLikeByPlaylistIdAndMemberId(playlistId, memberId, conn)
					: addLikeByPlaylistIdAndMemberId(playlistId, memberId, conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private boolean deleteLikeByPlaylistIdAndMemberId(int playlistId, int memberId, Connection conn) {
		String sql = "DELETE FROM likes WHERE playlist_id = ? AND member_id = ? ";
		String likeCountSql = "UPDATE playlist_like_count SET like_count = like_count - 1 WHERE playlist_id = ?";

		boolean success = false;
		try {
			conn.setAutoCommit(false); // 트랜잭션 시작

			try (PreparedStatement deletePstmt = conn.prepareStatement(sql);
					PreparedStatement updatePstmt = conn.prepareStatement(likeCountSql)) {
				// insert likes
				deletePstmt.setInt(1, playlistId);
				deletePstmt.setInt(2, memberId);
				int deleteResult = deletePstmt.executeUpdate();

				if (deleteResult <= 0) {
					conn.rollback();
					return false;
				}
				// update like count
				updatePstmt.setInt(1, playlistId);
				int updateResult = updatePstmt.executeUpdate();

				if (updateResult <= 0) {
					conn.rollback();
					return false;
				}
				conn.commit();
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				conn.rollback();
			} finally {
				conn.setAutoCommit(true); // 트랜잭션 종료 후 auto-commit 원복
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	private boolean addLikeByPlaylistIdAndMemberId(int playlistId, int memberId, Connection conn) {
		String sql = "INSERT INTO likes (member_id, playlist_id, created_at) VALUES (?, ?, SYSTIMESTAMP)";
		String likeCountSql = "UPDATE playlist_like_count SET like_count = like_count + 1 WHERE playlist_id = ?";

		boolean success = false;
		try {
			conn.setAutoCommit(false); // 트랜잭션 시작

			try (PreparedStatement insertStmt = conn.prepareStatement(sql);
					PreparedStatement updateStmt = conn.prepareStatement(likeCountSql)) {
				// insert likes
				insertStmt.setInt(1, memberId);
				insertStmt.setInt(2, playlistId);
				int insertResult = insertStmt.executeUpdate();

				if (insertResult <= 0) {
					conn.rollback();
					return false;
				}
				// update like count
				updateStmt.setInt(1, playlistId);
				int updateResult = updateStmt.executeUpdate();

				if (updateResult <= 0) {
					conn.rollback();
					return false;
				}
				conn.commit();
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				conn.rollback();
			} finally {
				conn.setAutoCommit(true); // 트랜잭션 종료 후 auto-commit 원복
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return success;
	}

	public boolean addComment(int playlistId, int memberId, String content, int parentId) {
		String sql = "INSERT " + "INTO playlist_comments "
				+ "VALUES(seq_playlist_comments_id.NEXTVAL, ?, ?, ?, SYSTIMESTAMP, ? )";
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			pstmt.setInt(2, playlistId);
			pstmt.setString(3, content);
			pstmt.setInt(4, parentId);

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public int findActiveMembershipByMemberId(int memberId, Connection conn) {
		String sql = "SELECT stopped_at,membership_id FROM MEMBERSHIP_MEMBERS WHERE stopped_at=(SELECT max(stopped_at) FROM MEMBERSHIP_MEMBERS WHERE member_id=?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);

			try (ResultSet rs = pstmt.executeQuery();) {

				if (rs.next()) {
					return System.currentTimeMillis() < rs.getTimestamp("stopped_at").getTime()
							? rs.getInt("membership_id")
							: -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * @return 다운로드 가능한 이용권이 없으면 null 반환, 플레이리스트에 곡이 없으면 빈 리스트 반환, 정상작동시 다운로드에 필요한
	 *         플레이리스트 노래정보(songId, songName, albumId, artistNickname)이 담긴 리스트 반환
	 */
	public List<PlaylistSongDto> findPlaylistInfoForDownloadByPlaylistId(int memberId, int playlistId) {
		String sql = "SELECT   " + "    s.id AS song_id, " + "    s.name AS song_name, " + "    a.id AS album_id, "
				+ "    m2.nickname AS artist_nickname " + "FROM playlists p "
				+ "LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id " + "LEFT JOIN songs s ON ps.song_id = s.id "
				+ "LEFT JOIN albums a ON a.id = s.album_id " + "LEFT JOIN members m2 ON m2.id = a.member_id "
				+ "WHERE p.id = ? " + "GROUP BY s.id, s.name, a.id, m2.nickname " + "ORDER BY MIN(ps.turn)";
		List<PlaylistSongDto> playlistDownloadDtos = new ArrayList<PlaylistSongDto>();
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {

			if (findActiveMembershipByMemberId(memberId, conn) != 3) {
				return null;
			}
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				while (rs.next()) {
					playlistDownloadDtos.add(new PlaylistSongDto(rs.getInt("song_id"), rs.getString("song_name"),
							rs.getInt("album_id"), rs.getString("artist_nickname")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistDownloadDtos;
	}

	public List<Integer> findSongIdsByPlaylistId(int playlistId) {
		String sql = "SELECT song_id FROM playlist_songs WHERE playlist_id = ? ORDER BY turn ASC";

		List<Integer> songIds = new ArrayList<Integer>();
		try (Connection conn = DBConnector.getConn();) {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, playlistId);

			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					songIds.add(rs.getInt("song_id"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return songIds;
	}
}
