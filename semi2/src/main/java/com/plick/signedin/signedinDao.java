package com.plick.signedin;

import java.util.Calendar;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import com.plick.member.MemberDto;
import com.plick.signedin.signedinDto;

public class signedinDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	static final int ERROR = -1;
	static final int INVALID_ID = 1;
	static final int INVALID_PWD = 2;
	static final int SIGNIN_SUCCESS = 0;
	public static final int COOKIE_LIFE_30DAYS = 3600 * 24 * 30;

	public int verifySignin(signedinDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT name, nickname, tel, email, password, access_type, created_at, "
					+ "description, membership_members.id, membership_id, member_id, started_at, stopped_at "
					+ "FROM members LEFT OUTER JOIN membership_members "
					+ "ON members.id = membership_members.member_id " + "WHERE members.email = ?";
			pstmt = conn.prepareStatement(sql);
			System.out.println(sql + dto.getMemberEmail());
			pstmt.setString(1, dto.getMemberEmail());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (!rs.getString("password").equals(dto.getMemberPassword()))
					return INVALID_PWD;
				dto.setMemberName(rs.getString("name"));
				dto.setMemberNickname(rs.getString("nickname"));
				dto.setMemberTel(rs.getString("tel"));
				dto.setMemberEmail(rs.getString("email"));
				dto.setMemberAccessType(rs.getString("access_type"));
				dto.setMemberCreatedAt(rs.getTimestamp("created_at"));
				dto.setMemberDescription(rs.getString("description"));
				dto.setId(rs.getInt("id"));
				dto.setMembershipId(rs.getInt("membership_id"));
				dto.setMemberId(rs.getInt("member_id"));
				dto.setMembershipStarted_at(rs.getTimestamp("started_at"));
				dto.setMembershipStopped_at(rs.getTimestamp("stopped_at"));
				return SIGNIN_SUCCESS;
			} else
				return INVALID_ID;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int hasActiveMembership(signedinDto dto) {
		try {
			conn = com.plick.db.DBConnector.getConn();
			String sql = "SELECT stopped_at,membership_id FROM MEMBERSHIP_MEMBERS WHERE stopped_at=(SELECT max(stopped_at) FROM MEMBERSHIP_MEMBERS WHERE member_id=?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMemberId());
			rs=pstmt.executeQuery();
			
			int hasMembershipId = 0;
			
			if (rs.next()) {
				Timestamp stoppedAt = rs.getTimestamp("stopped_at");
				int membershipId = rs.getInt("membership_id");
				Calendar now = Calendar.getInstance();

				long nowMili = now.getTimeInMillis();
				long stoppedAtMili = stoppedAt.getTime();

				if (nowMili < stoppedAtMili) {
					hasMembershipId = membershipId;
				}
			}

			return hasMembershipId;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}

	public long isMembershipValid(Timestamp startedAt, Timestamp stoppedAt) {
		Calendar now = Calendar.getInstance();
		long nowTime = now.getTimeInMillis();
		long startTime = startedAt.getTime();
		long stopTime = stoppedAt.getTime();
		if (nowTime > startTime && nowTime > stopTime) {
			return stopTime - nowTime;
		} else {
			return (long) 0;
		}
	}
}
