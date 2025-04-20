package com.plick.support;

import java.sql.*;
import java.util.*;

public class QuestionDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	//최대 parent_id가져오기
	public int getMaxParentId() {
		try {
		conn = com.plick.db.DBConnector.getConn();
		String sql = "select max(parent_id) from question";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		if(!rs.next()) return -1;

		return rs.getInt(1); 
		
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
	
	//글쓰기
	public int addQuestion(QuestionDto dto) {
		try {
			int maxParentId = getMaxParentId()+1;
			conn = com.plick.db.DBConnector.getConn();
			String sql = "insert into question values (seq_question_id.nextval,?,?,?,systimestamp,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getMemberId());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getContent());
			ps.setInt(4, maxParentId);
			int count = ps.executeUpdate();
			return count;
			
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
	public ArrayList<QuestionDto> showQuestions(int currentPage,int memberId){
		try {
			conn = com.plick.db.DBConnector.getConn();
			int start = (currentPage-1)*10+1;
			int end = currentPage*10;
				String sql = "select q.*,members.nickname,members.email  "
						+ "from(select rownum rn, n.* "
						+ "    from (select * from question where member_id=? "
						+ " 	or parent_id = any (select parent_id from question where member_id =?) order by parent_id desc,id asc) n) q,members "
						+ "where members.id=q.member_id and rn>=? and rn<=?";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
			ps.setInt(2, memberId);
			ps.setInt(3, start);
			ps.setInt(4, end);
			rs=ps.executeQuery();
			ArrayList<QuestionDto> arr = new ArrayList<QuestionDto>();
			if(!rs.next()) {
				return null;
			}
			do {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp createdAt = rs.getTimestamp("created_at");
				int parentId = rs.getInt("parent_id");
				String nickname = rs.getString("nickname");
				String email = rs.getString("email");
				QuestionDto dto = new QuestionDto(id, memberId, title, content, createdAt, parentId,nickname,email);
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
	public int showTotalQuestions(int memberId) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select count(*) from question where member_id=?";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberId);
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
	public QuestionDto showContent(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select q.*,members.nickname,members.email  "
					+ "from(select rownum rn, n.* "
					+ "    from (select * from question order by id desc) n) q,members "
					+ "where q.id=? and members.id=q.member_id";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if(!rs.next()) return null;
			int memberId = rs.getInt("member_id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			Timestamp createdAt = rs.getTimestamp("created_at");
			int parentId = rs.getInt("parent_id");
			String nickname = rs.getString("nickname");
			String email = rs.getString("email");
			QuestionDto dto = new QuestionDto(id, memberId, title, content, createdAt, parentId,nickname,email);
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
	//관리자버전 총 게시물 수 가져오기
	public int showTotalQuestionsAdmin() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select count(*) from question";
			
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
	//관리자버전글 목록 보여주기
		public ArrayList<QuestionDto> showQuestionsAdmin(int currentPage){
			try {
				conn = com.plick.db.DBConnector.getConn();
				int start = (currentPage-1)*10+1;
				int end = currentPage*10;
				String sql = "select q.*,members.nickname,members.email  "
						+ "from(select rownum rn, n.*  from (select * from question order by parent_id desc,id asc) n) q,members "
						+ "where members.id=q.member_id and rn>=? and rn<=? ";
				
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
				
				rs=ps.executeQuery();
				ArrayList<QuestionDto> arr = new ArrayList<QuestionDto>();
				if(!rs.next()) {
					return null;
				}
				do {
					int id = rs.getInt("id");
					int memberId = rs.getInt("member_Id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					Timestamp createdAt = rs.getTimestamp("created_at");
					int parentId = rs.getInt("parent_id");
					String nickname = rs.getString("nickname");
					String email = rs.getString("email");
					QuestionDto dto = new QuestionDto(id, memberId, title, content, createdAt, parentId,nickname,email);
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
		//관리자버전 답글쓰기
		public int addAnswer(QuestionDto dto) {
			try {
				conn = com.plick.db.DBConnector.getConn();
				String sql = "insert into question values (seq_question_id.nextval,?,?,?,systimestamp,?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, dto.getMemberId());
				ps.setString(2, dto.getTitle());
				ps.setString(3, dto.getContent());
				ps.setInt(4, dto.getParentId());
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
		// 글 수정
		public int updateQuestion(QuestionDto dto) {
				try {
					conn = com.plick.db.DBConnector.getConn();
					String sql = "update question set title=?,content=? where id=? ";
					ps = conn.prepareStatement(sql);
					ps.setString(1, dto.getTitle());
					ps.setString(2, dto.getContent());
					ps.setInt(3, dto.getId());
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
}