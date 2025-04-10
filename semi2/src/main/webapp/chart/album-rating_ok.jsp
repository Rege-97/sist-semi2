<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<%
String memberId_s = request.getParameter("memberid");
String albumId_s = request.getParameter("albumid");
String score_s = request.getParameter("score");

int memberId = Integer.parseInt(memberId_s);
int albumId = Integer.parseInt(albumId_s);
int score = Integer.parseInt(score_s);

if(memberId==0){
	%>
	<script>
	window.alert('로그인 후 이용해주세요.');
	window.parent.location.reload();
	</script>
	<%
	return;
}

int myScore=cdao.getMyRating(memberId, albumId);

if(myScore==0){
	cdao.insertRating(memberId, albumId, score);
	%>
	<script>
	window.parent.location.reload();
	</script>
	<%
}else{
	cdao.updateRating(memberId, albumId, score);
	%>
	<script>
	window.parent.location.reload();
	</script>
	<%
}


%>