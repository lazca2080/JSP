<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user2 manager</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script src="./js/list.js"></script>
		<script src="./js/register.js"></script>
		<script src="./js/btnregister.js"></script>
		<script src="./js/modify.js"></script>
		<script src="./js/btnmodify.js"></script>
		
		<script>
			$(document).ready(function(){
				
				
				// user2 목록 불러오기
				list();
				
				// user2 목록화면 동적 연결 이벤트
				$(document).on('click', '#userList', function(e){
					e.preventDefault();
					list();
				});
				
				// user2 등록화면
				$(document).on('click', '#userAdd', function(e){
					e.preventDefault();
					register();
				});
				
				// user2 등록하기
				$(document).on('click', '#btnRegister', function(e){
					e.preventDefault();
					btnregister();
				});
				
				
				// user2 수정화면
				$(document).on('click', '#modify', function(e){
					e.preventDefault();
					let users = $('#users > td');
					modify(users);			
				});
				
				// user2 수정하기
				$(document).on('click', '#btnmodify', function(e){
					e.preventDefault();
					btnmodify();
				});
				
				// user2 삭제하기
				$(document).on('click', '#delete', function(e){
					e.preventDefault();
					
					
				});
			});
		</script>
	</head>
	<body>
		<h3>user2 관리자</h3>
		
		<nav></nav>
		<section></section>
		
	</body>
</html>