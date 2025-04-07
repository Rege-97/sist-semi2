package com.plick.root;

import java.sql.*;

public class SignedinHeaderDto {
	private int memberId;
	private String memberNickname;
	private int membershipId;
	private Timestamp stoppedAt;
	private String membershipName;
	
	public SignedinHeaderDto() {
		// TODO Auto-generated constructor stub
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public int getMembershipId() {
		return membershipId;
	}

	public void setMembershipId(int membershipId) {
		this.membershipId = membershipId;
	}

	public Timestamp getStoppedAt() {
		return stoppedAt;
	}

	public void setStoppedAt(Timestamp stoppedAt) {
		this.stoppedAt = stoppedAt;
	}

	public String getMembershipName() {
		return membershipName;
	}

	public void setMembershipName(String membershipName) {
		this.membershipName = membershipName;
	}

	public SignedinHeaderDto(int memberId, String memberNickname, int membershipId, Timestamp stoppedAt,
			String membershipName) {
		super();
		this.memberId = memberId;
		this.memberNickname = memberNickname;
		this.membershipId = membershipId;
		this.stoppedAt = stoppedAt;
		this.membershipName = membershipName;
	}
	
	
}
