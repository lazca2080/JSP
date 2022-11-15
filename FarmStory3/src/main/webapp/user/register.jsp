<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<script>
	$(function(){
		
		// 데이터 검증에 사용되는 정규 표현식
		let reUid   = /^[a-z]+[a-z0-9]{5,19}$/g;
		let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
		let reName  = /^[가-힣]+$/;
		let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
		let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;
		
		// 최종 상태 변수
		let isUidOk   = false;
		let isPass1Ok = false;
		let isPass2Ok = false;
		let isNameOk  = false;
		let isNickOk  = false;
		let isEmailOk = false;
		let isHpOk 	  = false;
		
		// 데이터 검증
		
		$('#btnIdCheck').click(function(){
			
			let uid = $('input[name=uid]').val();
			
			if(uid.match(reUid)){
				isUidOk = true;
				$('.uidResult').css('color', 'green').text('사용 가능한 아이디입니다.');
			}else{
				isUidOk = false;
				$('.uidResult').css('color', 'red').text('사용할 수 없는 아이디입니다.');
			}
			
			let jsonData = { "uid":uid }
			
			$.ajax({
				url:'./proc/checkUidProc.jsp',
				method:'get',
				data:jsonData,
				datatype:'json',
				success: function(data){
					
				}
				
				
			});
			
		});
		
		$('input[name=pass2]').focusout(function(){
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass2.match(rePass)){
				isPass1Ok = true;
								
				if(pass1 == pass2){
					isPass2Ok = true;
					$('.passResult').css('color','green').text('사용가능한 비밀번호 입니다.');
				}else{
					isPass2Ok = false;
					$('.passResult').css('color','red').text('사용할 수 없는 비밀번호 입니다.');
				}
			}else{
				isPass1Ok = false;
				$('.passResult').css('color','red').text('할 수 없는 비밀번호 입니다.');
			}
		});
		
		$('input[name=name]').focusout(function(){
			
			let name = $('input[name=name]').val();
			
			if(name.match(reName)){
				isNameOk = true;
				$('.nameResult').css('color','green').text('');
			}else{
				isNameOk = false;
				$('.nameResult').css('color','red').text('두글자 이상 한글이여야 합니다.');
			}
		});
		
		$('#btnNickCheck').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			if(nick.match(reNick)){
				isNickOk = true;
				$('.nickResult').css('color', 'green').text('사용 가능한 별명입니다.');
			}else{
				isNickOk = false;
				$('.nickResult').css('color', 'red').text('사용할 수 없는 별명입니다.');
			}
		});
		
		$('input[name=email]').focusout(function(){
			
			let email = $('input[name=email]').val();
			
			if(email.match(reEmail)){
				isEmailOk = true;
				$('.emailResult').css('color', 'green').text('사용 가능한 별명입니다');
			}else{
				isEmailOk = false;
				$('.emailResult').css('color', 'red').text('사용할 수 없는 별명입니다');
			}
		});
		
		$('input[name=hp]').focusout(function(){
			
			let hp = $('input[name=hp]').val();
			
			if(hp.match(reHp)){
				isHpOk = true;
				$('.hpResult').css('color', 'green').text('사용 가능한 이메일입니다.');
			}else{
				isHpOk = false;
				$('.hpResult').css('color', 'red').text('사용할 수 없는 이메일입니다.');
			}
		});
		
		// 최종 폼 전송 확인
		
		$('.register > form').submit(function(){
			
			if(!isUidOk){
				alert('아이디를 다시 확인하세요');
				return false
			}
			
			if(!isPass1Ok){
				alert('비밀번호를 다시 확인하세요');
				return false
			}
			
			if(!isPass2Ok){
				alert('비밀번호를 다시 확인하세요');
				return false
			}
			
			if(!isNameOk){
				alert('이름을 다시 확인하세요');
				return false
			}
			
			if(!isNickOk){
				alert('별명을 다시 확인하세요');
				return false
			}
			
			if(!isEmailOk){
				alert('이메일을 다시 확인하세요');
				return false
			}
			
			if(!isHpOk){
				alert('휴대폰을 다시 확인하세요');
				return false
			}
			return true;
		});
	});
</script>
<main id="user">
    <section class="register">
        <form action="#" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력">
                        <button type="button" id="btnIdCheck"><img src="./img/chk_id.gif" alt="중복확인"></button>
                        <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                    	<input type="password" name="pass2" placeholder="비밀번호 입력 확인">
                    	<span class="passResult"></span>
                    </td>
                    
                </tr>
            </table>
            <table border="1">
                <caption>개인정보 입력</caption>
                <tr>
                    <td>이름</td>
                    <td>
                    	<input type="text" name="name" placeholder="이름 입력">
                    	<span class="nameResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <input type="text" name="nick" placeholder="별명 입력">
                        <button type="button" id="btnNickCheck"><img src="./img/chk_id.gif" alt="중복확인"></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>E-Mail</td>
                    <td>
                    	<input type="email" name="email" placeholder="이메일 입력">
                    	<span class="emailResult"></span>
                   	</td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td>
                    	<input type="text" name="hp" placeholder="- 포함 13자리 입력">
                    	<span class="hpResult"></span>
                   	</td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" id="zip" readonly="readonly"  placeholder="우편번호 입력">
                        <button type="button" onclick="zipcode()"><img src="./img/chk_post.gif" alt="우편번호찾기"></button>
                        <input type="text" name="addr1" id="addr1" placeholder="주소 검색">
                        <input type="text"name="addr2" id="addr2" placeholder="상제주소 입력">
                    </td>
                </tr>
            </table>
            <div>
                <a href="./login.jsp" class="btn btnCancel">취소</a>
                <input type="submit" value="회원가입" class=" btn btnRegister">
            </div>
        </form>
    </section>
</main>
<%@ include file="/_footer.jsp" %>