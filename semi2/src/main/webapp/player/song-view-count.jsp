<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="playerDao" class="com.plick.player.PlayerDao"></jsp:useBean>
<%
String id_s=request.getParameter("songid");

if(id_s==null||id_s.equals("")){
	id_s="0";
}

int id=Integer.parseInt(id_s);

int result = playerDao.countSongView(id);
String msg=result>0?"조회수 올라감":"조회수 실패";

%>
<script>
alert(<%=msg%>);
</script>