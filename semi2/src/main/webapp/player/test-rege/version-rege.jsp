<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.chart.SongDetailDto"%>
<%@page import="com.plick.chart.TrackDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="sdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
Cookie cks[] = request.getCookies();
String playlist = null;
if (cks != null) {
	for (int i = 0; i < cks.length; i++) {
		if (cks[i].getName().equals("playlist")) {
	playlist = cks[i].getValue();
	break;
		}
	}
}
if (playlist == null) {
	playlist = "";
}

String[] songs = playlist.split("a");

boolean hasSong = false;

String nowplay="";

if(request.getParameter("albumid")!=null){
	int albumid=Integer.parseInt(request.getParameter("albumid"));
	ArrayList<TrackDto> trackArr=sdao.trackList(albumid);
	
	for(int i=trackArr.size()-1;i>0;i--){
		for (int j = 0; j < songs.length; j++) {
			if (songs[j].equals(trackArr.get(i).getId()+"")) {
				hasSong = true;
			}
		}
		
		if (!hasSong) {
			if (playlist.length() == 0) {
				playlist = playlist + trackArr.get(i).getId();
				Cookie ck = new Cookie("playlist", playlist);
				ck.setMaxAge(60 * 60 * 24);
				response.addCookie(ck);
			} else {
				playlist = trackArr.get(i).getId() + "a" + playlist;
				Cookie ck = new Cookie("playlist", playlist);
				ck.setMaxAge(60 * 60 * 24);
				response.addCookie(ck);
			}
		}
	}
	nowplay=trackArr.get(1).getId()+"";
}else if(request.getParameter("songid")!=null){
	nowplay = request.getParameter("songid");
	if (nowplay != null) {
		for (int i = 0; i < songs.length; i++) {
			if (songs[i].equals(nowplay)) {
				hasSong = true;
			}
		}
	}
	if (!hasSong) {
		if (playlist.length() == 0) {
			playlist = playlist + nowplay;
			Cookie ck = new Cookie("playlist", playlist);
			ck.setMaxAge(60 * 60 * 24);
			response.addCookie(ck);
		} else {
			playlist = nowplay + "a" + playlist;
			Cookie ck = new Cookie("playlist", playlist);
			ck.setMaxAge(60 * 60 * 24);
			response.addCookie(ck);
		}
	}
}else if(request.getParameter("albumid")!=null&&request.getParameter("songid")!=null){
	if(songs.length==0){
		%>
	<script>
		window.alert('재생목록이 비어 있습니다.');
		window.location.href = document.referrer+'#comment';
	</script>
	<%
	}else{
	nowplay="0";
	}
}

songs = playlist.split("a");

ArrayList<SongDetailDto> arr = new ArrayList<SongDetailDto>();

int playingIndex = 0;
int maxIndex = songs.length - 1;

for (int i = 0; i < songs.length; i++) {
	SongDetailDto dto2 = sdao.findSong(Integer.parseInt(songs[i]));
	arr.add(dto2);
	if (songs[i].equals(nowplay)) {
		playingIndex = i;
	}
}

