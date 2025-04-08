package com.plick.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

public class SearchDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	// 앨범 검색 최신순
	public ArrayList<SearchAlbumDto> searchAlbums(String search, int rownum) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select *  " + "from (select rownum, alb.*,members.nickname "
					+ "    from (select * from albums where name like ? order by released_at desc) alb "
					+ "        left join members " + "        on alb.member_id = members.id ) " + "where rownum <=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ps.setInt(2, rownum);
			rs = ps.executeQuery();
			ArrayList<SearchAlbumDto> arr = new ArrayList<SearchAlbumDto>();
			while (rs.next()) {
				int albumId = rs.getInt("id");
				int memberId = rs.getInt("member_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String genre1 = rs.getString("genre1");
				String genre2 = rs.getString("genre2");
				String genre3 = rs.getString("genre3");
				Timestamp releasedAt = rs.getTimestamp("released_at");
				Timestamp createdAt = rs.getTimestamp("created_at");
				String nickname = rs.getString("nickname");
				SearchAlbumDto dto = new SearchAlbumDto(albumId, memberId, name, description, genre1, genre2, genre3,
						releasedAt, createdAt, nickname);
				arr.add(dto);
			}
			return arr;
		} catch (SQLException e) {
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
}
