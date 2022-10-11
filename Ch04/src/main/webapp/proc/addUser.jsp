<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="ub" class="bean.userBean">
	<jsp:setProperty property="id" name="ub"/> 
	<jsp:setProperty property="pw" name="ub"/> 
	<jsp:setProperty property="name" name="ub"/> 
	<jsp:setProperty property="birth" name="ub"/> 
	<jsp:setProperty property="gender" name="ub"/> 
	<jsp:setProperty property="addr" name="ub"/> 
	<jsp:setProperty property="hobby" name="ub"/> 
</jsp:useBean>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addUser</title>
	</head>
	<body>
		<h3>회원가입 사용자 출력</h3>
		<p>
			아이디 : <%= ub.getId() %><br/>
			비밀번호 : <%= ub.getPw() %><br/>
			이름 : <%= ub.getName() %><br/>
			생년월일 : <%= ub.getBirth() %><br/>
			성별 :
			<%= ub.getGender() == 1 ? "남자" : "여자" %><br/>
			<% 
				if(ub.getGender() == 1){
					out.println("남자");
				}else{
					out.println("여자");
				}
			%><br/> 	
			주소 : <%= ub.getAddr() %><br/>
			취미 : 
			<%= String.join(",", ub.getHobby()) %><br/>
			<% 
				for(String hobby : ub.getHobby()){
					out.println(hobby + "");
				}
			%><br/>
		</p>
	</body>
</html>