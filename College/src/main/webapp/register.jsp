<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.RegisterBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<RegisterBean> register = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `lecture`");
		
		while(rs.next()){
			RegisterBean rb = new RegisterBean();
			rb.setLecNo(rs.getInt(1));
			rb.setLecName(rs.getString(2));
			
			register.add(rb);
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
		<title>register::management</title>
		<!--
		날짜 : 2022/11/07
		이름 : 박종협
		내용 : 수행평가 
		 -->
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
			
			$('.search').click(function(){
				
				let stdNo = $('input[name=stdNo]').val();
				
				let jsonData = { "stdNo":stdNo }
				
				$.ajax({
					url:'./proc/registerSearchProc.jsp',
					method:'get',
					data:jsonData,
					datatype:'json',
					success: function(data){
						
						$(data).each(function(){
							
							let tags = "<tr>"
							   tags += "<td>"+this.stdNo+"</td>"
							   tags += "<td>"+this.stdName+"</td>"
							   tags += "<td>"+this.lecName+"</td>"
							   tags += "<td>"+this.lecNo+"</td>"
							   tags += "<td>"+this.regMidScore+"</td>"
							   tags += "<td>"+this.regFinalScore+"</td>"
							   tags += "<td>"+this.regTotalScore+"</td>"
							   tags += "<td>"+this.regGrade+"</td>"
							   tags += "</tr>"
							
							$('.register').append(tags);
						});
					}
				});
			});
			
			$('input[type=submit]').click(function(){
				
				let regStdNo = $('input[name=regStdNo]').val();
				let stdName = $('input[name=regStdName]').val();
				let lecNo = $('.select').val();
				
				let jsonData = {
						"regStdNo":regStdNo,
						"stdName":stdName,
						"lecNo":lecNo
				}
				
				$.ajax({
					url:'./proc/registerProc.jsp',
					method:'get',
					data:jsonData,
					datatype:'json',
					success: function(data){
						
						let tags = "<tr>";
						   tags += "<td>"+regStdNo+"</td>"
						   tags += "<td>"+StdName+"</td>"
						   tags += "<td>"+lecName+"</td>"
						   tags += "<td>"+lecNameNo+"</td>"
						   tags += "<td></td>"
						   tags += "<td></td>"
						   tags += "<td></td>"
						   tags += "<td></td>"
						   tags += "</tr>"
						   
						$('.register').append(tags);
					}
				});
			});
		});
	
	</script>
	<body>
		<h3>수강관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h4>수강현황</h4>
		<input type="text" name="stdNo" placeholder="">
		<input type="submit" value="검색" class="search">
		<input type="submit" value="수강신청" class="btnRegister">
		<table border="1" class="register">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
		</table>
		
		<section style="display:none">
			<h4>수강신청</h4>
			<button class="btnClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="regStdNo"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="regStdName"></td>
				</tr>
				<tr>
					<td>신청강좌</td>
					<td>
						<select class="select">
							<% for(RegisterBean rb : register) { %>
							<option value="<%= rb.getLecNo() %>"><%= rb.getLecName() %></option>
							<% } %>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="신청"></td>
				</tr>
			</table>
		
		</section>
		
	</body>
</html>