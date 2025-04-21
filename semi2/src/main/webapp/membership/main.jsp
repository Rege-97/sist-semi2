<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plick - 나만의 플레이리스트</title>
<link rel="icon" href="/semi2/resources/images/design/favicon.png" type="image/png">
</head>
<link rel="stylesheet" type="text/css" href="/semi2/css/main.css">
<body>
<%@include file="/header.jsp" %>
<div class="body-content">
	<section>
		<article>
			<a href="/semi2/membership/payment.jsp?membershipid=3"><img src="/semi2/resources/images/design/banner/banner-membership.jpg" class="membership-banner"></a>
			
			<table class="membership-table">
				<tr>
					<td class="membership-title-col">
					<div class="membership-title-box">
					<div class="membership-name">무제한 듣기<span class="membership-day">30일 이용권</span></div>
					<div class="membership-detail">모든 곡 스트리밍</div>
					</div>
					</td>
					<td>
						<div class="membership-real-price">정가 9,900원</div>
					</td>
					<td class="membership-price-col">
					<div class="membership-price">7,990원</div>
					<div class="membership-price-detail">VAT 포함</div>
					</td>
					<td class="membership-pay-col">
					<input type="button" value="구매" class="bt" onclick="location.href='/semi2/membership/payment.jsp?membershipid=1'">
					</td>
				</tr>
				</table>
				<table class="membership-table">
				<tr>
					<td class="membership-title-col">
					<div class="membership-title-box">
					<div class="membership-name">무제한 다운로드<span class="membership-day">30일 이용권</span></div>
					<div class="membership-detail">모든 곡 다운로드</div>
					</div>
					</td>
					<td>
						<div class="membership-real-price">정가 9,900원</div>
					</td>
					<td class="membership-price-col">
					<div class="membership-price">7,990원</div>
					<div class="membership-price-detail">VAT 포함</div>
					</td>
					<td class="membership-pay-col">
					<input type="button" value="구매" class="bt" onclick="location.href='/semi2/membership/payment.jsp?membershipid=2'">
					</td>
				</tr>
				</table>
				<table class="membership-table">
				<tr>
					<td class="membership-title-col">
					<div class="membership-title-box">
					<div class="membership-name">무제한 듣기 + 다운로드<span class="membership-day">30일 이용권</span></div>
					<div class="membership-detail">모든 곡 스트리밍 + 다운로드</div>
					</div>
					</td>
					<td>
						<div class="membership-real-price">정가 19,800원</div>
					</td>
					<td class="membership-price-col">
					<div class="membership-price">13,990원</div>
					<div class="membership-price-detail">VAT 포함</div>
					</td>
					<td class="membership-pay-col">
					<input type="button" value="구매" class="bt" onclick="location.href='/semi2/membership/payment.jsp?membershipid=3'">
					</td>
				</tr>
				</table>
		</article>
		<article>
		<div class="membership-caution-title">구매안내</div>
		<ul class="membership-caution">
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
</div>
</body>
</html>