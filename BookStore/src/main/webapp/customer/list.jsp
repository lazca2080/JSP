<%@page import="bean.CustomerBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	
	List<CustomerBean> customers = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
		
		while(rs.next()){
			CustomerBean cus = new CustomerBean();
			cus.setCustid(rs.getString(1));
			cus.setName(rs.getString(2));
			cus.setAddr(rs.getString(3));
			cus.setHp(rs.getString(4));
			
			customers.add(cus);
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
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">고객등록</a>
		
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<% for(CustomerBean cus : customers) { %>
			<tr>
				<td><%= cus.getCustid() %></td>
				<td><%= cus.getName() %></td>
				<td><%= cus.getAddr() %></td>
				<td><%= cus.getHp() %></td>
				<td>
					<a href="./modify.jsp?custid=<%= cus.getCustid() %>">수정</a>
					<a href="./delete.jsp?custid=<%= cus.getCustid() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		
		</table>
	</body>
</html>