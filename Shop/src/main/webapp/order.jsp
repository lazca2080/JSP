<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.OrderBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	List<OrderBean> order = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		Statement stmt = conn.createStatement();
		String sql = "SELECT `orderNo`, b.`name`,`prodName`,`orderCount`,`orderDate` ";
			  sql += "FROM `order` AS a JOIN `customer` AS b ON a.orderId = b.custId ";
			  sql += "JOIN `product` AS c ON a.orderProduct = c.prodNo";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			OrderBean ob = new OrderBean();
			ob.setOdno(rs.getString(1));
			ob.setOdid(rs.getString(2));
			ob.setOdproduct(rs.getString(3));
			ob.setOdcount(rs.getString(4));
			ob.setOddate(rs.getString(5));
			
			order.add(ob);
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
		<title>order::list</title>
		<!-- 
			날짜 : 2022/10/25
			이름 : 박종협
			내용 : SQL 응용 수행평가
		 -->
	</head>
	<body>
		<h3>주문목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<% for(OrderBean ob : order) { %>
			<tr>
				<td><%= ob.getOdno() %></td>
				<td><%= ob.getOdid() %></td>
				<td><%= ob.getOdproduct() %></td>
				<td><%= ob.getOdcount() %></td>
				<td><%= ob.getOddate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>