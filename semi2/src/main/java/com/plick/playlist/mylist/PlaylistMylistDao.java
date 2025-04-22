package com.plick.playlist.mylist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.plick.db.DBConnector;
import com.plick.playlist.PlaylistPreviewDto;

public class PlaylistMylistDao {
	public List<PlaylistPreviewDto> findPlaylistPreviewsOrderByCreatedAtByMemberId(int memberId) {
		String sql = "SELECT   " + "        p.id AS playlist_id, " + "        m.id AS member_id, "
				+ "        p.name AS playlist_name, " + "        p.created_at AS created_at, "
				+ "        COUNT(DISTINCT ps.id) AS song_count, " + "        m.nickname AS member_nickname, "
				+ "        ( " + "            SELECT s.album_id " + "            FROM playlist_songs ps2 "
				+ "            JOIN songs s ON ps2.song_id = s.id " + "            WHERE ps2.playlist_id = p.id "
				+ "              AND ps2.turn = 1 AND ROWNUM = 1 " + "        ) AS first_album_id "
				+ "    FROM playlists p  " + "    LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
				+ "    LEFT JOIN members m ON p.member_id = m.id " + "    WHERE m.id = ? "
				+ "    GROUP BY p.id, p.name, p.created_at, m.id, m.nickname " + "    ORDER BY p.created_at DESC";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), 0, rs.getInt("song_count"),
							rs.getString("member_nickname"), rs.getInt("first_album_id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;

	}

