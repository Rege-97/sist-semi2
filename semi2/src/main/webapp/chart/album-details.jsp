<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.chart.*"%>
<%@ page import="com.plick.dto.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function answer(commentId) {
		const answerRow = document.getElementById("answer-" + commentId);
		if (answerRow) {
			if (answerRow.style.display == "none" || answerRow.style.display == "") {
				answerRow.style.display = "table-row";
			} else {
				answerRow.style.display = "none";
			}
		}
		
		const answerBt = document.getElementById('answer-bt-'+commentId);

		if (answerBt.value == '답글') {
			answerBt.value = '답글 접기';
		} else {
			answerBt.value = '답글';
		}
	}
</script>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<%
String id_s = request.getParameter("albumid");
if (id_s == null || id_s.equals("")) {
	id_s = "0";
}
int id = Integer.parseInt(id_s);

AlbumDetailDto dto = cdao.findAlbum(id);

String genres[] = {dto.getGenre1(), dto.getGenre2(), dto.getGenre3()};
StringBuffer genre = new StringBuffer();

for (int i = 0; i < 3; i++) {
	if (genres[i] != null) {
		if (!genres[i].equals("")) {
	if (i == 0) {
		genre.append(genres[i]);
	} else {
		genre.append(" | " + genres[i]);
	}
		}
	}
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
String releasedAt = sdf.format(dto.getReleasedAt());

int memberId=signedinDto.getMemberId();

int myScore=cdao.getMyRating(memberId, id);

DecimalFormat df = new DecimalFormat("#.##");
String ratingScore =df.format(dto.getRating());


int totalCnt = cdao.getTotalCnt(id);
int listSize = 10;

int pageSize = 5;

String cp_s = request.getParameter("cp");
if (cp_s == null || cp_s.equals("")) {
	cp_s = "1";
}
int cp = Integer.parseInt(cp_s);

int totalPage = (totalCnt / listSize) + 1;
if (totalCnt % listSize == 0)
	totalPage--;

int userGroup = cp / pageSize;
if (cp % pageSize == 0)
	userGroup--;
%>
	
	<section>
		<article>
		<iframe name="hiddenFrame" style="display: none;"></iframe>
			<div class="detail-card">
				<img src="/semi2/resources/images/album/<%=dto.getId()%>/cover.jpg" class="detail-card-image">
				<div class="detail-card-info">
					<div class="detail-card-info-name">
						<h2><%=dto.getName()%></h2>
					</div>
					<div class="detail-card-info-artist-name">
						<a href="/semi2/artist/main.jsp?memberid=<%=dto.getMemberId()%>"><%=dto.getArtist()%></a>
					</div>
					<div class="detail-card-info-genre"><%=genre%></div>
					<div class="detail-card-info-date">
						<%=releasedAt%>
					</div>
					<div class="detail-card-info-icon">
						<div class="icon-group">
							<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?albumid=<%=dto.getId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
							</a>
						</div>
						<div class="icon-group">
							<a href="#" onclick="openModal('albumid',<%=dto.getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">						
							</a>
						</div>
						<div class="icon-group">
							<a href="/semi2/chart/download-album.jsp?albumid=<%=dto.getId()%>" target="hiddenFrame">
								<img src="/semi2/resources/images/design/download-icon.png" class="icon-dafault">
								<img src="/semi2/resources/images/design/download-icon-hover.png" class="icon-hover">
							</a>
						</div>
					</div>
				</div>
				<div class="rating-card">
				<div class="rating-title">현재 평점</div>
				<div class="now-rating-box">
				<div>
					<img src="/semi2/resources/images/design/star.png">
				</div>
				<div class="now-rating-score"><%=ratingScore %></div>
			</div>
			<div class="rating-title">평가하기</div>
			<form name="update_rating" action="album-rating_ok.jsp" target="hiddenFrame">
				<div class="star-rating">
					<input type="hidden" name="memberid" value="<%=memberId%>">
					<input type="hidden" name="albumid" value="<%=id%>">
					<input type="radio" class="star" name="score" value="1" <%=(myScore==1)?"checked":"" %> onchange="this.form.submit()">
					<input type="radio" class="star" name="score" value="2" <%=(myScore==2)?"checked":"" %> onchange="this.form.submit()">
					<input type="radio" class="star" name="score" value="3" <%=(myScore==3)?"checked":"" %> onchange="this.form.submit()">
					<input type="radio" class="star" name="score" value="4" <%=(myScore==4)?"checked":"" %> onchange="this.form.submit()">
					<input type="radio" class="star" name="score" value="5" <%=(myScore==5)?"checked":"" %> onchange="this.form.submit()">
			</div>
			</form>
			</div>
			
		</article>
		<article>
		<div class="categorey-name">수록곡</div>
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
					ArrayList<TrackDto> arr = cdao.trackList(id);

					if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="6">수록곡이 존재하지 않습니다.</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%>
					<tr class="song-list-body">
						<td>
							<div class="song-list-row"><%=arr.get(i).getRnum()%></div>
						</td>
						<td>
							<div class="song-list-album-image">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><img src="/semi2/resources/images/album/<%=arr.get(i).getAlbumId()%>/cover.jpg" class="song-list-album-image"></a>
							</div>
						</td>
						<td>
							<div class="song-list-song-name">
								<a href="/semi2/chart/song-details.jsp?songid=<%=arr.get(i).getId()%>"><%=arr.get(i).getName()%></a>
							</div>
							<div class="song-list-album-name">
								<a href="/semi2/chart/album-details.jsp?albumid=<%=arr.get(i).getAlbumId()%>"><%=arr.get(i).getAlbumName()%></a>
							</div>
						</td>
						<td>
							<div class="song-list-artist-name">
								<a href="/semi2/artist/main.jsp?memberid=<%=arr.get(i).getMemberId()%>"><%=arr.get(i).getArtist()%></a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openOrReuseTabWithChannel('/semi2/player/player.jsp?songid=<%=arr.get(i).getId()%>'); return false;">
								<img src="/semi2/resources/images/design/play-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/play-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="#" onclick="openModal('songid',<%=arr.get(i).getId()%>); return false;">
								<img src="/semi2/resources/images/design/add-list-icon.png" class="icon-default">
								<img src="/semi2/resources/images/design/add-list-icon-hover.png" class="icon-hover">
								</a>
							</div>
						</td>
						<td>
							<div class="icon-group">
								<a href="/semi2/chart/download-song.jsp?songid=<%=arr.get(i).getId()%>&songname=<%=arr.get(i).getName() %>&albumid=<%=arr.get(i).getAlbumId()%>&artist=<%=arr.get(i).getArtist()%>" target="hiddenFrame">
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
			<table>
				<tr>
					<td><div class="album-description">앨범 소개</div></td>
				</tr>
				<tr>
					<td class="album-released"><%=releasedAt%></td>
				</tr>
				<tr>
					<td><br><%=dto.getDescription().replaceAll("\n", "<br>")%></td>
				</tr>
			</table>
		</article>
		<article>
			<div class="album-comment-count">댓글&#40;<%=totalCnt %>&#41;</div>
			<form name="album-comment" action="album-comment_ok.jsp" id="comment">
				<input type="hidden" name="albumid" value="<%=dto.getId()%>">
				<div class="comment-add">
					<table class="commnet-add-table">
						<tr>
							<td class="comment-add-profile">
								<%
								if(signedinDto==null||signedinDto.getMemberId()==0){
									%>
									<img src="/semi2/resources/images/member/default-profile.jpg" class="comment-add-profile-image">
									<div class="comment-add-profile-nickname">비회원</div>
									<%
								}else{
									%>
									<img src="/semi2/resources/images/member/<%=signedinDto.getMemberId()%>/profile.jpg" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';" class="comment-add-profile-image">
									<div class="comment-add-profile-nickname"><%=signedinDto.getMemberNickname()%></div>
									<%
								}
								%>
							</td>
							<td class="comment-add-content">
								<textarea name="content" rows="3" cols="96" required></textarea>
							</td>
							<td class="comment-bt">
								<input type="submit" value="등록">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div>
			<table class="commnet-table">
				<colgroup>
					<col style="width: 178px;">
					<!-- 순위 -->
					<col style="width: 710px;">
					<!-- 앨범 이미지 -->
					<col style="width: 50px;">
					
				</colgroup>
				<tbody>
					<%
					ArrayList<CommentDto> arr2 = cdao.commentList(cp, listSize,id);
								if (arr2 == null || arr2.size() == 0) {
					%>
					<tr>
						<td colspan="2" align="center">등록된 댓글이 없습니다.
					</tr>
					<%
					} else {
					for (int i = 0; i < arr2.size(); i++) {
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String createAt = sdf2.format(arr2.get(i).getCreatedAt());
					%>
					<tr class="comment-row">
					<%
						
						if (arr2.get(i).getAnswerCheck()!=1) {
						%>
						<td class="comment-profile-answer">
							<img src="/semi2/resources/images/member/<%=arr2.get(i).getMemberId() %>/profile.jpg" class="comment-profile-image" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';">
							<div class="comment-profile-nickname"><%=arr2.get(i).getNickname()%></div>
						</td>
						<%
						}else{
							%>
							<td class="comment-profile">
								<img src="/semi2/resources/images/member/<%=arr2.get(i).getMemberId() %>/profile.jpg" class="comment-profile-image" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';">
								<div class="comment-profile-nickname"><%=arr2.get(i).getNickname()%></div>
							</td>
							<%
						}
						
						
							if (arr2.get(i).getAnswerCheck()==1) {
						%>
						<td>
						<div class="comment-content"><%=arr2.get(i).getContent().replaceAll("\n", "<br>")%></div>
						<div class="comment-content-date"><%=createAt%></div>
						</td>
						<td class="comment-bt">
							<input type="button" id="answer-bt-<%=arr2.get(i).getId()%>" value="답글" onclick="answer(<%=arr2.get(i).getId()%>)">
						</td>
						<%
						}else{
							%>
							<td colspan="2">
							<div class="comment-content-answer"><%=arr2.get(i).getContent().replaceAll("\n", "<br>")%></div>
							<div class="comment-content-answer-date"><%=createAt%></div>
							</td>
							<%
						}
						
						%>

					</tr>
					<tr class="comment-row" id="answer-<%=arr2.get(i).getId()%>" style="display: none">
						<form name="album-comment-answer" action="album-comment-answer_ok.jsp">
							<td class="comment-profile-answer">
								<%
								if(signedinDto==null||signedinDto.getMemberId()==0){
									%>
									<img src="/semi2/resources/images/member/default-profile.jpg" class="comment-add-profile-image" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';">
									<div class="comment-add-profile-nickname">비회원</div>
									<%
								}else{
									%>
									<img src="/semi2/resources/images/member/<%=signedinDto.getMemberId()%>/profile.jpg"  class="comment-add-profile-image"  onerror="this.src='/semi2/resources/images/member/default-profile.jpg';">
									<div class="comment-add-profile-nickname"><%=signedinDto.getMemberNickname()%></div>
									<%
								}
								%>
							</td>
							<td class="comment-add-answer-content">
								<input type="hidden" name="albumid" value="<%=dto.getId()%>">
								<input type="hidden" name="commentid" value="<%=arr2.get(i).getId()%>">
								<input type="hidden" name="parentid" value="<%=arr2.get(i).getParentId()%>">
								<textarea name="content" rows="3" cols="85" required></textarea>
							</td>
							<td class="comment-bt">
								<input type="submit" value="등록">
							</td>
						</form>
					</tr>
					<%
					}
					}
					%>
				</tbody>
				</table>
				<div class="paging">
							<%
							if (userGroup != 0) {
							%>
								<div class="left-page">
							<a href="album-details.jsp?albumid=<%=dto.getId()%>&cp=<%=(userGroup - 1) * pageSize + pageSize%>#comment">&lt;&lt;</a>
							</div>
							<%
							}
							%>
							<%
							for (int i = (userGroup * pageSize + 1); i <= (userGroup * pageSize + pageSize); i++) {
							%>
							<div class="<%=cp==i?"page-number-bold":"page-number" %>">
							 <a href="album-details.jsp?albumid=<%=dto.getId()%>&cp=<%=i%>#comment"><%=i%></a>
							 </div>
							 <%
							 if (i == totalPage) {
							 	break;
							 }
							 }
							 %>
							<%
							if (((totalPage / pageSize) - (totalPage % pageSize == 0 ? 1 : 0)) != userGroup) {
							%>
							<div class="right-page">
							<a href="album-details.jsp?albumid=<%=dto.getId()%>&cp=<%=(userGroup + 1) * pageSize + 1%>#comment">&gt;&gt;</a>
							</div>
							<%
							}
							%>
	</div>
			
</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>