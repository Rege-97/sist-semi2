package com.plick.signedin;

import java.sql.Timestamp;

public class SignedinDto {
	private int membershipMemberId;
	private int memberId;
	private int membershipId;
	private String memberName;
	private String memberNickname;
	private String memberTel;
	private String memberEmail;
	private String memberPassword;
	private String memberAccessType;
	private Timestamp memberCreatedAt;
	private String memberDescription;
	private Timestamp membershipStarted_at;
	private Timestamp membershipStopped_at;

	public  SignedinDto() {
	}

	

	public SignedinDto(int id, int memberId, int membershipId, String memberName, String memberNickname,
			String memberTel, String memberEmail, String memberPassword, String memberAccessType,
			Timestamp memberCreatedAt, String memberDescription, Timestamp membershipStarted_at,
			Timestamp membershipStopped_at) {
		super();
		this.membershipMemberId = id;
		this.memberId = memberId;
		this.membershipId = membershipId;
		this.memberName = memberName;
		this.memberNickname = memberNickname;
		this.memberTel = memberTel;
		this.memberEmail = memberEmail;
		this.memberPassword = memberPassword;
		this.memberAccessType = memberAccessType;
		this.memberCreatedAt = memberCreatedAt;
		this.memberDescription = memberDescription;
		this.membershipStarted_at = membershipStarted_at;
		this.membershipStopped_at = membershipStopped_at;
	}



	public int getMembershipMemberId() {
		return membershipMemberId;
	}

	public void setMembershipMemberId(int id) {
		this.membershipMemberId = id;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getMembershipId() {
		return membershipId;
	}

	public void setMembershipId(int membershipId) {
		this.membershipId = membershipId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberTel() {
		return memberTel;
	}

	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberPassword() {
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}

	public String getMemberAccessType() {
		return memberAccessType;
	}

	public void setMemberAccessType(String memberAccessType) {
		this.memberAccessType = memberAccessType;
	}

	public Timestamp getMemberCreatedAt() {
		return memberCreatedAt;
	}

	public void setMemberCreatedAt(Timestamp memberCreatedAt) {
		this.memberCreatedAt = memberCreatedAt;
	}

	public String getMemberDescription() {
		return memberDescription;
	}

	public void setMemberDescription(String memberDescription) {
		this.memberDescription = memberDescription;
	}

	public Timestamp getMembershipStarted_at() {
		return membershipStarted_at;
	}

	public void setMembershipStarted_at(Timestamp membershipStarted_at) {
		this.membershipStarted_at = membershipStarted_at;
	}

	public Timestamp getMembershipStopped_at() {
		return membershipStopped_at;
	}

	public void setMembershipStopped_at(Timestamp membershipStopped_at) {
		this.membershipStopped_at = membershipStopped_at;
	}

	
}
