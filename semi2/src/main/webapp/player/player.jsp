<%@page import="java.util.List"%>
<%@page import="com.plick.playlist.PlaylistDao"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.chart.SongDetailDto"%>
<%@page import="com.plick.chart.TrackDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="sdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="signedinDao" class="com.plick.signedin.SignedinDao"></jsp:useBean>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlickPlayer - 플릭 플레이어</title>
<link rel="icon" href="/semi2/resources/images/design/favicon2.png" type="image/png">
<script>
const channel = new BroadcastChannel("player-control");

channel.onmessage = function(event) {
  if (event.data.type === "navigate" && event.data.url) {
    window.location.href = event.data.url;
  }
};
</script>
<%
int mambershipId = signedinDao.hasActiveMembership(signedinDto);
int hasMembership = 0;
if (mambershipId == 0 || mambershipId == 2) {
	hasMembership = 0;
} else {
	hasMembership = 1;
}
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
StringTokenizer st = new StringTokenizer(playlist, "|");
ArrayList<String> songs = new ArrayList<String>();

while (st.hasMoreTokens()) {
	String a = st.nextToken();
	if (!a.equals("")) {
		songs.add(a);
	}
}

boolean hasSong = false;

String nowplay = "";

if (request.getParameter("albumid") != null) {
	int albumid = Integer.parseInt(request.getParameter("albumid"));
	ArrayList<TrackDto> trackArr = sdao.trackList(albumid);
	
	if(trackArr.size()==0){
		%>
		<script>
			window.alert('앨범에 곡이 없습니다.');
			window.location.href = '/semi2/player/player.jsp';
		</script>
		<%
		return;
	}

	for (int i = trackArr.size() - 1; i >= 0; i--) {
		if (playlist.contains("|" + trackArr.get(i).getId() + "|")) {
			System.out.println(123);
	playlist = playlist.replace("|" + trackArr.get(i).getId() + "|", "");
		}

		playlist = "|" + trackArr.get(i).getId() + "|" + playlist;
		
	}
	Cookie ck = new Cookie("playlist", playlist);
	ck.setMaxAge(60 * 60 * 24);
	response.addCookie(ck);
	nowplay = trackArr.get(0).getId() + "";
} else if (request.getParameter("songid") != null) {
	nowplay = request.getParameter("songid");
	if (playlist.contains("|" + nowplay + "|")) {
		playlist = playlist.replace("|" + nowplay + "|", "");
	}

	playlist = "|" + nowplay + "|" + playlist;
	Cookie ck = new Cookie("playlist", playlist);
	ck.setMaxAge(60 * 60 * 24);
	response.addCookie(ck);

} else if (request.getParameter("playlistid") != null) {
	int playlistId = Integer.parseInt(request.getParameter("playlistid"));
	PlaylistDao playlistDao = new PlaylistDao();
	List<Integer> playlistSongIds = playlistDao.findSongIdsByPlaylistId(playlistId);
	if(playlistSongIds.size()==0){
		%>
		<script>
			window.alert('플레이리스트에 곡이 없습니다.');
			window.location.href = '/semi2/player/player.jsp';
		</script>
		<%
		return;
	}

	for (int i = playlistSongIds.size() - 1; i >= 0; i--) {
		if (playlist.contains("|" + playlistSongIds.get(i) + "|")) {
	playlist = playlist.replace("|" + playlistSongIds.get(i) + "|", "");
		}

		playlist = "|" + playlistSongIds.get(i) + "|" + playlist;
		

	}
	Cookie ck = new Cookie("playlist", playlist);
	ck.setMaxAge(60 * 60 * 24);
	response.addCookie(ck);
	nowplay = playlistSongIds.get(0) + "";

} else if(request.getParameter("genre") != null){
	String genre=request.getParameter("genre");
	ArrayList<TrackDto> chartArr = null;
	
	
	if (genre.equals("전체")) {
		genre="전체";
		chartArr = cdao.allChartList();
	} else {
		chartArr = cdao.genreChartList(genre);
	}
	for (int i = chartArr.size() - 1; i >= 0; i--) {
		if (playlist.contains("|" + chartArr.get(i).getId() + "|")) {
	playlist = playlist.replace("|" + chartArr.get(i).getId() + "|", "");
		}

		playlist = "|" + chartArr.get(i).getId() + "|" + playlist;
		
	}
	Cookie ck = new Cookie("playlist", playlist);
	ck.setMaxAge(60 * 60 * 24);
	response.addCookie(ck);
	nowplay = chartArr.get(0).getId() + "";
	
}else if (request.getParameter("albumid") == null && request.getParameter("songid") == null
		&& request.getParameter("playlistid") == null) {
	if (songs.size() == 0) {
%>
<script>

		    window.alert('재생목록이 비어 있어 창을 닫습니다.');
		    window.close();



	</script>
<%
return;
} else {
nowplay = "0";
}
}

