<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="membershipDao" class="com.plick.membership.MembershipDao"></jsp:useBean>

<%
String memberid_s = request.getParameter("memberid");
String membershipid_s = request.getParameter("membershipid");

if (memberid_s == null || membershipid_s == null) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	location.href = '/semi2/membership/main.jsp';
</script>
<%
}

int memberid = Integer.parseInt(memberid_s);
int membershipid = Integer.parseInt(membershipid_s);

int result = membershipDao.payMembership(memberid, membershipid);

String msg = result > 0 ? "결제가 완료되었습니다." : "결제가 실패하였습니다.";
%>
<script>
window.alert('<%=msg%>');
location.href="/semi2/main.jsp";
</script>