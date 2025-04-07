<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="cdao" class="com.plick.chart.ChartDao"></jsp:useBean>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>

<%
if (signedinDto==null||signedinDto.getMemberId()==0) {
%>
<script>
	window.alert('로그인 후 이용해주세요.');
	window.location.href = document.referrer+'#comment';
</script>
<%
return;
}

String albumId_s= request.getParameter("albumid");

if (albumId_s == null || albumId_s.equals("")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = document.referrer+'#comment';
</script>
<%
}

int albumId = Integer.parseInt(albumId_s);
int memberId = signedinDto.getMemberId();
String content= request.getParameter("content");
String parentId_s= request.getParameter("parentid");
int parentId=Integer.parseInt(parentId_s);

int result = cdao.addCommentAnswer(memberId, albumId, content, parentId);

String msg = result > 0 ? "답글이 등록되었습니다." : "답글 등록을 실패하였습니다.";
%>
<script>
window.alert('<%=msg%>');
window.location.href = document.referrer+'#comment';
</script>