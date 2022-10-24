<%@page import="config.DB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	StudentBean sb = null;
	
	try{
		Connection conn = DB.getInstance().getConnection();
		
		String sql = "SELECT * FROM `student` WHERE `stdNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, no);
		
		ResultSet rs = psmt.executeQuery();
	
	if(rs.next()){
		sb = new StudentBean();
		sb.setNo(rs.getString(1));
		sb.setName(rs.getString(2));
		sb.setHp(rs.getString(3));
		sb.setYear(rs.getInt(4));
		sb.setAddr(rs.getString(5));
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
		<title>student::modify</title>
	</head>
	<body>
		<h3>Student 수정</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./list.jsp">Student 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="no" readonly="readonly" value="<%= sb.getNo() %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= sb.getName() %>"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= sb.getHp() %>"></td>
				</tr>
				<tr>
					<td>학년</td>
					<td><input type="number" name="year" value="<%= sb.getYear() %>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= sb.getAddr() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기">
					</td>
				</tr>
			
			</table>
		
		</form>
	</body>
</html>