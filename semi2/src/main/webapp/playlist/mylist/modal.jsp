<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	function openModal(targetType, targetId) {
		const iframe = document.getElementById('playlistIframe');
		iframe.src = '/semi2/playlist/mylist/popup-list.jsp?' + targetType + '=' + targetId;
		document.getElementById('myModal').style.display = 'block';
	}

	function closeModal() {
		document.getElementById('myModal').style.display = 'none';
		document.getElementById('playlistIframe').src = ''; // iframe 초기화
	}

	// 모달 바깥 클릭 시 닫기
	window.onclick = function(event) {
		const modal = document.getElementById("myModal");
		if (event.target === modal) {
			closeModal();
		}
	}
</script>

<style>
/* 모달 배경 */
.modal {
	display: none;
	position: fixed;
	z-index: 999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

/* 모달 박스 */
.modal-content {
	background-color: #fff;
	margin: 5% auto;
	border-radius: 10px;
	width: 500px;
	height: 600px;
	position: relative;
}

/* 닫기 버튼 */
.close {
	position: absolute;
	right: 15px;
	top: 10px;
	font-size: 25px;
	font-weight: bold;
	cursor: pointer;
	z-index: 1000;
}

/* iframe 스타일 */
.modal-iframe {
	width: 100%;
	height: 100%;
	border: none;
	border-radius: 10px;
}
</style>


<div id="myModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeModal()">×</span>

		<!-- iframe으로 JSP 페이지를 삽입 -->
		<iframe class="modal-iframe" id="playlistIframe" src=""></iframe>
	</div>
</div>