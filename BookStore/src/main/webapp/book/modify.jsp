<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bean.BookBean"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	String bookid = request.getParameter("bookid");
	BookBean book = null;
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT * FROM `book` WHERE `bookid`=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookid);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			book = new BookBean();
			book.setBookid(rs.getInt(1));
			book.setBookname(rs.getString(2));
			book.setPub(rs.getString(3));
			book.setPrice(rs.getInt(4));
		}
		
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">도서목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="text" name="bookid" readonly="readonly" value="<%= book.getBookid() %>"></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookname" value="<%= book.getBookname() %>"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="pub" value="<%= book.getPub() %>"></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" value="<%= book.getPrice() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>