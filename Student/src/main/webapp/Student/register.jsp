<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Student::register</title>
	</head>
	<body>
		<h3>학생등록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">학생목록</a>
		
		<form action="./registerProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="no" placeholder=""></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" placeholder=""></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" placeholder=""></td>
				</tr>
				<tr>
					<td>학년</td>
					<td><input type="number" name="year" placeholder=""></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" placeholder=""></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>