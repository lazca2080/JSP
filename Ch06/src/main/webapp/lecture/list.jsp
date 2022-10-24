<%@page import="config.DB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.lecture"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	List<lecture> lectures = null;
	
	try{
		Connection conn = DB.getInstance().getConnection();
		
		String sql = "SELECT * FROM `lecture`";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		lectures = new ArrayList<>();
		while(rs.next()){
			lecture lc = new lecture();
			lc.setLecNo(rs.getString(1));
			lc.setLecName(rs.getString(2));
			lc.setLecCredit(rs.getInt(3));
			lc.setLecTime(rs.getInt(4));
			lc.setLecClass(rs.getString(5));
			
			lectures.add(lc);
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
		<title>lecture::list</title>
	</head>
	<body>
		<h3>lecture 목록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./register.jsp">lecture 등록</a>
		
		<table border="1">
			<tr>
				<th>강의번호</th>
				<th>강의이름</th>
				<th>학점</th>
				<th>강의시간</th>
				<th>강의실</th>
				<th>관리</th>
			</tr>
			<% for(lecture lc : lectures) { %>
			<tr>
				<td><%= lc.getLecNo() %></td>
				<td><%= lc.getLecName() %></td>
				<td><%= lc.getLecCredit() %></td>
				<td><%= lc.getLecTime() %></td>
				<td><%= lc.getLecClass() %></td>
				<td>
					<a href="./modify.jsp?lecNo=<%= lc.getLecNo() %>">수정</a>
					<a href="#">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
			
	</body>
</html>