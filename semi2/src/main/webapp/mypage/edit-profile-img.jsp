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
<style>
#imgEditer {
	position: relative;
	display: inline-block;
}
#imgEditer canvas:first-of-type{
	display: block;
}
#imgEditer canvas:nth-of-type(2) {
	position: absolute;
	left: 0px;
	top: 0px;
	pointer-events: none;
}
</style>
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
<div id = "imgEditer">
	<canvas id = "profileCanvas"></canvas> 
	<canvas id = "profileCanvasEditer"></canvas>
</div>
	<form action = "edit_profile-img_ok.jsp" method = "post">
		<input style = "display: none;" type = "file" id = "editNewProfileImg" name = "editProfileImg" onchange = "changeEditImg();" accept="image/png, image/jpeg">
		<input type = "hidden" id = "img64" name = "img64">
		<input type = "button" value = "이미지 변경하기" onclick = "imgChange();">
		<input type = "submit" value = "저장하기" onclick = "canvasToBase64();">
	</form>
</fieldset>
<iframe id="profile_hidden" name="profile_hidden" style="display: none;"></iframe>
	<%@ include file="/footer.jsp"%>
<script>
//canvas에서 사용자의 조작에 따라 사진의 노출 부위를 변경해줘야 함
// 사용자가 드래그를 시작 했을 때만 컴포넌트 위의 마우스 상대 좌표를 가지고 있어야 함
var canvas = document.getElementById("profileCanvas");
var	ctx = canvas.getContext("2d");
var canvasE = document.getElementById("profileCanvasEditer");
var	ctxE = canvasE.getContext("2d");
var canvasEX = 0;
var canvasEY = 0;
var canvasEXs = 0;
var canvasEYs = 0;
var posX = 0;
var posY = 0;


var rect = canvas.getBoundingClientRect();
var rectE = canvasE.getBoundingClientRect();

var newImg;
var eventPermit = false;
var areaDiv = -1;

//부모 캔버스의 크기 설정
canvasE.width = (canvas.width = 300);
canvasE.height = (canvas.height = 300);

reloadCtxE(0, 0);

// 에디터 캔버스 랜더링
function reloadCtxE(w, h, div){
	var width = (canvasE.width += w);
	var height = (canvasE.height += h);
	
	if (div == 1){
		moveCanvas(-w, -h);
	}else if (div == 2){
		moveCanvas(-w, 0);
	}else if (div == 3){
		moveCanvas(0, -h);
	}
	
	
	const centerX = width / 2;
	const centerY = height / 2;
	const radius = Math.min(width, height) / 2.5;
	
	//1. 전체 회색 배경
	ctxE.fillStyle = "#808080";
	ctxE.fillRect(0, 0, width, height);
	// 2. 원형 투명 영역 만들기
	ctxE.globalCompositeOperation = "destination-out";
	ctxE.beginPath();
	ctxE.arc(centerX, centerY, radius, 0, Math.PI * 2);
	ctxE.fill();
	
	// 3. 그 이후 다시 겹칠 수 있도록 설정 복원
	ctxE.globalCompositeOperation = "source-over";

	// 4. 꼭짓점 점 그리기
	const dotSize = 10;
	const dotRadius = dotSize / 2;

	const offset = dotRadius + 1; // 안쪽으로 들어오게 하기 위한 여백

	ctxE.fillStyle = "#ff0000"; // 마커 색상

	// 좌상단
	ctxE.beginPath();
	ctxE.arc(offset, offset, dotRadius, 0, Math.PI * 2);
	ctxE.fill();

	// 우상단
	ctxE.beginPath();
	ctxE.arc(width - offset, offset, dotRadius, 0, Math.PI * 2);
	ctxE.fill();

	// 좌하단
	ctxE.beginPath();
	ctxE.arc(offset, height - offset, dotRadius, 0, Math.PI * 2);
	ctxE.fill();

	// 우하단
	ctxE.beginPath();
	ctxE.arc(width - offset, height - offset, dotRadius, 0, Math.PI * 2);
	ctxE.fill();
}

