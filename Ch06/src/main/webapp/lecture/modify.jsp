<%@page import="bean.lecture"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DB"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	lecture lc = null;
	
	String lecNo = request.getParameter("lecNo");
	
	try{
		Connection conn = DB.getInstance().getConnection();
		String sql = "SELECT INTO `lecture` WHERE `lecNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, lecNo);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			lc = new lecture();
			lc.setLecNo(rs.getString(1));
			lc.setLecName(rs.getString(2));
			lc.setLecCredit(rs.getInt(3));
			lc.setLecTime(rs.getInt(4));
			lc.setLecClass(rs.getString(5));
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
		<title>lecture::register</title>
	</head>
	<body>
		<h3>lecture 등록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./list.jsp">lecture 목록</a>
		<form action="./registerProc.jsp">
			<table border="1">
				<tr>
					<td>강의번호</td>
					<td>
						<input type="text" name="lecNo" placeholder="강의번호 입력">
					</td>
				</tr>
				<tr>
					<td>강의이름</td>
					<td>
						<input type="text" name="lecName" placeholder="강의이름 입력">
					</td>
				</tr>
				<tr>
					<td>학점</td>
					<td>
						<input type="number" name="lecCredit" placeholder="학점 입력">
					</td>
				</tr>
				<tr>
					<td>강의시간</td>	
					<td>
						<input type="text" name="lecTime" placeholder="강의시간 입력">
					</td>
				</tr>
				<tr>
					<td>강의실</td>
					<td>
						<input type="text" name="lecClass" placeholder="강의실 입력">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록하기">
					</td>
				</tr>
			
			</table>
		</form>
	</body>
</html>