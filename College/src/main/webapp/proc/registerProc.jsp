<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
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
	List<RegisterBean> register = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		conn.setAutoCommit(false);
		String sql = "INSERT INTO `register` (`regStdNo`,`regLecNo`) VALUES (?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, regStdNo);
		psmt.setString(2, lecNo);
		
		String sql3 = "SELECT `stdNo`, `stdName`, `lecName`, `lecNo`, `regMidScore`, `regFinalScore`, `regTotalScore`, `regGrade` ";
			  sql3 += "FROM `lecture` AS a ";
			  sql3 += "JOIN `register` AS b ";
			  sql3 += "ON a.lecNo = b.regLecNo ";
			  sql3 += "JOIN `student` AS c ";
			  sql3 += "ON b.regStdNo = c.stdNo ";
			  sql3 += "WHERE `regStdNo`=?";
	    PreparedStatement psmt3 = conn.prepareStatement(sql3);
	    psmt3.setString(1, regStdNo);
	    psmt.executeUpdate();
		ResultSet rs = psmt3.executeQuery();
		
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
		
		
		conn.commit();
		
		conn.close();
		psmt.close();
		psmt3.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	Gson gson = new Gson();
	String result = gson.toJson(register);
	out.print(result);
%>