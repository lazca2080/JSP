<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	let success = '${success}';
	
	if(success == 100){
		alert('로그인 실패!');
	}else if(success == 101){
		alert('세션이 초기화되었습니다.\n다시 로그인해주세요');
	}else if(success == 102){
		alert('먼저 로그인을 하셔야 합니다.');
	}else if(success == 105){
		alert('탈퇴 완료하였습니다. \n 그동안 이용해주셔서 감사합니다.');
	}
	
</script>
<main id="user">
    <section class="login">
        <form action="/Jboard2/user/login.do" method="post">
            <table border="0">
                <tr>
                    <td><img src="/Jboard2/img/login_ico_id.png" alt="아이디"/></td>
                    <td><input type="text" name="uid" placeholder="아이디 입력"/></td>
                </tr>
                <tr>
                    <td><img src="/Jboard2/img/login_ico_pw.png" alt="비밀번호"/></td>
                    <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
                </tr>
            </table>
            <input type="submit" value="로그인" class="btnLogin"/>
            <label><input type="checkbox" name="auto">자동 로그인</label>
        </form>
        <div>
            <h3>회원 로그인 안내</h3>
            <p>
                아직 회원이 아니시면 회원으로 가입하세요.
            </p>
            <div style="text-align: right;">
                <a href="/Jboard2/user/findId.do">아이디 |</a>
                <a href="/Jboard2/user/findPw.do">비밀번호찾기 |</a>
                <a href="/Jboard2/user/terms.do">회원가입</a>
            </div>                    
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>