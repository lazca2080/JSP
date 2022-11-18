<%@page import="bean.BookBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

	List<BookBean> books = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `book`");
		
		while(rs.next()){
 	BookBean book = new BookBean();
	book.setBookid(rs.getInt(1));
	book.setBookname(rs.getString(2));
	book.setPub(rs.getString(3));
	book.setPrice(rs.getInt(4));
	
	books.add(book);
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
		<title>book::list</title>
	</head>
	<body>
		<h3>도서목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">도서등록</a>
		
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<%
			for(BookBean book : books) {
			%>
			<tr>
				<td><%= book.getBookid() %></td>
				<td><%= book.getBookname() %></td>
				<td><%= book.getPub() %></td>
				<td><%= book.getPrice() %></td>
				<td>
					<a href="./modify.jsp?bookid=<%= book.getBookid() %>">수정</a>
					<a href="./delete.jsp?bookid=<%= book.getBookid() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>