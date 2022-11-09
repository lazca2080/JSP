<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdno 	  = request.getParameter("stdno");
	String lecno      = request.getParameter("lecno");
	String midscore   = request.getParameter("midscore");
	String finalscore = request.getParameter("finalscore");
	String totalscore = request.getParameter("totalscore");
	String grade      = request.getParameter("grade");
	
	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "UPDATE `register` SET `regMidScore`=?, `regFinalScore`=?, `regTotalScore`=?, `regGrade`=? WHERE `regStdNo`=?&&`regLecNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, midscore);
		psmt.setString(2, finalscore);
		psmt.setString(3, totalscore);
		psmt.setString(4, grade);
		psmt.setString(5, stdno);
		psmt.setString(6, lecno);
		
		result = psmt.executeUpdate();
		
		psmt.close();
		conn.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>