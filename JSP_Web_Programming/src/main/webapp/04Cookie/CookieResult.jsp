<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cookie</title>
		<!-- 
			날짜 : 2022/10/26
			이름 : 박종협
			내용 : JSP 웹 프로그래밍 04장 쿠키(Cookie)
		 -->
	</head>
	<body>
		<h2>쿠키 값 확인하기(쿠키가 생성된 이후의 페이지)</h2>
		<%
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie cookie : cookies){
				String cookieName = cookie.getName();
				String cookieValue = cookie.getValue();
				out.println(String.format("쿠키명 : %s - 쿠키값 : %s<br>", cookieName, cookieValue));
			}
		}
		
		%>
	</body>
</html>