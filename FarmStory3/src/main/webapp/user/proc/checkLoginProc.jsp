<%@page import="bean.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDAO.getinstance().checkLogin(uid, pass);
	
	if(ub != null){
		session.setAttribute("sess", ub);
		
		response.sendRedirect("/FarmStory3/");
	}else{
		response.sendRedirect("/FarmStory3/user/login.jsp?code=100");
	}

%>