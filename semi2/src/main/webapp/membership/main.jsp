<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article>
<h2>이용권 구매</h2>
<body>
	<section>
		<article>
			<img src="#">
			<hr>
			<table width="900">
				<tr>
					<td>무제한 듣기</td>
					<td rowspan="2">30일 이용권</td>
					<td rowspan="2">
						<del>정가 8,800원</del>
					</td>
					<td>8,690원</td>
					<td rowspan="2"><a href="payment.jsp?membership_id=1">구매</a></td>
				</tr>
				<tr>
					<td>모든 곡 스트리밍</td>
					<td>VAT 포함</td>
				</tr>
				</table>
				<hr>
				<table width="900">
				<tr>
					<td>무제한 다운로드</td>
					<td rowspan="2">30일 이용권</td>
					<td rowspan="2">
						<del>정가 8,800원</del>
					</td>
					<td>8,690원</td>
					<td rowspan="2"><a href="payment.jsp?membership_id=2">구매</a></td>
				</tr>
				<tr>
					<td>모든 곡 다운로드</td>
					<td>VAT 포함</td>
				</tr>
				</table>
				<hr>
				<table width="900">
				<tr>
					<td>무제한 듣기 + 다운로드</td>
					<td rowspan="2">30일 이용권</td>
					<td rowspan="2">
						<del>정가 19,800원</del>
					</td>
					<td>15,890원</td>
					<td rowspan="2"><a href="payment.jsp?membership_id=3">구매</a></td>
				</tr>
				<tr>
					<td>모든 곡 스트리밍 + 다운로드</td>
					<td>VAT 포함</td>
				</tr>
			</table>
			<hr>
		</article>
		<article>
		<h1>구매안내</h1>
		<ul>
		<li>이용권 구매 시 부가가치세(10%)가 별도 부가됩니다.</li>
		<li>무제한 듣기는 이용 기간 동안 전곡 스트리밍 무제한 감상이 가능합니다.</li>
		<li>무제한 듣기는 다운로드 기능은 제공되지 않습니다.</li>
		<li>무제한 다운로드는 이용 기간 동안 음원 다운로드 무제한 이용이 가능합니다.</li>
		<li>무제한 다운로드는 스트리밍 감상은 제공되지 않습니다.</li>
		<li>무제한 듣기 + 다운로드는 이용 기간 동안 스트리밍과 다운로드 모두 무제한 이용이 가능합니다.</li>
		</ul>
		</article>
	</section>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>