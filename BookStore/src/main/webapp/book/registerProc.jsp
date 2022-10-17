<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name  = request.getParameter("bookname");
	String pub   = request.getParameter("pub");
	String price = request.getParameter("price");

	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "INSERT INTO `book` (`bookname`, `publisher`, `price`) VALUES(?, ?, ?)";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setString(2, pub);
		psmt.setString(3, price);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>