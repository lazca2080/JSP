<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custid = request.getParameter("custid");
	String name   = request.getParameter("name");
	String addr   = request.getParameter("addr");
	String hp 	  = request.getParameter("hp");
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "UPDATE `customer` SET `name`=?,`address`=?,`phone`=? WHERE `custId`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setString(2, addr);
		psmt.setString(3, hp);
		psmt.setString(4, custid);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
				
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
