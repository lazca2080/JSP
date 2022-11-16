<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.FarmStory2.bean.ArticleBean"%>
<%@page import="kr.co.FarmStory2.dao.ArticleDAO"%>
<%@page import="kr.co.FarmStory2.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String content = request.getParameter("content");
	String cate = request.getParameter("cate");
	String parent = request.getParameter("parent");
	String regip = request.getRemoteAddr();
	
	ArticleBean ab = new ArticleBean();
	ab.setUid(uid);
	ab.setCate(cate);
	ab.setRegip(regip);
	ab.setParent(parent);
	ab.setContent(content);
	
	int result = ArticleDAO.getInstance().insertComment(ab);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>