<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<body>
<%@ include file="/header.jsp" %>
<h2>마이페이지</h2>
<label>이용권 정보:</label><img src = "">
<input type = "button" value = "이용권구매" onclick = "location.href = '/semi2/membership/main.jsp'">
<input type = "button" value = "이용권변경" onclick = "location.href = '/semi2/membership/main.jsp'">

<br>
<input type = "button" value = "비밀번호 변경" onclick = "location.href = '/semi2/member/find/password-reset.jsp'"> 
<input type = "button" value = "프로필 변경" onclick = "location.href = '/semi2/mypage/profile.jsp'"> 
<input type = "button" value = "앨범 등록" onclick = "location.href = '/semi2/mypage/album-management/main.jsp'"> 
<fieldset>
	<img src = "">
	<br>
	<input type = "text" id = "nickname" name = "nickname" value = "<%=signedinDto.getMemberNickname() %>" readonly onchange = "checkDuplicateNickname();">
	<input type = "button" id = "nicknameEditButton" value = "닉네임 변경"  onclick = "changeNickname();" >
	<label id = "duplicateNickname"></label>
	<input type = "hidden" id = "nicknamecheck" value = "true">
	<input type = "text" id = "nickname" name = "tel" value = "<%=signedinDto.getMemberTel() %>" readonly>
	<input type = "button" id = "telEditButton" value = "번호 변경"  onclick = "changeTel();">
</fieldset>
<input type = "button" value = "아티스트 등록">
<%@ include file="/footer.jsp" %>
<iframe id = "profile_hidden" style = "display: none;"></iframe>
<script>
// 닉네임 변경 dom 제어/ ifarame으로 중복 검사 요청
	var nicknameEditButton = document.getElementById("nicknameEditButton");
	var nickname = document.getElementById("nickname");
	var profileHidden = document.getElementById("profile_hidden");
function changeNickname() {
	if (nicknameEditButton.value == "닉네임 변경"){
		nickname.removeAttribute("readonly");
		nicknameEditButton.value = "수정완료";
	}else if (nicknameEditButton.value == "수정완료"){	
		var effectiveness = document.getElementById("nicknamecheck").value == "true" ? true : false;
		if (effectiveness){
			window.alert("1");
			profileHidden.src = "profile_hidden.jsp?editedNickname="+nickname.value
					+"&memberId=<%=signedinDto.getMemberId() %>";
		}
		nickname.setAttribute("readonly", true);
		nicknameEditButton.value = "닉네임 변경";
	}
}
// 전화 번호 변경 정책이 정해지면 구현할 부분
function changeTel() {
	
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