<%@page import="com.plick.member.MemberDao"%>
<%@page import="com.plick.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 세션에서 로컬 플리 정보를 받아와서 매핑해야 함
MemberDao memberDao = new MemberDao();
memberDao.addMember10000();
%>
<label>앨범 커버</label>
<label>곡 명</label>
<label>아티스트</label>
<input type = "button" value = "플레이 리스트에 추가">
<input type = "button" value = "셔플ON/OFF">
<input type = "button" value = "이전 곡">
<input type = "button" value = "재생/일시 정지" onclick = "musicPlay(this);">
<input type = "button" value = "다음 곡">
<input type = "button" value = "트랙 반복/한 곡 반복/반복 비활성화" onclick = "addLoop(this);">
<label>재생 바</label>
<input type = "button" value = "음소거">
<input type = "button" value = "가사">
<input type = "button" value = "재생목록">
<label>음량 바</label>
<script>
// 맴버 변수로 사용하는 오디오 인스터스
var audio = new Audio("<%="#" %>");
// 오디오 src의 배열
var audios = [];
// 해당 곡이 끝나면 트랙의 다음 곡 재생
audio.addEventListener("ended", () => {
	for (var i = 0; i < audios.length; i++){
		if (audio.src == audios[i]) audio.src = audios[i+1 >= audios.length ? 0 : i+1];
	}
})

var looptypes = ["트랙 반복", "한 곡 반복", "반복 없음"];

// 재생 버튼 로직
function musicPlay(pb) {
	if (pb.value == "재생") audio.play();
	if (pb.vlaue == "일시정지") audio.pause();
	pb.vlaue == "재생" ? "일시정지" : "재생";
}
// 반복 기능 함수
function addLoop(lb) {
	audios = [];
	// audios에 세션에 저장된 재생 목록을 저장해서 트랙 반복 시킴
	if (lb.value == looptypes[0]) {
		for (var i = 0; i < <%="세션에 저장된 src 컬렉션" %>; i++){
			audios = push("세션에 저장된 src");
		}
	}
	// audios에 한 곡의 정보만 저장해서 한 곡 반복 시킴
	if (lb.value == looptypes[1]);
		audios = push("세션에 저장된 src");
	}
	if (lb.value == looptypes[2])
		for (var i = 0; i < looptypes.length; i++){
			if (lb.value == looptypes[i]) lb.value = looptypes[i+1 >= looptypes.length ? 0 : i+1];
		}
}
</script>
</body>
</html>