package com.plick.artist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.plick.db.DBConnector;
import com.plick.dto.PlaylistDto;

public class ArtistDao {
	public ArtistDto findArtistDetailsByMemberId(int memberId) {
		try (Connection conn = DBConnector.getConn();) {
			MemberDto memberDto = findMemberDetailsByMemberId(memberId, conn);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public MemberDto findMemberDetailsByMemberId(int memberId) {
		try (Connection conn = DBConnector.getConn();) {
			return findMemberDetailsByMemberId(memberId, conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private MemberDto findMemberDetailsByMemberId(int memberId, Connection conn) {
		String sql = "SELECT * FROM ( SELECT * FROM members WHERE id = ? ) filtered_member "
				+ "INNER JOIN playlists ON filtered_member.id = playlists.member_id";

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, memberId);
			try (ResultSet rs = pstmt.executeQuery()) {

				List<PlaylistDto> playlists = new ArrayList<PlaylistDto>();
				if (!rs.isBeforeFirst()) {
					return null;
				}
				rs.next();
				String nickname = rs.getString("filtered_member.nickname");
				String description = rs.getString("filtered_member.description");
				playlists.add(new PlaylistDto(rs.getInt("playlist.id"), rs.getInt("playlist.member_id"),
						rs.getString("playlist.name"), rs.getTimestamp("playlist.created_at"),
						rs.getString("playlist.mood1"), rs.getString("playlist.mood2")));
				while (rs.next()) {
					playlists.add(new PlaylistDto(rs.getInt("playlist.id"), rs.getInt("playlist.member_id"),
							rs.getString("playlist.name"), rs.getTimestamp("playlist.created_at"),
							rs.getString("playlist.mood1"), rs.getString("playlist.mood2")));
				}
				return new MemberDto(memberId, nickname, description, playlists);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
