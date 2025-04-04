<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="signedinDao" class="com.plick.signedin.signedinDao"></jsp:useBean>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
if (signedinDto.getMemberEmail() == null) {
%>
<script>
	window.alert('로그인 후 이용하세요.');
	location.href='/semi2/membership/main.jsp';
</script>
<%
}

String membershipId_s = request.getParameter("membershipid");


%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<h2>이용권 구매</h2>
			<form name="payment" action="payment_ok">
				<fieldset>
					<table>
						<tr>
							<th colspan="4">카드번호</th>
						</tr>
						<tr>
							<td><input type="text" name="card_number1"></td>
							<td><input type="text" name="card_number2"></td>
							<td><input type="text" name="card_number3"></td>
							<td><input type="text" name="card_number4"></td>
						</tr>
						<th colspan="2">유효기간</th>
						<th colspan="2">CVC</th>
						</tr>
						<tr>
							<td><input type="text" name="card_month"></td>
							<td><input type="text" name="card_year"></td>
							<td colspan="2"><input type="text" name="card_cvc"></td>
						</tr>
						<tr>
							<th colspan="4">결제금액</th>
						</tr>
						<tr>
							<td colspan="4">10,000원</td>
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