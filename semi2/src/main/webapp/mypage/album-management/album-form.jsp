<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
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
<%
Calendar now = Calendar.getInstance();
%>
	<div class=profile-change-card>
	<div class="subtitle">
			<h2>앨범 등록</h2>
		</div>
	<form action="song-form.jsp?first=true" method = "post">
	<img name = "albumCover" onclick = "addAlbumCover();">
	<input style = "display: none;" type = "file" id = "inputAlbumCover" name = "inputAlbumCover">
	<br>
	<div>
	<input type = "text" name = "name" placeholder="앨범제목" class="login-text">
	</div>
	<div>
	<input type = "text" name = "description" placeholder="앨범소개" class="login-text">
	</div>
	<div>
	<input type = "text" name = "memberName" value = "<%=signedinDto.getMemberNickname() %>" class="login-text">
	<input type = "hidden" name = "memberId" value = "<%=signedinDto.getMemberId() %>">
	</div>
	<div class="subtitle">
	<h3>발매예정일</h3>
	</div>
	<div>
	<select id = "year" name = "year" onchange = "releaseMonthChanged();" class="album-select">
<%
for (int i = now.get(Calendar.YEAR); i <= now.get(Calendar.YEAR)+2; i++){
%>
		<option><%=i+"년" %></option>
<%
}
%>
	</select>
	<select id = "month" name = "month" onchange = "releaseDateChanged();" class="album-select">
<%
for (int i = now.get(Calendar.MONTH)+1; i <= 12; i++){
%>
		<option><%=i+"월" %></option>
<%
}
%>
	</select>
	<select id = "date" name = "date" class="album-select">
<%
for (int i = now.get(Calendar.DAY_OF_MONTH); i <= now.getMaximum(Calendar.DAY_OF_MONTH); i++){
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
	<iframe style = "display: none;" src = "album-form_hidden.jsp" id = "releaseDateCal"></iframe>
	<div class="genre-select">
	<select id = "genre1" onchange = "inputGenre1();" class="album-select">
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
	<select id = "genre2" onchange = "inputGenre2();" class="album-select">
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
	<select id = "genre3" onchange = "inputGenre3();" class="album-select">
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
	<input type = "submit" value = "다음" class="bt">
	</div>
	</form>
</div>
<script>
function addAlbumCover() {
	document.getElementById("inputAlbumCover").click();
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
	var days = new Date(year, month+1, 0).getDate();
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
</script>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>