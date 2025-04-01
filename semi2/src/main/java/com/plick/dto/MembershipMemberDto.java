package com.plick.dto;

import java.sql.Timestamp;

public class MembershipMemberDto {
	private int id;
	private int membershipId;
	private int memberId;
	private Timestamp startedAt;
	private Timestamp stoppedAt;

	public MembershipMemberDto() {
	}

	public MembershipMemberDto(int id, int membershipId, int memberId, Timestamp startedAt, Timestamp stoppedAt) {
		super();
		this.id = id;
		this.membershipId = membershipId;
		this.memberId = memberId;
		this.startedAt = startedAt;
		this.stoppedAt = stoppedAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMembershipId() {
		return membershipId;
	}

	public void setMembershipId(int membershipId) {
		this.membershipId = membershipId;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public Timestamp getStartedAt() {
		return startedAt;
	}

	public void setStartedAt(Timestamp startedAt) {
		this.startedAt = startedAt;
	}

	public Timestamp getStoppedAt() {
		return stoppedAt;
	}

	public void setStoppedAt(Timestamp stoppedAt) {
		this.stoppedAt = stoppedAt;
	}

}
