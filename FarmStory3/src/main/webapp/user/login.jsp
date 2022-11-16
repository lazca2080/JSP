<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
%>
<%@ include file="/_header.jsp" %>
<script>
	let code = "<%= code %>";
	if(code == "100"){
		alert('로그인 정보가 맞지 않습니다.');
	}
</script>
<main id="user">
    <section class="login">
        <form action="/FarmStory3/user/proc/checkLoginProc.jsp" method="post">
            <table>
                <tr>
                    <td><img src="./img/login_ico_id.png" alt="아이디"></td>
                    <td><input type="text" name="uid" placeholder="아이디 입력"></td>
                </tr>
                <tr>
                    <td><img src="./img/login_ico_pw.png" alt="비밀번호"></td>
                    <td><input type="password" name="pass" placeholder="비밀번호 입력"></td>
                </tr>
            </table>
            <input type="submit" value="로그인" class="btn btnLogin">
        </form>
        <div>
            <h3>회원 로그인 안내</h3>
            <p>
                아직 회원이 아니시면 회원으로 가입하세요.
            </p>
            <a href="/FarmStory3/user/terms.jsp">회원가입</a>
        </div>
    </section>
</main>
<%@ include file="/_footer.jsp" %>