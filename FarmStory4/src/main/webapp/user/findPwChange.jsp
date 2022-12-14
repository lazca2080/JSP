<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../_header.jsp"/>
<main id="user">
    <section class="find findPwChange">
        <form action="#">
            <table border="0">
                <caption>비밀번호 변경</caption>                        
                <tr>
                    <td>아이디</td>
                    <td>sdfsdfsdf</td>
                </tr>
                <tr>
                    <td>새 비밀번호</td>
                    <td>
                        <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                        <span class="resultPass"></span>
                    </td>
                </tr>
                <tr>
                    <td>새 비밀번호 확인</td>
                    <td>
                        <input type="password" name="pass2" placeholder="새 비밀번호 입력"/>
                    </td>
                </tr>
            </table>                                        
        </form>
        
        <p>
            비밀번호를 변경해 주세요.<br>
            영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
        </p>

        <div>
            <a href="/Jboard2/user/login.do" class="btn btnCancel">취소</a>
            <a href="/Jboard2/user/login.do" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="../_footer.jsp"/>