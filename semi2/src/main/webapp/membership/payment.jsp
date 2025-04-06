<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.dto.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="signedinDao" class="com.plick.signedin.signedinDao"></jsp:useBean>
<jsp:useBean id="membershipDao" class="com.plick.membership.MembershipDao"></jsp:useBean>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
if (signedinDto.getMemberId() ==0) {
%>
<script>
	window.alert('로그인 후 이용하세요.');
	location.href = '/semi2/membership/main.jsp';
</script>
<%
}

int hasMembershipId = signedinDao.hasActiveMembership(signedinDto);

if (hasMembershipId > 0) {
	%>
	<script>
	if(!confirm('이미 이용권이 있습니다. 변경하시겠습니까?')){
		location.href = '/semi2/membership/main.jsp';
	}
	</script>
	<%
	
}

String membershipId_s = request.getParameter("membershipid");

if (membershipId_s == null || membershipId_s == "") {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/membership/main.jsp';
</script>
<%
}
int membershipId = Integer.parseInt(membershipId_s);
MembershipDto dto= membershipDao.findMembership(membershipId);

DecimalFormat formatter = new DecimalFormat("#,###");
String price=formatter.format(dto.getPrice());
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<h2>이용권 구매</h2>
			<form name="payment" action="payment_ok">
				<input type="hidden" name="memberid" value="<%=signedinDto.getMemberId()%>">
				<input type="hidden" name="membershipid" value="<%=membershipId%>">
				<fieldset>
				<h2><%=dto.getName() %></h2>
					<table>
						<tr>
							<th colspan="4">카드번호</th>
						</tr>
						<tr>
							<td><input type="text" name="card_number1" required></td>
							<td><input type="text" name="card_number2" required></td>
							<td><input type="text" name="card_number3" required></td>
							<td><input type="text" name="card_number4" required></td>
						</tr>
						<th colspan="2">유효기간</th>
						<th colspan="2">CVC</th>
						</tr>
						<tr>
							<td><input type="text" name="card_month" required></td>
							<td><input type="text" name="card_year" required></td>
							<td colspan="2"><input type="text" name="card_cvc" required></td>
						</tr>
						<tr>
							<th colspan="4">결제금액 : <%=price %>원</th>
						</tr>
						<tr>
							<td colspan="4"><input type="submit" value="결제하기"></td>
						</tr>
					</table>
				</fieldset>
			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>