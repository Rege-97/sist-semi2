<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section>
		<article>
			<h2>고객센터</h2>
			<table>
				<tr>
					<td>
						<a href="support_Notice.jsp" target="support_child">공지사항</a>
					</td>
					<td>
						<a href="support_FAQ.jsp" target="support_child">자주 묻는 질문</a>
					</td>
					<td>
						<a href="support_Question.jsp" target="support_child">1대1 질문</a>
					</td>
				</tr>
			</table>
			<iframe src="support_Notice.jsp" name="support_child" width="955"
				height="1500"></iframe>
		</article>
	</section>
</body>
</html>