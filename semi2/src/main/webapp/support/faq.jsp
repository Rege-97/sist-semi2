<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>	
<%@ page import="com.plick.support.*" %>
<jsp:useBean id="faqDao" class="com.plick.support.FaqDao"></jsp:useBean>
<jsp:useBean id="memberDto" class="com.plick.dto.MemberDto" scope="session"></jsp:useBean>
<%
String accessType=memberDto.getAccessType();
if(accessType==null){
	accessType="";
}
if(accessType.equals("admin")){
	
}

int totalfaq = faqDao.showTotalFaqs();
int pageSize = 10;
int totalPage = (totalfaq-1)/pageSize+1;
int pageGroupSize = 5;
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals(""))currentPage_str="1";
int currentPage = Integer.parseInt(currentPage_str);
int pageGroupCount = (totalPage-1)/pageGroupSize+1;
int currentGroup = (currentPage-1)/pageGroupSize+1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function write(){
	console.log('write함수 실행')
	location.href='/semi2/support/faqWrite.jsp';
}
</script>
</head>
<body>
<%@ include file="/header.jsp" %>
	<section>
		<article>
			<h2>고객센터</h2>
			<ul>
				<li><a href="main.jsp">공지사항</a></li>
				<li><a href="faq.jsp">자주 묻는 질문</a></li>
				<li><a href="question.jsp">1대1 질문</a></li>
			</ul>
			<hr>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
				ArrayList<FaqDto> arr= faqDao.showFaqs(currentPage);
				if(arr==null){
					%>
					<tr>
					<td>보여줄 정보가 없습니다.
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						%>
						<tr>
						<td><%=arr.get(i).getId() %>
						<td>
						<a href="/semi2/support/faq/showContent.jsp?id=<%=arr.get(i).getId()%>">
						<%=arr.get(i).getTitle() %></a>
						<td><%=arr.get(i).getCreatedAt() %>
						<%
					}
				}
				%>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="2">
					<%String lt = currentGroup==1?"":"&lt;&lt;"; %>
					<%String gt = currentGroup==pageGroupCount?"":"&gt;&gt;"; %>
					<a href="/semi2/support/faq.jsp?page=<%=(currentGroup-1)*5%>"><%=lt %></a>
					<%
					
					int startPageNum = (currentGroup-1) * 5 + 1;
					int endPageNum = currentGroup==pageGroupCount?totalPage:(currentGroup-1) * 5 + 5;
					for (int i=startPageNum; i<=endPageNum;i++){
						%>
						<a href="/semi2/support/faq.jsp?page=<%=i%>"><%=i %></a>
						<%
					}
					%>
					<a href="/semi2/support/faq.jsp?page=<%=currentGroup*5+1%>"><%=gt %></a>
					<td>
					<%
					if(accessType.equals("admin")){
						%>
						<input type="button" value="글쓰기" onclick='location.href="/semi2/support/faq/write.jsp"'>						
						<%
					}
					%>
				</tfoot>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>