// canvas 이동 함수 Css 작성하면서 같이 구현해야 할듯
function moveCanvas(x, y) {
    posX += x;
    posY += y;
    canvasE.style.left = posX+"px";
    canvasE.style.top = posY+"px";
}

	// canvas 에디터 제어 함수
	canvas.addEventListener("mousedown", function(event){
		rectE = canvasE.getBoundingClientRect();
		
		canvasEXs = event.clientX; 
		canvasEYs = event.clientY;
		
        if((canvasEXs <= rectE.left+10 && canvasEYs <= rectE.top+10) && (canvasEXs > rectE.left && canvasEYs > rectE.top)){
        	console.log("Div=1");
			areaDiv = 1;
			eventPermit = true;
		}else if((canvasEXs <= rectE.left+10 && canvasEYs >= rectE.bottom-10) && (canvasEXs > rectE.left && canvasEYs < rectE.bottom)){
			console.log("Div=2");
			areaDiv = 2;
			eventPermit = true;
		}else if((canvasEXs >= rectE.right-10 && canvasEYs <= rectE.top+10) && (canvasEXs < rectE.right && canvasEYs > rectE.top)){
			console.log("Div=3");
			areaDiv = 3;
			eventPermit = true;
		}else if((canvasEXs >= rectE.right-10 && canvasEYs >= rectE.bottom-10) && (canvasEXs < rectE.right && canvasEYs < rectE.bottom)){
			console.log("Div=4");
			areaDiv = 4;
			eventPermit = true;
		}else{
			console.log("Div=5");
			areaDiv = 5;
			eventPermit = true;
		}
		
	})
	canvas.addEventListener("mousemove", function(event){
		canvasE.style.pointerEvents = "auto";
		if(eventPermit){
			
			rect = canvas.getBoundingClientRect();
			rectE = canvasE.getBoundingClientRect();
			
	        // canvasE의 사이즈와 좌표를 canvas 안으로 제한 너무 어려워따..
	        canvasPaddingMinX = (canvasEXs - rectE.left);
	        canvasPaddingMaxX = (canvasEXs - rectE.right);
	        canvasPaddingMinY = (canvasEYs - rectE.top);
	        canvasPaddingMaxY = (canvasEYs - rectE.bottom);
	        
	        // 크기 조절용
	        canvasEX = Math.max(rect.left, Math.min(event.clientX, rect.right));
	        canvasEY = Math.max(rect.top, Math.min(event.clientY, rect.bottom));
	        const deltaX = canvasEXs - canvasEX;
	        const deltaY = canvasEYs - canvasEY;
	        
	        // 이동용
	        canvasEXMove = Math.max(rect.left + canvasPaddingMinX, Math.min(event.clientX, rect.right + canvasPaddingMaxX));
	        canvasEYMove = Math.max(rect.top + canvasPaddingMinY, Math.min(event.clientY, rect.bottom + canvasPaddingMaxY));
	        const deltaXMove = canvasEXs - canvasEXMove;
	        const deltaYMove = canvasEYs - canvasEYMove;
	
	        switch(areaDiv){
	    		case 1: 
	    			reloadCtxE(deltaX, deltaY, areaDiv);
	    			break;
	    		case 2: 
	    			reloadCtxE(deltaX, -deltaY, areaDiv);
	    			break;
	    		case 3:
	    			reloadCtxE(-deltaX, deltaY, areaDiv);
	    			break;
	    		case 4:
	    			reloadCtxE(-deltaX, -deltaY, areaDiv);
	    			break;
	    		case 5:
	    			moveCanvas(-deltaXMove, -deltaYMove);
	    			break;
	    		default:
	    	}    
	        canvasEXs = canvasEX;
			canvasEYs = canvasEY;
		}
		canvasE.style.pointerEvents = "none";
	})
	window.addEventListener("mouseup", function(event){
		eventPermit = false;
	})

	


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
	newImg = document.getElementById('editNewProfileImg').files[0];
	if (newImg){ 
		var reader = new FileReader();
		reader.onload = function(e) {
			var tempImg = new Image();
			tempImg.onload = function() {
				ctx.drawImage(tempImg, 0, 0, canvas.width, canvas.height);
			}
			tempImg.src = e.target.result;
			newImg = tempImg;
		}
		reader.readAsDataURL(newImg);
	}else{
		window.alert("잘못된 이미지를 선택하셨습니다.");
	}
}

function canvasToBase64() {
	// 이미지와 캔버스의 크기가 다르므로 비율이 필요
	const scaleX = newImg.width / canvas.width;
	const scaleY = newImg.height / canvas.height;
	
	// 캔버스를 새로 만들어서 사용하지 않으면 자른 이미지가 기존 이미지 위에 덧붙여지기만 한다
	const tempCanvas = document.createElement("canvas");
	tempCanvas.width = canvasE.width;
	tempCanvas.height = canvasE.height;
	const tempCtx = tempCanvas.getContext("2d");
	
	
	// 이미지 자를 영역과 그릴 영역
	tempCtx.drawImage(newImg, parseInt(canvasE.style.left)*scaleX, parseInt(canvasE.style.top)*scaleY, canvasE.width*scaleX, canvasE.height*scaleY, 
			0, 0, canvasE.width, canvasE.height);
	document.getElementById("img64").value = tempCanvas.toDataURL("image/jpeg");
}
</script>
</body>
</html>