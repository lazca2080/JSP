<%@page import="com.google.gson.JsonObject"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	
	int result = UserDAO.getinstance().checkUid(uid);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
	
%>