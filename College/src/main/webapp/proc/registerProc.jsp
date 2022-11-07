<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.RegisterBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String regStdNo = request.getParameter("regStdNo");
	String stdName  = request.getParameter("stdName");
	String lecNo  = request.getParameter("lecNo");
	RegisterBean rb = null;
	
	try{
		Connection conn = DBCP.getConnection();
		
		conn.setAutoCommit(false);
		String sql1 = "INSERT INTO `student` (`stdNo`,`stdName`) VALUES (?,?)";
		String sql2 = "INSERT INTO `register` (`regStdNo`,`regLecNo`) VALUES (?,?)";
		PreparedStatement psmt1 = conn.prepareStatement(sql1);
		psmt1.setString(1, regStdNo);
		psmt1.setString(2, stdName);
		PreparedStatement psmt2 = conn.prepareStatement(sql2);
		psmt2.setString(1, regStdNo);
		psmt2.setString(2, lecNo);
		Statement stmt = conn.createStatement();
		String sql3 = "SELECT `stdNo`, `stdName`, `lecName`, `lecNo`, `regMidScore`, `regFinalScore`, `regTotalScore`, `regGrade` ";
			  sql3 += "FROM `lecture` AS a ";
			  sql3 += "JOIN `register` AS b ";
			  sql3 += "ON a.lecNo = b.regLecNo ";
			  sql3 += "JOIN `student` AS c ";
			  sql3 += "ON b.regStdNo = c.stdNo";
		ResultSet rs = stmt.executeQuery(sql3);
		
		if(rs.next()){
			rb = new RegisterBean();
			rb.setStdNo(rs.getString(1));
			rb.setStdName(rs.getString(2));
			rb.setLecName(rs.getString(3));
			rb.setLecNo(rs.getInt(4));
			rb.setRegMidScore(rs.getInt(5));
			rb.setRegFinalScore(rs.getInt(6));
			rb.setRegTotalScore(rs.getInt(7));
			rb.setRegGrade(rs.getString(8));
		}
		
		psmt1.executeUpdate();
		psmt2.executeUpdate();
		
		conn.commit();
		
		conn.close();
		psmt1.close();
		psmt2.close();
		stmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	Gson gson = new Gson();
	String result = gson.toJson(rb);
	out.print(result);
%>