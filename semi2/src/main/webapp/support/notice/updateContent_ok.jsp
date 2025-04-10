<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>     
<jsp:useBean id="noticeDao" class="com.plick.support.NoticeDao"></jsp:useBean>
<jsp:useBean id="noticeDto" class="com.plick.support.NoticeDto"></jsp:useBean>
<jsp:setProperty property="*" name="noticeDto"/>
<%
String page_str = request.getParameter("page");
if (page_str == null || page_str.equals("")) {
	page_str="1";
}
int previousPage = Integer.parseInt(page_str);
int result = noticeDao.updateNotice(noticeDto);
String msg = result>0? "수정 성공":"수정 실패";
%>    
<script>
window.alert('<%=msg%>');
location.href="/semi2/support/notice/showContent.jsp?id=<%=noticeDto.getId()%>&page=<%=previousPage%>";
</script>