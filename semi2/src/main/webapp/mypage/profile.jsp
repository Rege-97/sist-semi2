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
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">

<body>
	<%@ include file="/header.jsp"%>
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>프로필 변경</h2>
		</div>
		<img
			src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>"
			onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"
			class="mypage-artist-image" id="profileImg" >
		<!-- 화면 비전환으로 구현예정 추가 브랜치 열어서 작업 예정 -->
		<div>
			<input type="button" value="사진 변경" class="bt"
				onclick="location.href = 'edit-profile-img.jsp?memberId=<%=signedinDto.getMemberId()%>';">
			<input type="button" value="사진 삭제" class="bt" id="deleteProfileImg"
				onclick="delProfileImg();">
		</div>
		<div class="profile-change-card-input">
			<input type="text" id="nickname" name="nickname"
				value="<%=signedinDto.getMemberNickname()%>" readonly
				onchange="checkDuplicateNickname();" class="mypage-text"> <input
				type="button" id="nicknameEditButton" value="닉네임 변경"
				onclick="changeNickname();" class="bt"> <label
				id="duplicateNickname"></label> <input type="hidden"
				id="nicknamecheck" value="true">
		</div>
		<textarea style = "resize: none;" name = "description" rows = "10" cols = "70" maxlength = "4000" readonly class="login-text"></textarea>
	</div>
	<%@ include file="/footer.jsp"%>
	<iframe id="profile_hidden" style="display: none;"></iframe>

	<script>
		var nicknameEditButton = document.getElementById("nicknameEditButton");
		var nickname = document.getElementById("nickname");
		var profileHidden = document.getElementById("profile_hidden");
		var profileImg = document.getElementById("profileImg");
		if (profileImg.src.indexOf("default-profile")!=-1){
			document.getElementById("deleteProfileImg").style.visibility = "hidden";
		}
		
		
		// 닉네임 변경 dom 제어/ ifarame으로 중복 검사 요청
		function changeNickname() {
			if (nicknameEditButton.value == "닉네임 변경") {
				nickname.removeAttribute("readonly");
				nicknameEditButton.value = "수정완료";
			} else if (nicknameEditButton.value == "수정완료") {
				var effectiveness = document.getElementById("nicknamecheck").value == "true" ? true
						: false;
				if (effectiveness) {
					profileHidden.src = "profile_hidden.jsp?editNickname="
							+ nickname.value + "&memberId="
							+
	<%=signedinDto.getMemberId()%>
		;
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
			document.getElementById('profile_hidden').src = "del-profile-img.jsp?memberId="
					+
	<%=signedinDto.getMemberId()%>
		;
		}
	</script>
</body>
</html>