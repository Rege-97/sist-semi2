<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>	
<%@page import="java.text.*"%>
<%@ page import="com.plick.support.*" %>
<jsp:useBean id="ndao" class="com.plick.support.NoticeDao"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<script>
function write(){
	console.log('write함수 실행')
	location.href='/semi2/support/noticeWrite.jsp';
}
</script>
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@ include file="/header.jsp" %>
<div class="body-content">
<%
String accessType=signedinDto.getMemberAccessType();
if(accessType==null){
	accessType="";
}

int totalNotice = ndao.showTotalNotices();
int pageSize = 10;
int totalPage = (totalNotice-1)/pageSize+1;
int pageGroupSize = 5;
String currentPage_str = request.getParameter("page");
if(currentPage_str==null||currentPage_str.equals(""))currentPage_str="1";
int currentPage = Integer.parseInt(currentPage_str);
int pageGroupCount = (totalPage-1)/pageGroupSize+1;
int currentGroup = (currentPage-1)/pageGroupSize+1;
%>
	<section>
		<article>
			<div class="subtitle"><h2>고객센터</h2></div>
			<div class="submenu-box">
		<input type="button" value="공지사항" class="bt_clicked" onclick="location.href='/semi2/support/main.jsp'">

		<input type="button" value="자주 묻는 질문" class="bt" onclick="location.href='/semi2/support/faq.jsp'">

		<input type="button" value="1 : 1 문의" class="bt" onclick="location.href='/semi2/support/question.jsp'">
	</div>
					<%
					if(accessType.equals("admin")){
						%>
						<div class="support-bt">
						<input type="button" value="글쓰기" class="bt" onclick='location.href="/semi2/support/notice/write.jsp"'>						
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
				<tr>
				<%
				ArrayList<NoticeDto> arr= ndao.showNotices(currentPage);
						if(arr==null){
				%>
					<tr>
					<td>보여줄 정보가 없습니다.
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String createAt = sdf.format(arr.get(i).getCreatedAt());
						%>
						<tr class="support-table-body">
						<td class="support-table-num"><%=arr.get(i).getId() %></td>
						<td class="support-table-title">
						<a href="/semi2/support/notice/showContent.jsp?id=<%=arr.get(i).getId()%>&page=<%=currentPage%>">
						<%=arr.get(i).getTitle() %></a></td>
						<td class="support-table-create"><%=createAt %></td>
						<%
					}
				}
				%>
				</tbody>
				<tfoot>
					<tr class="support-table-foot">
					<td colspan="4">
					<%String lt = currentGroup==1?"":"&lt;&lt;"; %>
					<%String gt = currentGroup==pageGroupCount?"":"&gt;&gt;"; %>
					<a href="/semi2/support/main.jsp?page=<%=(currentGroup-1)*5%>"><%=lt %></a>
					<%
					
					int startPageNum = (currentGroup-1) * 5 + 1;
					int endPageNum = currentGroup==pageGroupCount?totalPage:(currentGroup-1) * 5 + 5;
					for (int i=startPageNum; i<=endPageNum;i++){
						%>
						<span class="<%=currentPage==i?"page-number-bold":"page-number" %>">
						<a href="/semi2/support/main.jsp?page=<%=i%>"><%=i %></a>
						</span>
						<%
					}
					%>
					<a href="/semi2/support/main.jsp?page=<%=currentGroup*5+1%>"><%=gt %></a>
					
				</tfoot>
			</table>
			
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
	</div>
</body>
</html>