<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	List<CustomerBean> customer = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
		
		while(rs.next()){
			CustomerBean cb = new CustomerBean();
			cb.setCuuid(rs.getString(1));
			cb.setCuname(rs.getString(2));
			cb.setCuhp(rs.getString(3));
			cb.setCuaddr(rs.getString(4));
			cb.setCurdate(rs.getString(5));
			
			customer.add(cb);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::list</title>
		<!-- 
			날짜 : 2022/10/25
			이름 : 박종협
			내용 : SQL 응용 수행평가
		 -->
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>주소</th>
				<th>가입일</th>
			</tr>
			<% for(CustomerBean cb : customer){ %>
			<tr>
				<td><%= cb.getCuuid() %></td>
				<td><%= cb.getCuname() %></td>
				<td><%= cb.getCuhp() %></td>
				<td><%= cb.getCuaddr() %></td>
				<td><%= cb.getCurdate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>