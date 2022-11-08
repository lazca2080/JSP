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
			
			
			// 수강신청버튼
			$('.btnRegister').click(function(){
				
				let stdNo = $('input[name=stdNo]').val();
				
				if(stdNo != ""){
					
					$('section').show();
					
					$('input[name=regStdNo]').val(stdNo);
					
					let jsonData = { "stdNo":stdNo }
					
					$.ajax({
						url:'./proc/registerNameProc.jsp',
						method:'get',
						data:jsonData,
						datatype:'json',
						success: function(data){
							
							$('input[name=regStdName]').val(data.stdName);
						}
					});
				}else{
					alert('학번을 입력하세요');
				}
			});
			
			// 닫기버튼
			$('.btnClose').click(function(){
				$('section').hide();				
			});
			
			$('.search').click(function(){
				
				let stdNo = $('input[name=stdNo]').val();
				
				if(stdNo != ""){
					let jsonData = { "stdNo":stdNo }
					
					$('.tr').hide();
					$('section').hide();
					
					$.ajax({
						url:'./proc/registerSearchProc.jsp',
						method:'get',
						data:jsonData,
						datatype:'json',
						success: function(data){
							
							if(data != ""){
								$(data).each(function(){
									
									let tags = "<tr class='tr'>"
									   tags += "<td>"+this.stdNo+"</td>"
									   tags += "<td>"+this.stdName+"</td>"
									   tags += "<td>"+this.lecName+"</td>"
									   tags += "<td>"+this.lecNo+"</td>"
									   tags += "<td>"+this.regMidScore+"</td>"
									   tags += "<td>"+this.regFinalScore+"</td>"
									   tags += "<td>"+this.regTotalScore+"</td>"
									   tags += "<td>"+this.regGrade+"</td>"
									   tags += "<td><input type='submit' value='관리' class='manage'></td>"
									   tags += "</tr>"
										
									$('.register').append(tags);									

								});
							}else{
								alert('검색된 수강목록이 없습니다. 수강신청을 하세요');
							}
							

						}
					});
				}else{
					alert('학번을 입력하세요');
				}
				

			});
			
			// 신청버튼
			$('#reg').click(function(){
				
				let regStdNo = $('input[name=regStdNo]').val();
				let stdName = $('input[name=regStdName]').val();
				let lecNo = $('.select').val();
				
				let jsonData = {
						"regStdNo":regStdNo,
						"stdName":stdName,
						"lecNo":lecNo
				}
				
				$('.tr').hide();
				
				$.ajax({
					url:'./proc/registerProc.jsp',
					method:'get',
					data:jsonData,
					datatype:'json',
					success: function(data){
						
						$(data).each(function(){
							
							let tags = "<tr class='tr'>"
							   tags += "<td>"+this.stdNo+"</td>"
							   tags += "<td>"+this.stdName+"</td>"
							   tags += "<td>"+this.lecName+"</td>"
							   tags += "<td>"+this.lecNo+"</td>"
							   tags += "<td>"+this.regMidScore+"</td>"
							   tags += "<td>"+this.regFinalScore+"</td>"
							   tags += "<td>"+this.regTotalScore+"</td>"
							   tags += "<td>"+this.regGrade+"</td>"
							   tags += "<td><input type='submit' value='관리' class='manage'></td>"
							   tags += "</tr>"
							
							$('.register').append(tags);
						});
					}
				});
			});
			
			// 관리버튼
			$(document).on('click', '.manage', function(){
				
				
				
			});
			
			
		});
	
	</script>
	<body>
		<h3>수강관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h4>수강현황</h4>
		<input type="text" name="stdNo" placeholder="학번을 입력하세요">
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
				<th>관리</th>
			</tr>
		</table>
		
		<section style="display:none">
			<h4>수강신청</h4>
			<button class="btnClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="regStdNo" readonly="readonly"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="regStdName" readonly="readonly"></td>
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
					<td colspan="2" align="right"><input type="submit" value="신청" id="reg"></td>
				</tr>
			</table>
		
		</section>
		
	</body>
</html>