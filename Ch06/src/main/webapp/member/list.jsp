<%@page import="java.util.ArrayList"%>
<%@page import="bean.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String host = "jdbc:mysql://127.0.0.1:3306/java2db";
	String user = "root";
	String pass = "1234";
	
	List<Member> users = null;
	
	try{
		Connection conn = DriverManager.getConnection(host, user, pass);
		
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT * FROM `member`";
		ResultSet rs = stmt.executeQuery(sql);
		
		users = new ArrayList<>();
		while(rs.next()){
			Member mb = new Member();
			mb.setUid(rs.getString(1));
			mb.setName(rs.getString(2));
			mb.setHp(rs.getString(3));
			mb.setPos(rs.getString(4));
			mb.setDep(rs.getInt(5));
			mb.setRdate(rs.getString(6));
			
			users.add(mb);
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
		<title>member::list</title>
	</head>
	<body>
		<h3>member 목록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./register.jsp">member 등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>직급</th>
				<th>부서</th>
				<th>입사일</th>
				<th>관리</th>
			</tr>
			<%
			for(Member mb : users){
			%>
			<tr>
				<td><%= mb.getUid() %></td>
				<td><%= mb.getName() %></td>
				<td><%= mb.getHp() %></td>
				<td><%= mb.getPos() %></td>
				<td>
					<% switch(mb.getDep()){
						case 101:
							out.println("영업1부");
							break;
						case 102:
							out.println("영업2부");
							break;
						case 103:
							out.println("영업3부");
							break;
						case 104:
							out.println("영업4부");
							break;
						case 105:
							out.println("영업지원");
							break;
					}
					%>
				</td>
				<td><%= mb.getRdate().substring(2, 10) %></td>
				<td>
					<a href="./modify.jsp?uid=<%= mb.getUid()%>">수정</a>
					<a href="./delete.jsp?uid=<%= mb.getUid()%>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>