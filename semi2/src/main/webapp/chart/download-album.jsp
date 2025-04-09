<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
    <%@ page import="com.plick.chart.*"%>
    <jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
 <jsp:useBean id="signedinDao" class="com.plick.signedin.SignedinDao"></jsp:useBean>
 <jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
if (signedinDto==null||signedinDto.getMemberId()==0) {
%>
<script>
	window.alert('로그인 후 이용해주세요.');
	window.parent.location.href="/semi2/member/signin.jsp";
</script>
<%
return;
}

int mambershipId= signedinDao.hasActiveMembership(signedinDto);

if(mambershipId==0){
	%>
	<script>
		window.alert('이용권이 없습니다. 이용권을 구매해주세요.');
		window.parent.location.href="/semi2/membership/main.jsp";
	</script>
	<%
	return;
}
if(mambershipId<2){
	%>
	<script>
		window.alert('보유하신 이용권은 다운로드를 사용할 수 없습니다.');
		window.parent.location.href="/semi2/membership/main.jsp";
	</script>
	<%
	return;
}

String albumId_s=request.getParameter("albumid");

if(albumId_s==null){
	%>
	<script>
		window.alert('잘못된 접근입니다.');
		window.parent.location.reload();
	</script>
	<%
	return;
}

int albumId=Integer.parseInt(albumId_s);

%>
<script>
function downloadSong() {
    var download = document.querySelectorAll("a");

    for (var i = 0; i < download.length; i++) {
        delayedClick(download, i);
    }
}

function delayedClick(list, index) {
    setTimeout(function() {
        list[index].click();
    }, index * 200); // 0.2초 간격
}
</script>
</head>
<body onload="downloadSong()">
<%
ArrayList<TrackDto> arr = cdao.trackList(albumId);

for(int i=0;i<arr.size();i++){
	%>
	<a href="/semi2/resources/songs/<%=arr.get(i).getAlbumId()%>/<%=arr.get(i).getId()%>.mp3" download="<%=arr.get(i).getAlbumName()+"-"+arr.get(i).getRnum()+"-"+arr.get(i).getName()+"-"+arr.get(i).getArtist()%>.mp3"></a>
	<%
}

%>
</body>
</html>