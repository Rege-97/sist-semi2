<%@page import="com.plick.mypage.MypageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<style>
#description {
	display: block;
	margin: 0 auto;
	width: 500px;
	height: 300px;
	resize: none;
	border: 1px solid #666666;
	border-radius: 8px;
}
textarea::-webkit-scrollbar {
    display: none; /* 스크롤바 숨기기 */
}
#descriptionBt {
	margin-top: 30px;
	
}
</style>
<body>
	<%@ include file="/header.jsp"%>
	<div class="body-content">
	<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>프로필 변경</h2>
		</div>
		<img
			src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>?v=<%=System.currentTimeMillis()%>"
			onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"
			class="mypage-artist-image" id="profileImg" >
		<!-- 화면 비전환으로 구현예정 추가 브랜치 열어서 작업 예정 -->
		<div class="profile-image-button">
			<input type="button" value="사진 변경" class="bt"
				onclick="location.href = 'edit-profile-img.jsp?memberId=<%=signedinDto.getMemberId()%>';">
			<input type="button" value="사진 삭제" class="bt" id="deleteProfileImg"
				onclick="delProfileImg();">
		</div>
		<div class="profile-change-card-input">
			<input type="text" id="nickname" name="nickname"
				value="<%=signedinDto.getMemberNickname()%>" readonly
				oninput="checkDuplicateNickname();" class="mypage-text"> 
				<input type="button" id="nicknameEditButton" value="닉네임 변경"
				onclick="changeNickname();" class="bt"> <label
				id="duplicateNickname"></label> <input type="hidden"
				id="nicknamecheck" value="true">
		</div>
		<textarea name = "description" id = "description" rows = "10" cols = "70" maxlength = "4000" readonly class="login-text"><%=signedinDto.getMemberDescription() == null ? "" : signedinDto.getMemberDescription() %></textarea>
		<input type = "button" value = "프로필 메세지 수정" id = "descriptionBt" class="bt" onclick = "changeDescription(this);">
	</div>
	<%@ include file="/footer.jsp"%>
	<iframe id="profile_hidden" style="display: none;"></iframe>

	<script>
		var nicknameEditButton = document.getElementById("nicknameEditButton");
		var nickname = document.getElementById("nickname");
		var profileHidden = document.getElementById("profile_hidden");
		var profileImg = document.getElementById("profileImg");
		var description = document.getElementById("description");
		if (profileImg.src.indexOf("default-profile")!=-1){
			document.getElementById("deleteProfileImg").style.display = "none";
		}
		
		
		function changeDescription(bt) {
			if (bt.value == "프로필 메세지 수정"){
				description.removeAttribute("readonly");
				bt.value = "수정 완료";
			}else{
				description.setAttribute("readonly", true);
				profileHidden.src = "description_hidden.jsp?description="+description.value+"&memberId=<%=signedinDto.getMemberId()%>";
				bt.value = "프로필 메세지 수정";
				}
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
			document.getElementById('profile_hidden').src = "del-profile-img.jsp?memberId="+"<%=signedinDto.getMemberId()%>";
		}
	</script>
	</div>
</body>
</html>