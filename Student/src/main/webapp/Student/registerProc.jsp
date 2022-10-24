<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String year = request.getParameter("year");
	String addr = request.getParameter("addr");
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "INSERT INTO `student` VALUES(?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, no);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, year);
		psmt.setString(5, addr);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}

	response.sendRedirect("./list.jsp");
%>