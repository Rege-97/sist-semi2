<%@page import="com.plick.mypage.MypageDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plick.member.MemberDto"%>
<%@page import="com.plick.mypage.MypageDao"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.io.File"%>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<%
MypageDao mdao = new MypageDao();
String yesParam = request.getParameter("yes");
if (yesParam != null){
	yesParam = yesParam.substring(0, yesParam.length()-1);
	String yp[] = yesParam.split(",");
	mdao.requestYes(yp);
%>
<script>
window.alert("처리완료");
</script>
<%
}
String noParam = request.getParameter("no");
if (noParam != null){
	noParam = noParam.substring(0, noParam.length()-1);
	String np[] = noParam.split(",");
	mdao.requestNo(np);
	%>
	<script>
	window.alert("처리완료");
	</script>
	<%
}
%>


<body>
		<%@ include file="/header.jsp"%>
	<%
	// Dao에서 이용권 이름, 만료 기간을 가져와서 남은 일자 계산 후 출력
	HashMap<String, Timestamp> map = mdao.getMembershipName(signedinDto.getMemberId());
	ArrayList<String> list = mdao.getMembershipType();
	boolean a = false;
	%>
	<div class="subtitle">
		<h2>마이페이지</h2>
	</div>

	<%
	// 모든 이용권을 반복문으로 돌려 사용자가 가지고 있는 이용권들을 화면에 표시
	boolean b = false, c = false;
	for (int i = 0; i < 3; i++) {
		Calendar now = Calendar.getInstance();
		Calendar now2 = Calendar.getInstance();
		if (map.get(list.get(i)) == null) {
			continue;
		}
		now2.setTimeInMillis(map.get(list.get(i)).getTime());
		long timeLeft = now2.getTimeInMillis() - now.getTimeInMillis();
		if (timeLeft > 0)
			b = true;
		long dayLeft = TimeUnit.MILLISECONDS.toDays(timeLeft);
		if (dayLeft > 0)
			a = true;
	%><div class="mypage-card">
		<img src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), signedinDto.getMemberId())%>" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';" class="mypage-artist-image">
		<div class="subtitle">
			<label>현재 이용권 : <%=dayLeft > 0 ? list.get(i) : "보유중인 이용권이 없습니다"%>
			</label>
		</div>
		<div class="subtitle-sub">
			<label><%=dayLeft > 0 ? "남은 일자 : " + dayLeft + "일" : ""%></label>
			<%
			break;
			}
			%>
			<input type="button" value="<%=a ? "이용권변경" : "이용권구매"%>" onclick="location.href = '/semi2/membership/main.jsp'" class="bt">

		</div>
	</div>
	<div class="submenu-box">
		<input type="button" value="프로필 변경" onclick="location.href = '/semi2/mypage/profile.jsp'" class="bt">
		<input type="button" value="비밀번호 변경" onclick="location.href = '/semi2/mypage/password-check.jsp'" class="bt">
		<%
		if (signedinDto.getMemberAccessType().equals("listener")) {
		%>
		<input type="button" value="아티스트 신청" onclick="location.href = '/semi2/mypage/request/artist-request.jsp'" class="bt">
		<%
		} else if (signedinDto.getMemberAccessType().equals("applicant")) {
		%>
		<label>현재 아티스트 등록 심사 중 입니다.</label>
		<%
		} else if (signedinDto.getMemberAccessType().equals("artist")) {
		%>
		<input type="button" value="앨범 등록" onclick="location.href = '/semi2/mypage/album-management/main.jsp'" class="bt">
		<%
		} else if (signedinDto.getMemberAccessType().equals("admin")) {
		%>
		<input type="button" value="아티스트 요청 처리" onclick="location.href = '/semi2/mypage/request/request-processing.jsp'" class="bt_clicked">

		<%
		}
		%>
	</div>
	<div class="footer-line"></div>
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
				int firstRow = 0, lastRow = 5, pageLate = 5;
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
		if (thisPage > pageLate / 2 + pageLate % 2) {
		%>
		<a href="request-processing.jsp?thisPage=<%=thisPage-pageLate/2 %>">&lt;</a>
		<%
		}
		int pageStart = thisPage < pageLate / 2 + pageLate % 2 ? 1 : thisPage - pageLate / 2;
		for (int i = pageStart; i < pageStart+pageLate; i++) {
			if (i * lastRow > maxRow) break;
		%>
		<span class="<%=thisPage==i?"page-number-bold":"page-number" %>">
		<a href="request-processing.jsp?thisPage=<%=i %>"><%=i%></a>
		</span>
		<%
		}
		if (thisPage+pageLate/2 < maxRow/lastRow) {
		%>
		<a href="request-processing.jsp?thisPage=<%=thisPage+pageLate/2 %>">&gt;</a>
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
	for (var i = <%=(thisPage-1) * lastRow%>; i <= <%=maxRow %>; i++){
		
		if(i > <%=(thisPage) * lastRow%>) break;
		var checkbox = document.getElementById(i);
		if (checkbox != null){
			if (checkbox.checked){
				rqStr += checkbox.name+",";
			}
		}
	}
	location.href = "request-processing.jsp?thisPage=<%=thisPage %>&yes="+rqStr;
}
function requestNo(){
	var rqStr = "";
	for (var i = <%=(thisPage-1) * lastRow%>; i <= <%=maxRow %>; i++){
		if(i > <%=(thisPage) * lastRow%>) break;
		var checkbox = document.getElementById(i);
		if (checkbox != null){
			if (checkbox.checked){
				rqStr += checkbox.name+",";
			}
		}
	}
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
</body>
</html>