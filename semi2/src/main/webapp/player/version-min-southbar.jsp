<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.audioPlayer {
	width: 100%;
	height: 100px;
	background-color: black;
	position: relative;
}
.progressContainer {
	width: 40%;
	height: 7px;
	background-color: gray;
	position: absolute;
	bottom: 30%;
	left: 50%;
	transform: translate(-50%, 0%);
	margin: 0;
}
.progressBar {
	height: 100%;
	background-color: white;
	width: 0%;
}
.controlPanel {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}
.controlButtons {
display: flex;
gap: 50px;
}
.controlButtons img{
width: 30px;
height: 30px;
filter: invert(100%);
}
.effext {
display: flex;
margin-left: auto;
}
.effect img{
width: 40px;
height: 40px;
}
</style>
</head>
<body>
<div id = "audioPlayer" class = "audioPlayer">
	<div id  = "controlPanel" class = "controlPanel">
	<div id = "controlButtons" class = "controlButtons">
		<img src = "/semi2/player/img-min/셔플.png" onclick = "shuffle();">
		<img src = "/semi2/player/img-min/이전곡.png" onclick = "previous();">
		<img src = "/semi2/player/img-min/재생.png" onclick = "play();">
		<img src = "/semi2/player/img-min/다음곡.png" onclick = "next();">
		<img src = "/semi2/player/img-min/트랙반복.png" onclick = "loop();">
		<img src = "/semi2/player/img-min/다음곡.png" onclick = "mute();">
	</div>
	<div id = "effect" class = "effect"> 
		<img src = "/semi2/player/img-min/제리.png">
	</div>
	 </div>
<!--재생 바 -->
	<div id = "progressContainer" class = "progressContainer">
		<div id = "progressBar" class = "progressBar">
		</div>
	</div>
</div>
<script>
const modalWindow = window.open('version-min.jsp', '모달', 'width=500,height=500');
function shuffle(){	
	modalWindow.document.getElementById('shuffle').click();
}
function previous(){	
	modalWindow.document.getElementById('previous').click();
}
function play(){	
	modalWindow.document.getElementById('play').click();
}
function next(){	
	modalWindow.document.getElementById('next').click();
}
function loop(){	
	modalWindow.document.getElementById('loop').click();
}
function mute(){	
	modalWindow.document.getElementById('mute').click();
}
</script>
</body>
</html>