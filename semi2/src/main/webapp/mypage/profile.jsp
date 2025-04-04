<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<script>

function changeNickname() {
	var nicknameEditButton = document.getElementById("nicknameEditButton");
	var nickname = document.getElementById("nickname");
	if (nicknameEditButton.value == "닉네임 변경"){
		document.getElementById("nickname").removeAttribute("readonly");
		nicknameEditButton.value = "수정완료";
	}else if (nicknameEditButton.value == "수정완료"){	
		var effectiveness = document.getElementById("nicknamecheck").value = true ? true : false;
		if (effectiveness){
			document.getElementById("profile_hidden").src = "profile_hidden.jsp?editedNickname="+document.getElementById("nickname").value
					+"&memberId=<%=signedinDto.getMemberId() %>";
		}
		documen
		document.getElementById("nickname").setAttribute("readonly", true);
		nicknameEditButton.value = "닉네임 변경";
	}
}
function changeTel() {
	document.getElementById("tle").removeAttribute("readonly");
	document.getElementById("tleEditButton").value = "수정완료";
}
function checkDuplicateNickname() {
	document.getElementById("profile_hidden").src = "profile_hidden.jsp?editNickname="+document.getElementById("nickname").value;
}
function checkForm() {

	
}
</script>
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
</body>
</html>