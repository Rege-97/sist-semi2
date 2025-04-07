<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.File" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
<body>
<%@ include file="/header.jsp" %>
<h2>마이페이지</h2>
<label>이용권 정보:</label><img src = "">
<input type = "button" value = "이용권구매" onclick = "location.href = '/semi2/membership/payment.jsp'">
<input type = "button" value = "이용권변경" onclick = "location.href = '/semi2/membership/payment.jsp'">

<br>
<input type = "button" value = "비밀번호 변경" onclick = "location.href = '/semi2/member/find/password-reset.jsp'"> 
<input type = "button" value = "프로필 변경" onclick = "location.href = '/semi2/mypage/profile.jsp'"> 
<input type = "button" value = "앨범 등록" onclick = "location.href = '/semi2/mypage/album-management/main.jsp'"> 
<fieldset>
	<img src = "/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>">
	<label onclick = "window.open('edit-profile-img.jsp?memberId=<%=signedinDto.getMemberId() %>', '프로필 사진 변경', 'width=300, height=200');">사진 변경</label>
	<!-- 화면 비전환으로 구현예정 추가 브랜치 열어서 작업 예정 -->
	<label>사진 삭제</label>
	<br>
	<input type = "text" id = "nickname" name = "nickname" value = "<%=signedinDto.getMemberNickname() %>" readonly onchange = "checkDuplicateNickname();">
	<input type = "button" id = "nicknameEditButton" value = "닉네임 변경"  onclick = "changeNickname();" >
	<label id = "duplicateNickname"></label>
	<input type = "hidden" id = "nicknamecheck" value = "true">
	<input type = "text" id = "tel" name = "tel" value = "<%=signedinDto.getMemberTel() %>" readonly>
</fieldset>
<input type = "button" value = "아티스트 등록">
<%@ include file="/footer.jsp" %>
<iframe id = "profile_hidden" style = "display: none;"></iframe>
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
			profileHidden.src = "profile_hidden.jsp?editNickname="+nickname.value+"&memberId=<%=signedinDto.getMemberId() %>";
		}
		nickname.setAttribute("readonly", true);
		nicknameEditButton.value = "닉네임 변경";
	}
}
// 닉네임 중복 실시간 검수 함수
function checkDuplicateNickname() {
	profileHidden.src = "profile_hidden.jsp?editNickname="+nickname.value;
}
// 서밋 전 최종 데이터 검수
function checkForm() {

	
}
</script>
</body>
</html>