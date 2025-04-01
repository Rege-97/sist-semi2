<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/header.jsp" %>
	<section>
		<article>
			<h2>고객센터</h2>
			<ul>
				<li><a href="main.jsp">공지사항</a></li>
				<li><a href="faq.jsp">자주 묻는 질문</a></li>
				<li><a href="question.jsp">1대1 질문</a></li>
			</ul>
			<hr>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>