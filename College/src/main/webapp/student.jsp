<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<StudentBean> student = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `student`");
		
		while(rs.next()){
			StudentBean sb = new StudentBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdName(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getInt(4));
			sb.setStdAddress(rs.getString(5));
			
			
			student.add(sb);
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
		<title>student::management</title>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(function(){
			
			$('.btnRegister').click(function(){
				$('section').show();
			});
			
			$('.btnClose').click(function(){
				$('section').hide();				
			});
			
			$('input[type=submit]').click(function(){
				
				let stdNo      = $('input[name=stdNo]').val();
				let stdName    = $('input[name=stdName]').val();
				let stdHp      = $('input[name=stdHp]').val();
				let stdYear    = $('input[name=stdYear]').val();
				let stdAddress = $('input[name=stdAddress]').val();
				
				let jsonData = {
						"lecNo":lecNo,
						"lecName":lecName,
						"lecCredit":lecCredit,
						"lecTime":lecTime,
						"lecClass":lecClass
				}
				
				$.ajax({
					url:'./proc/lectureProc.jsp',
					method:'post',
					data:jsonData,
					datatype:'json',
					success: function(data){
						
						if(data.result == 1){
							alert('등록 성공');
							let table = "<tr>";
							   table += "<td>"+lecNo+"</td>";
							   table += "<td>"+lecName+"</td>";
							   table += "<td>"+lecCredit+"</td>";
							   table += "<td>"+lecTime+"</td>";
							   table += "<td>"+lecClass+"</td>";
							   table += "</tr>";
							   
							$('.lecture').append(table);
						}else{
							alert('등록 실패');
						}
					}
				});
			});
			
			
		});
	
	</script>
	<body>
		<h3>학생관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h4>학생목록</h4>
				<button class="btnRegister">등록</button>
		<table border="1" class="lecture">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<% for(StudentBean sb : student) { %>
			<tr class="tr">
				<td><%= sb.getStdNo() %></td>
				<td><%= sb.getStdName() %></td>
				<td><%= sb.getStdHp() %></td>
				<td><%= sb.getStdHp() %></td>
				<td><%= sb.getStdAddress() %></td>
			</tr>
			<% } %>
		</table>
		<section style="display:none">
			<h4>학생등록</h4>
			<button class="btnClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo" placeholder=""></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName" placeholder=""></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp" placeholder=""></td>
				</tr>
				<tr>
					<td>학년</td>
					<td>
						<select class="select">
							<option value="1학년">1학년</option>
							<option value="2학년">2학년</option>
							<option value="3학년">3학년</option>
							<option value="4학년">4학년</option>
							<option value="5학년">5학년</option>
							<option value="6학년">6학년</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress" placeholder=""></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록">
					</td>
				</tr>
			</table>
		</section>
		
	</body>
</html>