<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
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


// 쿠키에서 로컬 플리 정보를 받아와서 매핑해야 함

ArrayList<String> songs = new ArrayList<String>();
songs.add("1.mp3");
songs.add("2.mp3");
songs.add("3.mp3");
songs.add("4.mp3");

StringBuilder sb = new StringBuilder();
for (int i = 0; i < songs.size(); i++){
	sb.append(songs.get(i));
	if (i < songs.size()-1) sb.append(",&");
}
String songsUrl = URLEncoder.encode(sb.toString(), "UTF-8");


%>
<label>앨범 커버</label>
<label>곡 명</label>
<label>아티스트</label>
<audio id = "audio" preload="auto"></audio>
<input type = "button" value = "플레이 리스트에 추가">
<input type = "button" value = "셔플ON" onclick = "addShuffle();">
<input type = "button" value = "이전 곡" onclick = "palyPrevious();">
<input type = "button" value = "재생" onclick = "musicPlay(this);">
<input type = "button" value = "다음 곡" onclick = "playNext();">
<input type = "button" value = "트랙 반복/한 곡 반복/반복 비활성화" onclick = "addLoop(this);">
<label>재생 바</label>
<input type = "button" value = "음소거">
<input type = "button" value = "가사">
<input type = "button" value = "재생목록">
<label>음량 바</label>
<label id = "nowSong">현재 곡</label>

<script>
// 플레이어 필수 변수
var audios = [];
var audiosStr = "<%=songsUrl %>";
audios = audiosStr.split("%2C%26");

for (var i = 0; i < audios.length; i++){
	console.log(audios[i]);
}
var playingIdx = 0;



//맴버 변수로 사용하는 오디오 인스터스
var frontPath = "/semi2/player/audios/";
var audio = document.getElementById("audio");
audio.src = frontPath+audios[playingIdx];
console.log("현재 재생 경로: " + audio.src);


audio.addEventListener("canplaythrough", () => {
	console.log('오디오 로드 완료');
})

// 해당 곡이 끝나면 트랙의 다음 곡 재생
audio.addEventListener("ended", () => {
	console.log("현재 곡:"+audio.src);
	console.log("재생 끝?:"+audio.ended);
	console.log("일시정지 중?:"+audio.paused);
	playingIdx = playingIdx == audios.length-1 ? 0 : ++playingIdx;
	audio.src = frontPath+audios[playingIdx];
	audio.play();
})

// 반복 기능 설정
var looptypes = ["트랙 반복", "한 곡 반복", "반복 없음"];

// 재생 버튼 로직
function musicPlay(pb) {
	if (pb.value == "재생"){
		audio.load();
		audio.play();
		console.log(audio.src);
	}
	if (pb.value == "일시정지") audio.pause();
	pb.value = pb.value == "재생" ? "일시정지" : "재생";
}
// 반복 기능 함수
function addLoop(lb) {
	// audios에 쿠키에 저장된 재생 목록을 저장해서 트랙 반복 시킴
	if (lb.value == looptypes[0]) {
		for (var i = 0; i < <%=0 %>; i++){
			audios = push("세션에 저장된 src");
		}
	}
	// audios에 한 곡의 정보만 저장해서 한 곡 반복 시킴
	if (lb.value == looptypes[1]){
		audios = push("세션에 저장된 src");
	}
	if (lb.value == looptypes[2]){
		for (var i = 0; i < looptypes.length; i++){
			if (lb.value == looptypes[i]) lb.value = looptypes[i+1 >= looptypes.length ? 0 : i+1];
		}
	}
}
// 셔플 기능 함수
function addShuffle(sb) {
	tempAudios = [];
	audios = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
	
	if (sb.value == "셔플ON"){
		for (var i = audios.length-1; i >= 0; i--){
			var randomNum = Math.floor(Math.random()*i);
			//난수 생성 후 마지막 인덱스랑 난수 발생 부분을 변경 이후 숫자 중복 바지
			var temp = audios[i];
			audios[i] = audios[randomNum];
			audios[randomNum] = temp;
			tempAudios.push(audios[i]);
		} 
		audios = tempAudios;
		sb.value = "셔플OFF";
	}else{
		
		sb.value = "셔플ON";
	}
}

function playNext() {
	playingIdx = playingIdx == audios.length-1 ? 0 : ++playingIdx;
	audio.src = frontPath+audios[playingIdx];
	audio.play();
}

function palyPrevious() {
	playingIdx = playingIdx == 0 ? 0 : --playingIdx;
	audio.src = frontPath+audios[playingIdx];
	audio.play();
}
</script>
</body>
</html>