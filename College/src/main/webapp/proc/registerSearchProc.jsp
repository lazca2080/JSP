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
	List<RegisterBean> register = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT `stdNo`, `stdName`, `lecName`, `lecNo`, `regMidScore`, `regFinalScore`, `regTotalScore`, `regGrade` ";
			  sql += "FROM `lecture` AS a ";
			  sql += "JOIN `register` AS b ";
			  sql += "ON a.lecNo = b.regLecNo ";
			  sql += "JOIN `student` AS c ";
			  sql += "ON b.regStdNo = c.stdNo ";
			  sql += "WHERE `stdNo` = ?";
		
	  	PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, stdNo);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			RegisterBean rb = new RegisterBean();
			rb.setStdNo(rs.getString(1));
			rb.setStdName(rs.getString(2));
			rb.setLecName(rs.getString(3));
			rb.setLecNo(rs.getInt(4));
			rb.setRegMidScore(rs.getInt(5));
			rb.setRegFinalScore(rs.getInt(6));
			rb.setRegTotalScore(rs.getInt(7));
			rb.setRegGrade(rs.getString(8));
			
			
			register.add(rb);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	Gson gson = new Gson();
	String result = gson.toJson(register);
	out.print(result);
	
%>