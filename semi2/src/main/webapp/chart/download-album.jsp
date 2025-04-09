<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String songId=request.getParameter("songid");
String albumId=request.getParameter("albumid");
String artist=request.getParameter("artist");
String songName=request.getParameter("songname");

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
<a href="/semi2/resources/songs/<%=albumId%>/<%=songId%>.mp3" download="<%=songName+"-"+artist%>"></a>
</body>
</html>