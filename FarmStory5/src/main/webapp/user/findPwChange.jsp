<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../_header.jsp"/>
<script>
	$(function(){
		
		$('.btnNext').click(function(e){
			e.preventDefault();
			
			let uid = '${sessFindPass.uid}';
			let pass = $('input[name=pass2]').val();
			
			let jsonData = {
					"uid":uid,
					"pass":pass,
			}
			
			console.log(uid);
			
			$.ajax({
				url:'/FarmStory5/user/findPwChange.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success: function(data){
					
					if(data.result == 1){
						alert('비밀번호를 변경했습니다.\n 다시 로그인 해주세요');
						location.href="/FarmStory5/user/login.do";
					}else{
						alert('비밀번호 변경에 실패했습니다. \n 다시 시도해주세요');
					}
				}
			});
		});
	});

</script>
<main id="user">
    <section class="find findPwChange">
        <form action="#">
            <table border="0">
                <caption>비밀번호 변경</caption>                        
                <tr>
                    <td>아이디</td>
                    <td>${sessFindPass.uid}</td>
                </tr>
                <tr>
                    <td>새 비밀번호</td>
                    <td>
                        <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
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
            <a href="./login.do" class="btn btnCancel">취소</a>
            <a href="./login.do" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="../_footer.jsp"/>