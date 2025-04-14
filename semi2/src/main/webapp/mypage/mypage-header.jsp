<%@page import="java.util.Iterator"%>
<%@page import="com.plick.signedin.SignedinDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.plick.mypage.MypageDao"%>
<jsp:useBean id="memberDao" class="com.plick.member.MemberDao"></jsp:useBean>


	<%
	SignedinDto sdto = (SignedinDto)session.getAttribute("signedinDto");
	MypageDao mdao = new MypageDao();
	// Dao에서 이용권 이름, 만료 기간을 가져와서 남은 일자 계산 후 출력
	Calendar now = Calendar.getInstance();
	HashMap<String, Timestamp> map = mdao.getMembershipName(sdto.getMemberId(), now);
	ArrayList<String> list = mdao.getMembershipType();
	boolean a = map.size() > 0 ? true : false; 
	String url=request.getRequestURI();
	int urlCheck=0;
	if(url.contains("profile")){
		urlCheck=0;
	}else if(url.contains("password")){
		urlCheck=1;
	}else if(url.contains("artist-request")){
		urlCheck=2;
	}else if(url.contains("form")){
		urlCheck=3;
	}else if(url.contains("request-processing")){
		urlCheck=4;
	}
	
	
	%>
	<div class="subtitle">
		<h2>마이페이지</h2>
	</div>

	<%
	// 모든 이용권을 반복문으로 돌려 사용자가 가지고 있는 이용권들을 화면에 표시
	String passName = "보유 중인 이용권이 없습니다";
	long dayLeft = 0;
	for (int i = 0; i < list.size(); i++) {
		Calendar now2 = Calendar.getInstance();
		if (map.get(list.get(i)) == null) {
			continue;
		}
		Iterator <String> kSet = map.keySet().iterator();
		while(kSet.hasNext()){
			String temp = kSet.next();
			if (temp.equals(list.get(i))){
				passName = temp;
			}
		}
		now2.setTimeInMillis(map.get(list.get(i)).getTime());
		long timeLeft = now2.getTimeInMillis() - now.getTimeInMillis();
		if (timeLeft > 0){
			dayLeft = TimeUnit.MILLISECONDS.toDays(timeLeft);
		}
	}
			%>
			<div class="mypage-card">
		<img src="/semi2/<%=memberDao.loadProfileImg(request.getRealPath(""), sdto.getMemberId())%>" onerror="this.src='/semi2/resources/images/member/default-profile.jpg';" class="mypage-artist-image">
		<div class="subtitle">
			<label>현재 이용권 : <%=passName%>
			</label>
		</div>
		<div class="subtitle-sub">
			<label><%=dayLeft + "일"%></label>
			
			<input type="button" value="<%=a ? "이용권변경" : "이용권구매"%>" onclick="location.href = '/semi2/membership/main.jsp'" class="bt">
		</div>
	</div>
	<div class="submenu-box">
		<input type="button" value="프로필 변경" onclick="location.href = '/semi2/mypage/profile.jsp'" class="<%=urlCheck==0?"bt_clicked" : "bt" %>">
		<input type="button" value="비밀번호 변경" onclick="location.href = '/semi2/mypage/password-check.jsp'" class="<%=urlCheck==1?"bt_clicked" : "bt" %>">
		<%
		if (sdto.getMemberAccessType().equals("listener")) {
		%>
		<input type="button" value="아티스트 신청" onclick="location.href = '/semi2/mypage/request/artist-request.jsp'" class="<%=urlCheck==2?"bt_clicked" : "bt" %>">
		<%
		} else if (sdto.getMemberAccessType().equals("applicant")) {
		%>
		<label>현재 아티스트 등록 심사 중 입니다.</label>
		<%
		} else if (sdto.getMemberAccessType().equals("artist")) {
		%>
		<input type="button" value="앨범 등록" onclick="location.href = '/semi2/mypage/album-management/album-form.jsp'" class="<%=urlCheck==3?"bt_clicked" : "bt" %>">
		<%
		} else if (sdto.getMemberAccessType().equals("admin")) {
		%>
		<input type="button" value="아티스트 요청 처리" onclick="location.href = '/semi2/mypage/request/request-processing.jsp'" class="<%=urlCheck==4?"bt_clicked" : "bt" %>">
		<%
		}
		%>
	</div>
	<div class="footer-line"></div>