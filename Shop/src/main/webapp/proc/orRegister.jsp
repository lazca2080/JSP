<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String prodno  = request.getParameter("prodno");
	String orcount = request.getParameter("orcount");
	String orid    = request.getParameter("orid");
	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "INSERT INTO `order` (`orderProduct`,`orderCount`,`orderId`,`orderdate`) VALUES (?,?,?,NOW())";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, prodno);
		psmt.setString(2, orcount);
		psmt.setString(3, orid);

		result = psmt.executeUpdate();
		
		conn.close();
		psmt.close();
	
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	String jsondata = json.toString();
	out.print(jsondata);

%>