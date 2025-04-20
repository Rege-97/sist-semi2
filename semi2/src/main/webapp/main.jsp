<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.IntStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="rdao" class="com.plick.root.RootDao"></jsp:useBean>
<%! 
static final int MAX_PLAYLISTS_LENGTH = 5;  
static final int MAX_SONGS_LENGTH = 5;  
static final int MAX_MOODS_LENGTH = 5;  
static final String[] moods = {"신나는", "잔잔한", "감성적인", "슬플 때", "달달한", "상쾌한", "몽환적인"};
static Map<Integer, String> moodMap; 
static{
	moodMap = IntStream.rangeClosed(1, moods.length).boxed().collect(Collectors.toMap(i -> i, i -> moods[i-1]));
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@ include file="/header.jsp"%>
		<iframe name="hiddenFrame" style="display: none;"></iframe>
	<!-- 배너 -->
	<section>
		<article>
			<div class="main-banner1">
				<button class="prev-btn">←</button>
				<div class="slide-container">
					<a href="/semi2/membership/main.jsp"> <img src="/semi2/resources/images/design/banner/banner-main1.jpg" alt="Slide 1">
					</a> <a href="#"> <img src="/semi2/resources/images/design/banner/banner-main2.jpg" alt="Slide 2">
					</a> <a href="/semi2/chart/main.jsp"> <img src="/semi2/resources/images/design/banner/banner-main3.jpg" alt="Slide 3">
					</a>
				</div>
				<button class="next-btn">→</button>
				<div class="slide-indicators">
					<span class="indicator active"></span> <span class="indicator"></span> <span class="indicator"></span>
				</div>
			</div>
		</article>
	</section>
	<!-- 첫 번째 메뉴 + 컨텐츠 -->
	<section>
		<article>
		<div class="blank2"></div>
			<div class="categorey-name">
				<label> 최신발매앨범 </label>
			</div>
			<div class="gallery">
				<%
			ArrayList<RecentAlbumDto> recentAlbumArr = new ArrayList<RecentAlbumDto>();
				recentAlbumArr = rdao.showRecentAlbums();
			if(recentAlbumArr==null){
				%>
				불러올 정보가 없습니다.
				<%
			}else{
				
				for (int i=0;i<recentAlbumArr.size();i++){
					%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
						<a href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"> <img src="/semi2/resources/images/album/<%=recentAlbumArr.get(i).getAlbumId()%>/cover.jpg" class="gallery-card-album-image"  onerror="this.src='/semi2/resources/images/playlist/default-cover.jpg';">
						</a>
						<div class="gallery-card-album-image-play">
							<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>'); return false;">
 <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
							</a>
						</div>
					</div>
					<div class="gallery-card-album-name">
						<label><a href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"><%=recentAlbumArr.get(i).getAlbumName() %></a></label>
					</div>
					<div class="gallery-card-artist-name">
						<label><a href="/semi2/artist/main.jsp?memberid=<%=recentAlbumArr.get(i).getMemberId()%>"><%=recentAlbumArr.get(i).getMemberNickname() %></a></label>
					</div>
				</div>
				<%
					
				}
			}
			%>
			</div>
		</article>
		<article>
		<div class="blank"></div>
			<div class="categorey-name">
				<a href="/semi2/chart/main.jsp"><label> 인기음악 </label></a>
			</div>
			
			<table class="song-list">
				<colgroup>
					<col style="width: 40px;">
					<!-- 순위 -->
					<col style="width: 50px;">
					<!-- 앨범 이미지 -->
					<col style="width: 270px;">
					<!-- 곡/앨범 -->
					<col style="width: 120px;">
					<!-- 아티스트 -->
					<col style="width: 40px;">
					<!-- 듣기 -->
					<col style="width: 40px;">
					<!-- 리스트 -->
					<col style="width: 40px;">
					<!-- 다운로드 -->
				</colgroup>
				<thead>
					<tr class="song-list-head">
						<th>순번</th>
						<th colspan="2">곡/앨범</th>
						<th>아티스트</th>
						<th>듣기</th>
						<th>내 리스트</th>
						<th>다운로드</th>
					</tr>
				</thead>
				<tbody>
					<%
					ArrayList<PopularSongDto> arrPopularSong = new ArrayList<PopularSongDto>();
					arrPopularSong = rdao.showPopularSongs();

					if (arrPopularSong == null || arrPopularSong.size() == 0) {
					%>
					<tr>
						<td colspan="6">보여줄 정보가 없습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < Math.min(MAX_SONGS_LENGTH, arrPopularSong.size()); i++) {
					%>
					<tr class="song-list-body">
					<td>
							<div class="song-list-row"><%=i+1 %></div>
						</td>
						
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arrPopularSong.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=arrPopularSong.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=arrPopularSong.get(i).getSongId()%>"><%=arrPopularSong.get(i).getSongName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=arrPopularSong.get(i).getMemberId()%>"><%=arrPopularSong.get(i).getMemberNickname()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=arrPopularSong.get(i).getSongId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openModal('songid',<%=arrPopularSong.get(i).getSongId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
									<a href="/semi2/chart/download-song.jsp?songid=<%=arrPopularSong.get(i).getSongId()%>&songname=<%=arrPopularSong.get(i).getSongName() %>&albumid=<%=arrPopularSong.get(i).getAlbumId()%>&artist=<%=arrPopularSong.get(i).getMemberNickname()%>" target="hiddenFrame">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
					</tr>

					<%
					}

					}
					%>
				</tbody>
			</table>
		</article>
		<article>
		<div class="blank2"></div>
			<div class="categorey-name">
				<label> 인기 플레이리스트 </label>
			</div>
			<div class="gallery">
				<%
				ArrayList<PopularPlaylistDto> arrPopularPlaylist = new ArrayList<PopularPlaylistDto>();
				arrPopularPlaylist = rdao.showPopularPlaylists();
			if(arrPopularPlaylist==null){
				%>
				불러올 정보가 없습니다.
				<%
			}else{
				
				for (int i=0;i<Math.min(MAX_PLAYLISTS_LENGTH, arrPopularPlaylist.size());i++){
					%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
						<a href="/semi2/playlist/details.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>"><img src="/semi2/resources/images/album/<%=arrPopularPlaylist.get(i).getFirstAlbumId() %>/cover.jpg" class="gallery-card-album-image" onerror="this.src='/semi2/resources/images/playlist/default-cover.jpg';">
						</a>
						<div class="gallery-card-album-image-play">
							<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>'); return false;"> 
 <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
							</a>
						</div>
					</div>
					<div class="gallery-card-playlist-name">
						<label><a href="/semi2/playlist/details.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>"><%=arrPopularPlaylist.get(i).getPlaylistName()%></a></label>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</article>
		<article>
			<div class="categorey-name">
				<label> 무드별 플레이리스트 </label>
			</div>
			<div class="gallery">
				<%
				List<Map.Entry<Integer, String>> randomMoods = new ArrayList<>(moodMap.entrySet());
      	  		Collections.shuffle(randomMoods);
       	 	
				for(int i = 0; i < Math.min(MAX_MOODS_LENGTH, randomMoods.size()); i++){
					%>
					<div class="gallery-card-last">
						<a href="/semi2/search/searchMood.jsp?mood=<%=randomMoods.get(i).getValue()%>"><img
							src="/semi2/resources/images/design/mood/mood<%=randomMoods.get(i).getKey()%>.jpg"
							class="gallery-card-album-image" alt="<%=randomMoods.get(i).getValue()%>"></a>
					</div>			
					<%
				}
				%>
			</div>
		</article>
		<article>
			<div class="categorey-name">
				<label> 장르 콜렉션 </label>
			</div>
			<div class="gallery">
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=발라드"><img src="/semi2/resources/images/design/genre/genre1.jpg" class="gallery-card-album-image" alt="발라드"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=알앤비"><img src="/semi2/resources/images/design/genre/genre2.jpg" class="gallery-card-album-image" alt="알앤비"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=힙합"><img src="/semi2/resources/images/design/genre/genre3.jpg" class="gallery-card-album-image" alt="힙합"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=아이돌"><img src="/semi2/resources/images/design/genre/genre4.jpg" class="gallery-card-album-image" alt="아이돌"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=재즈"><img src="/semi2/resources/images/design/genre/genre5.jpg" class="gallery-card-album-image" alt="재즈"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=팝"><img src="/semi2/resources/images/design/genre/genre6.jpg" class="gallery-card-album-image" alt="팝"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=클래식"><img src="/semi2/resources/images/design/genre/genre7.jpg" class="gallery-card-album-image" alt="클래식"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=댄스"><img src="/semi2/resources/images/design/genre/genre8.jpg" class="gallery-card-album-image" alt="댄스"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=인디"><img src="/semi2/resources/images/design/genre/genre9.jpg" class="gallery-card-album-image" alt="인디"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/chart/main.jsp?genre=락"><img src="/semi2/resources/images/design/genre/genre10.jpg" class="gallery-card-album-image" alt="락"></a>
				</div>
			</div>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>

	<script>
window.onload = function() {
    const slideContainer = document.querySelector('.main-banner1 .slide-container');
    const slides = document.querySelectorAll('.main-banner1 .slide-container img');
    const prevBtn = document.querySelector('.main-banner1 .prev-btn');
    const nextBtn = document.querySelector('.main-banner1 .next-btn');
    const indicators = document.querySelectorAll('.indicator');

    let currentSlide = 0;
    const totalSlides = slides.length;
    let slideInterval;

    function showSlide(index) {
        slideContainer.style.transform = 'translateX(-' + (995 * index) + 'px)';
        updateIndicators(index);
    }

    function updateIndicators(index) {
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle('active', i === index);
        });
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
    }

    function startAutoSlide() {
        slideInterval = setInterval(nextSlide, 5000); // 5초 간격
    }

    function resetAutoSlide() {
        clearInterval(slideInterval);
        startAutoSlide();
    }

    prevBtn.onclick = function() {
        currentSlide = (currentSlide === 0) ? totalSlides - 1 : currentSlide - 1;
        showSlide(currentSlide);
        resetAutoSlide(); // 수동조작 시 타이머 재설정
    };

    nextBtn.onclick = function() {
        nextSlide();
        resetAutoSlide(); // 수동조작 시 타이머 재설정
    };

    indicators.forEach((indicator, i) => {
        indicator.onclick = function() {
            currentSlide = i;
            showSlide(currentSlide);
            resetAutoSlide(); // 수동조작 시 타이머 재설정
        };
    });

    showSlide(currentSlide);
    startAutoSlide(); // 자동 슬라이드 시작
};
</script>


</body>
</html>