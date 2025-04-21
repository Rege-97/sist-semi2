<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plick.dto.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<jsp:useBean id="signedinDao" class="com.plick.signedin.SignedinDao"></jsp:useBean>
<jsp:useBean id="membershipDao" class="com.plick.membership.MembershipDao"></jsp:useBean>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="body-content">
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
	<section>
		<article>
			<form name="payment" action="payment_ok.jsp" method="post">
				<input type="hidden" name="memberid" value="<%=signedinDto.getMemberId()%>">
				<input type="hidden" name="membershipid" value="<%=membershipId%>">
					<div class="payment-card">
					<table class="payment-table">
					<tr>
					<th colspan="4">
					<div class="payment-title"><%=dto.getName() %> 결제 요청</div>
					</th>
					</tr>
						<tr>
							<th colspan="4">카드번호</th>
						</tr>
						<tr>
							<td><input type="text" name="card_number1" minlength="4" maxlength="4" required class="card-number-text"></td>
							<td><input type="text" name="card_number2" minlength="4" maxlength="4" required class="card-number-text"></td>
							<td><input type="text" name="card_number3" minlength="4" maxlength="4" required class="card-number-text"></td>
							<td><input type="text" name="card_number4" minlength="4" maxlength="4" required class="card-number-text"></td>
						</tr>
						<tr>
						<th colspan="2">유효기간</th>
						<th colspan="2">CVC</th>
						</tr>
						<tr>
							<td><input type="text" name="card_month" minlength="2" maxlength="2" required class="card-number-text"></td>
							<td><input type="text" name="card_year" minlength="2" maxlength="2" required class="card-number-text"></td>
							<td colspan="2"><input type="password" name="card_cvc" minlength="3" maxlength="3" required class="card-number-text-cvc"></td>
						</tr>
						<tr>
							<th colspan="4">결제금액 : <%=price %>원</th>
						</tr>
						<tr>
							<td colspan="4"><input type="submit" value="결제하기" class="bt"></td>
						</tr>
					</table>
					</div>
			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
	</div>
	<script>
document.querySelectorAll(".card-number-text").forEach(function(input) {
  input.addEventListener("input", function() {
    this.value = this.value.replace(/[^0-9]/g, '');
  });
});
</script>
</body>
</html>