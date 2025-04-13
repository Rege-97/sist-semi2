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
<input type = "button" value = "셔플ON" onclick = "addShuffle(this);">
<input type = "button" value = "이전 곡" onclick = "palyPrevious();">
<input type = "button" id = "play" value = "재생" onclick = "musicPlay();">
<input type = "button" value = "다음 곡" onclick = "playNext();">
<input type = "button" id = "loop" value = "반복 없음" onclick = "addLoop();">
<label>재생 바</label>
<input type = "button" value = "음소거" onclick = "mute(this);">
<input type = "button" value = "가사">
<input type = "button" value = "재생목록">
<label>음량 바</label>
<label id = "nowSong">현재 곡</label>

<script>
// 플레이어 필수 변수
var audios = [];
var audiosStr = "<%=songsUrl %>";
audios = audiosStr.split("%2C%26");
var playingIdx = 0;
var playButton = document.getElementById("play");
var loopButton = document.getElementById("loop");



//맴버 변수로 사용하는 오디오 인스터스
var frontPath = "/semi2/player/audios/";
var audio = document.getElementById("audio");
audio.src = frontPath+audios[playingIdx];
var volume = audio.volume;

//반복 기능 설정
var looptypes = ["트랙 반복", "한 곡 반복", "반복 없음"];

audio.addEventListener("canplaythrough", () => {
	console.log('오디오 로드 완료');
})

audio.addEventListener("ended", () => {
	if(loopButton.value == looptypes[0]){
		playingIdx = playingIdx == audios.length-1 ? 0 : ++playingIdx;
		audio.src = frontPath+audios[playingIdx];
		audio.play();
	}else if(loopButton.value == looptypes[1]){
		audio.play();
	}else if(loopButton.value == looptypes[2]){
		playButton.value = "재생";
	}
	
})

function mute(muteButton) {
	if (muteButton.value == "음소거"){
		audio.volume = 0.0;
		muteButton.value = volume*10;
	}else{
		audio.volume = volume;
		muteButton.value = "음소거";
	}
}

// 재생 버튼 로직
function musicPlay() {
	if (playButton.value == "재생"){
		audio.load();
		audio.play();
		console.log(audio.src);
	}
	if (playButton.value == "일시정지") audio.pause();
	playButton.value = playButton.value == "재생" ? "일시정지" : "재생";
}
// 반복 기능 함수
function addLoop() {
	for (var i = 0; i < looptypes.length; i++){
		if (loopButton.value == looptypes[i]) {
			loopButton.value = looptypes[i+1 >= looptypes.length ? 0 : i+1];
			break;
		}
	}
}

// 셔플 기능 함수
function addShuffle(sb) {
	tempAudios = [];
	
	if (sb.value == "셔플OFF"){
		for (var i = audios.length-1; i >= 0; i--){
			var randomNum = Math.floor(Math.random()*i);
			//난수 생성 후 마지막 인덱스랑 난수 발생 부분을 변경 이후 숫자 중복 방지
			var temp = audios[i];
			audios[i] = audios[randomNum];
			audios[randomNum] = temp;
			tempAudios.push(audios[i]);
		} 
		audios = tempAudios;
		sb.value = "셔플ON";
	}else{
		sb.value = "셔플OFF";
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