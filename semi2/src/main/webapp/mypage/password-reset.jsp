<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page import="java.io.File"%>
<%@page import="com.plick.signedin.SignedinDao"%>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<%
request.setCharacterEncoding("UTF-8");
%>
<body>
<%@ include file="/header.jsp" %>
<%
SignedinDao sDao = new SignedinDao();
String pwd = request.getParameter("password");
int result = sDao.verifyPasswordReset(signedinDto, pwd);
boolean a = result == 0 ? true : false;
%>
<script>
if (<%=a %>){
}else{
	window.alert("입력하신 비밀번호가 잘못되었습니다.");
	history.back();
}

var pwdsame = true;
function testPassword() {
	var pwd = document.getElementById("pwd").value;
	var pwd2 = document.getElementById("pwdTest").value;
	if (pwd == pwd2){
		document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 같습니다";
		pwdsame = true;
		if (pwd == <%=pwd %>){
			document.getElementById("pwdCheck").innerText = "이전과 동일한 비밀번호는 사용하실 수 없습니다";
			pwdsame = false;
		}
	}else{
		document.getElementById("pwdCheck").innerText = "입력하신 비밀번호가 다릅니다";
		pwdsame = false;
	}
}
function formCheck(event) {
	var a = true;
	if (pwdsame == false){ 
		event.preventDefault();
		a = false;
	}
	if (!a) window.alert("form에 잘못된 부분 있음 확인바람");
}
</script>
	<%
	MypageDao mdao = new MypageDao();
	// Dao에서 이용권 이름, 만료 기간을 가져와서 남은 일자 계산 후 출력
	HashMap<String, Timestamp> map = mdao.getMembershipName(signedinDto.getMemberId());
	ArrayList<String> list = mdao.getMembershipType();
	
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
			<h2>비밀번호 찾기</h2>
		</div>
	<form action = "password-reset_ok.jsp?email=<%=signedinDto.getMemberEmail() %>" method = "post" onsubmit = "formCheck(event)">
		<input type="password" id = "pwd" name = "password" placeholder="새 비밀번호" onchange = "testPassword()" class="login-text">
		<br>
		<input type="password" id = "pwdTest" placeholder="새 비밀번호 확인" onchange = "testPassword()" class="login-text">
		<div class="signin-hidden">
		<label id = pwdCheck></label>
		</div>
		<input type="submit" value="비밀번호 변경" class="bt">
	</form>
</div>
<%@ include file="/footer.jsp" %>
</body>
</body>
</html>