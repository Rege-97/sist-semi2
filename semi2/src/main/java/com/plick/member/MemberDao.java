package com.plick.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.plick.dto.MemberDto;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	static final int INVALID_ID = 1;
	static final int INVALID_PWD = 2;
	static final int SIGNIN_SUCCESS = 0;
	
	public int addMember(MemberDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT INTO members (id, name, nickname, tel, email, password, access_type, created_at)"
					+ " VALUES (seq_members_id.nextval, ?, ?, ?, ?, ?, ?, systimestamp)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getPassword());
			pstmt.setString(6, dto.getAccessType());
			int result = pstmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public int checkEmailDuplicate(String email) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM members WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
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
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public int verifySignin(MemberDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM members WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(!rs.getString("password").equals(dto.getPassword())) return INVALID_PWD;
				dto.setId(rs.getInt("id"));
				dto.setName(rs.getString("name"));
				dto.setNickname(rs.getString("nickname"));
				dto.setTel(rs.getString("tel"));
				dto.setAccessType(rs.getString("access_type"));
				dto.setCreatedAt(rs.getTimestamp("created_at"));
				dto.setDescription(rs.getString("description"));
				return SIGNIN_SUCCESS;
			}else return INVALID_ID;
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public ArrayList<String> searchEmail(String name, String tel) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM members WHERE name = ? AND tel = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, tel);
			rs = pstmt.executeQuery();
			ArrayList<String> arr = new ArrayList<String>();
			if(rs.next()) {
				do {
					arr.add(rs.getString("email"));
				}while(rs.next());
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {	
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
