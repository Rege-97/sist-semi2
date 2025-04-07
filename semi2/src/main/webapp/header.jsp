<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*" %>    
<jsp:useBean id="signedinDto" class="com.plick.signedin.signedinDto" scope="session"></jsp:useBean>
<jsp:useBean id="signedinDao" class="com.plick.signedin.signedinDao" scope="session"></jsp:useBean>
<jsp:useBean id="rootDao" class="com.plick.root.RootDao"></jsp:useBean>
  
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
SignedinHeaderDto shDto = rootDao.signedinHeader(signedinDto.getMemberId());
if (signedinDto.getMemberId()!=0){
	%>
	<a href="/semi2/mypage/profile.jsp"><%=signedinDto.getMemberNickname() %></a>
	<%
	if(signedinDao.hasActiveMembership(signedinDto)>0){
		%>
		<a href="/semi2/membership/main.jsp"><%=shDto.getMembershipName() %></a>
		<%
	}else{
		%>
		<a href="/semi2/membership/main.jsp">이용권 구매하기</a>
		<%
	}
	%>
	
	<img src="/semi2/resources/images/member/<%=signedinDto.getMemberId() %>.jpg">
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
