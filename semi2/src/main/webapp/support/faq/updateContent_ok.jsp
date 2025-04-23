<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>     
<jsp:useBean id="faqDao" class="com.plick.support.FaqDao"></jsp:useBean>
<jsp:useBean id="faqDto" class="com.plick.support.FaqDto"></jsp:useBean>
<jsp:setProperty property="*" name="faqDto"/>
<%
String page_str = request.getParameter("page");
if (page_str == null || page_str.equals("")) {
	page_str="1";
}
int previousPage = Integer.parseInt(page_str);
int result = faqDao.updateFaq(faqDto);
String msg = result>0? "수정 성공":"수정 실패";
%>    
<script>
window.alert('<%=msg%>');
location.href="/semi2/support/faq/showContent.jsp?id=<%=faqDto.getId()%>&page=<%=previousPage%>";
</script>