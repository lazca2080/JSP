<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.FarmStory2.dao.UserDAO"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	
	int result = UserDAO.INSTANCE.selectUid(uid);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>