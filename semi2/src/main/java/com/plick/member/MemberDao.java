package com.plick.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.File;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	
	
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
	public int checkNicknameDuplicate(String nickname) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id FROM members WHERE nickname = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
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
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	public boolean findPassword(String email, String name, String tel) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM members WHERE email = ? AND name = ? AND tel = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			pstmt.setString(3, tel);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}else return false;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
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
	public int resetPassword(String pwd, String email) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET password = ? WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, email);
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
	public int searchId(String email) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM members WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					return rs.getInt("id");
				}while(rs.next());
			}
			return 0;
		}catch(Exception e) {
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
	public String loadProfileImg(String realPath, int memberId) {
		File profileImg = new File(realPath+"resources/member/"+memberId+"/profileImg.jpg");
		if (profileImg.exists()) {
			return("resources/member/"+memberId+"/profileImg.jpg");
		}else return "resources/member/defaultImg.jpg";
	}
	public String loadEditerImg(String realPath, int memberId) {
		File profileImg = new File(realPath+"resources/member/"+memberId+"/profileImg.jpg");
		if (profileImg.exists()) {
			return("resources/member/"+memberId+"/profileImg.jpg");
		}else return "resources/member/editerImg.jpg";
	}
}
