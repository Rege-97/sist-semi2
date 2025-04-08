<%@page import="com.plick.mypage.MypageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<%
MypageDao mdao = new MypageDao();
int result = mdao.changeMemberAccessType(signedinDto.getMemberId());
if (result > 0) signedinDto.setMemberAccessType("applicant");
String msg = result > 0 ? "아티스트 등업이 신청되었습니다":"신청 실패";
%>
<script>
window.alert("<%=msg %>");
location.href = "/semi2/mypage/profile.jsp";
</script>