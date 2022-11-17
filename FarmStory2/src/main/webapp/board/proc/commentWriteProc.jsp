<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.FarmStory2.bean.ArticleBean"%>
<%@page import="kr.co.FarmStory2.dao.ArticleDAO"%>
<%@page import="kr.co.FarmStory2.dao.UserDAO"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid 	   = request.getParameter("uid");
	String content = request.getParameter("content");
	String cate    = request.getParameter("cate");
	String no  = request.getParameter("no");
	String regip   = request.getRemoteAddr();
	
	ArticleBean ab = new ArticleBean();
	ab.setUid(uid);
	ab.setContent(content);
	ab.setCate(cate);
	ab.setParent(no);
	ab.setRegip(regip);
	
	ArticleBean article = ArticleDAO.getInstance().insertComment(ab);
	
	JsonObject json = new JsonObject();
	json.addProperty("content", article.getContent());
	json.addProperty("nick", article.getNick());
	json.addProperty("rdate", article.getRdate().substring(2,10));
	out.print(json.toString());
%>