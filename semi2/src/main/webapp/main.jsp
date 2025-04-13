<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="rdao" class="com.plick.root.RootDao"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@ include file="/header.jsp"%>
	<!-- 배너 -->
	<section>
		<article>
			<div class="main-banner1">
				<button class="prev-btn">←</button>
				<div class="slide-container">
					<a href="/semi2/membership/main.jsp"> <img src="/semi2/resources/images/design/banner/banner-main1.jpg" alt="Slide 1">
					</a> <a href="#"> <img src="/semi2/resources/images/design/banner/banner-main1.jpg" alt="Slide 2">
					</a> <a href="#"> <img src="/semi2/resources/images/design/banner/banner-main1.jpg" alt="Slide 3">
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
						<a href="/semi2/chart/album-details.jsp?albumid=<%=recentAlbumArr.get(i).getAlbumId()%>"> <img src="/semi2/resources/images/album/<%=recentAlbumArr.get(i).getAlbumId()%>/cover.jpg" class="gallery-card-album-image">
						</a>
						<div class="gallery-card-album-image-play">
							<a href="#"> <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
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
			<div class="categorey-name">
				<label> 인기음악 </label>
			</div>
			<div class="gallery">
				<%
				ArrayList<PopularSongDto> arrPopularSong = new ArrayList<PopularSongDto>();
				arrPopularSong = rdao.showPopularSongs();
			if(arrPopularSong==null){
				%>
				불러올 정보가 없습니다.
				<%
			}else{
				for (int i=0;i<arrPopularSong.size();i++){
				%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
						<a href="/semi2/chart/album-details.jsp?albumid=<%=arrPopularSong.get(i).getAlbumId()%>"> <img src="/semi2/resources/images/album/<%=arrPopularSong.get(i).getAlbumId()%>/cover.jpg" class="gallery-card-album-image">
						</a>
						<div class="gallery-card-album-image-play">
							<a href="/semi2/player/version-nam.jsp?songId=<%=arrPopularSong.get(i).getSongId()%>"> <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
							</a>
						</div>
					</div>
					<div class="gallery-card-album-name">
						<label><a href="/semi2/chart/song-details.jsp?songid=<%=arrPopularSong.get(i).getSongId()%>"><%=arrPopularSong.get(i).getSongName() %></a></label>
					</div>
					<div class="gallery-card-artist-name">
						<label><a href="/semi2/artist/main.jsp?memberid=<%=arrPopularSong.get(i).getMemberId() %>"><%=arrPopularSong.get(i).getMemberNickname() %></a></label>
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
				
				for (int i=0;i<arrPopularPlaylist.size();i++){
					%>
				<div class="gallery-card">
					<div class="gallery-card-album-image-group">
						<a href="/semi2/playlist/details.jsp?playlistid=<%=arrPopularPlaylist.get(i).getPlaylistId()%>"> <!-- <img src="/semi2/resources/images/playlist/<%=arrPopularPlaylist.get(i).getPlaylistId()%>/cover.jpg" class="gallery-card-album-image"> --> <img src="/semi2/resources/images/album/1/cover.jpg" class="gallery-card-album-image">
						</a>
						<div class="gallery-card-album-image-play">
							<a href="#"> <img src="/semi2/resources/images/design/album-play.png" class="play-default"> <img src="/semi2/resources/images/design/album-play-hover.png" class="play-hover">
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
				<div class="gallery-card">
					<a href="/semi2/search/searchMood.jsp?mood=신나는"><img src="/semi2/resources/images/design/mood/mood1.jpg" class="gallery-card-album-image" alt="신나는"></a>
				</div>
				<div class="gallery-card">
					<a href="/semi2/search/searchMood.jsp?mood=잔잔한"><img src="/semi2/resources/images/design/mood/mood2.jpg" class="gallery-card-album-image" alt="잔잔한"></a>
				</div>
				<div class="gallery-card">
					<a href="/semi2/search/searchMood.jsp?mood=슬플때"><img src="/semi2/resources/images/design/mood/mood4.jpg" class="gallery-card-album-image" alt="슬플 때"></a>
				</div>
				<div class="gallery-card">
					<a href="/semi2/search/searchMood.jsp?mood=달달한"><img src="/semi2/resources/images/design/mood/mood5.jpg" class="gallery-card-album-image" alt="달달한"></a>
				</div>
				<div class="gallery-card-last">
					<a href="/semi2/search/searchMood.jsp?mood=몽환적인"><img src="/semi2/resources/images/design/mood/mood7.jpg" class="gallery-card-album-image" alt="몽환적인"></a>
				</div>
			</div>
		</article>
		<article>
			<div class="categorey-name">
				<label> 장르 콜렉션 </label>
			</div>
			<div class="gallery">
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre1.jpg" class="gallery-card-album-image" alt="발라드"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre2.jpg" class="gallery-card-album-image" alt="알앤비"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre3.jpg" class="gallery-card-album-image" alt="힙합"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre4.jpg" class="gallery-card-album-image" alt="아이돌"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre5.jpg" class="gallery-card-album-image" alt="재즈"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre6.jpg" class="gallery-card-album-image" alt="팝"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre7.jpg" class="gallery-card-album-image" alt="클래식"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre8.jpg" class="gallery-card-album-image" alt="댄스"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre9.jpg" class="gallery-card-album-image" alt="인디"></a>
				</div>
				<div class="gallery-card-last">
					<a href="#"><img src="/semi2/resources/images/design/genre/genre10.jpg" class="gallery-card-album-image" alt="락"></a>
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