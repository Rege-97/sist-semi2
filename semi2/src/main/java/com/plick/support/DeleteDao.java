package com.plick.support;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DeleteDao {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	// 글 검색
	public int selectId(int parentId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select * from question where parent_id=? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, parentId);
			rs = ps.executeQuery();
			if(!rs.next()) return 0; 
			int count = 0;
			do {
				count++;
			}while(rs.next());
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs!=null) 
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
	
	// 글 삭제
	public int delete(int id, String table, int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "delete from " + table + " where id=? AND member_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setInt(2, memberId);
			return ps.executeUpdate();

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

}
