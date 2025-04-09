package com.plick.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import com.plick.member.MemberDto;

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
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();
			HashMap<String, Timestamp> map = new HashMap<String, Timestamp>();
			if(rs.next()) {
				do {
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
	public int changeMemberAccessType(int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'applicant' WHERE id = ? ORDER BY started_at DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberId);
			int result = pstmt.executeUpdate();
			return result;
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
	
	public  ArrayList<MypageDto> getapplicantInfo(int firstNum, int lastNum) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT id, name, rnum FROM (SELECT id, name, rnum FROM (SELECT rownum AS rnum, id, name FROM members WHERE access_type = 'applicant') ORDER BY rnum DESC)WHERE rnum BETWEEN ?+1 AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, firstNum);
			pstmt.setInt(2, lastNum);
			rs = pstmt.executeQuery();
			ArrayList<MypageDto> list = new ArrayList<MypageDto>();
			if(rs.next()) {
				do {
					MypageDto dto = new MypageDto();
					dto.setRnum(rs.getInt("rnum"));
					dto.setId(rs.getInt("id"));
					dto.setName(rs.getString("name"));
					list.add(dto);
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
	
	public  int getMaxRow() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT MAX(rnum) AS maxrow FROM (SELECT id, name, rnum FROM (SELECT rownum AS rnum, id, name FROM members WHERE access_type = 'applicant') ORDER BY rnum DESC)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<MypageDto> list = new ArrayList<MypageDto>();
			if(rs.next()) {
				do {
					return rs.getInt("maxrow");
				}while(rs.next());
			}
				return 0;
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
	
	public  int requestYes(String[] yp) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'artist' WHERE id in (";
			for (int i = 0; i < yp.length; i++) {
				sql += "?";
				if(i!=yp.length-1) sql += ", ";
			}
			sql += ")";
			pstmt = conn.prepareStatement(sql);
			for (int i = 1; i <= yp.length; i++) {
				pstmt.setString(i, yp[i-1]);
			}
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
	
	public  int requestNo(String[] np) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "UPDATE members SET access_type = 'listener' WHERE id in (";
			for (int i = 0; i < np.length; i++) {
				sql += "?";
				if(i!=np.length-1) sql += ", ";
			}
			sql += ")";
			pstmt = conn.prepareStatement(sql);
			for (int i = 1; i <= np.length; i++) {
				pstmt.setString(i, np[i-1]);
			}
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
}
