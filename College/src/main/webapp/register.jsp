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
					
					let jsonData = { "stdNo":stdNo }
					
					$.ajax({
						url:'./proc/registerNameProc.jsp',
						method:'get',
						data:jsonData,
						datatype:'json',
						success: function(data){
							
							if(data.stdName == "a"){
								alert('등록된 학생이 아닙니다.');
								$('section').hide();
								$('.tr').hide();
							}else{
								$('section').show();
								$('input[name=regStdName]').val(data.stdName);
								$('input[name=regStdNo]').val(stdNo);
							}
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
			
			// 검색버튼
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
									   tags += "<td><p class='midscore' contenteditable='false'>"+this.regMidScore+"</p></td>"
									   tags += "<td><p class='finalscore' contenteditable='false'>"+this.regFinalScore+"</p></td>"
									   tags += "<td><p class='totalscore' contenteditable='false'>"+this.regTotalScore+"</p></td>"
									   tags += "<td><p class='grade' contenteditable='false'>"+this.regGrade+"</p></td>"
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
							   tags += "<td><p class='midscore' contenteditable='false'>"+this.regMidScore+"</p></td>"
							   tags += "<td><p class='finalscore' contenteditable='false'>"+this.regFinalScore+"</p></td>"
							   tags += "<td><p class='totalscore' contenteditable='false'>"+this.regTotalScore+"</p></td>"
							   tags += "<td><p class='grade' contenteditable='false'>"+this.regGrade+"</p></td>"
							   tags += "<td><input type='submit' value='관리' class='manage'></td>"
							   tags += "</tr>"
							
							$('.register').append(tags);
						});
					}
				});
			});
			
			// 관리버튼
			$(document).on('click', '.manage', function(){
				
				let mod = $(this);
				mod1 = mod.val();
				let p = $(this).parent().parent().children('td').children('p');
				
				if(mod1 == "관리"){
					
					mod.val('수정');
					p.focus();
					p.attr('contenteditable', true);
					
				}else{
					
					let stdno = $(this).parent().parent().children('td:eq(0)');
					let lecno = $(this).parent().parent().children('td:eq(3)');
					let midscore = $(this).parent().parent().children('td').children('.midscore');
					let finalscore = $(this).parent().parent().children('td').children('.finalscore');
					let totalscore = $(this).parent().parent().children('td').children('.totalscore');
					let grade = $(this).parent().parent().children('td').children('.grade');
					
					let jsonData = {
							"stdno":stdno.text(),
							"lecno":lecno.text(),
							"midscore":midscore.text(),
							"finalscore":finalscore.text(),
							"totalscore":totalscore.text(),
							"grade":grade.text()
					};
					
					
					$.ajax({
						url:'./proc/registerModifyProc.jsp',
						method:'post',
						data:jsonData,
						datatype:'json',
						success: function(data){
							
							if(data.result == 1){
								
								alert('수정 성공!');
								mod.val('관리');
								p.attr('contenteditable', false);
								
								stdno.text(stdno.text());
								lecno.text(lecno.text());
								midscore.text(midscore.text());
								finalscore.text(finalscore.text());
								totalscore.text(totalscore.text());
								grade.text(grade.text());
								
							}else{
								alert('수정 실패!');
							}
						}
					});
				}
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