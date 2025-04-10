<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 사진 변경</title>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
</head>
<body onload = "loadCanvas();">
	<%@ include file="/header.jsp"%>
<%
	MypageDao mdao = new MypageDao();
	File oldProfile = new File(request.getRealPath("resources/images/member/"+signedinDto.getMemberId()+"/profile.jpg"));
	String imgSrc = oldProfile.exists() ? 
		oldProfile.getPath() : request.getRealPath("resources/images/member/default-profile.jpg");
	String fileB64 = mdao.fileExportBase64(imgSrc);
%>
	<%
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
	<canvas id = "profileCanvas" onclick = "imgChange();"></canvas> 
	<form action = "edit_profile-img_ok.jsp" method = "post">
		<input style = "display: none;" type = "file" id = "editNewProfileImg" name = "editProfileImg" onchange = "changeEditImg();" accept="image/png, image/jpeg">
		<input type = "button" value = "이미지 변경하기" onclick = "imgChange();">
		<input type = "submit" value = "저장하기">
	</form>
</fieldset>
<iframe id="profile_hidden" name="profile_hidden" style="display: none;"></iframe>
	<%@ include file="/footer.jsp"%>
<script>
//해당 부분에서 처리해야 하는 일
//1. 사용자에게 받은 이미지 파일을 base64로 변환 <--
//2. base64인 문자열을 인코딩 하여 canvas에 그려줘야 함
//3. canvas에서 사용자의 조작에 따라 사진의 노출 부위를 변경해줘야 함
//4. canvas에서 자른 이미지를 파일 형태로 저장 해야 함

var canvas = document.getElementById("profileCanvas");
var	ctx = canvas.getContext("2d");
// canvas 시작 이미지 설정
function loadCanvas() {
	var oldImg = new Image();
	oldImg.onload = function(){
		ctx.drawImage(oldImg, 0, 0, canvas.width, canvas.height);
	}
	oldImg.src = "<%=fileB64 %>";
}

// 숨겨진 파일 태그 대신 선택
function imgChange() {
	document.getElementById('editNewProfileImg').click();
}

//사용자가 선택한 이미지를 Filereader()로 읽어와 canvas에 다시 그려줌 
function changeEditImg() {
	var newImg = document.getElementById('editNewProfileImg').files[0];
	if (newImg){ 
		var reader = new FileReader();
		reader.onload = function(e) {
			var tempImg = new Image();
			tempImg.onload = function() {
				ctx.drawImage(tempImg, 0, 0, canvas.width, canvas.height);
			}
			tempImg.src = e.target.result;
		}
		reader.readAsDataURL(newImg);
	}else{
		window.alert("잘못된 이미지를 선택하셨습니다.");
	}
}
</script>
</body>
</html>