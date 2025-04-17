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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
if (mambershipId == 0) {
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

StringTokenizer st = new StringTokenizer(playlist, "a");
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

	for (int i = trackArr.size() - 1; i >= 0; i--) {
		if (playlist.contains("a" + trackArr.get(i).getId() + "a")) {
	playlist = playlist.replaceAll("a" + trackArr.get(i).getId() + "a", "");
		}

		playlist = "a" + trackArr.get(i).getId() + "a" + playlist;
		Cookie ck = new Cookie("playlist", playlist);
		ck.setMaxAge(60 * 60 * 24);
		response.addCookie(ck);

	}
	nowplay = trackArr.get(0).getId() + "";
} else if (request.getParameter("songid") != null) {
	nowplay = request.getParameter("songid");
	if (playlist.contains("a" + nowplay + "a")) {
		playlist = playlist.replaceAll("a" + nowplay + "a", "");
	}

	playlist = "a" + nowplay + "a" + playlist;
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
		if (playlist.contains("a" + playlistSongIds.get(i) + "a")) {
	playlist = playlist.replaceAll("a" + playlistSongIds.get(i) + "a", "");
		}

		playlist = "a" + playlistSongIds.get(i) + "a" + playlist;
		Cookie ck = new Cookie("playlist", playlist);
		ck.setMaxAge(60 * 60 * 24);
		response.addCookie(ck);

	}
	nowplay = playlistSongIds.get(0) + "";

} else if (request.getParameter("albumid") == null && request.getParameter("songid") == null
		&& request.getParameter("playlistid") == null) {
	if (songs.size() == 0) {
		System.out.println("ddd");
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

st = new StringTokenizer(playlist, "a");
songs = new ArrayList<String>();

while (st.hasMoreTokens()) {
String temp = st.nextToken();
if (!temp.equals("")) {
songs.add(temp);
}
}

ArrayList<SongDetailDto> arr = new ArrayList<SongDetailDto>();

int playingIndex = 0;
int maxIndex = songs.size() - 1;

for (int i = 0; i < songs.size(); i++) {
SongDetailDto dto2 = sdao.findSong(Integer.parseInt(songs.get(i)));
arr.add(dto2);
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
		<div class="blur-container">
			<img src="/semi2/resources/images/album/<%=arr.get(playingIndex).getAlbumId()%>/cover.jpg" class="bg-img" id="back-album-cover">
			<div class="overlay-content">
				<div class="play-now-info-div">
					<div class="play-now-info-songname" id="info-songname">
						<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(playingIndex).getId()%>" id="songlink" target="_blank"> <%=arr.get(playingIndex).getName()%>
						</a>
					</div>
					<div class="play-now-info-artist" id="info-artist">
						<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(playingIndex).getMemberId()%>" id="artistlink" target="_blank"> <%=arr.get(playingIndex).getArtist()%>
						</a>
					</div>
					<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(playingIndex).getAlbumId()%>" id="albumlink" target="_blank"> <img src="/semi2/resources/images/album/<%=arr.get(playingIndex).getAlbumId()%>/cover.jpg" class="play-now-info-image" id="info-album-cover">
					</a>
					<div>
						<input type="button" value="전체 가사 보기" class="bt" onclick="showLyrics()">
					</div>
					<%
					if (hasMembership == 0) {
					%>
					<div class="nomembership">1분 미리듣기 중 입니다.<br>이용권을 구매하시고 전체를 감상해보세요.</div>
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
					<div class="nomembership">1분 미리듣기 중 입니다.<br>이용권을 구매하시고 전체를 감상해보세요.</div>
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
					
					console.log(countPlayTime);
					
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
			} else {
				audio.addEventListener('canplaythrough', function onReady() {
					audio.play();
					console.log("오디오 로드 완료됨");
					audio.removeEventListener('canplaythrough', onReady); // 중복 방지
				});
			}
			play_bt.style.display = 'none';
			pause_bt.style.display = 'inline';
			
		}

		function pause() {
			audio.pause();
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
			document.getElementById("info-album-cover").src='/semi2/resources/images/album/'+allAlbumId[playingIndex].value+'/cover.jpg';
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
			    
				if(cookieValue.includes('a'+allSongId[deleteIndex].value+'a')){
					cookieValue=cookieValue.replaceAll('a'+allSongId[deleteIndex].value+'a','');
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
		
	</script>
</body>
</html>