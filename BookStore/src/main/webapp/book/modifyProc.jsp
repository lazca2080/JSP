<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bean.BookBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookid   = request.getParameter("bookid");
	String bookname = request.getParameter("bookname");
	String pub      = request.getParameter("pub");
	String price    = request.getParameter("price");
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "UPDATE `book` SET `bookname`=?, `publisher`=?, `price`=? WHERE `bookid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookname);
		psmt.setString(2, pub);
		psmt.setString(3, price);
		psmt.setString(4, bookid);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
				
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
