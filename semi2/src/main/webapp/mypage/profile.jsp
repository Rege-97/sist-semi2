<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>

<body>
	<%@ include file="/header.jsp"%>
	<%
	MypageDao mdao = new MypageDao();
	// Dao에서 이용권 이름, 만료 기간을 가져와서 남은 일자 계산 후 출력
	HashMap<String, Timestamp> map = mdao.getMembershipName(signedinDto.getMemberId());
	ArrayList<String> list = mdao.getMembershipType();
	boolean a = false;
	%>
	<h2>마이페이지</h2>

	<%
	// 모든 이용권을 반복문으로 돌려 사용자가 가지고 있는 이용권들을 화면에 표시
	boolean b = false, c = false;
	for (int i = 0; i < 3; i++) {
		Calendar now = Calendar.getInstance();
		Calendar now2 = Calendar.getInstance();
		if (map.get(list.get(i)) == null){
			continue;
		}
		now2.setTimeInMillis(map.get(list.get(i)).getTime());
		long timeLeft = now2.getTimeInMillis() - now.getTimeInMillis();
		if (timeLeft > 0) b = true;
		long dayLeft = TimeUnit.MILLISECONDS.toDays(timeLeft);
		if (dayLeft > 0)
			a = true;
	%>
	<label> <%=dayLeft > 0 ? list.get(i) : "보유중인 이용권이 없습니다" %> <%=dayLeft > 0 ? "남은 일자 : 일"+dayLeft : ""%>
	</label>
	<%
	break;
	}
	%>
	<img src="">
	<input type="button" value="<%=a ? "이용권변경" : "이용권구매"%>"
		onclick="location.href = '/semi2/membership/main.jsp'">

	<br>
	<input type="button" value="비밀번호 변경"
		onclick="location.href = '/semi2/mypage/password-check.jsp'">
	<%
	if (signedinDto.getMemberAccessType().equals("listener")) {
	%>
	<input type="button" value="아티스트 신청"
		onclick="location.href = '/semi2/mypage/request/artist-request.jsp'">
	<%
	} else if (signedinDto.getMemberAccessType().equals("applicant")) {
	%>
	<label>현재 아티스트 등록 심사 중 입니다.</label>
	<%
	} else if (signedinDto.getMemberAccessType().equals("artist")) {
	%>
	<input type="button" value="앨범 등록"
		onclick="location.href = '/semi2/mypage/album-management/main.jsp'">
	<%
	} else if (signedinDto.getMemberAccessType().equals("admin")) {
	%>
	<input type="button" value="아티스트 요청 처리"
		onclick="location.href = '/semi2/mypage/request/request-processing.jsp'">
	<%
	}
	%>
	<fieldset>
		<img
			src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>">
		<label
			onclick="location.href = 'edit-profile-img.jsp?memberId=<%=signedinDto.getMemberId()%>';">사진
			변경</label>
		<!-- 화면 비전환으로 구현예정 추가 브랜치 열어서 작업 예정 -->
		<label onclick="delProfileImg();">
		사진 삭제</label>	 <br> <input type="text" id="nickname"
			name="nickname" value="<%=signedinDto.getMemberNickname()%>"
			readonly onchange="checkDuplicateNickname();"> <input
			type="button" id="nicknameEditButton" value="닉네임 변경"
			onclick="changeNickname();"> <label id="duplicateNickname"></label>
		<input type="hidden" id="nicknamecheck" value="true"> <input
			type="text" id="tel" name="tel"
			value="<%=signedinDto.getMemberTel()%>" readonly>
	</fieldset>
	<%@ include file="/footer.jsp"%>
	<iframe id="profile_hidden" style="display: none;"></iframe>

<script>
var nicknameEditButton = document.getElementById("nicknameEditButton");
var nickname = document.getElementById("nickname");
var profileHidden = document.getElementById("profile_hidden");
// 닉네임 변경 dom 제어/ ifarame으로 중복 검사 요청
function changeNickname() {
	
	if (nicknameEditButton.value == "닉네임 변경"){
		nickname.removeAttribute("readonly");
		nicknameEditButton.value = "수정완료";
	}else if (nicknameEditButton.value == "수정완료"){	
		var effectiveness = document.getElementById("nicknamecheck").value == "true" ? true : false;
		if (effectiveness){
			profileHidden.src = "profile_hidden.jsp?editNickname="+nickname.value+"&memberId=<%=signedinDto.getMemberId()%>";
				}
				nickname.setAttribute("readonly", true);
				nicknameEditButton.value = "닉네임 변경";
			}
		}
		// 닉네임 중복 실시간 검수 함수
		function checkDuplicateNickname() {
			profileHidden.src = "profile_hidden.jsp?editNickname="
					+ nickname.value;
		}
		// 서밋 전 최종 데이터 검수
		function checkForm() {

		}
		// 프로필 사진 삭제
		function delProfileImg() {
			document.getElementById('profile_hidden').src = "del-profile-img.jsp?memberId=<%=signedinDto.getMemberId()%>";
		}
	</script>
</body>
</html>