<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid  = request.getParameter("uid");
	String pass = request.getParameter("pass");

	UserBean ub = UserDAO.getInstance().selectUsers(uid, pass);
	
	if(ub != null){
		// 회원이 맞을 경우
		
		// 세션처리
		session.setAttribute("sessUser", ub);
		
		// 리다이렉트
		response.sendRedirect("/Jboard1/list.jsp");
	}else{
		// 회원이 아닐 경우
		response.sendRedirect("/Jboard1/user/login.jsp?success=100");
	}

%>