<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.FarmStory2.bean.ArticleBean"%>
<%@page import="kr.co.FarmStory2.dao.ArticleDAO"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String no    = request.getParameter("no");
	String cate  = request.getParameter("cate");
	String group = request.getParameter("group");
	
	List<ArticleBean> articles = ArticleDAO.getInstance().selectCommentList(no, cate);
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(articles);
	out.print(jsonData);
%>