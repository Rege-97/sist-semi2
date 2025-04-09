<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
    <jsp:useBean id="signedinDao" class="com.plick.signedin.SignedinDao"></jsp:useBean>
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

String songId=request.getParameter("songid");
String albumId=request.getParameter("albumid");
String artist=request.getParameter("artist");
String songName=request.getParameter("songname");

if(songId==null||albumId==null||artist==null||songName==null){
	%>
	<script>
		window.alert('잘못된 접근입니다.');
		window.parent.location.reload();
	</script>
	<%
	return;
}

%>
<script>
function downloadSong() {
    const download = document.querySelector("a");
    download.click();
}

</script>
</head>
<body onload="downloadSong()">
<a href="/semi2/resources/songs/<%=albumId%>/<%=songId%>.mp3" download="<%=songName+"-"+artist%>.mp3"></a>
</body>
</html>