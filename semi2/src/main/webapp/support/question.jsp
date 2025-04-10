<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>	
<%@page import="java.text.*"%>
<%@ page import="com.plick.support.*" %>
<jsp:useBean id="questionDao" class="com.plick.support.QuestionDao"></jsp:useBean>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
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
				<div class="subtitle"><h2>1 : 1 문의</h2></div>
			<div class="submenu-box">
		<input type="button" value="공지사항" class="bt" onclick="location.href='/semi2/support/main.jsp'">

		<input type="button" value="자주 묻는 질문" class="bt" onclick="location.href='/semi2/support/faq.jsp'">

		<input type="button" value="1 : 1 문의" class="bt_clicked" onclick="location.href='/semi2/support/question.jsp'">
	</div>
	<%
					if(!accessType.equals("admin")){
						%>
						<div class="support-bt">
						<input type="button" value="글쓰기" class="bt" onclick='location.href="/semi2/support/question/write.jsp"'>						
						</div>
						<%
					}
					%>
						<table class="support-table">
				<colgroup>
					<col style="width: 40px;">
					<col style="width: 500px;">
					<%if(!sw){ %><col style="width: 50px;"><% }%>
					<col style="width: 70px;">
				</colgroup>
				<thead>
					<tr class="support-table-head">
						<th>번호</th>
						<th>제목</th>
						<%if(!sw){ %><th>작성자<% }%>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
				<%
				ArrayList<QuestionDto> arr=sw? questionDao.showQuestions(currentPage,memberId):questionDao.showQuestionsAdmin(currentPage);
				if(arr==null){
					%>
					<td colspan="3" align="center" class="support-table-body">보여줄 정보가 없습니다.
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String createAt = sdf.format(arr.get(i).getCreatedAt());
						%>
						<tr class="support-table-body">
						<td class="support-table-num"><%=arr.get(i).getId() %>
						<td class="support-table-title">
						<%
						boolean swAnswer = i>=1&&arr.get(i).getParentId()==arr.get(i-1).getParentId(); 
						%>
						<a href="/semi2/support/question/showContent.jsp?id=<%=arr.get(i).getId()%>&answer=<%=swAnswer%>&page=<%=currentPage%>">
						<%
						
						//답글이면 true 담김
						if(swAnswer){
							%>
							&nbsp;└
							<%
						}
						%>
						<%=arr.get(i).getTitle() %></a>
						<%if(!sw){ %><td class="support-table-create"><%=arr.get(i).getNickname()%><% }%>
						<td class="support-table-create"><%=createAt %>
						<%
					}
				}
				%>
				</tbody>
				<tfoot>
					<tr class="support-table-foot">
					<td colspan="3">
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
				</tfoot>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>