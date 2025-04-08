package com.plick.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.io.File;

public class MypageDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	static final int ERROR = -1;
	static final int DUPLICATE = 1;
	static final int UNDUPLICATE = 0;
	
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
	public int updateMemberNickname(String nickname, int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET nickname = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setInt(2, id);
			int result = pstmt.executeUpdate();
			return result;
		}catch(Exception e){
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
	
	public  HashMap<String, Timestamp> getMembershipName(int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT name, stopped_at FROM membership_members mm LEFT JOIN memberships m ON mm.membership_id = m.id WHERE mm.membership_id IN (SELECT membership_id FROM membership_members WHERE member_id = ?)";
			System.out.println("sql1");
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();
			HashMap<String, Timestamp> map = new HashMap<String, Timestamp>();
			if(rs.next()) {
				do {
					System.out.println(rs.getString("name"));
					map.put(rs.getString("name"), rs.getTimestamp("stopped_at"));
				}while(rs.next());
			}
				return map;
		}catch(Exception e){
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
	
	public  ArrayList<String> getMembershipType() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT name FROM memberships";
			pstmt = conn.prepareStatement(sql);
			System.out.println("sql2");
			rs = pstmt.executeQuery();
			ArrayList<String> list = new ArrayList<String>();
			if(rs.next()) {
				do {
					list.add(rs.getString("name"));
				}while(rs.next());
			}
				return list;
		}catch(Exception e){
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
}
