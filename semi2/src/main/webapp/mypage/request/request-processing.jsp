<%@page import="com.plick.mypage.MypageDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.member.MemberDto"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String yesParam = request.getParameter("yes");
if (yesParam != null){
	String yp[] = yesParam.split(",");
	
}
%>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<fieldset>
		<legend>아티스트 요청 목록</legend>
		<table>
			<thead>
				<tr>
					<td>열번호</td>
					<td>유저번호</td>
					<td>유저명</td>
					<td><input type = "button" value = "모두 선택"></td>
				</tr>
			</thead>
			<tbody>
				<%
				// 현재 페이지 정보 생성
				String temp = request.getParameter("thisPage");
				int thisPage = temp != null ? Integer.parseInt(temp) : 1;
				int firstRow = 0, lastRow = 2, pageLate = 5;
				MypageDao mdao = new MypageDao();
				ArrayList<MypageDto> mypageDtos = mdao.getapplicantInfo((thisPage-1)*lastRow, (thisPage-1)*lastRow+lastRow);
				int maxRow = mdao.getMaxRow();
				if (mypageDtos == null || mypageDtos.size() == 0) {
				%>
				<tr>
					<td colspan="4">요청 목록이 없습니다.
					<td>
				<tr>
				<%
				}else{
					for (int i = 0; i < mypageDtos.size(); i++) {
					%>
				<tr>
				<td><%=mypageDtos.get(i).getRnum()%></td>
				<td><%=mypageDtos.get(i).getId()%></td>
				<td><%=mypageDtos.get(i).getName()%></td>
				<td><input type="checkbox" id="<%=mypageDtos.get(i).getRnum()%>"></td>
				</tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		<input type="button" value="아티스트 등록" onclick = "requestYes();"> 
		<input type="button" value="요청 거절" onclick = "requestNo();">
		<%
		if (thisPage > pageLate / 2 + pageLate % 2) {
		%>
		<a href="request-processing.jsp?thisPage=<%=thisPage-pageLate/2 %>"><label> << </label></a>
		<%
		}
		int pageStart = thisPage < pageLate / 2 + pageLate % 2 ? 1 : thisPage - pageLate / 2;
		for (int i = pageStart; i < pageStart+pageLate; i++) {
			if (i * lastRow > maxRow) break;
		%>
		<a href="request-processing.jsp?thisPage=<%=i %>"><label><%=i%> </label></a>
		<%
		}
		if (thisPage+pageLate/2 < maxRow/lastRow) {
		%>
		<a href="request-processing.jsp?thisPage=<%=thisPage+pageLate/2 %>"><label> >></label></a>
		<%
		}
		%>
	</fieldset>
	<jsp:include page="/footer.jsp"></jsp:include>
	<script>
function requestYes(){
	var rqStr = "";
	for (var i = <%=(thisPage-1) * lastRow%>; i <= <%=maxRow %>; i++){
		if(i > <%=(thisPage) * lastRow%>) break;
		var checkbox = document.getElementById(i);
		if (checkbox != null){
			if (checkbox.checked){
				rqStr = rqStr+checkbox.id+",";
			}
		}
	}
	location.href = "request-procession.jsp?yes="+rqStr;
}
function requestNo(){
	
}
</script>
</body>
</html>