System.out.println(Arrays.toString(songs));
%>
</head>
<style>
</style>
<body onload="set1()">
	<div>
		<%
		for (int i = 0; i < arr.size(); i++) {
		%>
		<input type="hidden" value="<%=arr.get(i).getId()%>" class="allsongid">
		<input type="hidden" value="<%=arr.get(i).getAlbumId()%>" class="allalbumid">
		<input type="hidden" value="<%=arr.get(i).getName()%>" class="allsongname">
		<input type="hidden" value="<%=arr.get(i).getArtist()%>" class="allartist">
		<input type="hidden" value="<%=arr.get(i).getAlbumName()%>" class="allalbumname">
		<%
		}
		%>

		<input type="hidden" value="<%=playingIndex%>" id="playingindex">
		<input type="hidden" value="<%=maxIndex%>" id="maxindex">
		<input type="button" value="재생" class="playbt" onclick="play()">
		<input type="button" value="멈춤" class="pausebt" onclick="pause()" style="display: none;">
		<input type="range" id="audiometer" value="0" step="0.1" oninput="moveCurrentTime()">
		<input type="range" id="volume" max="1" step="0.1" onclick="changeVolume()">
		<input type="button" value="⬅️" onclick="resetCurrentTime()">
		<input type="button" value="➡️" onclick="next()">
		
		<input type="button" value="반복안함" class="noloop" onclick="noLoopClick()">
		<input type="button" value="반복" class="allloop" onclick="allLoopClick()" style="display: none;">
		<input type="button" value="한곡반복" class="oneloop" onclick="oneLoopClick()" style="display: none;">
		<input type="button" value="랜덤안함" class="norandom" onclick="noRandomClick()">
		<input type="button" value="랜덤재생" class="random" onclick="randomClick()" style="display: none;">
		<span id="current"></span> / <span id="max"></span>
		<div id="songname">
			제목 :
			<%=arr.get(playingIndex).getName()%></div>
		<div id="artist">
			아티스트 :
			<%=arr.get(playingIndex).getArtist()%></div>
		<div id="albumname">
			앨범명 :
			<%=arr.get(playingIndex).getAlbumName()%></div>
		<table border="1">
			<thead>
				<tr>
					<th>제목</th>
					<th>아티스트</th>
					<th>앨범명</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < arr.size(); i++) {
				%>
				<tr class="songlist">
					<td><div onclick="moveSong(<%=i%>)">
							<%=arr.get(i).getName()%>
						</div></td>
					<td><%=arr.get(i).getArtist()%></td>
					<td><%=arr.get(i).getAlbumName()%></td>
				</tr>
				<%
				}
				%>

			</tbody>

		</table>


	</div>

	<script>
		var audio;
		var audioMeter;
		var current;
		var max;
		var play_bt;
		var pause_bt;
		var volume;
		
		var playingIndex;
		var maxIndex;
		var allSongId;
		var allAlbumId;
		var allSongName;
		var allArtist;
		var allAlbumName;
		var allSongList;
		var songList;
		var allLoop;
		var oneLoop;
		var noLoop;
		var random;
		var count;
		var randomList;
		
		function set1() {
			allSongId=document.querySelectorAll('.allsongid');
			allAlbumId=document.querySelectorAll('.allalbumid');
			allSongName=document.querySelectorAll('.allsongname');
			allArtist=document.querySelectorAll('.allartist');
			allAlbumName=document.querySelectorAll('.allalbumname');
			allSongList=document.querySelectorAll('.songlist');
			
			playingIndex = document.getElementById("playingindex").value;
			maxIndex = document.getElementById("maxindex").value;
			
			allSongList[playingIndex].style.fontWeight = "bold";
			
			audio = new Audio('/semi2/resources/songs/' + allAlbumId[playingIndex].value + '/'
					+ allSongId[playingIndex].value + '.mp3');
			audioMeter = document.getElementById("audiometer");
			current = document.getElementById("current");
			max = document.getElementById("max");
			volume = document.getElementById("volume");
			volume.value = audio.volume;
			play_bt = document.querySelector('.playbt');
			pause_bt = document.querySelector('.pausebt');
			noLoop_bt = document.querySelector('.noloop');
			allLoop_bt = document.querySelector('.allloop');
			oneLoop_bt = document.querySelector('.oneloop');
			random_bt=document.querySelector('.random');
			noRandom_bt=document.querySelector('.norandom');
			
			noLoop=true;
			oneLoop=false;
			allLoop=false;
			
			random=false;
			
			count=0;

			audio.addEventListener('loadedmetadata', function() {
				current.innerHTML = '0 : 00';
				audioMeter.max = audio.duration;
				const max_second = Math.floor(audio.duration % 60);
				if (max_second < 10) {
					var max_second_s = '0' + max_second;
				} else {
					var max_second_s = max_second;
				}
				max.innerHTML = Math.floor(audio.duration / 60) + ' : '
						+ max_second_s;
			});

			audio.addEventListener('ended', function() {
				if(noLoop){
					if(playingIndex==maxIndex){
						window.alert('마지막 곡 입니다.');
					}else{
						next();
					}
				}
				
				if(oneLoop){
					play();
				}
				
				if(allLoop){
				  next();
				}
				});
			
			audio.addEventListener('timeupdate', function() {
				const current_second = Math.floor(audio.currentTime % 60);
				if (current_second < 10) {
					var current_second_s = '0' + current_second;
				} else {
					var current_second_s = current_second;
				}
				current.innerHTML = Math.floor(audio.currentTime / 60) + ' : '
						+ current_second_s;
				audioMeter.value = audio.currentTime;
			});	
		}

		function play() {
			audio.play();
			play_bt.style.display = 'none';
			pause_bt.style.display = 'inline';
			
		}

		function pause() {
			audio.pause();
			pause_bt.style.display = 'none';
			play_bt.style.display = 'inline';
		}

		function moveCurrentTime() {
			audio.currentTime = audioMeter.value;
		}

		function resetCurrentTime() {
			if(audio.currentTime<0.3){
				if(random){
					if(noLoop || oneLoop){
						if(count==0){
							window.alert('첫 곡 입니다.');
						}else{
							count--;
							playingIndex=randomList[count];
							changeSong();
						}
					}else if(allLoop){
						if(count==0){
							count=randomList.length-1;
							playingIndex=randomList[count];
							changeSong();
						}else{
							count--;
							playingIndex=randomList[count];
							changeSong();
						}
					}
				}else{
					if(playingIndex!=0){
						playingIndex--;
						changeSong();
					}else{
						if(allLoop){
							playingIndex=maxIndex;
							changeSong();
						}
					}
				}

			}else{
				audio.currentTime = 0;
			}
			
		}
		
		function changeVolume() {
			audio.volume = volume.value;
		}
		
		function changeSong(){
			pause();
			audio.src='/semi2/resources/songs/' + allAlbumId[playingIndex].value + '/'
			+ allSongId[playingIndex].value + '.mp3';
	document.getElementById("songname").innerHTML='제목 : '+ allSongName[playingIndex].value;
	document.getElementById("artist").innerHTML='아티스트 : '+ allArtist[playingIndex].value;
	document.getElementById("albumname").innerHTML='앨범명 : '+ allAlbumName[playingIndex].value;
	play();
	
		for(var i=0;i<allSongList.length;i++){
			allSongList[i].style.fontWeight = "normal";
		}
		allSongList[playingIndex].style.fontWeight = "bold";
		
		}
		
		function next(){
			if(random){
				if(noLoop || oneLoop){
					if(count==maxIndex){
						window.alert('마지막 곡 입니다.');
					}else{
						playingIndex=randomList[count];
						count++;
						changeSong();
					}
				}else if(allLoop){
					var beforeIndex=playingIndex;
					while(beforeIndex==playingIndex){
						playingIndex=Math.floor(Math.random()*(parseInt(maxIndex)+1));
					}
					changeSong();
				}

			}else{
				if(noLoop){
					if(playingIndex==maxIndex){
						window.alert('마지막 곡 입니다.');
					}else{
						playingIndex++;
						changeSong();
					}
				
				}else if(allLoop){
					if(playingIndex==maxIndex){
						playingIndex=0;
						changeSong();
					}else{
						playingIndex++;
						changeSong();
					}
				}else if(oneLoop){
					playingIndex++;
					changeSong();
				}
				
			}
			
		}
		
		function moveSong(i){
			count=0;
			randomListing();
				playingIndex=i;
				changeSong();
		}
		
		function noLoopClick(){
			noLoop=false;
			oneLoop=false;
			allLoop=true;
			
			allLoop_bt.style.display = 'inline';
			noLoop_bt.style.display = 'none';
			oneLoop_bt.style.display = 'none';
			
			
		}
		
		function allLoopClick(){
			noLoop=false;
			oneLoop=true;
			allLoop=false;
			
			allLoop_bt.style.display = 'none';
			noLoop_bt.style.display = 'none';
			oneLoop_bt.style.display = 'inline';
		}
		
		function oneLoopClick(){
			noLoop=true;
			oneLoop=false;
			allLoop=false;
			
			allLoop_bt.style.display = 'none';
			noLoop_bt.style.display = 'inline';
			oneLoop_bt.style.display = 'none';
		}
		
		function noRandomClick(){
			count=0;
			randomListing();
			random=true;
			noRandom_bt.style.display = 'none';
			random_bt.style.display = 'inline';
		}
		
		function randomClick(){
			random=false;
			noRandom_bt.style.display = 'inline';
			random_bt.style.display = 'none';
		}
		
		function randomListing(){
			 randomList=new Array(parseInt(maxIndex)+1);
			 randomList[0]=playingIndex;
				for(var i=1;i<randomList.length;i++){
					randomList[i]=Math.floor(Math.random()*(parseInt(maxIndex)+1));
					for(var j=0;j<i;j++){
						if(randomList[i]==randomList[j]){
							i--;
							break;
						}
					}
				}
		
		}
		
	</script>
</body>
</html>