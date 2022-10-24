<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookid = request.getParameter("bookid");
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "DELETE FROM `book` WHERE `bookid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookid);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
				
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>