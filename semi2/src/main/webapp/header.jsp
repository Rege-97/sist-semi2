<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*" %>    
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<header>
<nav>
<a href = "/semi2/main.jsp"><img name="로고">로고</a>
<a href="/semi2/chart/main.jsp">차트</a>
<a href="/semi2/playlist/main.jsp">플리</a>
<form>
<input type="text" placeholder="검색어를 입력하세요">
<input type="submit" value="검색">
</form>
<%
if (signedinDto.getMemberId()!=0){
	%>
	<a href="/semi2/mypage/profile.jsp"><%=signedinDto.getMemberNickname() %></a>
	<img src="/semi2/resources/images/member/<%=signedinDto.getMemberId() %>/profile.jpg" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"
         width="100">
	<a href="/semi2/member/signout_ok.jsp">로그아웃</a>
	<%
}else{
	%>
	<a href="/semi2/member/signin.jsp">로그인</a>
	<a href="/semi2/member/signup/terms.jsp">회원가입</a>
	<%
}
%> 

</nav>
</header>
