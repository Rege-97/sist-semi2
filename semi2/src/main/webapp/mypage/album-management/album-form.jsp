<%@page import="com.plick.mypage.AlbumDto"%>
<%@page import="com.plick.album.AlbumDao"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
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
	width: 300px;
	height: 300px;
	resize: none;
	border: 1px solid #666666;
	border-radius: 8px;
}
textarea::-webkit-scrollbar {
    display: none; /* 스크롤바 숨기기 */
}
</style>
<body>
	<%@ include file="/header.jsp"%>
	<div class="body-content">
	<%@ include file="/mypage/mypage-header.jsp"%>
<%
if(request.getParameter("albumId")==null){
%>
	<div class=profile-change-card>
	<div class="subtitle">
			<h2>앨범 등록</h2>
		</div>
	<form action="album-form_ok.jsp" method = "post" enctype="multipart/form-data"> 
	<div class="blank"></div>
	<img name = "albumCover"  id = "albumCover" src = "/semi2/resources/images/album/add-cover.jpg" onclick = "addAlbumCover();" class="detail-card-image">
	<input style = "display: none;" type = "file" required id = "inputAlbumCover" name = "inputAlbumCover" onchange="changeImg();">
	<div class="blank"></div>
	<label>jpg 이미지만 등록이 가능합니다</label>
	<div>
	<input type = "text" name = "name" id = "name" placeholder="앨범제목" required class="login-text">
	</div>
	<div>
	<input type = "text" name = "memberName" value = "<%=signedinDto.getMemberNickname() %>" class="login-text">
	<input type = "hidden" name = "memberId" value = "<%=signedinDto.getMemberId() %>">
	</div>
	<div>
	<textarea  style = "resize: none;" name = "description" rows = "10" cols = "70" maxlength = "4000" placeholder="앨범소개" required class="login-text"></textarea>
	</div>
	<div class="subtitle">
	<h3>발매일</h3>
	</div>
	<div>
	<select id = "year" name = "year" onchange = "releaseMonthChanged();" class="album-select">
<%
for (int i = now.get(Calendar.YEAR)+2; i >= now.get(Calendar.YEAR)-20; i--){
	if (i == now.get(Calendar.YEAR)){
		%>
		<option selected="selected"><%=i+"년" %></option>
		<%
		continue;	
	}
%>
		<option><%=i+"년" %></option>
<%
}
%>
	</select>
	<select id = "month" name = "month" onchange = "releaseDateChanged();" class="album-select">
<%
for (int i = 1; i <= 12; i++){
	if (i == now.get(Calendar.MONTH)+1){
		%>
		<option selected="selected"><%=i+"월" %></option>
		<%
		continue;	
	}
%>
		<option><%=i+"월" %></option>
<%
}
%>
	</select>
	<select id = "date" name = "date" class="album-select">
<%
for (int i = 1; i <= now.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
	if (i == now.get(Calendar.DAY_OF_MONTH)){
		%>
		<option selected="selected"><%=i+"일" %></option>
		<%
		continue;	
	}
%>
		<option><%=i+"일" %></option>
<%
}
%>
	</select>
	</div>
		<div class="subtitle">
	<h3>장르 선택</h3>
	</div>
	<div class="genre-select">
	<select id = "genre1" name = "genre1" onchange = "inputGenre1();" required class="album-select">
	<option disabled selected value = "">장르선택</option>
	<option value = "발라드">발라드</option>
	<option value = "알앤비">알앤비</option>
	<option value = "힙합">힙합</option>
	<option value = "아이돌">아이돌</option>
	<option value = "재즈">재즈</option>
	<option value = "팝">팝</option>
	<option value = "클래식">클래식</option>
	<option value = "댄스">댄스</option>
	<option value = "인디">인디</option>
	<option value = "락">락</option>
	</select>
	<select id = "genre2" name = "genre2" onchange = "inputGenre2();" class="album-select">
	<option disabled selected>장르선택</option>
	<option>발라드</option>
	<option>알앤비</option>
	<option>힙합</option>
	<option>아이돌</option>
	<option>재즈</option>
	<option>팝</option>
	<option>클래식</option>
	<option>댄스</option>
	<option>인디</option>
	<option>락</option>
	</select>
	<select id = "genre3" name = "genre3" onchange = "inputGenre3();" class="album-select">
	<option disabled selected>장르선택</option>
	<option>발라드</option>
	<option>알앤비</option>
	<option>힙합</option>
	<option>아이돌</option>
	<option>재즈</option>
	<option>팝</option>
	<option>클래식</option>
	<option>댄스</option>
	<option>인디</option>
	<option>락</option>
	</select>
	</div>
	<div>
	<input type = "submit" value = "앨범 등록" class="bt">
	</div>
	</form>
</div>
<%
}else{// 수정 요청 들어오면 앨범 정보 로드 후 표시
	MypageDao mDao = new MypageDao();
AlbumDto aDto = mDao.findInfoAlbums(Integer.parseInt(request.getParameter("albumId")));
%>
	<div class=profile-change-card>
	<div class="subtitle">
			<h2>앨범 등록</h2>
		</div>
	<form action="album-form_ok.jsp?albumId=<%=request.getParameter("albumId") %>" method = "post" enctype="multipart/form-data"> 
	<img name = "albumCover"  id = "albumCover" src = "/semi2/resources/images/album/<%=aDto.getId() %>/cover.jpg" onclick = "addAlbumCover();" class="detail-card-image">
	<input style = "display: none;" type = "file" id = "inputAlbumCover" name = "inputAlbumCover" onchange="changeImg();">
	<div class="blank"></div>
	<div>
	<input type = "text" name = "name" id = "name" value = "<%=aDto.getName() %>" class="login-text">
	</div>
	<div>
	<input type = "text" name = "memberName" value = "<%=signedinDto.getMemberNickname() %>" class="login-text">
	<input type = "hidden" name = "memberId" value = "<%=signedinDto.getMemberId() %>">
	</div>
	<div>
		<div class="blank3"></div>
	<textarea  style = "resize: none;" name = "description" id = "description" rows = "10" cols = "70" maxlength = "4000" class="login-text"><%=aDto.getDiscription() %></textarea>
	</div>
		<div class="blank"></div>
	<div class="subtitle">
	<h3>발매일</h3>
	</div>
	<div>
	<select id = "year" name = "year" onchange = "releaseMonthChanged();" class="album-select">
<%
Calendar time = Calendar.getInstance();
time.setTimeInMillis(aDto.getReleased_at().getTime());
for (int i = time.get(Calendar.YEAR)+2; i >= time.get(Calendar.YEAR)-20; i--){
	if (i == time.get(Calendar.YEAR)){
		%>
		<option selected="selected"><%=i+"년" %></option>
		<%
		continue;	
	}
%>
		<option><%=i+"년" %></option>
<%
}
%>
	</select>
	<select id = "month" name = "month" onchange = "releaseDateChanged();" class="album-select">
<%
for (int i = 1; i <= 12; i++){
	if (i == time.get(Calendar.MONTH)+1){
		%>
		<option selected="selected"><%=i+"월" %></option>
		<%
		continue;	
	}
%>
		<option><%=i+"월" %></option>
<%
}
%>
	</select>
	<select id = "date" name = "date" class="album-select">
<%
for (int i = 1; i <= time.getActualMaximum(Calendar.DAY_OF_MONTH); i++){
	if (i == time.get(Calendar.DAY_OF_MONTH)){
		%>
		<option selected="selected"><%=i+"일" %></option>
		<%
		continue;	
	}
		%>
		<option><%=i+"일" %></option>
<%
}
%>
	</select>
	</div>
		<div class="subtitle">
	<h3>장르 선택</h3>
	</div>
	<div class="genre-select">
	<select id = "genre1" name = "genre1" onchange = "inputGenre1();" class="album-select">
	<option disabled selected>장르선택(필수)</option>
	<option>발라드</option>
	<option>알앤비</option>
	<option>힙합</option>
	<option>아이돌</option>
	<option>재즈</option>
	<option>팝</option>
	<option>클래식</option>
	<option>댄스</option>
	<option>인디</option>
	<option>락</option>
	</select>
	<select id = "genre2" name = "genre2" onchange = "inputGenre2();" class="album-select">
	<option disabled selected>장르선택</option>
	<option>발라드</option>
	<option>알앤비</option>
	<option>힙합</option>
	<option>아이돌</option>
	<option>재즈</option>
	<option>팝</option>
	<option>클래식</option>
	<option>댄스</option>
	<option>인디</option>
	<option>락</option>
	</select>
	<select id = "genre3" name = "genre3" onchange = "inputGenre3();" class="album-select">
	<option disabled selected>장르선택</option>
	<option>발라드</option>
	<option>알앤비</option>
	<option>힙합</option>
	<option>아이돌</option>
	<option>재즈</option>
	<option>팝</option>
	<option>클래식</option>
	<option>댄스</option>
	<option>인디</option>
	<option>락</option>
	</select>
	</div>
	<div>
	<input type = "submit" value = "앨범 수정" class="bt">
	</div>
	</form>
</div>
<%
}
%>
<script>
 var inputAlbumCover = document.getElementById("inputAlbumCover");