st = new StringTokenizer(playlist, "|");
songs = new ArrayList<String>();

while (st.hasMoreTokens()) {
String temp = st.nextToken();
if (!temp.equals("")) {
songs.add(temp);
}
}
ArrayList<SongDetailDto> arr = sdao.playerListing(songs);

int playingIndex = 0;
int maxIndex = songs.size() - 1;
for (int i = 0; i < songs.size(); i++) {
if (songs.get(i).equals(nowplay)) {
playingIndex = i;
}
}
%>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/player.css">
<body onload="set1()">
<iframe name="hiddenFrame" style="display: none;" id="hiddenframe"></iframe>
	<div>
		<%
		if (arr == null || arr.size() == 0) {
			%>
			    <script>
			        alert("곡 목록을 불러올 수 없습니다.");
			        window.close();
			    </script>
			<%
	    	Cookie ck = new Cookie("playlist", "");
			ck.setMaxAge(60 * 60 * 24);
			response.addCookie(ck);
			    return;
			}
		
		for (int i = 0; i < arr.size(); i++) {
		%>
		<input type="hidden" value="<%=arr.get(i).getId()%>" class="allsongid">
		<input type="hidden" value="<%=arr.get(i).getAlbumId()%>" class="allalbumid">
		<input type="hidden" value="<%=arr.get(i).getName()%>" class="allsongname">
		<input type="hidden" value="<%=arr.get(i).getArtist()%>" class="allartist">
		<input type="hidden" value="<%=arr.get(i).getMemberId()%>" class="allmemberid">
		<input type="hidden" value="<%=arr.get(i).getAlbumName()%>" class="allalbumname">
		<input type="hidden" value="<%=arr.get(i).getLyrics()%>" class="alllyrics">
		<%
		}
		%>
		<input type="hidden" value="<%=playingIndex%>" id="playingindex">
		<input type="hidden" value="<%=maxIndex%>" id="maxindex">
		<input type="hidden" value="<%=hasMembership%>" id="hasmembership">
		<div id="modalOverlay" onclick="firstClick();">	</div>
		<div class="blur-container">
			<img src="/semi2/resources/images/album/<%=arr.get(playingIndex).getAlbumId()%>/cover.jpg" class="bg-img" id="back-album-cover" fetchpriority="high">
			<div class="overlay-content" onclick="firstClick();">
				<div class="play-now-info-div">
					<div class="play-now-info-songname" id="info-songname">
						<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(playingIndex).getId()%>" id="songlink" target="_blank"> <%=arr.get(playingIndex).getName()%>
						</a>
					</div>
					<div class="play-now-info-artist" id="info-artist">
						<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(playingIndex).getMemberId()%>" id="artistlink" target="_blank"> <%=arr.get(playingIndex).getArtist()%>
						</a>
					</div>
					<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(playingIndex).getAlbumId()%>" id="albumlink" target="_blank"> <img class="play-now-info-image" id="info-album-cover">
					</a>
					<div>
						<input type="button" value="전체 가사 보기" class="bt" onclick="showLyrics()">
					</div>
					<%
					if (hasMembership == 0) {
					%>
					<div class="nomembership">1분 미리듣기 중 입니다.<br><a href="/semi2/membership/main.jsp">이용권 구매하러 가기</a></div>
					<%
					}
					%>
				</div>
				<div class="play-now-lyrics-div" style="display: none">
					<div class="play-now-info-songname" id="lyrics-songname"><%=arr.get(playingIndex).getName()%></div>
					<div class="play-now-info-artist" id="lyrics-artist"><%=arr.get(playingIndex).getArtist()%></div>
					<div class="play-now-lyrics" id="lyrics"><%=arr.get(playingIndex).getLyrics().replaceAll("\n", "<br>")%></div>
					<div>
						<input type="button" value="전체 가사 접기" class="bt" onclick="showInfo()">
					</div>
					<%
					if (hasMembership == 0) {
					%>
					<div class="nomembership">1분 미리듣기 중 입니다.<br><a href="/semi2/membership/main.jsp">이용권 구매하러 가기</a></div>
					<%
					}
					%>
				</div>

				<div class="song-list-table-div">
					<div class="title">재생목록</div>
					<div class="list-table-div">
						<table class="song-list-table">
							<tbody>
								<%
								for (int i = 0; i < arr.size(); i++) {
								%>
								<tr class="songlist">
									<td><img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg" class="songlist-image" onclick="moveSong(<%=arr.get(i).getId() + ""%>)"></td>
									<td class="sonlist-info" onclick="moveSong(<%=arr.get(i).getId() + ""%>)">
										<div>
											<%=arr.get(i).getName()%>
										</div>
										<div class="sonlist-info-artist">
											<%=arr.get(i).getArtist()%>
										</div>
									</td>
									<td>
										<div class="delete-icon-group" onclick="deleteSong(<%=arr.get(i).getId() + ""%>)">
											<img src="/semi2/resources/images/design/playlist-delete.png" class="delete"> <img src="/semi2/resources/images/design/playlist-delete-hover.png" class="delete-hover">
										</div>
									</td>
								</tr>
								<%
								}
								%>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div id="seekbar-wrapper">
			<div id="seekbar-fill"></div>
		</div>
		<div class="player-card">

			<div class="left-info">
				<img src="/semi2/resources/images/album/<%=arr.get(playingIndex).getAlbumId()%>/cover.jpg" id="album-cover">
				<div class="song-info-text">
					<div id="songname"><%=arr.get(playingIndex).getName()%></div>
					<div id="artist"><%=arr.get(playingIndex).getArtist()%></div>
				</div>
			</div>
			<div class="center-controls">
				<img src="/semi2/resources/images/player/player-no-loop.png" class="noloop" onclick="noLoopClick()"> <img src="/semi2/resources/images/player/player-loop.png" class="allloop" onclick="allLoopClick()" style="display: none;"> <img src="/semi2/resources/images/player/player-one-loop.png" class="oneloop" onclick="oneLoopClick()" style="display: none;"> <img src="/semi2/resources/images/player/player-before.png" onclick="resetCurrentTime()"> <img src="/semi2/resources/images/player/player-play.png" class="playbt" onclick="play()"> <img src="/semi2/resources/images/player/player-pause.png" class="pausebt" onclick="pause()" style="display: none;"> <img src="/semi2/resources/images/player/player-after.png" onclick="next()"> <img src="/semi2/resources/images/player/player-no-shuffle.png" class="norandom" onclick="noRandomClick()"> <img src="/semi2/resources/images/player/player-shuffle.png" class="random" onclick="randomClick()"
					style="display: none;">
				<div class="time-state">
					<span id="current"></span> / <span id="max"></span>
				</div>
			</div>

			<div class="right-controls">
				<img src="/semi2/resources/images/player/player-no-mute.png" class="nomute" onclick="noMute()"> <img src="/semi2/resources/images/player/player-mute.png" class="mute" onclick="mute()" style="display: none;">
				<div id="volume-wrapper">
					<div id="volume-fill"></div>
				</div>
			</div>

		</div>
	</div>

	<div id="confirmModal" >
		<div>플릭 플레이어에 오신 것을 환영합니다!</div>
