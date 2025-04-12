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
				List<PlaylistCommentDto> playlistCommentDtos = findPlaylistCommentDtosByPlaylistId(playlistId, conn, commentLimit);

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
		String sql = "SELECT COUNT(*) AS total_count " + "FROM likes WHERE playlist_id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			try (ResultSet rs = pstmt.executeQuery();) {

				return rs.next() ? rs.getInt("total_count") : -1L;
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
	
	private List<PlaylistCommentDto> findPlaylistCommentDtosByPlaylistId(int playlistId, Connection conn, int commentLimit) {
		String sql = "SELECT ROWNUM, inner_result.* " + "FROM ( " + "    SELECT " + "        c.id AS comment_id, "
				+ "        c.member_id AS member_id, " + "        c.playlist_id AS playlist_id, "
				+ "        c.content AS content, " + "        c.created_at AS created_at, "
				+ "        c.parent_id AS parent_id, " + "        m.nickname AS member_nickname "
				+ "    FROM playlist_COMMENTS c " + "    JOIN MEMBERS m ON c.MEMBER_ID = m.ID "
				+ "    WHERE c.PLAYLIST_ID = ? " + "    ORDER BY "
				+ "        CASE WHEN c.PARENT_ID = 0 THEN c.ID ELSE c.PARENT_ID END DESC, "
				+ "        CASE WHEN c.PARENT_ID = 0 THEN 0 ELSE 1 END, " + "        c.ID ASC " + ") inner_result "
				+ "WHERE ROWNUM <= ? ";

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

	public boolean deletePlaylistSong(int playlistSongId, int turn, int playlistId, int memberId) {

		try (Connection conn = DBConnector.getConn();) {
			return hasPlaylistByMember(playlistId, memberId, conn)
					? deletePlaylistSongAndUpdateTurn(playlistSongId, playlistId, turn, conn)
					: false;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	/**
	 * 로그인한 멤버가 실제로 그 플레이리스트를 가지고있는지 확인함.
	 */
	private boolean hasPlaylistByMember(int playlistId, int memberId, Connection conn) {
		String sql = "SELECT * FROM playlists WHERE id= ? AND member_id = ? ";

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

	/**
	 * playlist_songs.id를 지우는데, playlists.id가 일치해야 지움. 지운 후에 남아있는 turn 를 다시 정렬함 트랜잭션
	 * 처리로 두 쿼리를 수행하면서 실패하면 롤백할 것임.
	 * 
	 * @throws SQLException
	 */
	private boolean deletePlaylistSongAndUpdateTurn(int playlistSondId, int playlistId, int turn, Connection conn)
			throws SQLException {
		String deleteSql = "DELETE FROM playlist_songs WHERE id = ? AND playlist_id = ? ";
		String updateSql = "UPDATE playlist_songs SET turn = turn - 1 WHERE playlist_id = ? AND turn > ? ";

		try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
				PreparedStatement updatePstmt = conn.prepareStatement(updateSql);) {

			// 트랜잭션시작
			conn.setAutoCommit(false);

			deletePstmt.setInt(1, playlistSondId);
			deletePstmt.setInt(2, playlistId);
			if (deletePstmt.executeUpdate() == 0) {
				conn.rollback();
				return false;
			}

			updatePstmt.setInt(1, playlistId);
			updatePstmt.setInt(2, turn);
			updatePstmt.executeUpdate();

			// 트랜잭션끝
			conn.commit();
			return true;

		} catch (Exception e) {
			// 예외발생시 롤백
			conn.rollback();
			e.printStackTrace();
			return false;

		} finally {
			// 오토커밋시작
			conn.setAutoCommit(true);
		}
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
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			pstmt.setInt(2, memberId);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private boolean addLikeByPlaylistIdAndMemberId(int playlistId, int memberId, Connection conn) {
		String sql = "INSERT INTO likes (member_id, playlist_id, created_at) VALUES (?, ?, SYSTIMESTAMP)";
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			pstmt.setInt(2, playlistId);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
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
}
