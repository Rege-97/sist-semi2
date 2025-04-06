package com.plick.membership;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.plick.dto.MembershipDto;

public class MembershipDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public MembershipDao() {

	}

	public MembershipDto findMembership(int id) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT * FROM memberships WHERE id=?";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			MembershipDto dto = null;

			if (rs.next()) {
				String name = rs.getString("name");
				int price = rs.getInt("price");
				int period = rs.getInt("period");
				dto = new MembershipDto(id, name, price, period);
			}

			return dto;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
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

	public int payMembership(int memberid, int membershipid) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "INSERT  " + "INTO MEMBERSHIP_MEMBERS  "
					+ "values(seq_membership_members_id.nextval,?,?,systimestamp,systimestamp+(SELECT period FROM MEMBERSHIPS WHERE id=?))";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, membershipid);
			ps.setInt(2, memberid);
			ps.setInt(3, membershipid);

			int count= ps.executeUpdate();
			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
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

}