	public List<PlaylistPreviewDto> findLikedPlaylistsOrderByLikesCreatedAtByMemberId(int memberId) {
		String sql = "SELECT " + "  p.id                     AS playlist_id, "
				+ "  p.name                   AS playlist_name, " + "  l.created_at             AS liked_at, "
				+ "  m.id                     AS member_id, " + "  m.nickname               AS member_nickname, "
				+ "  s_first.album_id         AS first_album_id, " + "  ps_count.song_count 		AS song_count "
				+ "FROM likes l " + "JOIN playlists p               ON l.playlist_id = p.id "
				+ "JOIN members m                 ON p.member_id   = m.id "
				+ "LEFT JOIN playlist_songs ps_first ON ps_first.playlist_id = p.id AND ps_first.turn = 1 "
				+ "LEFT JOIN songs s_first           ON ps_first.song_id     = s_first.id " + "LEFT JOIN ( "
				+ "    SELECT playlist_id, COUNT(*) AS song_count " + "    FROM playlist_songs "
				+ "    GROUP BY playlist_id " + ") ps_count ON ps_count.playlist_id = p.id " + "WHERE l.member_id = ? "
				+ "ORDER BY l.created_at DESC";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("liked_at"), 0, rs.getInt("song_count"),
							rs.getString("member_nickname"), rs.getInt("first_album_id")));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistPreviewDtos;

	}

	public boolean deletePlaylistByPlaylistIdAndMemberId(int playlistId, int memberId) {
		String sql = "DELETE FROM playlists WHERE id= ? AND member_id = ?";

		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, playlistId);
			pstmt.setInt(2, memberId);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean addPlaylistByMemberIdAndPlaylistName(int memberId, String playlistName) {
		String sql = "INSERT INTO playlists (id, member_id, name, created_at, mood1, mood2) "
				+ "VALUES (seq_playlists_id.NEXTVAL, ?, ?, SYSTIMESTAMP, ?, ?)";

		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			pstmt.setString(2, playlistName);
			pstmt.setString(3, null);
			pstmt.setString(4, null);

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean addPlaylistWithLikeCount(int memberId, String playlistName) {
		try (Connection conn = DBConnector.getConn();) {
			return addPlaylistWithLikeCount(memberId, playlistName, conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean addPlaylistWithLikeCount(int memberId, String playlistName, Connection conn) throws SQLException {
		String getSeqSql = "SELECT seq_playlists_id.NEXTVAL FROM dual";
		String insertPlaylistSql = "INSERT INTO playlists (id, member_id, name, created_at, mood1, mood2) "
				+ "VALUES (?, ?, ?, SYSTIMESTAMP, ?, ?)";
		String insertLikeCountSql = "INSERT INTO playlist_like_count (playlist_id, like_count) VALUES (?, ?)";

		conn.setAutoCommit(false);
		try (PreparedStatement seqStmt = conn.prepareStatement(getSeqSql);
				PreparedStatement insertPlaylistStmt = conn.prepareStatement(insertPlaylistSql);
				PreparedStatement insertLikeCountStmt = conn.prepareStatement(insertLikeCountSql)) {
			int playlistId;

			// 시퀀스 가져오기
			try (ResultSet rs = seqStmt.executeQuery()) {
				if (rs.next()) {
					playlistId = rs.getInt(1);
				} else {
					throw new SQLException("시퀀스를 가져오지 못했습니다.");
				}
			}
			// playlists 테이블에 insert
			insertPlaylistStmt.setInt(1, playlistId);
			insertPlaylistStmt.setInt(2, memberId);
			insertPlaylistStmt.setString(3, playlistName);
			insertPlaylistStmt.setString(4, null); // mood1
			insertPlaylistStmt.setString(5, null); // mood2
			insertPlaylistStmt.executeUpdate();

			// playlist_like_count 테이블에 insert
			insertLikeCountStmt.setInt(1, playlistId);
			insertLikeCountStmt.setInt(2, 0); // 기본 좋아요 수
			insertLikeCountStmt.executeUpdate();

			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} finally {
			conn.setAutoCommit(true);
		}
	}

	private int findCountPlaylistByMemberId(int memberId, Connection conn) {
		String sql = "SELECT COUNT(*) AS playlist_count " + "FROM playlists p " + "WHERE p.member_id = ? ";

		int playlistCount = -1;
		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					playlistCount = rs.getInt("playlist_count");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return playlistCount;
	}

	public boolean addSongIntoPlaylist(int songId, int playlistId) {
		try (Connection conn = DBConnector.getConn();) {
			return existsBySongId(songId, conn) ? insertSongToTopInTransaction(songId, playlistId, conn) : false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private boolean existsBySongId(int songId, Connection conn) {
		String sql = "SELECT COUNT(*) AS count FROM songs WHERE id = ? ";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, songId);
			try (ResultSet rs = pstmt.executeQuery();) {
				rs.next();
				return rs.getInt("count") > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private boolean insertSongToTopInTransaction(int songId, int playlistId, Connection conn) throws SQLException {
		String selectTurnSql = "SELECT turn FROM playlist_songs WHERE playlist_id = ? AND song_id = ?";
		String updateOthersSql = "UPDATE playlist_songs SET turn = turn + 1 WHERE playlist_id = ? AND turn < ?";
		String updateTurnSql = "UPDATE playlist_songs SET turn = 1 WHERE playlist_id = ? AND song_id = ?";
		String insertSql = "INSERT INTO playlist_songs (id, song_id, playlist_id, turn) VALUES (seq_playlist_songs_id.NEXTVAL, ?, ?, 1)";
		String updateAllSql = "UPDATE playlist_songs SET turn = turn + 1 WHERE playlist_id = ?";

		try {
			conn.setAutoCommit(false);
			int existingTurn = -1;
			// SELECT turn
			try (PreparedStatement selectPstmt = conn.prepareStatement(selectTurnSql)) {
				selectPstmt.setInt(1, playlistId);
				selectPstmt.setInt(2, songId);

				try (ResultSet rs = selectPstmt.executeQuery()) {
					if (rs.next()) {
						existingTurn = rs.getInt("turn");
					}
				}
			}
			if (existingTurn != -1) {
				// 이미 있으면: 작은 turn들만 +1, 해당 곡은 turn = 1
				try (PreparedStatement updateOthersPstmt = conn.prepareStatement(updateOthersSql);
						PreparedStatement updateTurnPstmt = conn.prepareStatement(updateTurnSql)) {
					updateOthersPstmt.setInt(1, playlistId);
					updateOthersPstmt.setInt(2, existingTurn);
					updateOthersPstmt.executeUpdate();

					updateTurnPstmt.setInt(1, playlistId);
					updateTurnPstmt.setInt(2, songId);
					updateTurnPstmt.executeUpdate();
				}
			} else {
				// 없으면: 전체 turn +1, 새 insert
				try (PreparedStatement updateAllPstmt = conn.prepareStatement(updateAllSql);
						PreparedStatement insertPstmt = conn.prepareStatement(insertSql)) {
					updateAllPstmt.setInt(1, playlistId);
					updateAllPstmt.executeUpdate();

					insertPstmt.setInt(1, songId);
					insertPstmt.setInt(2, playlistId);
					insertPstmt.executeUpdate();
				}
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
			return false;

		} finally {
			conn.setAutoCommit(true);
		}
	}

	public boolean addAlbumIntoPlaylist(int targetPlaylistId, int myPlaylistId) {
		try (Connection conn = DBConnector.getConn()) {
			return addAlbumIntoPlaylist(targetPlaylistId, myPlaylistId, conn);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean addAlbumIntoPlaylist(int targetPlaylistId, int myPlaylistId, Connection conn) throws SQLException {
		conn.setAutoCommit(false);
		try {
			// 1. 대상 앨범 곡 가져오기
			String selectSql = "SELECT id FROM songs WHERE album_id = ?";
			List<Integer> targetSongIds = new ArrayList<>();

			try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
				pstmt.setInt(1, targetPlaylistId);
				try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						targetSongIds.add(rs.getInt("id"));
					}
				}
			}

			if (targetSongIds.isEmpty())
				return false;

			// 2. 내 플레이리스트: song_id -> turn 매핑
			Map<Integer, Integer> mySongsMap = new HashMap<>();
			String selectMySql = "SELECT song_id, turn FROM playlist_songs WHERE playlist_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(selectMySql)) {
				pstmt.setInt(1, myPlaylistId);
				try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						mySongsMap.put(rs.getInt("song_id"), rs.getInt("turn"));
					}
				}
			}

			// 3. 중복된 곡 삭제하고 turn 조정
			String deleteSql = "DELETE FROM playlist_songs WHERE playlist_id = ? AND song_id = ?";
			String updateTurnSql = "UPDATE playlist_songs SET turn = turn - 1 WHERE playlist_id = ? AND turn > ?";
			try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
					PreparedStatement updatePstmt = conn.prepareStatement(updateTurnSql)) {
				for (int songId : targetSongIds) {
					if (mySongsMap.containsKey(songId)) {
						int oldTurn = mySongsMap.get(songId);

						// 삭제
						deletePstmt.setInt(1, myPlaylistId);
						deletePstmt.setInt(2, songId);
						deletePstmt.addBatch();

						// 뒤의 순서 -1 밀기
						updatePstmt.setInt(1, myPlaylistId);
						updatePstmt.setInt(2, oldTurn);
						updatePstmt.addBatch();
					}
				}
				deletePstmt.executeBatch();
				updatePstmt.executeBatch();
			}

			// 4. 내 플레이리스트 기존 곡들 turn + 타겟 곡 개수만큼 밀기
			String shiftAllSql = "UPDATE playlist_songs SET turn = turn + ? WHERE playlist_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(shiftAllSql)) {
				pstmt.setInt(1, targetSongIds.size());
				pstmt.setInt(2, myPlaylistId);
				pstmt.executeUpdate();
			}

			// 5. 타겟 플레이리스트 순서대로 삽입 (turn = 1부터)
			String insertSql = "INSERT INTO playlist_songs (id, song_id, playlist_id, turn) VALUES (seq_playlist_songs_id.NEXTVAL, ?, ?, ?)";
			try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
				int turn = 1;
				for (int songId : targetSongIds) {
					pstmt.setInt(1, songId);
					pstmt.setInt(2, myPlaylistId);
					pstmt.setInt(3, turn++);
					pstmt.addBatch();
				}
				pstmt.executeBatch();
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
	}

	public boolean addAnoterPlaylistIntoMyPlaylist(int targetPlaylistId, int myPlaylistId) {
		try (Connection conn = DBConnector.getConn()) {
			conn.setAutoCommit(false);

			// 1. 타겟 플레이리스트 곡들 (순서 유지)
			String selectTargetSql = "SELECT song_id FROM playlist_songs WHERE playlist_id = ? ORDER BY turn ASC";
			List<Integer> targetSongIds = new ArrayList<>();

			try (PreparedStatement pstmt = conn.prepareStatement(selectTargetSql)) {
				pstmt.setInt(1, targetPlaylistId);
				try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						targetSongIds.add(rs.getInt("song_id"));
					}
				}
			}

			if (targetSongIds.isEmpty())
				return false;

			// 2. 내 플레이리스트: song_id -> turn 매핑
			Map<Integer, Integer> mySongsMap = new HashMap<>();
			String selectMySql = "SELECT song_id, turn FROM playlist_songs WHERE playlist_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(selectMySql)) {
				pstmt.setInt(1, myPlaylistId);
				try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						mySongsMap.put(rs.getInt("song_id"), rs.getInt("turn"));
					}
				}
			}

			// 3. 중복된 곡 삭제하고 turn 조정
			String deleteSql = "DELETE FROM playlist_songs WHERE playlist_id = ? AND song_id = ?";
			String updateTurnSql = "UPDATE playlist_songs SET turn = turn - 1 WHERE playlist_id = ? AND turn > ?";
			try (PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
					PreparedStatement updatePstmt = conn.prepareStatement(updateTurnSql)) {
				for (int songId : targetSongIds) {
					if (mySongsMap.containsKey(songId)) {
						int oldTurn = mySongsMap.get(songId);

						// 삭제
						deletePstmt.setInt(1, myPlaylistId);
						deletePstmt.setInt(2, songId);
						deletePstmt.addBatch();

						// 뒤의 순서 -1 밀기
						updatePstmt.setInt(1, myPlaylistId);
						updatePstmt.setInt(2, oldTurn);
						updatePstmt.addBatch();
					}
				}
				deletePstmt.executeBatch();
				updatePstmt.executeBatch();
			}

			// 4. 내 플레이리스트 기존 곡들 turn + 타겟 곡 개수만큼 밀기
			String shiftAllSql = "UPDATE playlist_songs SET turn = turn + ? WHERE playlist_id = ?";
			try (PreparedStatement pstmt = conn.prepareStatement(shiftAllSql)) {
				pstmt.setInt(1, targetSongIds.size());
				pstmt.setInt(2, myPlaylistId);
				pstmt.executeUpdate();
			}

			// 5. 타겟 플레이리스트 순서대로 삽입 (turn = 1부터)
			String insertSql = "INSERT INTO playlist_songs (id, song_id, playlist_id, turn) VALUES (seq_playlist_songs_id.NEXTVAL, ?, ?, ?)";
			try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
				int turn = 1;
				for (int songId : targetSongIds) {
					pstmt.setInt(1, songId);
					pstmt.setInt(2, myPlaylistId);
					pstmt.setInt(3, turn++);
					pstmt.addBatch();
				}
				pstmt.executeBatch();
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			try (Connection conn = DBConnector.getConn()) {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			return false;
		}
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

			conn.commit();
			return true;

		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
			return false;

		} finally {
			conn.setAutoCommit(true);
		}
	}
}
