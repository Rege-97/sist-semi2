package com.plick.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import com.plick.dto.MemberDto;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	
	public int addMember(MemberDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT INTO members (id, name, nickname, tel, email, password, access_type, created_at)"
					+ " VALUES (seq_members_id.nextval, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getPassword());
			pstmt.setString(6, dto.getAccessType());
			pstmt.setTimestamp(7, dto.getCreatedAt());
			int result = pstmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	public int checkEmailDuplicate(String email) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM members";
			pstmt = conn.prepareStatement(sql);
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
			}catch(Exception e2) {}
		}
	}
}