// 숨겨진 파일 인풋 컴포넌트를 매핑
function addAlbumCover() {
	inputAlbumCover.click();
}

// 날짜 선택 박스 제어 함수
// default: 현재 날짜
// 미래 날짜 선택하면 월, 일 자동 세팅
function releaseMonthChanged() {
	var month = document.getElementById("month");
	month.innerHTML = "";
	for(let i = 1; i <= 12; i++){
		const newoption = document.createElement("option");
		newoption.value = (i+"월");
		newoption.text = (i+"월");
		month.appendChild(newoption);
	}
	releaseDateChanged();
}
function releaseDateChanged() {
	var date = document.getElementById("date");
	date.innerHTML = "";
	var year = document.getElementById("year").value.slice(0, -1);
	var month = document.getElementById("month").value.slice(0, -1);
	var days = new Date(year, month, 0).getDate();
	for(let i = 1; i <= days; i++){
		const newoption = document.createElement("option");
		newoption.value = (i+"일");
		newoption.text = (i+"일");
		date.appendChild(newoption);
	}
}
// 장르 선택시 select 태그의 name 속성값을 변경 후 서밋
function inputGenre1() {
	var genre = document.getElementById("genre1");
	genre.name = "genre"+(genre.selectedIndex+1);
}
function inputGenre2() {
	var genre = document.getElementById("genre2");
	genre.name = "genre"+(genre.selectedIndex+1);
}
function inputGenre3() {
	var genre = document.getElementById("genre3");
	genre.name = "genre"+(genre.selectedIndex+1);
}
// 앨범 이미지 변경시 이미지 보여주기
function changeImg() {
	newImg = inputAlbumCover.files[0];
	if (newImg.name.slice(-4).toLowerCase() == ".jpg"){ 
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById("albumCover").src = e.target.result;
		}
		reader.readAsDataURL(newImg);
	}else{
		window.alert("잘못된 이미지를 선택하셨습니다.");
		inputAlbumCover.files[0].value = "";
	}
}

</script>
	<jsp:include page="/footer.jsp"></jsp:include>
	</div>
</body>
</html>