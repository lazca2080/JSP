<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Book::List</title>
	</head>
	<body>
		<h3>도서목록</h3>
		<a href="/Bookstore2/">처음으로</a>
		<a href="/Bookstore2/book/register.do">도서등록</a>
		
		<table border="1">
			<tr>
				<th>도서번호</th>			
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<c:forEach var="books" items="${requestScope.books}">
			<tr>
				<td>${books.id}</td>			
				<td>${books.name}</td>			
				<td>${books.pub}</td>			
				<td>${books.price}</td>			
				<td>
					<a href="/Bookstore2/book/modify.do?id=${books.id}">수정</a>
					<a href="/Bookstore2/book/delete.do?id=${books.id}">삭제</a>
				</td>			
			</tr>
			</c:forEach>
		</table>
		
	</body>
</html>