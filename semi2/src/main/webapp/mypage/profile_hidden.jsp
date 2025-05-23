<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plick.mypage.MypageDao" %>
<%@ page import="com.plick.signedin.SignedinDto" %>
<jsp:useBean id="signedinDto" class="com.plick.signedin.SignedinDto" scope="session"></jsp:useBean>
<%
MypageDao mypageDao = new MypageDao();
String nickname = request.getParameter("editNickname");
String memberId = request.getParameter("memberId");
String description = request.getParameter("description");
// "editNickname"로 요청이 들어오면 닉네임 중복 검사
if (nickname!=null && memberId==null){
	int result = mypageDao.checkNicknameDuplicate(nickname);
	switch(result){
	case 0: 
		%>
		<script>
		parent.document.getElementById("duplicateNickname").innerText = "사용가능한 닉네임이에요";
		parent.document.getElementById("nicknamecheck").value = "true";
		</script>
		<%
		break;
	case 1:
		%>
		<script>
		parent.document.getElementById("duplicateNickname").innerText = "중복된 닉네임이에요";
		parent.document.getElementById("nicknamecheck").value = "false";
		</script>
		<%
		break;
	default:
	}
}else if(nickname!=null && memberId!=null){// "description"로 요청이 들어오면 닉네임 업데이트
	int result = mypageDao.updateMemberNickname(nickname, Integer.parseInt(request.getParameter("memberId")));
	if (result > 0){
		((SignedinDto) session.getAttribute("signedinDto")).setMemberNickname(nickname);
	%>
	<script>
	parent.document.getElementById("duplicateNickname").innerText = "";
	</script>
	<%	
	}
}
%>