</div>

	<script>

		let audio;
		let playingIndex;
		let maxIndex;
		let count;
		let randomList = [];
		let playTime = 0;
		let viewPlus=false;
	
		let allSongId;
		let allAlbumId;
		let allSongName;
		let allArtist;
		let allAlbumName;
		let allSongList;
		let allLyrics;
		let allMemberId;
	
		let noLoop;
		let oneLoop;
		let allLoop;
		let random;
	
		let isDragging = false;
		let isVolumeDragging = false;
		
		let volume;
		let hasMembership;
		let hasMembership_end=false;
		
		let firstPlay=false;
	
		const current = document.getElementById("current");
		const max = document.getElementById("max");
		const play_bt = document.querySelector(".playbt");
		const pause_bt = document.querySelector(".pausebt");
	
		const seekbarWrapper = document.getElementById("seekbar-wrapper");
		const seekbarFill = document.getElementById("seekbar-fill");
	
		const volumeWrapper = document.getElementById("volume-wrapper");
		const volumeFill = document.getElementById("volume-fill");
	
		const noLoop_bt = document.querySelector(".noloop");
		const allLoop_bt = document.querySelector(".allloop");
		const oneLoop_bt = document.querySelector(".oneloop");
		const random_bt = document.querySelector(".random");
		const noRandom_bt = document.querySelector(".norandom");
		const noMute_bt = document.querySelector(".nomute");
		const mute_bt = document.querySelector(".mute");
		const playNowInfo = document.querySelector(".play-now-info-div");
		const playNowLyrics = document.querySelector(".play-now-lyrics-div");
		
		const hiddenFrame= document.getElementById("hiddenframe");
		
		// 오디오 이펙트
		// 오디오 이펙트에 사용할 맴버변수들
		var cnt = 0;
		var cnt2 = 0;
		var nomalyamp = 0;
		var animationFrame;
		var audioContext;
		var source;
		var analyser;
		var bufferLength;
		var timeDomainData;
		var frequencyData;
		
		// 오디오 이펙트 제어 변수
		var img = document.getElementById("info-album-cover");
		img.src = "/semi2/resources/images/album/<%=arr.get(playingIndex).getAlbumId()%>/cover.jpg";
		
		// 앨범 이미지 
	    img.onload = function (event) {
	       
	    	const canvas = document.createElement("canvas");
		    const ctx = canvas.getContext("2d");
		    
		    // 캔버스 크기를 이미지 크기와 동일하게 설정
		    canvas.width = img.naturalWidth;
	        canvas.height = img.naturalHeight;
	        ctx.drawImage(img, 0, 0);
	        const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
	        const imgdata = imageData.data;
	        
	        var pxCnt = 0;
	        
	        //투명도까지 4씩 증가
	        for(var i = 0; i < imgdata.length; i+=4 ){
	        	R += imgdata[i];
	        	G += imgdata[i+1];
	        	B += imgdata[i+2];
	        	pxCnt++;
	        }
	        
	        R = Math.round(R/pxCnt);
	        G = Math.round(G/pxCnt);
	        B = Math.round(B/pxCnt);
	    	
	        console.log("R:"+R+"G"+G+"B"+B);
	    }
		
		
		
		//무드 선택 인덱스 - 파기
		var colorsetIdx = 0;
		// 컬러 틱 변환 인덱스 (모든 컬러 배열의 공배수여야함)
		var colorLate = 1;
		// 루프 안에서 컬러 배열의 인덱스
		var colorIdx = 0;
		// 효과 크기의 계수 (1을 기준으로 최대 볼륨을 때 이미지와 같은 크기)
		var effectLate = 0.1;
		// 볼륨 값이 변경되는 프레임 수
		var tic = 1;
		// 색상이 변경되는 프레임 수
		var tic2 = 25;
		// 색상의 변곡점 수
		var colorTic = 20;
		// 색상의 이동 범위
		var colorRange = 50;
		// 평균 색상이 너무 약해서 설정한 채도 보정 계수
		var colorSet = 30;
		
		
		// 분위기 별, 장르별 색상 변환 배열
		function generateSoftColorArray(avg, range, steps) {
			const arr = [];
			for (let i = 0; i < steps; i++) {
			let offset = Math.round(Math.sin(i / steps * Math.PI * 2) * range);
			let val = Math.max(0, Math.min(255, (avg + offset + colorSet)));
			arr.push(val);
			}
			return arr;
		}
		
		// 인덱스 0은 이미지의 평균 색상
		var R = 0;
		var G = 0;
		var B = 0;
		
		
		var colorR1 = generateSoftColorArray(R, colorRange, colorTic);
		var colorG1 = generateSoftColorArray(G, colorRange, colorTic);
		var colorB1 = generateSoftColorArray(B, colorRange, colorTic);
		
		
		
		var RArr = [colorR1];
		var GArr = [colorG1];
		var BArr = [colorB1];
			
		// 데이터 추출 루프
		function draw() {
			var colorR = RArr[colorsetIdx][colorIdx];
			var colorG = GArr[colorsetIdx][colorIdx];
			var colorB = BArr[colorsetIdx][colorIdx];
			animationFrame = requestAnimationFrame(draw);
		
			analyser.getByteTimeDomainData(timeDomainData);  // 진폭
			analyser.getByteFrequencyData(frequencyData);    // 주파수
			cnt2++;
			cnt++;
		  // 데이터의 최대크기는 analyser.fftSize/2
		  var max = analyser.fftSize/2;
		  var amplitudes = Array.prototype.slice.call(timeDomainData, 0, max);
		  var frequencys = Array.prototype.slice.call(frequencyData, 0, max);
		  
		  // 진폭 == -1 ~ 1로 평준화 후 루트 공식으로 음량 데이터로 가공
		  // 주파수 == 한 도메인 안에서 가장 에너지가 높은 주파수 패턴을 가지고 음정으로 가공 (단순히 maxnode 가져가니 음정 오차가 심함)
		  var sum = 0;
		  var high = 0;
		  for (var i = 0; i < max; i++) {
		      var amp = amplitudes[i] / 128 - 1;  
		      sum += amp * amp;
		  }
		  nomalyamp += Math.sqrt(sum / max);
		  
		  // 설정한 틱 당 배경 이미지 크기 변경
		  if(cnt>=tic){
			  // 설정한 틱 당 색상 변경
			 if(cnt2>=tic2){
				if(colorR != RArr[colorsetIdx][colorIdx]){
					colorR = colorR-RArr[colorsetIdx][colorIdx] > 0 ? colorR+colorLate : colorR-colorLate;
				}
				if(colorG != GArr[colorsetIdx][colorIdx]){
					colorG = colorG-GArr[colorsetIdx][colorIdx] > 0 ? colorG+colorLate : colorG-colorLate;
				}
				if(colorB != BArr[colorsetIdx][colorIdx]){
					colorB = colorB-BArr[colorsetIdx][colorIdx] > 0 ? colorB+colorLate : colorB-colorLate;
				}
				if(colorR == RArr[colorsetIdx][colorIdx] && colorG == GArr[colorsetIdx][colorIdx] && colorB == BArr[colorsetIdx][colorIdx]){
					colorIdx = colorIdx >= (colorR1.length-2) ? 0 : (colorIdx+1);
				}
				cnt2 = 0;
			 }
			 	img.style.filter = "drop-shadow(0 0 "+Math.round(nomalyamp*img.width/cnt*effectLate)+"px rgba("+colorR+", "+colorG+", "+colorB+", 0.7))";
		        img.style.boxShadow = "0 0 15px rgba("+colorR+", "+colorG+", "+colorB+", 0.9)";
					
		        console.log(colorR+' '+colorG+' '+colorB);
				cnt = 0;
				
				nomalyamp = 0;
		  }
		
		  
		}
		
		
		
		function set1() {
			allSongId=document.querySelectorAll('.allsongid');
			allAlbumId=document.querySelectorAll('.allalbumid');
			allSongName=document.querySelectorAll('.allsongname');
			allArtist=document.querySelectorAll('.allartist');
			allAlbumName=document.querySelectorAll('.allalbumname');
			allSongList=document.querySelectorAll('.songlist');
			allLyrics=document.querySelectorAll('.alllyrics');
			allMemberId=document.querySelectorAll('.allmemberid');
			
			hasMembership=document.getElementById("hasmembership").value;
			playingIndex = document.getElementById("playingindex").value;
			maxIndex = document.getElementById("maxindex").value;
			allSongList[playingIndex].style.fontWeight = "bold";
			allSongList[playingIndex].style.color = "#ff2dac";
			audio = new Audio('/semi2/resources/songs/' + allAlbumId[playingIndex].value + '/'
					+ allSongId[playingIndex].value + '.mp3');
			audio.preload = "auto";
			
			// 오디오 객체로부터 arrayBuffer로 데이터를 뽑아내서 오디오api로 전달
			audioContext = new (window.AudioContext || window.webkitAudioContext)();
			
			source = audioContext.createMediaElementSource(audio);
			analyser = audioContext.createAnalyser();
			analyser.fftSize = 2048;
			
			// 오디오 연결: source → analyser → destination
			source.connect(analyser);
			analyser.connect(audioContext.destination);
			
			bufferLength = analyser.frequencyBinCount;
			timeDomainData = new Uint8Array(bufferLength);
			frequencyData = new Uint8Array(bufferLength);
						
			volumeFill.style.width = (audio.volume * 100) + "%";

			
			noLoop=true;
			oneLoop=false;
			allLoop=false;
			random=false;
			count=0;

			audio.addEventListener('loadedmetadata', function() {
				current.innerHTML = '0 : 00';
				const max_second = Math.floor(audio.duration % 60);
				if (max_second < 10) {
					var max_second_s = '0' + max_second;
				} else {
					var max_second_s = max_second;
				}
				
				if(hasMembership==0){
					max.innerHTML =  '1 : 00'
				}else{
					max.innerHTML = Math.floor(audio.duration / 60) + ' : '
							+ max_second_s;
				}

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
			
			
			seekbarWrapper.addEventListener('mousedown', startDrag);
			document.addEventListener('mousemove', duringDrag);
			document.addEventListener('mouseup', stopDrag);
			
			volumeWrapper.addEventListener('mousedown', startVolumeDrag);
			document.addEventListener('mousemove', duringVolumeDrag);
			document.addEventListener('mouseup', stopVolumeDrag);
			
			audio.addEventListener('timeupdate', function() {
				if(audio.currentTime<=60){
					hasMembership_end=false;
				}
					let percent=0;
				if(hasMembership==0){
					 percent = (audio.currentTime / 60) * 100;
				}else{
					 percent = (audio.currentTime / audio.duration) * 100;
				}
				  seekbarFill.style.width = percent + "%"; 
				  
				const current_second = Math.floor(audio.currentTime % 60);
				if (current_second < 10) {
					var current_second_s = '0' + current_second;
				} else {
					var current_second_s = current_second;
				}
				current.innerHTML = Math.floor(audio.currentTime / 60) + ' : '
						+ current_second_s;
				if(hasMembership==0){
					if(audio.currentTime>60&&!hasMembership_end){
						hasMembership_end=true;
						next();
					}
				}
				if(!audio.paused){
					playTime=playTime+0.25;
					const countPlayTime=audio.duration / 2;
					
					if(playTime>countPlayTime&&!viewPlus){
						viewPlus=true;
						hiddenFrame.src='/semi2/player/song-view-count.jsp?songid='+allSongId[playingIndex].value;
					}
				}
				
				
			});	
			
			if(hasMembership==0){
				audio.addEventListener('playing', function() {
					if(audio.currentTime>60){
						next();
					}
				});	
			}
			
			showModal();
		}
		
		function seek(e) {
			  const rect = seekbarWrapper.getBoundingClientRect();
			  const percent = (e.clientX - rect.left) / rect.width;
			  const clamped = Math.max(0, Math.min(1, percent));
			  
			  if(hasMembership==0){
				  audio.currentTime = clamped * 60;
			  }else{
				  audio.currentTime = clamped * audio.duration;
			  }
			}

		function startDrag(e) {
			  isDragging = true;
			  seek(e);
			}

			function duringDrag(e) {
			  if (!isDragging) return;
			  seek(e);
			}

			function stopDrag() {
			  isDragging = false;
			}
			
			
			function changeVolumeWithPosition(e) {
				  const rect = volumeWrapper.getBoundingClientRect();
				  let percent = (e.clientX - rect.left) / rect.width;
				  percent = Math.max(0, Math.min(1, percent));
				  audio.volume = percent;
				  volumeFill.style.width = (percent * 100) + "%";
				}

				function startVolumeDrag(e) {
				  isVolumeDragging = true;
				  changeVolumeWithPosition(e);
				}

				function duringVolumeDrag(e) {
				  if (!isVolumeDragging) return;
				  changeVolumeWithPosition(e);
				}

				function stopVolumeDrag() {
				  isVolumeDragging = false;
				}
			
		function play() {
			if (audio.readyState >= 4) { 
				audio.play();
				audioContext.resume();
				draw();
			} else {
				audio.addEventListener('canplaythrough', function onReady() {
					audio.play();
					console.log("오디오 로드 완료됨");
					audioContext.resume();
					draw();
					audio.removeEventListener('canplaythrough', onReady); // 중복 방지
				});
			}
			play_bt.style.display = 'none';
			pause_bt.style.display = 'inline';
			
		}
		
		function firstClick(){
			if(!firstPlay){
				firstPlay=true;
				play();
				confirmNo();
			}
		}

		function pause() {
			audio.pause();
			audioContext.suspend();
			cancelAnimationFrame(animationFrame);
			pause_bt.style.display = 'none';
			play_bt.style.display = 'inline';
		}
		
		function noMute(){
			volume=audio.volume;
			audio.muted = true;
			noMute_bt.style.display='none';
			mute_bt.style.display='inline';
			volumeFill.style.width = (0 * 100) + "%";
		}
		
		
		function mute(){
			audio.muted = false;
			mute_bt.style.display='none';
			noMute_bt.style.display='inline';
			volumeFill.style.width = (volume * 100) + "%";
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
		
		function changeSong(){
			pause();
			hasMembership_end=false;
			audio.src='/semi2/resources/songs/' + allAlbumId[playingIndex].value + '/'
			+ allSongId[playingIndex].value + '.mp3';
			document.getElementById("songname").innerHTML=allSongName[playingIndex].value;
			document.getElementById("songlink").innerText=allSongName[playingIndex].value;
			document.getElementById("lyrics-songname").innerHTML=allSongName[playingIndex].value;
			
			document.getElementById("artist").innerHTML=allArtist[playingIndex].value;
			document.getElementById("artistlink").innerText=allArtist[playingIndex].value;
			document.getElementById("lyrics-artist").innerHTML=allArtist[playingIndex].value;
			
			document.getElementById("album-cover").src='/semi2/resources/images/album/'+allAlbumId[playingIndex].value+'/cover.jpg';
			img.src='/semi2/resources/images/album/'+allAlbumId[playingIndex].value+'/cover.jpg';
			document.getElementById("back-album-cover").src='/semi2/resources/images/album/'+allAlbumId[playingIndex].value+'/cover.jpg';
			

			document.getElementById("lyrics").innerHTML=allLyrics[playingIndex].value.replaceAll("\n", "<br>");
			
			playTime=0;
			viewPlus=false;
			
			document.getElementById("songlink").href='/semi2/chart/song-details.jsp?songid='+allSongId[playingIndex].value;
			document.getElementById("artistlink").href='/semi2/artist/main.jsp?memberid='+allMemberId[playingIndex].value;
			document.getElementById("albumlink").href='/semi2/chart/album-details.jsp?albumid='+allAlbumId[playingIndex].value;
			play();

		    
			
		for(var i=0;i<allSongList.length;i++){
			allSongList[i].style.fontWeight = "normal";
			allSongList[i].style.color = "white";
		}
		allSongList[playingIndex].style.fontWeight = "bold";
		allSongList[playingIndex].style.color = "#ff2dac";
		
		allSongList[playingIndex].scrollIntoView({
			  behavior: "smooth",
			  block: "center"
			});
		}
		
		function next(){
			if(random){
				if(noLoop || oneLoop){
					if(count>maxIndex){
						window.alert('마지막 곡 입니다.');
						pause();
					}else{
						playingIndex=randomList[count];
						count++;
						changeSong();
					}
				}else if(allLoop){
					if(count>maxIndex){
						count=0;
						playingIndex=randomList[count];
					}else{
						playingIndex=randomList[count];
						count++;
					}
					changeSong();
				}

			}else{
				if(noLoop){
					if(playingIndex==maxIndex){
						window.alert('마지막 곡 입니다.');
						pause();
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
		
		function moveSong(id){
			count=0;
			randomListing();
			for(let i=0;i<allSongId.length;i++){
				if(allSongId[i].value==id){
					playingIndex=i;
				}
			}
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
			 
			for(let i=0;i<randomList.length;i++){
				randomList[i]=i;
			}
			
			for(let i=0;i<randomList.length;i++){
				if(i==playingIndex){
					let temp=randomList[0];
					randomList[0]=playingIndex;
					randomList[i]=temp;
					break;
				}
			}
			
			randomList.shift();

			for(let i=randomList.length-1;i>0;i--){
				let j=Math.floor(Math.random() * (i + 1));
				[randomList[i],randomList[j]]=[randomList[j],randomList[i]];
			}
			
			randomList.unshift(playingIndex);
		}
		
		function showInfo(){
			playNowInfo.style.display="inline";
			playNowLyrics.style.display="none";
			
		}
		
		function showLyrics(){
			playNowInfo.style.display="none";
			playNowLyrics.style.display="inline";
		}
		
		function deleteSong(id){
			   cookieName = 'playlist=';
			    let cookieData = document.cookie;
			    let start = cookieData.indexOf(cookieName);
			    let cookieValue = '';
			    if (start != -1) {
			        start += cookieName.length;
			        let end = cookieData.indexOf(';', start);
			        if (end == -1) end = cookieData.length;
			        cookieValue = cookieData.substring(start, end);
			    }
			    
			    let deleteIndex=0;
			    
			    for(let i=0;i<allSongId.length;i++){
					if(allSongId[i].value==id){
						deleteIndex=i;
					}
				}
			    
				if(cookieValue.includes('|'+allSongId[deleteIndex].value+'|')){
					cookieValue=cookieValue.replaceAll('|'+allSongId[deleteIndex].value+'|','');
					document.cookie=cookieName+cookieValue;
					allSongList[deleteIndex].style.display='none';
					
					allSongId[deleteIndex].remove();
					allAlbumId[deleteIndex].remove();
					allSongName[deleteIndex].remove();
					allArtist[deleteIndex].remove();
					allAlbumName[deleteIndex].remove();
					allSongList[deleteIndex].remove();
					allLyrics[deleteIndex].remove();
					allMemberId[deleteIndex].remove();
					
					allSongId=document.querySelectorAll('.allsongid');
					allAlbumId=document.querySelectorAll('.allalbumid');
					allSongName=document.querySelectorAll('.allsongname');
					allArtist=document.querySelectorAll('.allartist');
					allAlbumName=document.querySelectorAll('.allalbumname');
					allSongList=document.querySelectorAll('.songlist');
					allLyrics=document.querySelectorAll('.alllyrics');
					allMemberId=document.querySelectorAll('.allmemberid');
					
					maxIndex=allSongId.length-1;
					
					count=0;
					randomListing();
				}
		}
		function showModal() {
			document.getElementById("modalOverlay").style.display = "block";
			  document.getElementById("confirmModal").classList.add("active");
		}

		function confirmYes() {
			 const overlay = document.getElementById("modalOverlay");
			  if (overlay) overlay.remove(); // DOM에서 아예 제거
			  hideModal();
			firstClick();
		}

		function confirmNo() {
			 const overlay = document.getElementById("modalOverlay");
			 hideModal();
			  if (overlay) overlay.remove(); // DOM에서 아예 제거
		}
		function hideModal() {
			  document.getElementById("confirmModal").classList.remove("active");
			}
	</script>
</body>
</html>