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
	//최신 앨범 보여주기
	public ArrayList<RootDto> recentAlbumShow(){
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select alb.id, alb.name albname,alb.member_id, members.name memname, rownum "
					+ "from (select * from albums order by released_at desc) alb,members "
					+ "where alb.member_id = members.id and rownum <=10";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<RootDto> arr = new ArrayList<RootDto>();
			if(!rs.next()) {
				return null;
			}
			do{
				int albumId = rs.getInt("id");
				String albumName = rs.getString("albname");
				int memberId = rs.getInt("member_id");
				String memberName = rs.getString("memname");
				
				RootDto dto = new RootDto(albumId, albumName, memberId, memberName);
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
			}catch(Exception e2){e2.printStackTrace();}
		}
	}
	//인기 음악 보여주기
	public ArrayList<RootDto> popularSongShow() {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select s.view_count,rownum,alb.id,s.name songname,s.id song_id,alb.memname,alb.member_id "
					+ "from (select *  "
					+ "    from songs "
					+ "    order by view_count desc) s, "
					+ "     (select albums.id,albums.member_id,members.name memname "
					+ "     from albums,members "
					+ "     where albums.member_id = members.id) alb "
					+ "where s.album_id = alb.id and rownum<=10 "
					+ "order by rownum ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<RootDto> arr = new ArrayList<RootDto>();
			if(!rs.next()) {
				return null;
			}
			do {
				int albumId = rs.getInt("id");//앨범id
				int memberId = rs.getInt("member_id");
				String memberName = rs.getString("memname");
				String songName = rs.getString("songname");
				int songId = rs.getInt("song_id");
				RootDto dto= new RootDto(albumId, memberId, memberName, songName, songId);
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
		
		//인기 플리 보여주기
	}
	public ArrayList<RootDto> popularPlaylistShow(){
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "select rownum , t.*  "
					+ "from(  "
					+ "    select a.like_count,playlists.id,playlists.name,playlists.mood1,playlists.mood2 "
					+ "    from (select playlist_id,count(*) like_count   "
					+ "        from likes  "
					+ "        group by playlist_id  "
					+ "        order by like_count desc) a, playlists "
					+ "where playlists.id = a.playlist_id "
					+ "order by a.like_count desc) t";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<RootDto> arr= new ArrayList<RootDto>();
			if(!rs.next()) {
				return null;
			}
			do {
				int playlistId = rs.getInt("id");
				String playlistName = rs.getString("name");
				String playlsitMood1 = rs.getString("mood1");
				String playlsitMood2 = rs.getString("mood2");
				RootDto dto = new RootDto(playlistId, playlistName, playlistName, playlistName);
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
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
