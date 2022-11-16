<%@page import="com.google.gson.JsonObject"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String nick = request.getParameter("nick");
	
	int result = UserDAO.getinstance().checkNick(nick);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
	
%>