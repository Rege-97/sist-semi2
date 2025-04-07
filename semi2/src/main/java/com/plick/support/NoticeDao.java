package com.plick.support;

import java.sql.*;
import java.util.*;

public class NoticeDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	public NoticeDao() {
		// TODO Auto-generated constructor stub
	}
	//글쓰기
	public int addNotice(NoticeDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "insert into notice values (seq_notice_id.nextval,?,?,?,systimestamp)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getId());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getContent());
			return ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {e2.printStackTrace();}
		}
	}
	//글 목록 보여주기
	public ArrayList<NoticeDto> showNotices(int currentPage){
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage-1)*10+1;
			int end = currentPage*10;
			String sql = "select *  "
					+ "from(select rownum rn, n.* "
					+ "		from (select * from notice order by id desc) n) "
					+ "where rn>=? and rn<=?";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs=ps.executeQuery();
			ArrayList<NoticeDto> arr = new ArrayList<NoticeDto>();
			if(!rs.next()) {
				return null;
			}
			do {
				int id = rs.getInt("id");
				int memberId = rs.getInt("member_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp createdAt = rs.getTimestamp("created_at");
				NoticeDto dto = new NoticeDto(id, memberId, title, content, createdAt);
				arr.add(dto);
			}while(rs.next());
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {e2.printStackTrace();}
		}
	}
	//총 게시물 수 가져오기
	public int showTotalNotices() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select count(*) from notice";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(!rs.next()) return -1;
			return rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {e2.printStackTrace();}
		}
	}
	//글 내용 보여주기
	public NoticeDto showContent(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select * from notice where id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if(!rs.next()) return null;
			int memberId = rs.getInt("member_id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			Timestamp createdAt = rs.getTimestamp("created_at");
			NoticeDto dto = new NoticeDto(id, memberId, title, content, createdAt);
			return dto;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} finally{
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {e2.printStackTrace();}
		}
		
	}
}
