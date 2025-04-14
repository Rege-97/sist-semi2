<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.root.*" %>    
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<header>

<nav class="menu-list">
<a href="/semi2/main.jsp"><img src="/semi2/resources/images/design/logo.png" class="logo"></a>
		<div class="menu">
			<a href="/semi2/chart/main.jsp">인기차트</a>
		</div>
		<div class="menu">
			<a href="/semi2/playlist/main.jsp">추천 플리</a>
		</div>
		<div class="menu">
			<a href="/semi2/membership/main.jsp">이용권</a>
		</div>
		<div class="menu">
		<form action="/semi2/search/main.jsp">
			<div class=search-wrapper>
				<input name="search" type="text" placeholder="검색어를 입력해 주세요."> <input type="image" src="/semi2/resources/images/design/search-icon.png">
			</div>
			</form>
		</div>


<%
if (signedinDto.getMemberId()!=0){
	%>
	
	<div class="login">
	<a href="/semi2/member/signout_ok.jsp" class="logout">로그아웃</a>
	<a href="/semi2/mypage/profile.jsp"><%=signedinDto.getMemberNickname() %></a>
	<a href="/semi2/mypage/profile.jsp"><img src="/semi2/resources/images/member/<%=signedinDto.getMemberId() %>/profile.jpg" class="login-profile-image" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';"></a>
	</div>

	
	
	
	<%
}else{
	%>
	<div class="login">
			<a href="/semi2/member/signin.jsp">로그인 </a> <a href="/semi2/member/signup/terms.jsp">회원가입</a>
		</div>
	<%
}
%> 
<%@include file="/playlist/mylist/modal.jsp"%>
</nav>
</header>
