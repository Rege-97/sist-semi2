<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="deleteDao" class="com.plick.support.DeleteDao"></jsp:useBean>
<%
String id_str = request.getParameter("id");
String parentId_str = request.getParameter("parentId");
if (id_str == null || id_str.equals("") || parentId_str == null || parentId_str.equals("")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/support/main.jsp';
</script>
<%
}else{
	int id = Integer.parseInt(id_str);
	int parentId = Integer.parseInt(parentId_str);
	int haveAnswer = deleteDao.selectId(parentId);
	
	if (haveAnswer > 1) {
	%>
	<script>
		
		window.alert('답변이 달린 게시물은 삭제할 수 없습니다.');
		
		history.back();
		</script>
	<%
	} else {
	int result = deleteDao.delete(id, "question");
	String msg = result > 0 ? "삭제 성공" : "삭제 실패";
	%>
	<script>
		window.alert('<%=msg%>');
		location.href = '/semi2/support/question.jsp'
	</script>
	<%
	}
}
	%>
	
	

