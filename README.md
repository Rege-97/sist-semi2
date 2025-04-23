# sist-semi2
# git clone 후 이클립스 워크스페이스 만들고 프로젝트 임포트 후 프로젝트 프로퍼티에서 프로젝트 파셋츠 들어가서 다이나믹 웹 모듈, 자바, 자바스크립트 체크 후 다이나믹 웹 모듈은 4.0, 자바는 11, 자바스크립트 1.0으로 세팅 후 어플라이 하고 서버에  모듈 추가
# apache-tomcat-9.0.100 - 원본 톰캣 포트 번호 변경 필요 
# 톰캣 폴더 - conf - server.xml 에서 포트번호 9090으로 변경 필요
# <Connector port="9090" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" maxParameterCount="1000" URIEncoding="UTF-8"/>