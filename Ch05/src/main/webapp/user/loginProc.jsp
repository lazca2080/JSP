<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id 	= request.getParameter("id");
	String pw 	= request.getParameter("pw");
	String auto = request.getParameter("auto");

	if(pw.equals("1234")){
		// 회원 맞음
		
		// 자동 로그인 여부 확인
		if(auto != null){
			Cookie cookie = new Cookie("cid", id);
			cookie.setMaxAge(60*3);
			response.addCookie(cookie);
		}
		
		session.setAttribute("sessid", id);
		response.sendRedirect("./loginSuccess.jsp");				
		
	}else{
		// 회원 아님
		response.sendRedirect("./login.jsp");
	}
%>