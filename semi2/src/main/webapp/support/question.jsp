<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>	
<%@ page import="com.plick.support.*" %>
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<%
String accessType=signedinDto.getMemberAccessType();
boolean sw = true;
int memberId = signedinDto.getMemberId();
if(accessType==null){
	accessType="";
}
if(accessType.equals("listener")||accessType.equals("artist")){
	sw = true;
}else if(accessType.equals("admin")){
	sw= false;
}else{
	%>
	<script>
	window.alert('로그인 후 이용해주세요');
	location.href='/semi2/main.jsp';
	</script>
	<%
}

int totalQuestions = sw? questionDao.showTotalQuestions(memberId):questionDao.showTotalQuestionsAdmin();
int pageSize = 10;
int totalPage = (totalQuestions-1)/pageSize+1;
int pageGroupSize = 5;
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals(""))currentPage_str="1";
int currentPage = Integer.parseInt(currentPage_str);
int pageGroupCount = (totalPage-1)/pageGroupSize+1;
int currentGroup = (currentPage-1)/pageGroupSize+1;
%>
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
						<%if(!sw){ %><th>작성자<% }%>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
				ArrayList<QuestionDto> arr=sw? questionDao.showQuestions(currentPage,memberId):questionDao.showQuestionsAdmin(currentPage);
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
						<%
						boolean swAnswer = i>=1&&arr.get(i).getParentId()==arr.get(i-1).getParentId(); 
						%>
						<a href="/semi2/support/question/showContent.jsp?id=<%=arr.get(i).getId()%>&answer=<%=swAnswer%>">
						<%
						
						//답글이면 true 담김
						if(swAnswer){
							%>
							&nbsp;&nbsp;
							<%
						}
						%>
						<%=arr.get(i).getTitle() %></a>
						<%if(!sw){ %><td><%=arr.get(i).getNickname()%><% }%>
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
					<a href="/semi2/support/question.jsp?page=<%=(currentGroup-1)*5%>"><%=lt %></a>
					<%
					
					int startPageNum = (currentGroup-1) * 5 + 1;
					int endPageNum = currentGroup==pageGroupCount?totalPage:(currentGroup-1) * 5 + 5;
					for (int i=startPageNum; i<=endPageNum;i++){
						%>
						<a href="/semi2/support/question.jsp?page=<%=i%>"><%=i %></a>
						<%
					}
					%>
					<a href="/semi2/support/question.jsp?page=<%=currentGroup*5+1%>"><%=gt %></a>
					<td><input type="button" value="글쓰기" onclick='location.href="/semi2/support/question/write.jsp"'>
				</tfoot>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>