package com.plick.playlist.mylist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.plick.db.DBConnector;
import com.plick.playlist.PlaylistPreviewDto;

public class PlaylistMylistDao {
	public List<PlaylistPreviewDto> findPlaylistPreviewsOrderByCreatedAtByMemberId(int memberId) {
		String sql = "SELECT   " + "        p.id AS playlist_id, " + "        m.id AS member_id, "
				+ "        p.name AS playlist_name, " + "        p.created_at AS created_at, "
				+ "        COUNT(DISTINCT l.member_id) AS like_count, "
				+ "        COUNT(DISTINCT ps.id) AS song_count, " + "        m.nickname AS member_nickname, "
				+ "        ( " + "            SELECT s.album_id " + "            FROM playlist_songs ps2 "
				+ "            JOIN songs s ON ps2.song_id = s.id " + "            WHERE ps2.playlist_id = p.id "
				+ "              AND ps2.turn = 1 " + "        ) AS first_album_id " + "    FROM playlists p  "
				+ "    LEFT JOIN playlist_songs ps ON p.id = ps.playlist_id "
				+ "    LEFT JOIN likes l ON p.id = l.playlist_id " + "    LEFT JOIN members m ON p.member_id = m.id "
				+ "    WHERE m.id = ? " + "    GROUP BY p.id, p.name, p.created_at, m.id, m.nickname "
				+ "    ORDER BY p.created_at DESC";

		List<PlaylistPreviewDto> playlistPreviewDtos = new ArrayList<PlaylistPreviewDto>();
		try (Connection conn = DBConnector.getConn(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					playlistPreviewDtos.add(new PlaylistPreviewDto(rs.getInt("playlist_id"), rs.getInt("member_id"),
							rs.getString("playlist_name"), rs.getTimestamp("created_at"), rs.getInt("like_count"),
							rs.getInt("song_count"), rs.getString("member_nickname"), rs.getInt("first_album_id")));
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

	public boolean addPlaylistByMemberId(int memberId, String playlistName) {
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

		String updateSql = "UPDATE playlist_songs SET turn = turn + 1 WHERE playlist_id = ?";
		String insertSql = "INSERT INTO playlist_songs (id, song_id, playlist_id, turn) VALUES (seq_playlist_songs_id.NEXTVAL, ?, ?, 1)";

		try (PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
				PreparedStatement insertPstmt = conn.prepareStatement(insertSql)) {
			// 트랜잭션시작
			conn.setAutoCommit(false);

			updatePstmt.setInt(1, playlistId);
			updatePstmt.executeUpdate();

			insertPstmt.setInt(1, songId);
			insertPstmt.setInt(2, playlistId);
			insertPstmt.executeUpdate();

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

	public boolean addAlbumIntoPlaylist(int albumId, int playlistId) {
		try (Connection conn = DBConnector.getConn()) {
			// 트랜잭션 시작
			conn.setAutoCommit(false);

			// 앨범에 속한 노래 가져오기
			String selectSql = "SELECT id FROM songs WHERE album_id = ?";
			try (PreparedStatement selectPstmt = conn.prepareStatement(selectSql)) {
				selectPstmt.setInt(1, albumId);
				try (ResultSet rs = selectPstmt.executeQuery()) {

					// 먼저 turn을 전부 밀어줌 (한 번만)
					String updateSql = "UPDATE playlist_songs SET turn = turn + ? WHERE playlist_id = ?";
					List<Integer> songIds = new ArrayList<>();
					while (rs.next()) {
						songIds.add(rs.getInt("id"));
					}
					
					if (songIds.isEmpty()) return false;

					try (PreparedStatement updatePstmt = conn.prepareStatement(updateSql)) {
						updatePstmt.setInt(1, songIds.size()); // 전체 밀어버림
						updatePstmt.setInt(2, playlistId);
						updatePstmt.executeUpdate();
					}

					// 노래들을 turn 순서대로 삽입 (1부터 시작해서 2, 3,... 순으로 쌓임)
					String insertSql = "INSERT INTO playlist_songs (id, song_id, playlist_id, turn) VALUES (seq_playlist_songs_id.NEXTVAL, ?, ?, ?)";
					try (PreparedStatement insertPstmt = conn.prepareStatement(insertSql)) {
						int turn = 1;
						for (int songId : songIds) {
							insertPstmt.setInt(1, songId);
							insertPstmt.setInt(2, playlistId);
							insertPstmt.setInt(3, turn++);
							insertPstmt.addBatch();
						}
						insertPstmt.executeBatch(); // 배치로 한 번에 insert
					}
				}
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				// 에러 발생 시 롤백
				Connection conn = DBConnector.getConn();
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			return false;
		}
	}
}
