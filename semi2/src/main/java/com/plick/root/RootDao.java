package com.plick.root;

import java.sql.*;
import java.util.*;

public class RootDao {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public RootDao() {
		// TODO Auto-generated constructor stub
	}
	
	public ArrayList<RootDto> recentAlbumShow(){
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select alb.id, alb.name albname,alb.member_id, members.name memname, rownum "
					+ "from (select * from albums order by released_at desc) alb,members "
					+ "where alb.member_id = members.id and rownum <=10";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<RootDto> arr = new ArrayList<RootDto>();
			while(rs.next()) {
				int id = rs.getInt("id");
				String albumName = rs.getString("albname");
				int memberId = rs.getInt("member_id");
				String memberName = rs.getString("memname");
				
				RootDto dto = new RootDto(id, albumName, memberId, memberName);
				arr.add(dto);
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2){}
		}
	}
	
}
