<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="Bean.RegisterBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdNo = request.getParameter("stdNo");
	RegisterBean rb = null;
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT * FROM `student` WHERE `stdNo`=?";
		
	  	PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, stdNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			rb = new RegisterBean();
			rb.setStdName(rs.getString(2));
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("stdName", rb.getStdName());
	out.print(json.toString());
%>