<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>	
<%@page import="java.text.*"%>
<%@ page import="com.plick.support.*" %>
<jsp:useBean id="faqDao" class="com.plick.support.FaqDao"></jsp:useBean>

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
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<%
String accessType=signedinDto.getMemberAccessType();
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
	<section>
		<article>
			<div class="subtitle"><h2>자주 묻는 질문</h2></div>
			<div class="submenu-box">
		<input type="button" value="공지사항" class="bt" onclick="location.href='/semi2/support/main.jsp'">

		<input type="button" value="자주 묻는 질문" class="bt_clicked" onclick="location.href='/semi2/support/faq.jsp'">

		<input type="button" value="1 : 1 문의" class="bt" onclick="location.href='/semi2/support/question.jsp'">
	</div>
					<%
					if(accessType.equals("admin")){
						%>
						<div class="support-bt">
						<input type="button" value="글쓰기" class="bt" onclick='location.href="/semi2/support/faq/write.jsp"'>						
						</div>
						<%
					}
					%>
			<table class="support-table">
				<colgroup>
					<col style="width: 40px;">
					<col style="width: 500px;">
					<col style="width: 70px;">
				</colgroup>
				<thead>
					<tr class="support-table-head">
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
					<td colspan="3">보여줄 정보가 없습니다.
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String createAt = sdf.format(arr.get(i).getCreatedAt());
						%>
						<tr class="support-table-body">
						<td class="support-table-num"><%=arr.get(i).getId() %></td>
						<td class="support-table-title">
						<a href="/semi2/support/faq/showContent.jsp?id=<%=arr.get(i).getId()%>&page=<%=currentPage%>">
						<%=arr.get(i).getTitle() %></a></td>
						<td class="support-table-create"><%=createAt %></td>
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
					
				</tfoot>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>