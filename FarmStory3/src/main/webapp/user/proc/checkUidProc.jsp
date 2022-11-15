<%@page import="dao.UserDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	
	UserDAO.getinstance().checkNick(uid);
	
%>