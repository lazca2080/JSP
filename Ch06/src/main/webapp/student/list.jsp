<%@page import="java.util.ArrayList"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DB"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 데이터베이스 작업
	
	request.setCharacterEncoding("UTF-8");
	List<StudentBean> sbs = null;
	
	try{
		Connection conn = DB.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT * FROM `student`";
		ResultSet rs = stmt.executeQuery(sql);
		
		sbs = new ArrayList<>();
		while(rs.next()){
			StudentBean sb = new StudentBean();
			sb.setNo(rs.getString(1));
			sb.setName(rs.getString(2));
			sb.setHp(rs.getString(3));
			sb.setYear(rs.getInt(4));
			sb.setAddr(rs.getString(5));
			
			sbs.add(sb);
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
		<title>student::list</title>
	</head>
	<body>
		<h3>Student 목록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./register.jsp">Student 등록</a>
		
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
				<th>관리</th>
			</tr>
			<% for(StudentBean sb : sbs) { %>
			<tr>
				<td><%= sb.getNo() %></td>
				<td><%= sb.getName() %></td>
				<td><%= sb.getHp() %></td>
				<td><%= sb.getYear() %></td>
				<td><%= sb.getAddr() %></td>
				<td>
					<a href="./modify.jsp?no=<%= sb.getNo() %>">수정</a>
					<a href="./delete.jsp?no=<%= sb.getNo() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>