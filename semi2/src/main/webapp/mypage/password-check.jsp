<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page import="java.io.File"%>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
	<%@ include file="/header.jsp"%>
	<%
	MypageDao mdao = new MypageDao();
	// Dao에서 이용권 이름, 만료 기간을 가져와서 남은 일자 계산 후 출력
	HashMap<String, Timestamp> map = mdao.getMembershipName(signedinDto.getMemberId());
	ArrayList<String> list = mdao.getMembershipType();
	boolean a = false;
	%>
	<div class="subtitle">
		<h2>마이페이지</h2>
	</div>

	<%
	// 모든 이용권을 반복문으로 돌려 사용자가 가지고 있는 이용권들을 화면에 표시
	boolean b = false, c = false;
	for (int i = 0; i < 3; i++) {
		Calendar now = Calendar.getInstance();
		Calendar now2 = Calendar.getInstance();
		if (map.get(list.get(i)) == null) {
			continue;
		}
		now2.setTimeInMillis(map.get(list.get(i)).getTime());
		long timeLeft = now2.getTimeInMillis() - now.getTimeInMillis();
		if (timeLeft > 0)
			b = true;
		long dayLeft = TimeUnit.MILLISECONDS.toDays(timeLeft);
		if (dayLeft > 0)
			a = true;
	%><div class="mypage-card">
		<img src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';" class="mypage-artist-image">
		<div class="subtitle">
			<label>현재 이용권 : <%=dayLeft > 0 ? list.get(i) : "보유중인 이용권이 없습니다"%>
			</label>
		</div>
		<div class="subtitle-sub">
			<label><%=dayLeft > 0 ? "남은 일자 : " + dayLeft + "일" : ""%></label>
			<%
			break;
			}
			%>
			<input type="button" value="<%=a ? "이용권변경" : "이용권구매"%>" onclick="location.href = '/semi2/membership/main.jsp'" class="bt">

		</div>
	</div>
	<div class="submenu-box">
		<input type="button" value="프로필 변경" onclick="location.href = '/semi2/mypage/profile.jsp'" class="bt">
		<input type="button" value="비밀번호 변경" onclick="location.href = '/semi2/mypage/password-check.jsp'" class="bt_clicked">
		<%
		if (signedinDto.getMemberAccessType().equals("listener")) {
		%>
		<input type="button" value="아티스트 신청" onclick="location.href = '/semi2/mypage/request/artist-request.jsp'" class="bt">
		<%
		} else if (signedinDto.getMemberAccessType().equals("applicant")) {
		%>
		<label>현재 아티스트 등록 심사 중 입니다.</label>
		<%
		} else if (signedinDto.getMemberAccessType().equals("artist")) {
		%>
		<input type="button" value="앨범 등록" onclick="location.href = '/semi2/mypage/album-management/main.jsp'" class="bt">
		<%
		} else if (signedinDto.getMemberAccessType().equals("admin")) {
		%>
		<input type="button" value="아티스트 요청 처리" onclick="location.href = '/semi2/mypage/request/request-processing.jsp'" class="bt">

		<%
		}
		%>
	</div>
	<div class="footer-line"></div>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>비밀번호 확인</h2>
		</div>
		<form action="password-reset.jsp" method="post">
			<div class="profile-change-card-input">
				<input type="password" name="password" placeholder="비밀번호" class="login-text">
				<input type="submit" value="다음" class="bt">
			</div>
		</form>
	</div>
	<%@ include file="/footer.jsp"%>
</body>
</html>