<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="bean.User5Bean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	List<User5Bean> users = null;	

	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT * FROM `user5`";
		Statement psmt = conn.createStatement();
		
		ResultSet rs = psmt.executeQuery(sql);
		
		users = new ArrayList<>();
		
		while(rs.next()){
			User5Bean u5b = new User5Bean();
			u5b.setUid(rs.getString(1));
			u5b.setName(rs.getString(2));
			u5b.setBirth(rs.getString(3));
			u5b.setGender(rs.getInt(4));
			u5b.setAge(rs.getInt(5));
			u5b.setAddr(rs.getString(6));
			u5b.setHp(rs.getString(7));
	
			users.add(u5b);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::list</title>
	</head>
	<body>
		<h3>user5 목록</h3>
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./register.jsp">등록하기</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생일</th>
				<th>성별</th>
				<th>나이</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<%
			for(User5Bean u5b : users) {
			%>
			<tr>
				<td><%= u5b.getUid() %></td>
				<td><%= u5b.getName() %></td>
				<td><%= u5b.getBirth() %></td>
				<td><%= u5b.getGender() == 1? "남":"여" %></td>
				<td><%= u5b.getAge() %></td>
				<td><%= u5b.getAddr() %></td>
				<td><%= u5b.getHp() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= u5b.getUid() %>">수정</a>
					<a href="./delete.jsp?uid=<%= u5b.getUid() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>