<%@page import="java.sql.ResultSet"%>
<%@page import="bean.User5Bean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	User5Bean u5b = null;
	
	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT * FROM `user5` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			u5b = new User5Bean();
			u5b.setUid(rs.getString(1));
			u5b.setName(rs.getString(2));
			u5b.setBirth(rs.getString(3));
			u5b.setGender(rs.getInt(4));
			u5b.setAge(rs.getInt(5));
			u5b.setAddr(rs.getString(6));
			u5b.setHp(rs.getString(7));
		}
		
		conn.close();
		psmt.close();
		rs.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::modift</title>
	</head>
	<body>
		<h3>user5 수정</h3>
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./list.jsp">user 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly="readonly" value="<%= u5b.getUid() %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= u5b.getName() %>"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="date" name="birth" value="<%= u5b.getBirth() %>"></td>
				</tr>
				
				<tr>
					<td>성별</td>
					<td>
						<label><input type="radio" name="gender" value="1">남</label>
						<label><input type="radio" name="gender" value="2">여</label>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value="<%= u5b.getAge() %>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= u5b.getAddr() %>"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= u5b.getHp() %>"></td>
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