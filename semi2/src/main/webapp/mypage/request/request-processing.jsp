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
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
	<%
	if(session.getAttribute("signedinDto")==null){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}else if(((SignedinDto) session.getAttribute("signedinDto")).getMemberId() == 0){
		response.sendRedirect("/semi2/member/signin.jsp");
		return;
	}
	%>
<%
MypageDao mypageDao = new MypageDao();
String yesParam = request.getParameter("yes");
if (yesParam != null){
	yesParam = yesParam.substring(0, yesParam.length()-1);
	String yp[] = yesParam.split(",");
	mypageDao.requestYes(yp);
%>
<script>
window.alert("처리완료");
</script>
<%
}
String noParam = request.getParameter("no");
if (noParam != null){
	noParam = noParam.substring(0, noParam.length()	-1);
	String np[] = noParam.split(",");
	mypageDao.requestNo(np);
	%>
	<script>
	window.alert("처리완료");
	</script>
	<%
}
%>


<body>
		<%@ include file="/header.jsp"%>
		<div class="body-content">
		<%@ include file="/mypage/mypage-header.jsp"%>
	<div class=profile-change-card>
		<div class="subtitle">
			<h2>아티스트 요청 목록</h2>
		</div>
		<div class="submenu-box">
				<input type="button" value="아티스트 등록" onclick = "requestYes();" class="bt"> 
		<input type="button" value="요청 거절" onclick = "requestNo();" class="bt">
		</div>
		<table class="request-table">
		<colgroup>
					<col style="width: 40px;">
					<col style="width: 40px;">
					<col style="width: 120px;">
					<col style="width: 70px;">
				</colgroup>
			<thead>
				<tr class="support-table-head">
					<th>열번호</th>
					<th>유저번호</th>
					<th>유저명</th>
					<th><input type = "button" id = "selectB" value = "모두 선택" onclick = "selectAll();" class="bt"></th>
				</tr>
			</thead>
			<tbody>
				<%
				// 현재 페이지 정보 생성
				String temp = request.getParameter("thisPage");
				int thisPage = temp != null ? Integer.parseInt(temp) : 1;
				int firstRow = 0, lastRow = 10, pageLate = 5;
				ArrayList<MypageDto> mypageDtos = mdao.getapplicantInfo((thisPage-1)*lastRow, (thisPage-1)*lastRow+lastRow);
				int maxRow = mdao.getMaxRow();
				if (mypageDtos == null || mypageDtos.size() == 0) {
				%>
				<tr class="support-table-body">
					<td colspan="4">요청 목록이 없습니다.
					</td>
				</tr>
				<%
				}else{
					for (int i = mypageDtos.size()-1; i >= 0; i--) {
					%>
				<tr class="support-table-body">
				<td class="support-table-num"><%=mypageDtos.get(i).getRnum()%></td>
				<td class="support-table-title"><%=mypageDtos.get(i).getId()%></td>
				<td class="support-table-title"><%=mypageDtos.get(i).getName()%></td>
				<td><input type="checkbox" id="<%=mypageDtos.get(i).getRnum() %>" name = "<%=mypageDtos.get(i).getId() %>" class="checkbox"></td>
				</tr>
				<%
					}
				}
				%>
			</tbody>
			<tfoot>
			<tr class="support-table-foot">
			<td colspan="4">
		<%
		int pageStart = thisPage < pageLate / 2 + pageLate % 2 ? 1 : thisPage - pageLate / 2;
		int pageAnd = maxRow%lastRow == 0 ? maxRow/lastRow : maxRow/lastRow+1;
		pageStart = pageStart > pageAnd - pageLate ? pageAnd - pageLate : pageStart; 
		if (pageStart < 1) pageStart = 1;
		if (thisPage > pageLate / 2 + pageLate % 2) {
		%>
		<a href="request-processing.jsp?thisPage=<%=pageStart-1 %>">&lt;</a>
		<%
		}
	
		for (int i = pageStart; i <= pageAnd; i++) {
		%>
		<span class="<%=thisPage==i?"page-number-bold":"page-number" %>">
		<a href="request-processing.jsp?thisPage=<%=i %>"><%=i%></a>
		</span>
		<%
			if(i >= pageStart+pageLate) break;
		}
		if (pageStart+pageLate < (maxRow%lastRow == 0 ? maxRow/lastRow:maxRow/lastRow+1)) {
		%>
		<a href="request-processing.jsp?thisPage=<%=pageStart+pageLate+1 %>">&gt;</a>
		<%
		}
		%>
		</td>
		</tr>
			</tfoot>
		</table>
	
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
	<script>
function requestYes(){
	var rqStr = "";
	for (var i = <%=(Math.max(thisPage-1, 0)) * lastRow%>; i <= <%=maxRow %>; i++){
		
		if(i > <%=(thisPage) * lastRow%>) break;
		var checkbox = document.getElementById(i);
		if (checkbox != null){
			if (checkbox.checked){
				rqStr += checkbox.name+",";
			}
		}
	}
	if(rqStr == "") return;
	location.href = "request-processing.jsp?thisPage=<%=thisPage %>&yes="+rqStr;
}
function requestNo(){
	var rqStr = "";
	for (var i = <%=(Math.max(thisPage-1, 0))  * lastRow%>; i <= <%=maxRow %>; i++){
		if(i > <%=(thisPage) * lastRow%>) break;
		var checkbox = document.getElementById(i);
		if (checkbox != null){
			if (checkbox.checked){
				rqStr += checkbox.name+",";
			}
		}
	}
	if(rqStr == "") return;
	location.href = "request-processing.jsp?thisPage=<%=thisPage %>&no="+rqStr;
}
function selectAll(){
	var sb = document.getElementById("selectB");
	if (sb.value == "모두 선택"){
		for (var i = <%=(thisPage-1) * lastRow%>; i <= <%=maxRow %>; i++){
			if(i > <%=(thisPage) * lastRow%>) break;
			var checkbox = document.getElementById(i);
			if (checkbox != null){
			checkbox.checked = true;
			}
		}
	}else if(sb.value == "모두 해제"){
		for (var i = <%=(thisPage-1) * lastRow%>; i <= <%=maxRow %>; i++){
			if(i > <%=(thisPage) * lastRow%>) break;
			var checkbox = document.getElementById(i);
			if (checkbox != null){
				checkbox.checked = false;
			}	
		}
	}
	sb.value = sb.value == "모두 선택" ? "모두 해제" : "모두 선택";
}
</script>
</div>
</body>
</html>